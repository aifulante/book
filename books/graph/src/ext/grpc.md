# gRPC

> 高性能、开源的通用RPC框架，支持C#，C++，Dart，Go，Java，Kotlin，Node，Objective-C，PHP，Python，Ruby。

官方网站：https://www.grpc.io/

官方文档（Go）：https://www.grpc.io/docs/languages/go/quickstart/

## Protobuf生成gRPC、rest API、Swagger

### 安装

#### 安装protoc 
https://github.com/protocolbuffers/protobuf/releases

#### 安装依赖
```shell
	#protoc生成Go
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	#protoc生成grpc
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
	#protoc生成grpc gateway
	go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
	#protoc生成swagger文档，之后swagger editor查看
	go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
```

### 定义proto

```proto
syntax = "proto3";
package test;

import "google/protobuf/timestamp.proto";
import "google/api/annotations.proto";

option go_package  =  "github.com/user" ;

message User {
  int32 id = 1;  // Unique ID number for this person.
  string name = 2;
  string email = 3;

  enum PhoneType {
    MOBILE = 0;
    HOME = 1;
    WORK = 2;
  }

  message PhoneNumber {
    string number = 1;
    PhoneType type = 2;
  }

  repeated PhoneNumber phones = 4;

  google.protobuf.Timestamp last_updated = 5;
}

// The greeting service definition.
service Gint {
  // Sends a greeting
  rpc FindUser (FindUserRequest) returns (FindUserResponse) {
    option (google.api.http) = {
      post: "/v1/user/find"
      body: "*"
    };
  }
}

// The request message containing the user's name.
message FindUserRequest {
  int32 id = 1;
}

// The response message containing the greetings
message FindUserResponse {
  User user = 1;
}

```

### 生成gRPC、grpc-gateway、swagger

```shell
protoc  -I. --go_out=user --go-grpc_out=user -I$(GOPATH)/pkg/mod  \
	-I$(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.16.0/third_party/googleapis \
	--grpc-gateway_out=logtostderr=true:user --swagger_out=logtostderr=true:user user.proto
```

### 实现service接口，并启动服务

```go
// 启动grpc server
package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"
	"google.golang.org/grpc"
	pb "test/user/github.com/user"
)

// server is used to implement helloworld.GreeterServer.
type server struct {
	pb.UnimplementedGintServer
}

// SayHello implements helloworld.GreeterServer
func (s *server) FindUser(c context.Context, in *pb.FindUserRequest) (*pb.FindUserResponse, error) {
	return &pb.FindUserResponse{User: &pb.User{Name: "xixi"}}, nil
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", 8000))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	pb.RegisterGintServer(s, &server{})
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
```

```go
// 启动gateway server
package main

import (
	"context"
	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	"google.golang.org/grpc"
	"log"
	"net/http"
	pb "test/user/github.com/user"
)

func main() {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()
	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithInsecure()}
	err := pb.RegisterGintHandlerFromEndpoint(ctx, mux, "0.0.0.0:8000", opts)
	if err != nil {
		panic(err)
	}

	log.Println("服务开启")
	http.ListenAndServe(":8080", mux)
}

```

### 查看swagger文档

生成的swagger.json如下：
```json
{
  "swagger": "2.0",
  "info": {
    "title": "user.proto",
    "version": "version not set"
  },
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ],
  "paths": {
    "/v1/user/find": {
      "post": {
        "summary": "Sends a greeting",
        "operationId": "Gint_FindUser",
        "responses": {
          "200": {
            "description": "A successful response.",
            "schema": {
              "$ref": "#/definitions/testFindUserResponse"
            }
          },
          "default": {
            "description": "An unexpected error response.",
            "schema": {
              "$ref": "#/definitions/runtimeError"
            }
          }
        },
        "parameters": [
          {
            "name": "body",
            "in": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/testFindUserRequest"
            }
          }
        ],
        "tags": [
          "Gint"
        ]
      }
    }
  },
  "definitions": {
    "UserPhoneNumber": {
      "type": "object",
      "properties": {
        "number": {
          "type": "string"
        },
        "type": {
          "$ref": "#/definitions/UserPhoneType"
        }
      }
    },
    "UserPhoneType": {
      "type": "string",
      "enum": [
        "MOBILE",
        "HOME",
        "WORK"
      ],
      "default": "MOBILE"
    },
    "protobufAny": {
      "type": "object",
      "properties": {
        "type_url": {
          "type": "string"
        },
        "value": {
          "type": "string",
          "format": "byte"
        }
      }
    },
    "runtimeError": {
      "type": "object",
      "properties": {
        "error": {
          "type": "string"
        },
        "code": {
          "type": "integer",
          "format": "int32"
        },
        "message": {
          "type": "string"
        },
        "details": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/protobufAny"
          }
        }
      }
    },
    "testFindUserRequest": {
      "type": "object",
      "properties": {
        "id": {
          "type": "integer",
          "format": "int32"
        }
      },
      "description": "The request message containing the user's name."
    },
    "testFindUserResponse": {
      "type": "object",
      "properties": {
        "user": {
          "$ref": "#/definitions/testUser"
        }
      },
      "title": "The response message containing the greetings"
    },
    "testUser": {
      "type": "object",
      "properties": {
        "id": {
          "type": "integer",
          "format": "int32"
        },
        "name": {
          "type": "string"
        },
        "email": {
          "type": "string"
        },
        "phones": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/UserPhoneNumber"
          }
        },
        "last_updated": {
          "type": "string",
          "format": "date-time"
        }
      }
    }
  }
}

```

访问 [swagger editor](https://editor.swagger.io/)查看
