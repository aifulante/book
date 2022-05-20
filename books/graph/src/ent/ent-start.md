### 初始化

```go
go mod init <project>
go install entgo.io/ent/cmd/ent@latest
go run entgo.io/ent/cmd/ent init User Class
```

执行初始化后的目录结构：

```yaml
--schema
----user.go
----class.go
--generate.go
```



得到schema定义框架。如下：

```go
// schema/user.go
package schema

import "entgo.io/ent"

// User holds the schema definition for the User entity.
type User struct {
    ent.Schema
}

// Fields of the User.
func (User) Fields() []ent.Field {
    return nil
}

// Edges of the User.
func (User) Edges() []ent.Edge {
    return nil
}
```

```go
// generate.go
package ent

//go:generate go run -mod=mod entgo.io/ent/cmd/ent generate ./schema

```

补充实体和边

```go
// schema/user.go
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

## 生成代码

```shell
go generate ./ent
或者
go generate ./...
```

## 创建实体和边数据

```go

package main

import (
	"context"
	"fmt"
	_ "github.com/mattn/go-sqlite3"
	"log"
	"test/ent"
	"test/ent/class"
	"test/ent/user"
)

func main() {
	client, err := ent.Open("sqlite3", "file:./ent.db?cache=shared&_fk=1")
	if err != nil {
		log.Fatalf("failed opening connection to sqlite: %v", err)
	}
	defer client.Close()
	// Run the auto migration tool.
	if err := client.Schema.Create(context.Background()); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}

	//_, err = CreateUser(context.Background(), client)
	//if err != nil {
	//	log.Fatalf("failed creating schema resources: %v", err)
	//}
	//u, err := QueryUser(context.Background(), client)
	//if err != nil {
	//	log.Fatalf("failed creating schema resources: %v", err)
	//}
	//_ = QueryClasses(context.Background(), u)
    //创建俩个class，然后创建一个用户关联这俩个class
	_, err = CreateClasses(context.Background(), client)
	if err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}
}

func CreateUser(ctx context.Context, client *ent.Client) (*ent.User, error) {
	u, err := client.User.
		Create().
		SetAge(22).
		SetName("868").
		Save(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed creating user: %w", err)
	}
	log.Println("user was created: ", u)
	return u, nil
}

func QueryUser(ctx context.Context, client *ent.Client) (*ent.User, error) {
	u, err := client.User.
		Query().
		Where(user.Name("121")).
		// `Only` 在 找不到用户 或 找到多于一个用户 时报错,
		Only(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed querying user: %w", err)
	}
	log.Println("user returned: ", u)
	return u, nil
}

func CreateClasses(ctx context.Context, client *ent.Client) (*ent.User, error) {
	math, err := client.Class.
		Create().
		SetClassName("math").
		SetScore(100).
		Save(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed creating class: %w", err)
	}
	log.Println("class was created: ", math)

	chinese, err := client.Class.
		Create().
		SetClassName("chinese").
		SetScore(100).
		Save(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed creating car: %w", err)
	}
	log.Println("car was created: ", chinese)

	// 新建一个用户，将两辆车添加到他的名下
	a8m, err := client.User.
		Create().
		SetAge(18).
		SetName("121").
		AddClasses(math, chinese).
		Save(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed creating user: %w", err)
	}
	log.Println("user was created: ", a8m)
	return a8m, nil
}

func QueryClasses(ctx context.Context, a8m *ent.User) error {
	cars, err := a8m.QueryClasses().All(ctx)
	if err != nil {
		return fmt.Errorf("failed querying user cars: %w", err)
	}
	log.Println("returned cars:", cars)

	// What about filtering specific cars.
	ford, err := a8m.QueryClasses().
		Where(class.ClassName("math")).
		Only(ctx)
	if err != nil {
		return fmt.Errorf("failed querying user cars: %w", err)
	}
	log.Println(ford)
	return nil
}
```

### 实体和关系在Golang数据结构中的体现

```go
// User is the model entity for the User schema.
type User struct {
	config `json:"-"`
	// ID of the ent.
	ID int `json:"id,omitempty"`
	// Age holds the value of the "age" field.
	Age int `json:"age,omitempty"`
	// Name holds the value of the "name" field.
	Name string `json:"name,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the UserQuery when eager-loading is set.
	Edges UserEdges `json:"edges"`
}
// UserEdges holds the relations/edges for other nodes in the graph.
type UserEdges struct {
	// Classes holds the value of the classes edge.
	Classes []*Class `json:"classes,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [1]bool
}
// Class is the model entity for the Class schema.
type Class struct {
	config `json:"-"`
	// ID of the ent.
	ID int `json:"id,omitempty"`
	// ClassName holds the value of the "class_name" field.
	ClassName string `json:"class_name,omitempty"`
	// Score holds the value of the "score" field.
	Score        int64 `json:"score,omitempty"`
	user_classes *int
}
```

### 实体和边在关系型数据库表中的体现

表：users

| id | age | name |
| :--- | :--- | :--- |
| 1 | 30 | a8m |
| 2 | 22 | 868 |
| 5 | 18 | 121 |

表：classes


| id | class\_name | score | user\_classes |
| :--- | :--- | :--- | :--- |
| 7 | math | 100 | 5 |
| 8 | chinese | 100 | 5 |

TODO：关于其他形式的边的存储结构待补充

## 参考资料

- [ent快速指南](https://entgo.io/zh/docs/getting-started)

