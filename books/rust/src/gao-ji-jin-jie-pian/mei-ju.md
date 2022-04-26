---
description: 枚举是enums, 匹配是match，Option是一种特殊的枚举，if let是一种特殊的match,说到匹配，这里没有Switch！！！
---

# 枚举

#### enums定义

```rust
// 可以支持很多类型
enum Message { 
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

// 用::取使用枚举的值
let m = Message::Write(String::from("hello"));

// 也可以像struct那样用impl实现，并且定义方法
impl Message {
        fn call(&self) {
            // 在这里定义方法体
        }
    }

// 像struct一样去使用
m.call();
```



#### Option

> [https://doc.rust-lang.org/std/option/enum.Option.html](https://doc.rust-lang.org/std/option/enum.Option.html) Option的文档，提供了方法

```rust
enum Option<T> {  //<T> 语法是一个我们还未讲到的 Rust 功能。它是一个泛型类型参数
    None,
    Some(T),
}
// 不需要 Option:: 前缀来直接使用 Some 和 None
// Some(T) 和 None 仍是 Option<T> 的成员
  let some_number = Some(5);
  let some_string = Some("a string");

  let absent_number: Option<i32> = None;
```

#### 匹配match

```rust
// 匹配枚举类型的值
fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            println!("State quarter from {:?}!", state);
            25
        }
    }
}

// 匹配Option
fn plus_one(x: Option<i32>) -> Option<i32> {
        match x {
            None => None,
            Some(i) => Some(i + 1),
        }
    }
    
// 匹配值以外的其他值
 match dice_roll {
    3 => add_fancy_hat(),
    7 => remove_fancy_hat(),
    // 这里other是可以拿到这个值的，并在move_player函数中使用
    other => move_player(other), 
    //如果不想要这个值，直接执行一个行数
    // _ => reroll(),
    //也可以什么都不要，什么都不执行
    //_ => (),
}
```

#### if let

```rust
let config_max = Some(3u8);
// 匹配一个值
if let Some(max) = config_max {
    println!("The maximum is configured to be {}", max);
}

// 或者
let mut count = 0;
// 匹配俩个值
if let Coin::Quarter(state) = coin {
    println!("State quarter from {:?}!", state);
} else {
    count += 1;
}
```
