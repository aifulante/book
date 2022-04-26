# Page 1

### if

```rust
if number % 4 == 0 {
    println!("number is divisible by 4");
} else if number % 3 == 0 {
    println!("number is divisible by 3");
} else if number % 2 == 0 {
    println!("number is divisible by 2");
} else {
    println!("number is not divisible by 4, 3, or 2");
}

    
// 类似三元运算
let number = if condition { 5 } else { "six" };
```

### loop 死循环

```rust
loop {
 println!("again!");
}
 
// 返回结果
let result = loop {
   counter += 1;

   if counter == 10 {
       break counter * 2; // 高级感
   }
};
```

### while

```rust
while number != 0 {
  println!("{}!", number);

  number -= 1;
}
```

### for

```rust
for element in a {
    println!("the value is: {}", element);
}
    
    
// 倒着循环
for number in (1..4).rev() {  // 又是高级感
    println!("{}!", number);
}

```

