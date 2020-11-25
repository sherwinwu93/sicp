# emacs tutorial
C-<chr>: control+字符  
M-<chr>: Esc+字符

C-x C-c: 退出emacs,保存编辑

C-g: 退出正在输入的命令

>>: 示意要做的操作

C-v: 下一屏,会遗留两行

M-v: 上一屏,遗留两行

C-l: 循环移动半屏,聚焦半屏

### BASIC CURSOR CONTROL 基础光标移动
                          Previous line, C-p
                                  :
                                  :
   Backward, C-b .... Current cursor position .... Forward, C-f
                                  :
                                  :
                            Next line, C-n

有时候想要快速的移动时

M-f: 向前一个单词

M-b: 向后一个单词

C-a: 移动到行首(句子)

C-e: 移动到行尾(句子)

M-a: 移动到行首

M-e: 移动到行尾

M-<: 移动到文件头

M->: 移动到文件尾

重复N次的命令

C-u 8 C-f/b: 向前/后移动8个字符

C-u 8 C-v/M-v: 做了纠正

### IF EMACS STOPS RESPONDING emacs停止响应 
C-g: 取消之前的输入,输入C-g

### DISABLED COMMANDS
误进入"DISABLED COMMANDS"时,回答n

### WINDOWS 窗口
emacs可以使用多窗口

C-h k C-f: C-f的帮助

C-x 1: 保留窗口1,其它窗口关闭

### INSERTING AND DELETING 插入与删除
插入直接输入就好,删除的话注意Backspace是C-h, Delete是删除当前光标

<return>的electric行为:enter键自动缩行

C-u 8 *: 重复输入字符

<DEL> : 删除当前光标,尽量别用

C-d: 删除光标的下一个字符,实际不符与<DEL>同,尽量多用

M-<DEL>: 向前删除单词,无效

M-d: 删除单词

C-k: 删除整行

M-k: 删除整行

C-<SPC>: 两次输入C-<SPC>,再使用C-w,首尾killing字符串

yanking 粘贴

C-u 2 C-k: 删除两行

C-y: 粘贴,向上插入式粘贴

M-y: 先C-y,再M-y找回删除的点

### UNDO 撤销
C-/: 撤销,多用

C-_: 撤销

C-x-u: 撤销

### FILES 文件
emacs不"save",不保存文件."save"之后,会有个原文件供待会找回来

emacs会显示文件

C-x C-f: 找到文件

C-x C-s: 保存文件,没文件生成文件xx,有文件生成xx~

### BUFFERS 缓存区
C-x C-b: 缓存列表

C-x b <filename>: 切换缓存

"Messages": buffer of messages

C-x s: Save some buffers保存所有缓存

### EXTENDING THE COMMAND SET 拓展命令集
C-x: 单字符拓展

M-x: 名称扩展

C-z: 挂起emacs

->emacs fg: 恢复挂起

M-x repl s changed<tab>altered: repl s=replaceString,替换一行

### AUTO SAVE 自动保存
自动保存的文件是hello.c->#hello.c#

### ECHO AREA 反馈区域
emacs看到你输入命令慢会提醒你

### MODE LINE 模式行
 -:**-  TUTORIAL       63% L749    (Fundamental)
        文件名         百分 行数    模式

M-x text-mode: 切换模式,当是minor mode是表示加载或卸载

不同的模式各个命令的行为不一样

major mode只能一个, minor modes可以多个或无

C-u 20 C-x f 调整行距为20

M-q: 重新格式化

### SEARCHING 查询
C-s: 查询,再次输入查询下一个,输入<DEL>返回上一个,有必要改一下

C-r: 向上搜索

### MULTIPLE WINDOWS 多窗口
C-x 2: 切换成两窗口

C-M-v: ESC C-v, 移动下面的窗口

C-x-o: 移动光标到另一个窗口

C-x 4 C-f: 使用新窗口打开新文件

### MULTIPLE FRAMES
frame: windows的容器

M-x make-frame: 出现一个新的frame 没发现变化

M-x delete-frame: 删除frame

### RECURSIVE EDITING LEVELS 递归编辑级别
遇到 RECURSIVE EDITING LEVELS 按 <esc><esc><esc>

### GETTING MORE HELP
C-h c C-p: 告知命令做什么的

C-h k C-p: 详细信息

C-h f :描述方法

C-h a file:查询file下的所有方法

C-h i: 读Manuals

### MORE FEATURES 更多特性
可以都manuals了解更多特性

使用<tab>避免无用的输入

Dired: 文件管理器

### CONCLUSION 总结

