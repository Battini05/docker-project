FROM tomcat:8-jre8
ENV http_proxy http://http-proxy.amer.consind.ge.com:8080

# Clean the webapps directory. 
#The intention is to remove the default Contexts that includes Manager
RUN rm -r /usr/local/tomcat/webapps/*

# Deploy the application(war) into tomcat
ADD webapps/ /usr/local/tomcat/webapps/

ADD conf/server.xml /usr/local/tomcat/conf/


ADD bin/setenv.sh /usr/local/tomcat/bin/
ADD bin/run*.sh /root/

RUN chmod +x /root/run*.sh


# Expose 8080 Port.
# We would have Reverse Proxy configuration from Apache to Tomcat and hence would not require to expose the AJP port
EXPOSE 8080

# Start Tomcat and redirect all logs to stdout
CMD ["/root/run.sh"]
