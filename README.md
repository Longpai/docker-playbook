## XDXCTcontainer Runtime Deployment

- Requires Ansible 1.2 or newer
- Expects kylin server V10 or ubuntu

此工程是一个脚手架项目，用于在基础服务器环境下自动化配置 XDXCT Docker 容器运行时， 
它会自动安装 XDXGPU 驱动程序，docker 以及 XDXCT 容器运行时, 
通过检查 Node 状态执行安装程序，这意味着每个 Node 可以处于不同的初始安装状态。
关于 ansible 的详细信息，请访问：
https://ansible-tran.readthedocs.io/en/latest/docs/intro.html

目录结构如下
	
	.
	├── group_vars					# 全局变量
	│   └── all						
	├── hosts					# 集群主机信息
	├── LICENSE.md
	├── README.md
	├── roles						
	│   ├── deb_runtime_install			# 用于配置 deb 系列发行版
	│   │   ├── files				# 存放需要发送给 Node 的文件
	│   │   ├── handlers				# 用于便捷性的系统重启和服务重启
	│   │   ├── tasks				# 存放任务主逻辑
	│   │   └── templates				# 存放所需部署服务的配置文件
	│   ├── rpm_runtime_install			# 用于配置 rpm 系列发行版
	│   │   ├── files
	│   │   ├── handlers
	│   │   ├── tasks
	│   │   └── templates
	└── site.yml					# 主入口


1. 安装 master 环境
首先，需要在 master 机器上安装 Ansible，可以通过如下命令安装 

	sudo apt install ansible

	配置 `/etc/ansible/ansible.cfg`,添加以下字段

		[defaults]
		host_key_checking = False

		[privilege_escalation]
		become_method = sudo
		become_user = root
		become_ask_pass = False

	Node 中需要配置免密登录
	当具有大量不同的 Node 时，建议统一一个用户名和密码  
	目前只能处理密码统一的情况，用户名可统一可不统一

2. 修改文件
首先需要修改 `hosts` 文件，根据主机类型在对应的类型下添加主机名和 ip 地址  
	例如需要添加一台名为 ubuntu24 的主机，ip 为 192.168.0.33

		ubuntu_cli ansible_host=10.191.20.138

3. 配置代理
修改全局变量 `group_vars/all` 中 `http_proxy` 变量使 Node 可以访问源
如果 Node 不需要代理即可访问外网
请注释 `{deb | rpm}_runtime_install/tasks/main.yml` 文件的 `enviroment` 字段
分别位于前者（deb version）的 # todo 行和后者（rpm version）的 31-33 行

4. 启动自动化部署
	运行以下命令启动所有 Node ：

		ansible-playbook -i hosts site.yml -K

	-K 为交互式输入 Node 的 root 密码
	运行以下命令启动所有 tag 为 rpm 的 Node

		ansible-playbook -i hosts site.yml --tags rpm -K

	启动所有 tag 为 deb 的 Node
	
		ansible-playbook -i hosts site.yml --tags deb -K

	ansible-playbook会 会默认调用 5 个并行进程以同时启动 5 个 Node
	你可以显式调用 -f 来开启更多进程，例如

		ansible-playbook -i hosts site.yml -K -f 10

	`注意`： ansible -K 默认只会输入一次 root 密码用于提升权限，非此密码的 Node 将会无法访问
