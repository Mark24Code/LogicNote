# LogicNote

## 一、概念：逻辑软件：

一个新概念。不建造过多的轮子，使用数据结构，把多个软件的部分串起来，逻辑上形成一个可用的软件。


## 二、软件的基本要素

* 抽象数据结构
* 前端输入
* 前端呈现
* 后端数据处理
* 数据存储
* 周边自动化服务
  * 账号系统
  * 同步
  * 版本管理
  * 其他自动化功能

## 三、一个逻辑笔记软件

* 抽象数据结构
  * 【使用】 Github Markdown(Markdown + Mermaid)
* 前端输入
  * 【使用】Vscode 编辑器
* 前端呈现
  * 【使用】Vscode 插件：[github-markdown-preview](https://marketplace.visualstudio.com/items?itemName=bierner.github-markdown-preview)
* 后端数据处理
  * 【使用】Ruby Rake 脚本
* 数据存储
  * 【使用】远程 选择 Github 仓库的存储能力
  * 【使用】本地 选择操作系统下文件系统，使用 Ruby 标准库操作，把文件系统当作数据库来使用
* 周边自动化服务
  * 账号系统
    * 【使用】使用 Git 仓库能力
  * 同步
    * 【使用】使用 Git 仓库推送
  * 版本管理
    * 【使用】git 的能力
  * 其他自动化功能
    * 【使用】Ruby Rake 脚本，串联所有的自动化部分

  
## Ruby Rake
```
rake config:email[email]        # email: get/set email
rake config:username[username]  # name: get/set username
rake note:delete                # note:delete note
rake note:list                  # note:list note
rake note:new[notename]         # note: create note
rake note:search                # note:search note
rake task_list                  # list all tasks
```