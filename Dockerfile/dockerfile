FROM centos:7
USER root
RUN su --
RUN yum install -y  deltarpm \
 && yum update -y
RUN yum install -y yum-utils \
        && yum install -y epel-release \
        && yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
RUN yum --enablerepo=remi install -y gd-last-devel
RUN yum-config-manager --enable remi-php72 \
RUN yum install -y php72\
                && yum -y install php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache
          
RUN sed -e 's/127.0.0.1:9000/127.0.0.1:9000/' \
        -e '/allowed_clients/d' \
        -e '/catch_workers_output/s/^;//' \
        -e '/error_log/d' \
        -i /etc/opt/remi/php72/php-fpm.d/www.conf
RUN yum update -y    
RUN yum install nginx iptables mariadb -y \
                && yum install htop nano net-tools wget tar -y				
COPY test3.com.conf /etc/nginx/conf.d/test3.com.conf
COPY nginx.conf /etc/nginx/
RUN mkdir -p /var/www   
WORKDIR /var/www
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz 
RUN mv /var/www/wordpress /var/www/html
RUN chown -R nginx:nginx /var/www/html
EXPOSE 9000
EXPOSE 80

CMD ["/bin/bash","D"]