
# 一个简单的代码生成器（Gint）

    Gint提供从实体到CURD-L的能力，存储层基于Gorm实现，server使用了Gin框架。

## Gint初始化

新建项目

```shell
go mod init ginttest
cd ginttest
go mod tidy
```

执行Gint初始化，可以方便的得到一个Schema定义的框架。

```shell
go run gitee.com/wennmu/gint.git init
```

生成的代码目录：

```shell
--gint
----gint.yml  // schema定义文件
----generate.go // 生成代码脚本
```

## 定义实体以及边

> 在gint.yml配置文件中增加实体定义

```yaml
varsion: 1
schemas:
  - name: User
    fields:
      - name: name
        ftype: string
        anno:
      - name: Addr
        ftype: string
        anno:
      - name: Phone
        ftype: string
        anno:
    edges:
      - from: Team
        to: Order
        mode: 2
```

## 生成代码

执行命令生成schema的代码。

```shell
go generate ./...
```

## 启动服务

新建main.go添加如下代码：

```go
package main

import (
	"fmt"
	"ginttest/gint"
	"github.com/gin-gonic/gin"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"log"
)

func main()  {
	db, err := gint.Open(sqlite.Open("gint.db"), &gorm.Config{})
	if err != nil {
		log.Fatal("open db err")
	}
	if err = db.CreateMigrate(); err != nil {
		log.Fatal("migrate err")
	}

	r := gin.Default()

	gint.RegisterGintRouter(r, "api", func(c *gin.Context) {
		fmt.Println("中间件")
		c.Next()
	})

	err = r.Run(":8000")
	if err != nil {
		panic(err)
		return
	}
}

```

## 数据库中的表

未补充
