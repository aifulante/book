# 实体关系在数据库表和Go数据类型中的表现形式

> 通过对ent的学习,我们了解到实体关系大致分了八个模式
> 
> 那么这些实体关系是如何在数据表和数据类型定义中体现的呢

## ent实体框架中的边（关系或实体之间的关联）

1. 1对1 
2. 1对1 自引用
3. 1对1 双向自引用
4. 1对多 
5. 1对多 自引用
6. 多对多
7. 多对多 自引用
8. 多对多 双向自引用

*自引用和双向自引用在数据结构是其实一样的，它是对于有向图来说*

我们暂时只针对无向图，在数据存储结构上来说，其实分为一对一、一对多和多对多。

### 在数据表中的表现形式

> 在数据表存储时，使用数据表外键（foreign key）来表示实体之间的关联关系

- 一对一

TODO

- 一对多

TODO

- 多对多
- 
TODO

### 在Go数据类型中的表现形式

> 在Go数据类型中，使用结构体类型字段表示数据库外键，以及数据关联模型的引用

- A属于B
 
```go
// `User` 属于 `Company`，`CompanyID` 是外键
type User struct {
  gorm.Model
  Name      string
  CompanyID int
  Company   Company
}

type Company struct {
  ID   int
  Name string
}
```

- A包含B

```go
// User 有一张 CreditCard，UserID 是外键
type User struct {
  gorm.Model
  CreditCard CreditCard
}

type CreditCard struct {
  gorm.Model
  Number string
  UserID uint
}

```

- A包含很多B

```go
// User 有多张 CreditCard，UserID 是外键
type User struct {
  gorm.Model
  CreditCards []CreditCard
}

type CreditCard struct {
  gorm.Model
  Number string
  UserID uint
}
```

- 多对多

```go
// User 拥有并属于多种 language，`user_languages` 是连接表
type User struct {
  gorm.Model
  Languages []*Language `gorm:"many2many:user_languages;"`
}

type Language struct {
  gorm.Model
  Name string
  Users []*User `gorm:"many2many:user_languages;"`
}

存在关联表 user_languages;
```
