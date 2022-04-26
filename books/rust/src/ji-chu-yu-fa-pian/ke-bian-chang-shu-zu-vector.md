# 可变长数组vector

```rust
// 新建
let v: Vec<i32> = Vec::new();
let v = vec![1, 2, 3]; //使用vec!宏定义 

// 更新
v.push(4);

// 获取
let third: &i32 = &v[2];
match v.get(2) {
  Some(third) => println!("The third element is {}", third),
  None => println!("There is no third element."),
}

// 遍历 使用&改变值
 let mut v = vec![100, 32, 57];
for i in &mut v {
    *i += 50;
}

// 使用enums存储不同类型的值
enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}

let row = vec![
    SpreadsheetCell::Int(3),
    SpreadsheetCell::Text(String::from("blue")),
    SpreadsheetCell::Float(10.12),
];
```

#### &#x20;<a href="#xin-jian-vector" id="xin-jian-vector"></a>
