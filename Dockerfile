FROM tomcat
LABEL maintainer=sreekanth

ADD ./target/trucks.war  /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh","run"]