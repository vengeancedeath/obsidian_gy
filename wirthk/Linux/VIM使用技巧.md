---
aliases:
  - vim工具
tags:
  - linux
  - vim
data: 2026-04-20
---
[.vimrc](file:///D:/obsidian/Obsidian-1.12.7/$PLUGINSDIR/app-64/library/files/.vimrc)文件在files文件夹

NOTE：以下松手为全松

#基本命令

	保存并退出（最常用）
	:wq
	直接退出（没修改内容）
	:q
	强制退出（不保存！放弃所有修改）
	:q!
	保存但不退出
	:w

	光标转移第一行
	gg
	最后一行
	shift +g = (G)

	翻到下一页
	ctrl + f

	删除
	d
	删除一行
	dd
	删除 x行
	dxd

	查找
	/关键词 向下查找
	下一个
	n
	上一个
	shift +n = (N)
	替换
	%s/旧词/新词/g

	显示行数
	set nu
	set number
	关闭行数
	set nonu
	set nonumber
	取消高亮显示
	noh

	显示光标的ascii
	ga

	

#代码相关

	跳转到匹配的[] {} ()
	%
	全部展开
	fdo
	全部折叠
	fdc

	选中当前 {} 整个块（含大括号）
	va{
	选中块内部（不含大括号）
	vi{

	跳转到全局函数定义
	g + shift + d = (gD)
	后退
	Ctrl + o
	前进
	Ctrl + i

#SP命令

	水平拆分当前窗口（上下两屏显示同一个文件）
	:sp				
	垂直拆分当前窗口（左右两屏显示同一个文件）
	:vsp				
	所有屏等高
	Ctrl + w + 松手 + =		

#Diffthis比较命令

	直接对比两个文件(没有打开VIM)
	vim -d test.c test1.c
	已经打开了vim
	:vsp 另一个文件
	:windo diffthis
	关闭对比
	:diffoff

	跳到下一个差异
	]c 
	跳到上一个差异
	[c 
	展开折叠的代码
	zo（fdo有效）
	折叠代码
	zc（fdc有效）
	重新对比
	:diffupdate

#Buffer

	下一个文件
	Ctrl + n	
	上一个文件
	Ctrl + p	
	显示所有打开文件列表
	Ctrl + b	
	关闭当前文件
	Ctrl + b + Ctrl + d	

#撤回/恢复

	普通模式-撤回
	u				
	普通模式-恢复撤销
	Ctrl + r				
	插入模式-撤回
	Ctrl + u			

#批量修改

	选中 -> shift + i -> 进入insert模式 -> 修改后 -> ESC -> 完成

#复制粘贴（yank-put）

	进入字符可视模式 → 移动光标选中 → 按 y复制
	v				 
	进入 行可视模式 → 选中多行 → y 复制
	shift + v = (V)			
	进入 行可视模式 → 选块多行 → y 复制
	Ctrl + v			
	复制 当前整行	
	yy			
	粘贴到光标前
	p				
	粘贴到光标后
	shift + p = (P)			

#F1-9

	F1    ?
	快速保存
	F2
	打开 / 关闭目录树 NERDTree    **
	F3
	开启 / 关闭自动补全 YCM    **
	F4			
	一键编译并运行当前代码    **
	F5	
	插入当前日期		   **
	F6			
	把数字当时间戳解析    **
	F7			
	循环切换文件编码    **
	F8			
	切换十六进制模式    **
	F9			
	切换 DOS / UNIX 换行符    **
	Shift + F4			
	替换当前时间    **
	Shift + F6			
	手动选择编码    **
	Shift + F8			
	退出十六进制    **
	Shift + F9			

#窗口/终端

	水平分屏打开终端
	Ctrl + w +松手+ m	 
	垂直分屏打开终端
	Ctrl + w + m			
	Ctrl + w +松手+ Ctrl + m
	水平新建空白窗口
	Ctrl + w + 松手 +  n
	垂直新建空白窗口
	Ctrl + w + n
	Ctrl + w + 松手 +Ctrl + n

	调整高度（上下分屏）
	Ctrl + w +松手+：resize 20
	调整宽度（左右分屏）
	Ctrl + w +松手+：vertical resize 20

	旋转窗口
	ctrl + w + r
	ctrl + w + 松手 + r
	
	窗口切换
	Shift + 上下左右
	关闭窗口
	Ctrl + w +松手+ c
	Ctrl + w + c
	清空并限制滚动
	Ctrl+ w +松手+ / + /	
	清空终端屏幕	
	Ctrl+ w +松手+ / 	
	清空终端（大滚动）		 **   
	Ctrl + w /1
	清空终端（最大滚动）     **
	Ctrl + w /9
	
#标签

	把当前窗口变成新标签
	Ctrl + w +  t
	Ctrl + w + Ctrl + t	
	新建标签页显示opt目录
	Ctrl + W  输入  ：tabe /opt
	当前标签页替换显示opt目录
	Ctrl + W  输入  ：e /opt
	目录打开文件(新建标签打开/水平打开/垂直打开)
	t,o,v
	标签切换
	Ctrl + 上下左右
	标签移动
	ALT + 左右
	
#目录树

	开关目录树
	\ + t
	开关自动补全    **
	\ + a
	切换换行符格式    **
	\ + ff
