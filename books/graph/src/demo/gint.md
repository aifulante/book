
# 一个简单的代码生成器（Gint）

    Gint提供从实体到CURD-L的能力，它是基于Gorm的，Gorm很好的提供了对不同数据库的orm支持。

## Gint初始化

执行Gint初始化，可以方便的得到一个Schema定义的代码框架。

```shell
go run gitee.com/wennmu/gint.git init User Link
```

生成的代码目录：

```shell
--gint
----schema
------user.go
------link.go
----generate.go
```

## 定义实体以及边 TODO

```go
package schema

import (
    gint "gitee.com/wennmu/gint.git/cmd"
)

type User struct {
	gint.Schema
}

func (User) Fields() []gint.Field {
	return nil
}

func (User) Edges() []gint.Edge {
    // Not currently supported
	return nil
}

```

## 生成代码 TODO

执行命令生成schema的代码。

```shell
go run gitee.com/wennmu/gint.git init User Link
```

## 调用测试 TODO

在main.go中添加如下代码：

```go
// 添加用户链接

// 创建一个用户，把链接添加到用户

// 查询用户以及用户的链接

```

## 数据库中的表 TODO

生成的表结构
