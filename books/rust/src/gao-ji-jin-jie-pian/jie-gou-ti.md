# 结构体

#### 定义结构体

```rust
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}
```

#### 使用结构体

```rust
fn main() {
    let user1 = User {
        email: String::from("someone@example.com"),
        username: String::from("someusername123"),
        active: true,
        sign_in_count: 1,
    };
     user1.email = String::from("anotheremail@example.com");
}
```

#### 结构体嵌套

```rust
fn main() {
    // --snip--

    let user2 = User {
        email: String::from("another@example.com"),
        ..user1
    };
}
```

> `..` 语法指剩余没有指明的字段，来自user1

#### 元组类型结构体

```
struct Color(i32, i32, i32);
```

#### &#x20;没有任何字段的结构体

```rust
struct AlwaysEqual;
```

#### 结构体实现

```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    // 关联函数，有点构造函数的意思
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            height: size,
        }
    }
    // 实现的方法
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    let sq = Rectangle::square(3); // 使用关联函数用 ::
    println!(
        "The area of the rectangle is {} square pixels.",
        rect1.area() // 调用方法用 .
    );
}
```

> 使用impl实现结构体，可以有多个实现，名称也可以一样

####
