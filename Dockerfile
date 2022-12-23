FROM maven AS BUILD
WORKDIR /app
COPY . /app
RUN cd ./target; ls
RUN mvn clean package 

FROM tomcat:8.0-alpine
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=BUILD /app/target/hello-world-war.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh","run"]
