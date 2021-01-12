# SICP实践代码
## 安装MIT-SCHEME
apt install mit-scheme  
mit-scheme

->(exit) 杀死scheme

## edwin编辑器
->(edit) 进入edwin

->C-x z 挂起edwin

->C-x c 停止edwin

->C-x C-z 停止edwin 挂起scheme

->C-x C-c 停止edwin 停止scheme

## 基本使用
### 命令行方式下的使用
#### 基本使用
不区分大小写

#### 退出一层或多层"读入-求值-打印循环"
->C-u 退出一层求值循环 错的 

->C-g 退到第一层循环

#### 中断执行:
->C-g 杀掉当前值,回到第一次REPL

->C-x 杀掉当前值,回到当前的REPL 错的

->C-u 杀掉当前值,回到上一层REPL 错的

->C-b 暂停当前值进入断点REPL.可以用(continue)唤醒中断的执行 错的

### Edwin的基本使用
#### 概述
edwin是编辑器,支持scheme

#### 两种不同执行模式
##### Edwin模式
编辑模式,可以求值,不能debug

##### 特殊的REPL模式
下面状态条显示(REPL:listen).

编辑模式下编写,无误后保存.再用REPL模式试验和调试

->M-p: Meta相当于Alt键

##### 帮助信息
->Ctrl-h t

#### 退出系统
#### 简单编辑和执行
->C-i 光标自动对齐

->C-x C-e 求值表达式

->C-c C-u 杀掉正在求值的表达式

->C-c C-b 中断当前求值,进入断点状态

##### 翻页等命令
->C-v: 向下翻一屏

->M-v: 向上翻一屏

->C-a: 移动到行首

->C-e: 移动到行尾

##### 两个常用操作

#### 调试

#### 编辑技术

#### 其他
Edwin前端是一个功能强大的编辑器,允许用Scheme进行任意的扩充.

### Scheme文件操作
#### 编辑和装入程序文件
->(load "/dir/test.scm")

->(cd "/dir")

#### 保存和恢复系统镜像
->(disk-save "image1")

->(disk-restore "image1")

### 阅读MIT Scheme文档

MIT Scheme Reference: MIT Scheme的详细功能

MIT Scheme User's Manual: MIT Scheme 的使用

SOS Reference Manual: SOS:Scheme 的对象系统

IMAIL User's Manual: 用Scheme邮件阅读器

