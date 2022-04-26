# 字符串

> Rust 的核心语言中只有一种字符串类型：`str`，字符串 slice，它通常以被借用的形式出现，`&str`

#### [新建字符串](https://kaisery.github.io/trpl-zh-cn/ch08-02-strings.html#%E6%96%B0%E5%BB%BA%E5%AD%97%E7%AC%A6%E4%B8%B2) <a href="#xin-jian-zi-fu-chuan" id="xin-jian-zi-fu-chuan"></a>

```rust
let mut s = String::new();
let s = "initial contents".to_string();
let s = String::from("initial contents");
```



#### [更新字符串](https://kaisery.github.io/trpl-zh-cn/ch08-02-strings.html#%E6%9B%B4%E6%96%B0%E5%AD%97%E7%AC%A6%E4%B8%B2) <a href="#geng-xin-zi-fu-chuan" id="geng-xin-zi-fu-chuan"></a>

```rust
let mut s = String::from("foo");
s.push_str("bar");

 // 追加一个字符，结果lol
 let mut s = String::from("lo");
 s.push('l');
 
 // 使用 + 运算符或 format! 宏拼接字符串
 let s1 = String::from("Hello, ");
 let s2 = String::from("world!");
 let s3 = s1 + &s2; 
 
 // format! 宏拼接字符串
 let s = format!("{}-{}-{}", s1, s2, s3);
```

#### [索引字符串](https://kaisery.github.io/trpl-zh-cn/ch08-02-strings.html#%E7%B4%A2%E5%BC%95%E5%AD%97%E7%AC%A6%E4%B8%B2) <a href="#suo-yin-zi-fu-chuan" id="suo-yin-zi-fu-chuan"></a>

```rust
let s1 = String::from("hello");
let h = s1[0];
let s = &hello[0..4];
```

#### [遍历字符串的方法](https://kaisery.github.io/trpl-zh-cn/ch08-02-strings.html#%E9%81%8D%E5%8E%86%E5%AD%97%E7%AC%A6%E4%B8%B2%E7%9A%84%E6%96%B9%E6%B3%95) <a href="#bian-li-zi-fu-chuan-de-fang-fa" id="bian-li-zi-fu-chuan-de-fang-fa"></a>

```rust
for c in "abc".chars() {
    println!("{}", c);
}
for b in "abc".bytes() {
    println!("{}", b);
}
```
