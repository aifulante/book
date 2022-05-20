### 模板解析

> ent的init代码是如何学初始化的？



#### 定义模板

```go
// ./tpl/schema.tpl

package schema

import (
    gint "gitee.com/wennmu/gint.git/cmd"
)

type {{ .schemaName }} struct {
	gint.Schema
}

func ({{ .schemaName }}) Fields() []gint.Field {
	return nil
}

func ({{ .schemaName }}) Edges() []gint.Edge {
    // Not currently supported
	return nil
}

```

#### 生成Go文件

schemaDir 为 ``` ./schema```

```go
func initSchema(args []string) {
	for _, schemaName := range args {
		tmpl, err := template.ParseFiles("./tpl/schema.tpl")
		if err != nil {
			panic(err)
		}
		genFile := schemaDir + "/" + strings.ToLower(schemaName) + ".go"
		f, err := os.Create(genFile)
		defer f.Close()
		if err != nil {
			panic(err)
		}
		err = tmpl.Execute(f, map[string]string{
			"schemaName": schemaName,
		})
		if err != nil {
			panic(err)
		}
	}
}

```

#### 用模板生成的Go文件

```go
package schema

import (
    gint "gitee.com/wennmu/gint.git/cmd"
)

type User struct {
	gint.Schema
}

func (User) Fields() []gint.Field {
	return nil
}

func (User) Edges() []gint.Edge {
    // Not currently supported
	return nil
}

```

### 参考资料

- [Package template](https://go-zh.org/pkg/text/template/)
