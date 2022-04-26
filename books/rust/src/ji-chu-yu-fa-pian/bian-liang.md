# 变量

定义一个变量

```rust
let x = 5;
```

{% hint style="warning" %}
变量x默认是不可变的，不可以改变变量的值
{% endhint %}

定义一个可以改变值得变量

```
let mut x = 5;
```

{% hint style="success" %}
至于变量的类型，是可以自动识别的
{% endhint %}

get一个新操作---变量隐藏

```
let x = 5
{
    let x = "6"
}
```

{% hint style="info" %}
第二个被let申明的x把第一个x隐藏了

let可以定义重复的变量名称

同时变量的值也是可以改变的

更重要的是，当块{...}执行结束后，外面的x还是5，你说厉害不。厉害了\~！
{% endhint %}
