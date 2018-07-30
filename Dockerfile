# Version for jenkins
# Update center for jenkins
# Versions for tomcat
# Tomcat home
FROM fedora
RUN echo "JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk" >> /etc/default/tomcat7
RUN yum install -y wget
RUN groupadd tomcat && mkdir /opt/tomcat && useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.53/bin/apache-tomcat-8.0.53.tar.gz
RUN tar -zxvf apache-tomcat-8.0.53.tar.gz -C /opt/tomcat --strip-components=1
RUN cd /opt/tomcat && chgrp -R tomcat conf && chmod g+rwx conf && chmod g+r conf/* && chown -R tomcat logs/ temp/ webapps/ work/ && chgrp -R tomcat bin && chgrp -R tomcat lib && chmod g+rwx bin && chmod g+r bin/*


# Expose the default tomcat port
EXPOSE 8081

# Start the tomcat (and leave it hanging)
CMD systemctl start tomcat.service && tail -f /var/lib/tomcat7/logs/catalina.out
