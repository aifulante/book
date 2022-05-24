# entimport 

> 主要提供从数据表导入到实体的能力

## 安装

```shell
go run -mod=mod ariga.io/entimport/cmd/entimport -h
```

## 执行导入

### 已经存在数据表：

```sql
create table users
(
    id   integer not null
        primary key autoincrement,
    age  integer not null,
    name varchar(255) default 'unknown' not null
);

-- auto-generated definition
create table classes
(
    id           integer not null
        primary key autoincrement,
    class_name   varchar(255) default 'unknown' not null,
    score        integer      default 0 not null,
    user_classes integer
        constraint classes_users_classes
            references users
            on delete set null
);



```

### 执行以下命令导入到实体：

```shell
go run ariga.io/entimport/cmd/entimport -dsn "root:pass@tcp(localhost:3306)/entimport"
```

参数说明：

```shell
Usage of ~\entimport.exe:
  -dsn string
        data source name (connection information), for example: //数据源dsn链接，例如：mysql,pgsql
        "mysql://user:pass@tcp(localhost:3306)/dbname"
        "postgres://user:pass@host:port/dbname"
  -schema-path string
        output path for ent schema (default "./ent/schema") //输出schema的路径
  -tables value
        comma-separated list of tables to inspect (all if empty) //指定导出的表明，不指定就是全部表
```

### 导出完成的目录结构

```shell
├── ent
│   ├── generate.go
│   └── schema
│       ├── class.go
│       └── user.go

```
### 导出的实体定义

```go
package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

// User holds the schema definition for the User entity.
type User struct {
	ent.Schema
}

// Fields of the User.
func (User) Fields() []ent.Field {
	return []ent.Field{
		field.Int("age").
			Positive(),
		field.String("name").
			Default("unknown"),
	}
}

// Edges of the User.
func (User) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("classes", Class.Type),
	}
}

```
