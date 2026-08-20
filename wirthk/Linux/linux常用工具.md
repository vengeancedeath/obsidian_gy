---
aliases:
  - linux工具
tags:
  - linux
data: 2026-04-18
---

#Linux的基本软件安装

	ping：作用：测试网络通不通、延迟多少
	wget：作用：下载文件
	curl：作用：发请求、调试接口、下载
	net-tools：作用：网络工具包
	例如：
	sudo apt update && sudo apt install -y iputils-ping
	sudo apt install -y curl wget net-tools
	
#SSH命令

	SSH连接
	ssh wirthk@localhost -p 44334
	
#CP命令（复制）

	复制文件（cp 源文件 目标文件）
	cp a.txt b.txt
	cp a.txt b_{1..7}.txt
	复制到另一个目录（cp 源文件 目标目录）
	cp test.txt /home/user/ 
	复制整个文件夹（必须加 -r）（把 folder1 复制成 folder2）
	cp -r folder1 folder2
	覆盖前提示你确认（安全）
	（cp -i 源文件 目标文件）
	保留文件权限、时间戳
	（cp -p 源文件 目标文件）

	复制文件至多个目录 -- xargs -n 1 每次只拿1个目录
	echo hex_{1..7} | xargs -n 1 cp 目录/文件

#SCP命令（基于SSH的跨主机文件传输）  -- （简单复制，无断点继续，效率低） 不推荐

	基本格式(scp [参数] 源文件 目标文件)
	本地 → 远程（上传  scp 本地文件 用户名@远程IP:远程目录）
	scp test.txt root@192.168.1.100:/root/
	例如：通过44334端口 传输文件夹  -- windows
	scp -P 44334 -r C:\Users\weiping.sheng\Desktop\111\test_scp wirthk@localhost:/home/wirthk/test/
	例如：通过44334端口 传输文件  -- windows
	scp -P 44334 C:\Users\weiping.sheng\Desktop\111\test_scp.txt  wirthk@localhost:/home/wirthk/test/
	远程 → 本地（下载  scp 用户名@远程IP:远程文件 本地目录）
	scp root@192.168.1.100:/root/test.txt ./
	例如：通过44334端口 传输文件  -- windows
	scp -P 44334 wirthk@localhost:/home/wirthk/test/test2.txt C:\Users\weiping.sheng\Desktop\111\test_scp\
	例如：通过44334端口 传输文件夹  -- windows
	scp -P 44334 -r wirthk@localhost:/home/wirthk/test/test_scp C:\Users\weiping.sheng\Desktop\111\test_scp\
	传**整个文件夹**（加 -r）
	（scp -r 文件夹 用户名@远程IP:目标路径）
	指定端口（SSH 不是 22 时用 -P）
	（scp -P 2222 文件 用户名@远程IP:路径）  注意：**-P 大写**，且要放最前面。

	参数
	-r：递归复制目录
	-P：指定 SSH 端口
	-v：显示详细过程（调试用）

#Rsync工具 --（智能同步，断点继续，效率高）推荐使用

	上传：本地 → 本地
	rsync [选项] /本地/源/ /本地/目标/
	上传：本地 → 远程
	rsync [选项] /本地/path/ user@服务器IP:/远程/path/
	下载：远程 → 本地
	rsync [选项] user@服务器IP:/远程/path/ /本地/path/

	rsync -avrzP --rsh='ssh -p 44334' wirthk@192.168.30.54:/opt/EVK /opt/
	rsync -avrzP -e 'ssh -p 44334' wirthk@192.168.30.54:/opt/EVK /opt/

	选项参数
	-a：				     归档模式（递归(-r)、保留权限 / 时间 / 属主 / 软链接）几乎必加
	-v：				     显示详细过程
	-z：				     传输时压缩，省带宽、更快
	-P 				     = --partial（断点续传） + --progress（显示进度）
	--delete				严格镜像（目标多余文件删除）--慎用
	--exclude				排除文件 / 目录：

	NOTE:
	想要同步内容，源路径末尾加 /
	--rsh = 等于 -e 
	
#tar命令

	压缩为 .tar.gz（推荐  tar -zcvf 压缩包名.tar.gz 要压缩的文件/文件夹）
	 tar -zcvf test.tar.gz test   -（允许多个文件）
	 解压 .tar.gz （ tar -zxvf 压缩包名.tar.gz）
	 tar -zxvf test.tar.gz
	 解压到指定目录
	 (tar -zxvf 压缩包名.tar.gz -C 目标路径)
	 Note:
	压缩包后缀	           正确解压参数	            错误原因
	.tar.gz / .tgz	      tar -zxvf	正确，	     -z 对应 gzip
	.tar.bz2		        tar -jxvf		          用了 -z 就会报这个错
	.tar.xz		        tar -Jxvf		          用了 -z 就会报这个错
	.zip		              unzip		               不能用 tar 命令
	.rar		              unrar x		             不能用 tar 命令
	纯 .tar（未压缩）	  tar -xvf（去掉 -z）	      多了 -z 就会报这个错
	
#新建删除文件夹/文件命令

	mkdir 文件夹名
	mkdir dir1 dir2 dir3  （同时新建多个）
	新建多级目录（最常用：-p）
	mkdir -p a/b/c/d
	指定路径新建（绝对路径从根目录开始）
	mkdir -p /home/user/data/logs
	相对路径（当前目录下的子目录里新建）
	mkdir ./project/docs
	新建并指定权限（-m）
	mkdir -m 755 public   # 权限 rwxr-xr-x
	mkdir -m 700 private  # 仅自己可访问
	带空格的目录名（加引号）
	mkdir "my photos"
	mkdir 'new folder'

	删除空文件夹
	rmdir 文件夹名
	删除非空文件夹（最常用） 
	rm -r 文件夹名 
	强制删除（不提示、直接删）
	rm -rf 文件夹名
	删文件（不是文件夹）
	rm 文件名
	rm -f 文件名
	参数
	-v     显示详细过程
	-r     递归删除目中内容
	-f     强制删除

	创建/更新单个文件
	touch file.txt 
	创建多个文件
	touch file1.txt file2.txt
	批量创建文件 
	touch {a,b,c}.txt
	touch log{0..9}.log
	指定时间戳               **
	touch -t 202512312359.59 file.txt

#MV命令

	重命名(mv 参数 旧名字 新名字)
	mv a.txt b.txt
	mv mydir myfolder
	移动文件/文件夹
	mv test.txt ~/
	mv mydir /tmp/
	移动 + 改名
	mv a.txt ~/b.txt

	参数
	-n     不覆盖已存在的文件
	-i     覆盖前询问

#find命令

	基本用法
	find 从哪里找 -name "文件名"
		
	在当前目录及其子目录里找所有 .c 文件 find . -name "*.c"
	find . -name "*.c"
	在整个系统里找名为 passwd 的文件
	find / -name "passwd"
	在 home 目录找所有 .txt 文件（忽略大小写）
	find ~ -iname "*.txt"

	只找普通文件（f = file）
	find . -type f
	只找文件夹（d = directory）
	find . -type d
	只找软链接（l = link）
	find . -type l

	找大于 1M 的文件
	find . -size +1M
	找小于 100k 的文件
	find . -size -100k

	最近 1 天内修改过的文件
	find . -mtime -1
	最近 1 小时内修改过的文件
	find . -mmin -60

	找到所有 .log 文件并删除
	find . -name "*.log" -exec rm {} \;
	找到所有 .c 文件并显示详细信息
	find . -name "*.c" -exec ls -l {} \;

	按所有者搜索
	find . -user xxxxx
	找所有.C大于1M的文件
	find . -name "*.c" - size +1M
	
	NOTE：
	. = 当前目录
	/ = 整个系统
	-name = 按名字搜索
	-iname = 按名字搜索（不区分大小写）
	 k = 千字节
	 c = 字节
	 w = 字（2字节）

#修改用户名

	先新建一个临时管理员用户
	sudo useradd -m -s /bin/bash tempadmin 
	sudo passwd tempadmin 
	sudo usermod -aG sudo tempadmin
	退出当前会话，用 `tempadmin` 登录
	修改原用户的用户名和主目录
	sudo usermod -l Wirthk_Sheng wirthk
	sudo usermod -d /home/Wirthk_Sheng -m Wirthk_Sheng
	修改组名
	sudo groupmod -n Wirthk_Sheng wirthk
	退出临时用户，用 Wirthk_Sheng 登录
	再删掉临时用户
	sudo userdel -r tempadmin

#chmod命令  -改rwx权限

	权限格式    -rwxr-x---
	r = read 读   w = write 写  x = execute 执行
	user所有者权限（rwx）  group组权限（r-x）  other(---)
	给自己加执行权限
	chmod u+x test.sh
	去掉其他人的写权限
	chmod o-w test.sh
	所有人都能读+写
	chmod a+rw test.sh
	chmod +rw test.sh
	自己可读可写可执行，别人只能读 
	chmod 755 test.sh
	自己可读写，别人只能读（普通文件） 
	chmod 644 test.txt

	NOTE:
	u = user(自己) 
	g = group(组) 
	o = other(其他人) 
	a = all(全部) 
	+ = 添加权限 
	- = 去掉权限 
	= = 直接设置权限
	r = 4
	w = 2
	x = 1
	文件 x：能不能运行这个文件
	文件夹 x：能不能进入这个文件夹（cd）
	-文件 d 文件夹 l 软链接
	文件夹的rwx:r 能查看什么文件 w 不能新增删除重命名移动文件/文件夹 x 能进去
	 	
	
#chown命令  -chown所有者   -chgrp所属组

	只改所有者user(把 test.c改ubuntu这个用户)
	sudo chown ubuntu test.c
	同时改所有者 + 所属组chgrp（最常用）
	sudo chown ubuntu:ubuntu test.c
	对整个文件夹递归修改（-R）
	sudo chown -R ubuntu:ubuntu myproject/

	NOTE:
	遇到 “权限不够、打不开、改不了”，大概率是所有者不对  -把自己家目录全部恢复成自己的
	sudo chown -R $USER:$USER ~/

#df命令   -查看磁盘空间使用情况

	查看硬盘 / 分区 总共多大、用了多少、还剩多少
	df -h
	只看本地磁盘（不看 tmpfs、虚拟磁盘）        **
	df -lh
	显示 inode 使用情况（极客用）      **
	df -i

#du命令   -查看文件 / 文件夹

	查看当前目录/文件
	du -sh .
	du -sh xxxx



	NOTE:
	-s      总和
	-h      人类可读、文件
	-a      包含文件


#mingw

	在linux上编译windows程序

	安装
	sudo apt update && sudo apt install -y mingw-w64
	查询版本
	x86_64-w64-mingw32-gcc --version
	调用编译一个文件
	x86_64-w64-mingw32-gcc test.c -o test.exe

#wget

	传输文件
	wget URL -O 保存路径/文件名
	wget -c --no-check-certificate 链接 -O /opt/xxx/xxx.c
	传输文件夹
	wget -r URL
	wget -r -np -nH -c --no-check-certificate 目录链接

	参数
	-O     自定义保存文件（单文件）
	-c     断点续传
	-r     递归下载文件夹
	-np    不回溯上层目录
	-nH    不创建域名目录
	-q     静默安静
	-U     自定义 UA
	-t     重试次数
	--no-check-certificate     跳过 HTTPS 证书

#基本信息

	基本查询命令 - 基本ll够用
		命令	        显示隐藏文件？	显示详细信息？	
		ll(ls -la)	✅ 是		     ✅ 是	
		ls	          ❌ 否		     ❌ 否	
		ls -l	     ❌ 否		     ✅ 是	
		ls -a	     ✅ 是		     ❌ 否
	目录结构
		home根目录
		~   （cd ~ == cd ）
		根目录
		/   
		当前目录
		./    
		上级目录
		../ (cd ../ == cd ..)

	杂项
		电脑本机回路地址-大多数情况下
		127.0.0.1 == localhost
		当前用户名
		$USER

#cat命令   --用的比较少

	查看文件
	cat xxxx
	查看并显示行数
	cat -n xxxx
	
#more命令   --用的比较少

	查看文件
	more a.txt
	下一页
	空格
	下一行
	回车
	退出
	q
	NOTE:
	看完自动退出
	
#less命令  

	查看文件
	less xxxx
	下一页
	空格/f
	上下行
	上下箭头
	搜索
	/关键词
	下一个搜索结果
	n
	上一个搜索结果
	shift + n = (N)
	跳到开头
	g
	跳到末尾
	shift + g = (G)
	退出
	q

	NOTE:
	一部分功能和VIM相似
	搜索/下一个搜索结果/上一个搜索结果/跳到末尾 一样
	跳到开头 VIM是gg less是g

#tail命令

	查看文件尾部内容默认是10行
	tail 文件名
	指定显示末尾 N 行
	tail -n 20 文件名
	tail -20 文件名
	实时滚动追踪文件新增内容
	tail -f 文件名
	同时监控多个文件
	tail -f log1.log log2.log
	实时只看带 error 的日志
	tail -f app.log | grep error
	

	参数
	-n 数字      自定义显示末尾多少行
	-f           实时跟随、持续刷新文件新增内容
	-F           比 -f 更强：文件被轮转/重命名后，依然能自动追踪新文件
	-q           静默模式，多文件查看时不输出文件名
	-v           强制显示文件名标题
	
	
#echo命令   --适用脚本

	打印至控制台
	echo 文字
	输出带空格
	echo "hello world"
	输出不自动换行
	echo -n "hello"
	启用转义字符（比如换行、制表符）
	echo -e "第一行\n第二行\t缩进"
	
	输出变量的值 --name="张三" 
	echo $name
	
	
	把内容写入文件 -覆盖文件原有内容
	echo "我是文件内容" > test.txt
	
	文件末尾追加内容（不覆盖）
	echo "追加一行新内容" >> test.txt

	打印hello 在找包含he
	echo "hello" | grep he

	输出时间 -date是命令
	echo `date`

	NOTE:
	| 管道符
	把左边命令的输出，交给右边命令当输入

#grep过滤查找命令  -全局搜索、打印匹配行

	在文件里搜索
	grep "hello" test.txt
	从管道里搜索
	echo "hello" | grep he

	参数
	-i      忽略大小写
	-n      显示行号
	-v      向匹配（显示**不包含**关键词的行）
    -w      全词匹配（只匹配完整单词，不匹配部分）
    -r      递归搜索整个文件夹
	
#ln软链接命令 

	创建命令
	ln -s 原文件 快捷方式名
	ln -s /home/ubuntu/test.c mycode

#date命令    --用的少

	看当前时间
	date
	date "+%Y-%m-%d %H:%M:%S"
	date "+%F %T"
	昨天
	date -d "1 day ago"
	明天
	date -d "tomorrow"
	1小时前
	date -d "1 hour ago"
	看时区
	date -R
	设置系统当前时间
	date -s "xxxx-xx-xx xx:xx:xx"
	
#timedatectl时间命令

	查看所有时间信息
	timedatectl
	查看所有可用时区
	timedatectl list-timezones
	设置时区
	sudo timedatectl set-timezone Asia/Shanghai
	开启 / 关闭自动网络时间（NTP）
	sudo timedatectl set-ntp true/false
	手动设置时间（不推荐，仅特殊情况用） -需要关闭NTP
	sudo timedatectl set-time "2026-04-18 15:45:00"

#nano

	打开 / 新建文本
	nano xxxx
	保存文件
	Ctrl + O
	退出 nano
	Ctrl+X
	搜索文本
	Ctrl+W
	剪切当前一整行
	Ctrl+K
	粘贴剪切的内容
	Ctrl+U
	打开帮助页面
	Ctrl+G

NOTE:
	nano -w xxxx  关闭自动换行
	nano -c xxxx 显示行号

#常见命令

	安装卸载更新
		刷新商店
		sudo apt update 
		下载安装xxxx
		sudo apt install -y xxxx 
		可合并
		sudo apt update && sudo apt install -y xxxx

		卸载软件
		sudo apt remove xxxx
		sudo apt purge xxxx
	
		更新全部软件
		sudo apt upgrade
		清理不再需要的依赖包
		apt autoremove
		清理过期的安装包缓存
		apt autoclean
	开关机（重启）
		关机命令
		sudo shutdown -h now
		sudo poweroff
		重启命令
		sudo reboot
		定时关机-分钟
		sudo shutdown -h 1
		取消关机
		sudo shutdown -c
	服务管家(防火墙服务名-ufw)
		立刻启动/停止/重启/重载配置 一个服务
		sudo systemctl start/stop/restart/reload 服务名
		查看服务详细运行状态（最常用排错）
		systemctl status 服务名
		设置/取消 开机自动启动
		sudo systemctl enable/disable 服务名
		查看是否设置了开机自启
		systemctl is-enabled 服务名
		列出所有正在运行的服务
		systemctl list-units --type=service
		列出所有已安装的服务（不管跑没跑）
		systemctl list-unit-files --type=service
	
	常用杂项
		停止运行/清空输入行
		Ctrl + c/u
		查软件详细信息
		apt show xxxx
		查系统里所有已装的软件
		apt list --installed
		查已安装的软件包（系统层面确认）
		dpkg -l | grep vim
		查看用户
		id xxxx

		清屏
		ctrl + l
		clear
		
		查询IP
		ip a
		查询当前所在目录
		pwd
		切换root用户 (环境变量不加载 不推荐)
		su xxxx
		切换root用户 (完全加载 root)
		su - xxxx
		切回原来用户
		exit
		ctrl + d
		

		终端切换成正常模式(可复制 滚动)
		ctrl + w + 松手 +shift + n
		正常模式水平分屏打开文件
		ctrl + w + f
		ctrl + w + 松手 + f
		正常模式新建标签页打开文件
		ctrl + w + 松手 + g + f
		终端切换成输入模式
		i
		a
		

		sudo 强制保存（权限不足时用）    **
		:w !sudo tee %		
		:sudow			
		重新加载 vimrc    **
		:so $MYVIMRC		
	
		
		  
		
	