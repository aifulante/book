# trait

### trait限定

#### Where关键字

```
fn foo<T: A, K: A + C, B> (a: T, b: K, c: B) {}

优化为：

fn foo<T, K, B> (a: T, b: K, c: B) where T: A, K: A + C {}
```

> where 关键字 用来给泛型T增加trait限定
