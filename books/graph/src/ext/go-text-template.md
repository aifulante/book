# Go包text/template语法解析

> 包模板实现了用于生成文本输出的数据驱动模板。

模板内的数据会用{{}}包裹，{{ action }}其中的内容称为action.

action主要分为俩类内容：
  - 数据的值
  - 控制语句

{{ . }} .代表传入的数据 {{ .title }} 使用传入的title变量

## 语法介绍

{{/* comment */}} 注释

{{- content -}} 去掉俩边的空格

{{ pipeline }} 输出普通文本


{{ if pipeline }} xxx {{ else if pipeline }} xxx {{ end }} if条件语句

{{ range pipeline }} xxx {{ end }}  简单的循环语句

{{ range pipeline }} xxx {{ else }} xxx {{ end }} 条件循环语句

{{ range $index, $value := pipeline }} xxx {{ end }} 普通的循环语句

{{ define "name" }} 模板 {{ end }} 给模板命名

{{ template "name" }} 引用模板，配合define使用，可以完成模板部分的复用吧

{{ template "name" pipeline }} 条件引用模板

{{ block "name" pipeline }} 自定义模板内容 {{ end }} 使用模板name, 如果没有就使用自定义的模板内容

{{ with pipeline }} 模板1 {{ else }} 模板2 {{ end }} 一个新的上下文，如果条件不为空就模板1，否则模板2

### 比较运算符

eq
	 返回 arg1 == arg2 的布尔值
ne
	 返回 arg1 != arg2 的布尔值
lt
	 返回 arg1 < arg2 的布尔值
le
	 返回 arg1 <= arg2 的布尔值
gt
	 返回 arg1 > arg2 的布尔值
ge
	 返回 arg1 >= arg2 的布尔值

### 变量

定义变量： {{ $var = pipeline }}

变量的作用域：模板开始定义的变量作用域在整个模板，模板中块内定义的变量作用域在块内

### 函数

自定义函数接口：func (t *Template) Funcs(funcMap FuncMap) *Template 

**全局内置函数**

**and**

{{ and .x .y .z }} xyz全部为true，返回最后一个值（z）,如果任意一个为fasle，则返回它

**or**

{{ or .x .y .z }} xyz任意一个值为true则返回它，全为false则返回最后一个值

**call**

{{ call .fn .y .z } 调用fn函数传入yz参数，如果结果error不为nil, 则fatal

html
返回转义后的 HTML 字符串，这个函数不能在 html/template 中使用。
js
返回转义后的 JavaScript 字符串。
index
在第一个参数是 array、slice、map 时使用，返回对应下标的值。
index x 1 2 3 等于 x[1][2][3]。
len
返回复合类型的长度。
not
返回布尔类型参数的相反值。
print
等于 fmt.Sprint。
printf
等于 fmt.Sprintf。
println
等于 fmt.Sprintln。
urlquery
对字符串进行 url Query 转义，不能在 html/template 包中使用。



## 模板解析和执行

### 解析

```go
引入模板，不存在就报错
func Must(t *Template, err error) *Template
从字符串new模板
func New(name string) *Template
从文件系统中查找符合匹配规则的模板
func ParseFS(fsys fs.FS, patterns ...string) (*Template, error)
加载指定的多个模板文件
func ParseFiles(filenames ...string) (*Template, error)
加载符合匹配条件的模板
func ParseGlob(pattern string) (*Template, error)
```

### 执行

```go
//传入模板参数，执行模板，打印输出
err := tmpl.Execute(os.Stdout, "no data needed")
if err != nil {
	log.Fatalf("execution failed: %s", err)
}

//当有加载了很多模板的时候，可以指定要执行的模板名称（T2）,传入参数，执行模板，打印输出
err := tmpl.ExecuteTemplate(os.Stdout, "T2", "no data needed")
if err != nil {
	log.Fatalf("execution failed: %s", err)
}
```

## 在模板内使用自定义函数 funcMap

```go
package main

import (
	"log"
	"os"
	"strings"
	"text/template"
)

func main() {
	// First we create a FuncMap with which to register the function.
	funcMap := template.FuncMap{
		// The name "title" is what the function will be called in the template text.
		"title": strings.Title,
	}

	// A simple template definition to test our function.
	// We print the input text several ways:
	// - the original
	// - title-cased
	// - title-cased and then printed with %q
	// - printed with %q and then title-cased.
	const templateText = `
Input: {{printf "%q" .}}
Output 0: {{title .}}
Output 1: {{title . | printf "%q"}}
Output 2: {{printf "%q" . | title}}
`

	// Create a template, add the function map, and parse the text.
	tmpl, err := template.New("titleTest").Funcs(funcMap).Parse(templateText)
	if err != nil {
		log.Fatalf("parsing: %s", err)
	}

	// Run the template to verify the output.
	err = tmpl.Execute(os.Stdout, "the go programming language")
	if err != nil {
		log.Fatalf("execution: %s", err)
	}

}
```


## 参考资料

[](https://pkg.go.dev/text/template)
[](https://juejin.cn/post/6844903762901860360)

