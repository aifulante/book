# 错误处理

### 示例代码

```rust
// 这是一个package的开始
use std::fs::File;
use std::io;
use std::io::Read;

fn main() {
    panic!("抛出了一个错误"); //抛出一个错误，程序中断
    
    // enum Result<T, E> {
    //     Ok(T),
    //     Err(E),
    // }

    let f = File::open("hello.txt"); //返回一个Result的enums类型
    let _ff = match f {    // 没有被使用的变量可以加上下划线前缀  _ff ff没有被使用
        Ok(_file) => println!("exits"),
        Err(error) => panic!("Problem opening the file: {:?}", error), 
    };

    // unwrap() expect(string) 俩个函数都是如果发生错误就直接panic! 否则返回正确的值，expect则允许传一个字符串作为错误提示
    let _f = File::open("hello.txt").unwrap();
    let _f = File::open("1.txt").expect("出错了");

    let _g = open_file();
}

```

### 直接抛出错误

* panic!(“出错了”) - 直接抛出一个错误后，程序中断
* unwrap() - 对于返回类型是Result的结果，返回错误的话就直接panic!了，返回正确的话就得到正确的值
* expect(“出错了”) - 和unwrap一个，区别在于可以传递一个自定义的错误信息

### 函数返回错误

```rust
fn open_file()  -> Result<String, io::Error> {
    let mut s = String::new();
    File::open("1.txt")?.read_to_string(&mut s)?; // 发生错误的话，直接return错误了
    Ok(s) // 返回正确的值
}
```

* 函数返回结果是Result类型的话，可以直接使用？来直接return err,错误信息会传递给Result.
* 这里最后一行结果会默认return给Result
