# Gorm 关联的使用

> 创建关联，进行关联操作，以及查询关联表数据


## Go代码演示

数据类型定义

```go
type User struct {
	Id int64
	Name string
	Address string
	Phone string
	Orders []*Order
}

type Order struct {
	Id int64
	Amount int64
	CreateAt int64
	Goods []*Good
	UserId int64
}

type Good struct {
	Id int64
	Name string
	Price int64
	OrderId int64
}
```


```go
//go run main.go
package main

import (
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
	"log"
	"time"
)

//使用一对多模型创建关联
//一个用户有多个订单，一个订单有多个商品
//一个用户包含很多订单，一个订单包含很多商品
type User struct {
	Id int64
	Name string
	Address string
	Phone string
	Orders []*Order
}

type Order struct {
	Id int64
	Amount int64
	CreateAt int64
	Goods []*Good
	UserId int64
}

type Good struct {
	Id int64
	Name string
	Price int64
	OrderId int64
}

func main()  {
	//链接数据库
	db, err := gorm.Open(sqlite.Open("gorm.db"), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	//迁移表
	err = db.AutoMigrate(&User{}, &Order{}, &Good{})
	if err != nil {
		panic(err)
	}
	//初始化关联数据
	user := new(User)
	user.Name = "guojinfei"
	user.Address = "北京64胡同12号"
	user.Phone = "15311119999"
	user.Orders = []*Order{
		&Order{
			Amount: 1664,
			CreateAt: time.Now().Unix(),
			Goods: []*Good{
				&Good{
					Name:    "雪梨",
					Price:   128,
				},
			},
		},
	}
	//创建数据，自动创建关联
	tx := db.Create(&user)
	tx = db.Save(&user)
	if tx.Error != nil {
		panic(err)
	}
	//查询关联订单数
	count := db.Model(&User{Id: 2}).Association("Orders").Count()
	log.Println("count:", count)
	//查询用户的订单所购买的商品
	var orders []Order
	var goods []Good
	err = db.Model(&User{Id: 2}).Association("Orders").Find(&orders)
	if err != nil {
		panic(err)
	}
	err = db.Model(&orders).Association("Goods").Find(&goods)
	if err != nil {
		panic(err)
	}
	log.Println("orders:", orders)
	log.Println("goods:", goods)
	//删除关联
	db.Select("Orders", "Goods").Delete(&User{Id: 6})
	db.Select(clause.Associations).Delete(&User{Id: 7})
}

```

## 数据表展示

```sql

-- auto-generated definition
create table users
(
    id      integer
        primary key,
    name    text,
    address text,
    phone   text
);


-- auto-generated definition
create table orders
(
    id        integer
        primary key,
    amount    integer,
    create_at integer,
    user_id   integer
        constraint fk_users_orders
            references users
);


-- auto-generated definition
create table goods
(
    id       integer
        primary key,
    name     text,
    price    integer,
    order_id integer
        constraint fk_orders_goods
            references orders
);


```


## 文档参考

[Gorm关联](https://gorm.io/zh_CN/docs/belongs_to.html) https://gorm.io/zh_CN/docs/belongs_to.html
