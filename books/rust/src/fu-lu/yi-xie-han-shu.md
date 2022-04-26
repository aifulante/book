# 一些函数

#### dbg!

> `dbg!` 宏会打印到标准错误控制台流（`stderr`），与 `println!` 不同，后者会打印到标准输出控制台流（`stdout`）。

```rust
fn main() {
    let scale = 2;
    let rect1 = Rectangle {
        width: dbg!(30 * scale), // 打印stderr日志，并且返回计算结果
        height: 50,
    };

    dbg!(&rect1); // 打印stderr日志
}
```

#### assert\_eq!&#x20;

```rust
 assert_eq!(maybe_some_len, Some(12)); //相等不输出 不相等输出错误信息
```
