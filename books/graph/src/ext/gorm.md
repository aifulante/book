
# Gorm

> Golang的ORM库旨在成为开发者友好的。

全功能 ORM

关联 (Has One，Has Many，Belongs To，Many To Many，多态，单表继承)

Create，Save，Update，Delete，Find 中钩子方法

支持 Preload、Joins 的预加载

事务，嵌套事务，Save Point，Rollback To Saved Point

Context、预编译模式、DryRun 模式

批量插入，FindInBatches，Find/Create with Map，使用 SQL 表达式、Context Valuer 进行 CRUD

SQL 构建器，Upsert，数据库锁，Optimizer/Index/Comment Hint，命名参数，子查询

复合主键，索引，约束

Auto Migration

自定义 Logger

灵活的可扩展插件 API：Database Resolver（多数据库，读写分离）、Prometheus…

每个特性都经过了测试的重重考验

开发者友好

Gorm官网：https://gorm.io/zh_CN/

Gorm v2中文文档: https://learnku.com/docs/gorm/v2

## 安装

```shell
go get -u gorm.io/gorm
go get -u gorm.io/driver/sqlite
```

## 基于Gorm的CURD-L封装

```go
package main

import (
	"gorm.io/gorm"
	"gorm.io/driver/sqlite"
)

func init() {
	db, err := gorm.Open(sqlite.Open("gorm.db"), &gorm.Config{})

	// 大部分 CRUD API 都是兼容的
	db.AutoMigrate(&Product{})
	db.Create(&user)
	db.First(&user, 1)
	db.Model(&user).Update("Age", 18)
	db.Model(&user).Omit("Role").Updates(map[string]interface{}{"Name": "jinzhu", "Role": "admin"})
	db.Delete(&user)
}
```
