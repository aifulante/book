# 数组

### 数组&#x20;

```rust
let a = [1, 2, 3, 4, 5];
let a: [i32; 5] = [1, 2, 3, 4, 5]; //i32类型 5个元素
let a = [3; 5]; // 5个3元素
 let first = a[0]; //访问
```

> 元素的个数是固定的，元素的类型是相同的&#x20;

那么如何定义一个二位的数组

```rust
// 嵌套元组
let a: [(i32, &str, u8);3] = [(1,"nihao",2),(1,"nihao",2),(1,"nihao",2)];

// 嵌套结构体
struct Stu {
    name: String,
    age: u64,
}
let students: [Stu; 2] = [Stu{name: String::from("lili"), age: 12},Stu{name: String::from("xiaoniu"), age: 12}];
println!("{},{}", students[0].name,students[0].age);
println!("{},{}", students[1].name,students[1].age);
```

遍历数组

```rust
fn main() {
    let a = [10, 20, 30, 40, 50];

    for element in a {
        println!("the value is: {}", element);
    }
}
```
