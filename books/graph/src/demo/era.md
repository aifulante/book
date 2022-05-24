# era 

> 实体框架era (entity and relation in all)设计

![存储层实体框架系统设计](./存储层实体框架系统设计.png)


- 基于gqlgen E-R定义生成era Schema  --  entgql
- 基于era Schema定义生成数据E-R模型 -- entc
- 提供Schema的图查询能力            -- entql
- 使用Gorm操作与数据库交互          -- gorm
