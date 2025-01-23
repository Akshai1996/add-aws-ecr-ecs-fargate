### api gateway integration with cognito will need another source code to get the client id code and generate the access token

resource "aws_api_gateway_rest_api" "node_api" {
  api_key_source               = "HEADER"
  description                  = "nodejs-demo app"
  disable_execute_api_endpoint = "false"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  name = "nodejs-demo"
}

resource "aws_api_gateway_resource" "root_resource" {
  parent_id   = ""
  path_part   = ""
  rest_api_id = aws_api_gateway_rest_api.node_api.id
}

resource "aws_api_gateway_resource" "healthcheck_resource" {
  parent_id   = "0m3128egv8"
  path_part   = "healthcheck"
  rest_api_id = aws_api_gateway_rest_api.node_api.id
}

resource "aws_api_gateway_method" "tfer--kb82yflr86-002F-0m3128egv8-002F-GET" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "GET"
  resource_id      = "0m3128egv8"
  rest_api_id      = aws_api_gateway_rest_api.node_api.id
}

resource "aws_api_gateway_method" "tfer--kb82yflr86-002F-a194sw-002F-GET" {
  api_key_required = "false"
  authorization    = "COGNITO_USER_POOLS"
  authorizer_id    = "f39qtr"
  http_method      = "GET"

  request_parameters = {
    "method.request.header.id_token" = "true"
  }

  request_validator_id = "u2tmry"
  resource_id          = "a194sw"
  rest_api_id          = aws_api_gateway_rest_api.node_api.id
}

resource "aws_api_gateway_method_response" "response1" {
  http_method = "GET"
  resource_id = "0m3128egv8"

  response_models = {
    "application/json" = "Empty"
  }

  rest_api_id = aws_api_gateway_rest_api.node_api.id
  status_code = "200"
}

resource "aws_api_gateway_method_response" "response2" {
  http_method = "GET"
  resource_id = "a194sw"

  response_models = {
    "application/json" = "Empty"
  }

  rest_api_id = aws_api_gateway_rest_api.node_api.id
  status_code = "200"
}

resource "aws_api_gateway_stage" "tfer--kb82yflr86-002F-dev" {
  cache_cluster_enabled = "false"
  deployment_id         = "ybhl33"
  rest_api_id           = aws_api_gateway_rest_api.node_api.id
  stage_name            = "dev"
  xray_tracing_enabled  = "false"
}

resource "aws_api_gateway_authorizer" "tfer--f39qtr" {
  authorizer_result_ttl_in_seconds = "300"
  identity_source                  = "method.request.header.Authorization"
  name                             = "cognito-auth"
  provider_arns                    = ["arn:aws:cognito-idp:us-east-1:008971661427:userpool/us-east-1_Api2gExQ4"]
  rest_api_id                      = aws_api_gateway_rest_api.node_api.id
  type                             = "COGNITO_USER_POOLS"
}

resource "aws_api_gateway_model" "default_error" {
  content_type = "application/json"
  description  = "This is a default error schema model"
  name         = "Error"
  rest_api_id  = aws_api_gateway_rest_api.node_api.id
  schema       = "{\n  \"$schema\" : \"http://json-schema.org/draft-04/schema#\",\n  \"title\" : \"Error Schema\",\n  \"type\" : \"object\",\n  \"properties\" : {\n    \"message\" : { \"type\" : \"string\" }\n  }\n}"
}

resource "aws_api_gateway_model" "default_empty" {
  content_type = "application/json"
  description  = "This is a default empty schema model"
  name         = "Empty"
  rest_api_id  = aws_api_gateway_rest_api.node_api.id
  schema       = "{\n  \"$schema\": \"http://json-schema.org/draft-04/schema#\",\n  \"title\" : \"Empty Schema\",\n  \"type\" : \"object\"\n}"
}

resource "aws_api_gateway_integration" "tfer--kb82yflr86-002F-0m3128egv8-002F-GET" {
  cache_namespace         = "0m3128egv8"
  connection_type         = "INTERNET"
  http_method             = "GET"
  integration_http_method = "GET"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "0m3128egv8"
  rest_api_id             = aws_api_gateway_rest_api.node_api.id
  timeout_milliseconds    = "29000"
  type                    = "HTTP_PROXY"
  uri                     = "http://app-6-1377925927.us-east-1.elb.amazonaws.com"
}

resource "aws_api_gateway_integration" "tfer--kb82yflr86-002F-a194sw-002F-GET" {
  cache_namespace         = "a194sw"
  connection_type         = "INTERNET"
  http_method             = "GET"
  integration_http_method = "GET"
  passthrough_behavior    = "WHEN_NO_MATCH"

  request_parameters = {
    "integration.request.header.Authorization" = "method.request.header.Authorization"
  }

  resource_id          = "a194sw"
  rest_api_id          = aws_api_gateway_rest_api.node_api.id
  timeout_milliseconds = "29000"
  type                 = "HTTP_PROXY"
  uri                  = "http://app-6-1377925927.us-east-1.elb.amazonaws.com/"
}

resource "aws_api_gateway_integration_response" "tfer--kb82yflr86-002F-0m3128egv8-002F-GET-002F-200" {
  http_method = "GET"
  resource_id = "0m3128egv8"
  rest_api_id = aws_api_gateway_rest_api.node_api.id
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "tfer--kb82yflr86-002F-a194sw-002F-GET-002F-200" {
  http_method = "GET"
  resource_id = "a194sw"
  rest_api_id = aws_api_gateway_rest_api.node_api.id
  status_code = "200"
}
