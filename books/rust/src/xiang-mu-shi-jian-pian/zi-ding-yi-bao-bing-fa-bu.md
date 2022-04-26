---
description: 自定义一个crate，并发布到crates.io，然后在项目中引用crate
---

# 自定义包并发布

### 1、首先得有个包

#### 创建一个crate库

```rust
// 创建一个业务代码常用的自定义方法库businessfn
cargo new --lib businessfn
```

#### 定义模块以及函数

目录结构如下：

> businessfn:
>
> \----src
>
> \---------arr.rs
>
> \---------lib.rs
>
> \----.gitignore
>
> \----Cargo.lock
>
> \----Cargo.toml
>
> \----README.md

arr.rs：

````rust
/// 获取二维数组的列,返回一个包含该列所有值的一维数组
/// 
/// # Examples
///
/// ```
/// use businessfn::hello;
///
/// fn main() {
///     hello();
/// }
/// ```
pub fn array_columns() -> i64 {
    return 1
}
````

lib.rs:

```rust
/// 业务函数库

pub mod arr; // 加载arr同名文件的模块

pub fn hello() {
    let i = arr::array_columns();
    println!("i num : {}", i);
}
```

Cargo.toml:

```rust
[package]
name = "businessfn"
description = "Some custom function libraries for business development"
documentation = "https://github.com/finewenmu/businessfn/blob/master/README.md"
homepage="https://github.com/finewenmu/businessfn"
version = "0.1.0"
license = "MIT"
edition = "2021"
repository = "https://github.com/finewenmu/businessfn"
readme = "README.md"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
```

#### 编译发布版本

```rust
Cargo build --release
```

### 2、其次得做些准备

#### 注册一个github账号并且创建一个businessfn的仓库

> 注册github账号，点击\[走你]\(https://github.com)，自行注册即可，若有账号，继续下一步
>
> 创建github公开仓库，自行百度，不再赘述
>
> 然后你就有一个类似这样的仓库了 ：https://github.com/finewenmu/businessfn

#### 使用ssh-keygen生成本地秘钥。然后配置到github->setting->ssh设置中

> 这一步也不再细说，自行百度ssh-keygen -t rsa -c "xxx@gmail.com"

#### 在businessfn中绑定你的仓库，并将代码push到仓库中

> 这一步也不再细说，自行百度git的使用

#### 现在取crates.io注册一下账号，这个账号目前只能是用github授权的方式绑定

地址：[https://crates.io/](https://crates.io)

#### 创建API token

> 注册授权登录之后，在个人中心->Account setting->Api Token页面，点击New Token即可生成

### 3、发布自定义库到Crates.io

#### 本地登录Crates.io账号

打开终端执行命令：

```bash
cargo login [token]
// 比如
cargo login xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//提示登录成功
```

#### 在项目businessfn根目录执行发布

```bash
$cargo publish
   Updating crates.io index
   Packaging businessfn v0.1.0 
   Verifying businessfn v0.1.0 
   Compiling businessfn v0.1.0 
    Finished dev [unoptimized + debuginfo] target(s) in 2.06s
   Uploading businessfn v0.1.0 
```

### 4、使用自定义库

#### 创建一个项目

```rust
cargo new businessfn_test
```

#### 在Cargo.toml添加依赖

```rust
[dependencies]
businessfn = "0.1.0"
```

#### 在main.rs中使用

```rust
use businessfn::hello;

fn main() {
    hello();
}

```

#### 运行

```bash
$cargo run
   Updating crates.io index
   Compiling businessfn v0.1.0
   Compiling businessfn_test v0.1.0
    Finished dev [unoptimized + debuginfo] target(s) in 5.52s
     Running `target\debug\businessfn_test.exe`
i num : 1
```

#### 结束

> 恭喜！你成功了！庆贺吧！去搓一顿吧！！！
