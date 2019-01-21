#!/bin/sh
#安装ssl模块
yum install mod_ssl
#iptables开放443端口
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
service iptables save
curl https://get.acme.sh | sh
#申请并安装证书，证书每60天自动申请一次，记住用自己的域名替换掉www.dreamoftime0.com
mkdir /etc/httpd/ssl
#第一次需要先申请一次来验证网站的所有权，如果不是第一次运行，会有警告提示带--force参数，忽略即可
~/.acme.sh/acme.sh --issue  -d www.dreamoftime0.com   --apache
~/.acme.sh/acme.sh --issue -d www.dreamoftime0.com --apache --installcert --cert-file /etc/httpd/ssl/dreamoftime0.com.pem --key-file /etc/httpd/ssl/dreamoftime0.com.key --fullchain-file /etc/httpd/ssl/dreamoftime0.com.cer --reloadcmd "service httpd force-reload"
#enjoy the https
#SSLCertificateChainFile
