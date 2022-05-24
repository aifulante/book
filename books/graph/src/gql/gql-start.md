
# GraphQL - API查询语言

## 查询和修改

### 查询

```go
{
  hero {
    name
    # Queries can have comments!
    friends {
      name
    }
  }
}
```

### 传递参数

> 每个字段和嵌套对象都可以传递一组参数

```go
{
  human(id: "1000") {
    name
    height(unit: FOOT)
  }
}
```

### 定义别名

>查询具有不同参数的同一字段时

```go
{
  empireHero: hero(episode: EMPIRE) {
    name
  }
  jediHero: hero(episode: JEDI) {
    name
  }
}
```

### 使用片段

>片段让您可以构建字段集，然后将它们包含在您需要的查询中。

```go
{
  leftComparison: hero(episode: EMPIRE) {
    ...comparisonFields
  }
  rightComparison: hero(episode: JEDI) {
    ...comparisonFields
  }
}

fragment comparisonFields on Character {
  name
  appearsIn
  friends {
    name
  }
}
```

### 操作名称

>操作类型是查询、变异或订阅

```go
// 操作类型  操作名称
query HeroNameAndFriends {
  hero {
    name
    friends {
      name
    }
  }
}
```

### 变量

>$episode 是变量，以$开头
>可以给变量设置默认值
>类型旁边的!表示必须


```go
query HeroNameAndFriends($episode: Episode! = JEDI) {
  hero(episode: $episode) {
    name
    friends {
      name
    }
  }
}
```

### 指令

>指令可以附加到字段或片段包含
>@include(if: Boolean)如果参数为true，则仅在结果中包含此字段。
>@skip(if: Boolean)如果参数是true,跳过此字段。


```go
query Hero($episode: Episode, $withFriends: Boolean!) {
  hero(episode: $episode) {
    name
    friends @include(if: $withFriends) {
      name
    }
  }
}
```

### 突变

>一种修改服务器端数据的方法
>查询是并行的，突变的串行的


```go
mutation CreateReviewForEpisode($ep: Episode!, $review: ReviewInput!) {
  createReview(episode: $ep, review: $review) {
    stars
    commentary
  }
}
```

### 内联片段 TODO

```go
// TODO
```

