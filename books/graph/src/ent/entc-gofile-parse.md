### Go文件解析

> 实际上，ent的generate指的是entc，即ent codegen.



#### 解析Go包，获取实体（即schema）

这里使用了 ```golang.org/x/tools/go/packages```用来校验和分析Go包。

```go
// 从包路径中解析出schema的实体名称
func Generate(cmd *cobra.Command, args []string)  {
	cfg := &packages.Config{Mode: packages.NeedName | packages.NeedTypes | packages.NeedTypesInfo | packages.NeedModule,}
	// 加载要解析的Go包
    pkgs, err := packages.Load(cfg, args[0], entInterface.PkgPath())
	if err != nil {
		fmt.Fprintf(os.Stderr, "load: %v\n", err)
		os.Exit(1)
	}
	entPkg, pkg := pkgs[0], pkgs[1]
	if len(pkg.Errors) != 0 {
		log.Println(pkg.Errors[0])
	}
	if pkgs[0].PkgPath != entInterface.PkgPath() {
		entPkg, pkg = pkgs[1], pkgs[0]
	}
	var names []string
	//entInterface.Name() 反射类型名称
	//entPkg.Types.Scope().Lookup(entInterface.Name()) 从包的类型中找到给定名称的类型，返回其对象
	//.Type().Underlying() 对象类型的基础类型
	//(*types.Interface) 转为接口类型
	iface := entPkg.Types.Scope().Lookup(entInterface.Name()).Type().Underlying().(*types.Interface)
	//pkg.TypesInfo提供有关包的语法树的类型信息
    //pkg.TypesInfo.Defs 对象类型的定义信息
	//k ast.ident 
    //type Ident struct {
    //    NamePos token.Pos // 标识符的位置
    //    Name    string    // 标识符的名称
    //    Obj     *Object   // 所表示的对象; or nil
    //}
    //v obj
	for k, v := range pkg.TypesInfo.Defs {
        //做一些必要的校验
		typ, ok := v.(*types.TypeName)
		//IsExported id是否是大写开头
		//types.Implements 第一参数是否实现了第二参数
		if !ok || !k.IsExported() || !types.Implements(typ.Type(), iface) {
			continue
		}
		//一个类型的声明
		spec, ok := k.Obj.Decl.(*ast.TypeSpec)
		if !ok {
			fmt.Errorf("invalid declaration %T for %s", k.Obj.Decl, k.Name)
		}
		// ast.StructType 结构体类型声明
		if _, ok := spec.Type.(*ast.StructType); !ok {
			fmt.Errorf("invalid spec type %T for %s", spec.Type, k.Name)
		}
        //获取到schema的名称
		names = append(names, k.Name)
	}

	fmt.Println(names)
	fmt.Println(pkg.PkgPath)
}

//输出：
//[Link User]
//gitee.com/wennmu/gint.git/gint/schema

```


### 参考资料

- [go/packages](https://pkg.go.dev/golang.org/x/tools/go/packages) - 用来校验和分析Go包。
- [go/ast](https://go-zh.org/pkg/go/ast/) - 用来表示Go包的语法树的类型。
