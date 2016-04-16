# Updates From [awslabs/aws-apigateway-importer](https://github.com/awslabs/aws-apigateway-importer)

April 5, 2016: Swagger/OpenAPI import is now generally available in the API Gateway [REST API][api], the AWS [CLI][cli] and all AWS [SDKs][sdks]. You can also import and export Swagger definitions using the API Gateway [console][console]. This release addresses many of the open issues and feedback in this repository.

Customers are encouraged to migrate their workflow to the standard AWS tools. aws-apigateway-importer will receive minimal support from the API Gateway team going forward. Pull requests will be periodically reviewed. Customers using RAML definitions should continue to use aws-apigateway-importer for the time being.

Thanks for all of your feedback and contributions to this tool. Any feedback or issues going forward should be directed to the official API Gateway [forums][forums]. - @rpgreen

[sdks]: https://aws.amazon.com/tools
[cli]: http://docs.aws.amazon.com/cli/latest/reference/apigateway/put-rest-api.html
[forums]: https://forums.aws.amazon.com/forum.jspa?forumID=199
[api]: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api.html
[console]: https://console.aws.amazon.com/apigateway/home


Amazon API Gateway Swagger Importer
=============================

The **Amazon API Gateway Swagger Importer** lets you create or update [Amazon API Gateway][service-page] APIs from a Swagger representation.

To learn more about API Gateway, please see the [service documentation][service-docs] or the [API documentation][api-docs].

[service-page]: http://aws.amazon.com/api-gateway/
[service-docs]: http://docs.aws.amazon.com/apigateway/latest/developerguide/
[api-docs]: http://docs.aws.amazon.com/apigateway/api-reference

## Usage

### Prerequisites

This tool requires the [AWS CLI](http://aws.amazon.com/cli) to be installed and configured on your system.

Build with `mvn assembly:assembly`

### Usage Examples

#### Import a new API

e.g. `./aws-api-import.sh --create path/to/swagger.json`

#### Update an existing API and deploy it to a stage

e.g. `./aws-api-import.sh --update API_ID --deploy STAGE_NAME path/to/swagger.yaml`

#### Run import via docker

[Docker repository](https://registry.hub.docker.com/u/warnergodfrey/aws-apigateway-swagger/)

e.g. `docker run -i -t -v /path/to/swagger.json:/var/app/swagger.json -v ~/.aws:/root/.aws warnergodfrey/aws-apigateway-swagger -c /var/app/swagger.json`

### API Gateway Swagger Extension Example

You can fully define an API Gateway API in Swagger using the x-amazon-apigateway-auth and x-amazon-apigateway-integration extensions.

Defined on an Operation:

e.g.

```javascript

"x-amazon-apigateway-auth" : {
    "type" : "aws_iam"
},
 "x-amazon-apigateway-integration" : {
    "type" : "aws",
    "uri" : "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:MY_ACCT_ID:function:helloWorld/invocations",
    "httpMethod" : "POST",
    "credentials" : "arn:aws:iam::MY_ACCT_ID:role/lambda_exec_role",
    "requestTemplates" : {
        "application/json" : "json request template 2",
        "application/xml" : "xml request template 2"
    },
    "requestParameters" : {
        "integration.request.path.integrationPathParam" : "method.request.querystring.latitude",
        "integration.request.querystring.integrationQueryParam" : "method.request.querystring.longitude"
    },
    "cacheNamespace" : "cache-namespace",
    "cacheKeyParameters" : [],
    "responses" : {
        "2//d{2}" : {
            "statusCode" : "200",
            "responseParameters" : {
                "method.response.header.test-method-response-header" : "integration.response.header.integrationResponseHeaderParam1"
            },
            "responseTemplates" : {
                "application/json" : "json 200 response template",
                "application/xml" : "xml 200 response template"
            }
        },
        "default" : {
            "statusCode" : "400",
            "responseParameters" : {
                "method.response.header.test-method-response-header" : "'static value'"
            },
            "responseTemplates" : {
                "application/json" : "json 400 response template",
                "application/xml" : "xml 400 response template"
            }
        }
    }
}
```
