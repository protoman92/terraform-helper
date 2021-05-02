data "template_file" "lambda_inject_security_headers" {
  template = file("${path.module}/document/lambda_inject_security_headers.js.tpl")

  vars = {
    connectSource    = join(" ", var.connect_source)
    defaultSource    = "'none'",
    fontSource       = join(" ", var.font_source)
    frameSource      = join(" ", var.frame_source)
    imageSource      = join(" ", var.image_source)
    scriptSource     = join(" ", var.script_source)
    scriptSourceElem = join(" ", var.script_source_elem)
    styleSource      = join(" ", var.style_source)
    styleSourceElem  = join(" ", var.style_source_elem)
    xFrameOptions    = var.x_frame_options
  }
}

data "archive_file" "lambda_inject_security_headers_zip" {
  type        = "zip"
  output_path = "${path.module}/tmp/inject_security_headers.zip"
  source {
    content  = data.template_file.lambda_inject_security_headers.rendered
    filename = "inject_security_headers.js"
  }
}

module "iam_profile" {
  source  = "../iam/lambda_profile"
  create  = var.create
  service = var.service
  stage   = var.stage
}

module "lambda_edge_inject_security_header" {
  source           = "../lambda@edge"
  create           = var.create
  filename         = data.archive_file.lambda_inject_security_headers_zip.output_path
  function_name    = "inject-security-header"
  handler          = "inject_security_headers.handler"
  iam_role_arn     = module.iam_profile.role_arn
  runtime          = "nodejs12.x"
  service          = var.service
  source_code_hash = data.archive_file.lambda_inject_security_headers_zip.output_base64sha256
  stage            = var.stage
}
