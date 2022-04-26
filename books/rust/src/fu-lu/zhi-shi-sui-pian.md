# 知识碎片

## Rust

* [x] 语法参考
* [x] cargo管理工具
* [x] rustc编译器
* [ ] 标准库
* [x] crate.io库管理

### 一些问题

#### {} 和 {:?} 的区别

```
  println!("x is {}", x); // {}指的是任意变量内容  println!("y is {:?}", y);//fmt::Debug：使用 {:?} 标记。格式化文本以供调试使用。{:#?}提供了 “美化打印” 的功能//fmt::Display：使用 {} 标记。以更优雅和友好的风格来格式化文本。
```

#### 代码块{}的最后表达式加不加分号“；”的区别

```
let y = {    let x_squared = x * x;    let x_cube = x_squared * x;​    // 将此表达式赋给 `y`    x_cube + x_squared + x};​let z = {    // 分号结束了这个表达式，于是将 `()` 赋给 `z`    2 * x;};
```

#### 给变量赋值（）是什么意思

```
//单元类型（unit type）：()。其唯一可能的值就是 () 这个空元组let z = ()
```

#### println!() 为啥要加个！号

```
//println! 是一个宏（macros），可以将文本输出到控制台（console）
```

#### Rust的代码文件是以.rs结尾的

```
$rustc hello.rs
```

#### Rust的注释

```
//rust的注释是// 或者 /*块注释*/
```

#### Rust的文档注释

```
//rust的注释是/// 或者//!
```

#### struct Structure(i32) 定义一个结构体

```
struct Structure(i32) //定义一个元组结构体，包含一个 `i32` 元素// 元组结构体struct Pair(i32, f32);
```

### #!\[crate\_attribute] 是啥意思

```
#![crate_attribute] //作用在crate的属性#[item_attribute] //作用在模块、项的属性
```

```
//属性的格式#[attribute = "value"]#[attribute(key = "value")]#[attribute(value)]
```

#### #\[allow(dead\_code)]啥意思

```
//死代码，不被调用的代码#[allow(dead_code)]fn unused_function() {}
```

\
