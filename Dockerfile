FROM ubuntu
USER root
RUN su --
RUN apt-get install -y  deltarpm \
 && apt-get update -y
RUN apt-get install -y apt-get-utils \
        && apt-get install -y epel-release \
        && apt-get install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
RUN apt-get --enablerepo=remi install -y gd-last-devel
RUN apt-get-config-manager --enable remi-php72
RUN apt-get install -y php72 php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache
          
RUN sed -e '/allowed_clients/d' \
        -e '/catch_workers_output/s/^;//' \
        -e '/error_log/d' \
        -i /etc/opt/remi/php72/php-fpm.d/www.conf
RUN apt-get update -y    
RUN apt-get install  supervisor nginx iptables mariadb htop nano net-tools wget tar -y		
RUN	systemctl start nginx
RUN systemctl start mariadb 
COPY test3.com.conf /etc/nginx/conf.d/test3.com.conf
COPY nginx.conf /etc/nginx/
ENV supervisor_conf /etc/supervisor/supervisord.conf
COPY supervisord.conf ${supervisor_conf}
RUN mkdir -p /var/www   
WORKDIR /var/www
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz 
RUN mv /var/www/wordpress /var/www/html
RUN chown -R nginx:nginx /var/www/html
COPY start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 9000
EXPOSE 80

CMD ["/bin/sh"]
