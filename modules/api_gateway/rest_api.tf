resource "aws_api_gateway_rest_api" "rest_api"{
    name = var.rest_api_name
}

resource "aws_api_gateway_resource" "rest_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part = "thumbnails"
}

resource "aws_api_gateway_method" "rest_api_get_method"{
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "rest_api_get_method_integration" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = aws_api_gateway_method.rest_api_get_method.http_method
  type = "MOCK"
  //request_tempates is required to explicitly set the statusCode to an integer value of 200
   request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_method_response" "rest_api_get_method_response_200"{
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = aws_api_gateway_method.rest_api_get_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "rest_api_get_method_integration_response_200" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_resource.id
  http_method = aws_api_gateway_integration.rest_api_get_method_integration.http_method
  status_code = aws_api_gateway_method_response.rest_api_get_method_response_200.status_code
  response_templates = {
    "application/json" = jsonencode({
      body = "Hello from the thumbnails API!"
    })
  }
}

//  Creating a lambda resource based policy to allow API gateway to invoke the lambda function:
resource "aws_lambda_permission" "api_gateway_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.api_gateway_region}:${var.api_gateway_account_id}:${aws_api_gateway_rest_api.rest_api.id}/*/${aws_api_gateway_method.rest_api_get_method.http_method}${aws_api_gateway_resource.rest_api_resource.path}"
}