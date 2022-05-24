```go
package main

import "fmt"

type Node struct {
    left  *Node
    right *Node
    value string
}

var res [][]string

func main() {
    var path []string
    e := Node{nil, nil, "5"}
    d := Node{nil, nil, "4"}
    c := Node{left: nil, right: &e, value: "3"}
    b := Node{nil, nil, "6"}
    a := Node{left: &c, right: &d, value: "2"}
    head := Node{left: &a, right: &b, value: "1"}
    BinaryTreePath(&head, path)
    fmt.Println(res)
}

func BinaryTreePath(root *Node, path []string) {
    path = append(path, root.value)
    if root.left == nil && root.right == nil {
        res = append(res, path)
    }
    if root.left != nil {
        BinaryTreePath(root.left, path)
    }
    if root.right != nil {
        BinaryTreePath(root.right, path)
    }
}
```
