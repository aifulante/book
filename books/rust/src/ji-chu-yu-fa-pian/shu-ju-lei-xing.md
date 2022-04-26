# 数据类型

### 变量类型

#### 整型



| 8-bit   | `i8`    | `u8`    |
| ------- | ------- | ------- |
| 16-bit  | `i16`   | `u16`   |
| 32-bit  | `i32`   | `u32`   |
| 64-bit  | `i64`   | `u64`   |
| 128-bit | `i128`  | `u128`  |
| arch    | `isize` | `usize` |

#### 浮点

`f32` 和 `f64`



#### [**布尔型**](https://kaisery.github.io/trpl-zh-cn/ch03-02-data-types.html#%E5%B8%83%E5%B0%94%E5%9E%8B)

&#x20;bool

[**字符类型**](https://kaisery.github.io/trpl-zh-cn/ch03-02-data-types.html#%E5%AD%97%E7%AC%A6%E7%B1%BB%E5%9E%8B)

**char**

```
let c = 'z';
```

### 复合类型

#### 元组 tuple

```rust
 let tup: (i32, f64, u8) = (500, 6.4, 1);
 let tup = (500, 6.4, 1);
 let (x, y, z) = tup;
  // 读取
  let five_hundred = x.0
```

####
