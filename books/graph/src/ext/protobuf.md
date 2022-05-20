
# Protocol Buffer

> google 出品的一种数据交换格式, 缩写为 protobuf.

protobuf 分为编译器和运行时两部分. 编译器直接使用预编译的二进制文件即可, 可以从 releases 上下载.

protobuf 运行时就是不同语言对应的库, 以 Golang 为例:

```shell
go get github.com/golang/protobuf/protoc-gen-go
```

## 语法
```shell
syntax = "proto3";

message SearchRequest {
  string query = 1;
  int32 page_number = 2;
  int32 result_per_page = 3;
}
```
 message 的结构非常类似于各种语言中的 struct, dict 或者 map

 每个字段包括三个部分, 类型, 字段名和字段编号.

 同一个 message 中字段编号应该是唯一的

 注释语法是 // 和 /* ... */.

 ```shell
syntax = "proto3";

message Foo {
  reserved 2, 15, 9 to 11;
  reserved "foo", "bar";
}

message Test4 {
  repeated int32 d = 4 [packed=true];
}

message SearchRequest {
  string query = 1;
  int32 page_number = 2;
  int32 result_per_page = 3;
  enum Corpus {
    UNIVERSAL = 0;
    WEB = 1;
    IMAGES = 2;
    LOCAL = 3;
    NEWS = 4;
    PRODUCTS = 5;
    VIDEO = 6;
  }
  Corpus corpus = 4;
}

enum EnumAllowingAlias {
  option allow_alias = true;
  UNKNOWN = 0;
  STARTED = 1;
  RUNNING = 1;  // RUNNING 是 STARTED 的别名
}
```
使用 reserved 注明已被废弃的字段编号和字段名称.

使用 repeated 可以指定重复字段, 即数组.

使用 enum 定义枚举类型. 每个枚举定义都必须包含一个映射值为 0 的常量作为第一个元素.可以使用 allow_alias 选项允许枚举值的别名.

 ```shell
syntax = "proto3";

message SearchResponse {
  repeated Result results = 1;
}

message Result {
  string url = 1;
  string title = 2;
  repeated string snippets = 3;
}

```

类型也可以嵌套使用.

 ```shell
syntax = "proto3";

import "myproject/other_protos.proto";

import public "new.proto";

```
使用 import 可以导入外部定义.

使用 import public 可以传递导入依赖, 通常用于被导入的 proto 文件需要更改的情况下.

protocol 编译器搜索的位置是命令行参数中的 -I/--proto_path

 ```shell
syntax = "proto3";

import "google/protobuf/any.proto";

message ErrorStatus {
  string message = 1;
  repeated google.protobuf.Any details = 2;
}

```

Any 类型可以让你可以在没有它们的 proto 定义时, 将 messages 用作内嵌的类型. 一个 Any 包括任意的二进制序列化的 message, 就像 bytes 类型那样, 以及用作该类型的全局唯一的标识符 URL.

```shell
syntax = "proto3";

message SampleMessage {
  oneof test_oneof {
    string name = 4;
    SubMessage sub_message = 9;
  }
}

```

如果你有一个 message 包括许多字段, 但同时最多只有一个字段会被设置, 可以使用 Oneof 特性来节省内存. Oneof 字段和普通的字段没有区别, 除了所有这些 Oneof 字段共享内存, 且同时只能由一个字段被设置. 你可以使用特殊的 case() 或 WhichOneof() 方法检查哪个字段被设置了, 具体方法名称取决于实现的语言.

```shell
syntax = "proto3";

map<key_type, value_type> map_field = N;
map<string, Project> projects = 3;

```
使用 map 可以创建关联映射.key_type 可以是 integral 或 string 类型, 即 scalar 类型中除了 floating point types 和 bytes 以外的类型. value_type 可以是除 map 以外的任何类型.

```shell
syntax = "proto3";

package foo.bar;


```
使用 package 可以设置命名空间, 防止 message 类型冲突.
在Golang中: package 用作 Go 包名, 除了你使用 option go_package 显式声明包名

```shell
syntax = "proto3";

service SearchService {
  rpc Search (SearchRequest) returns (SearchResponse);
}


```
定义服务。

---

以上内容来自：https://zhuanlan.zhihu.com/p/92559559

## 相关资料

- [proto3文档](https://developers.google.com/protocol-buffers/docs/proto3)
- [protobuf 指南](https://zhuanlan.zhihu.com/p/92559559)
