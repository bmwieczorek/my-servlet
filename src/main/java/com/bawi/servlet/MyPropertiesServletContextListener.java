package com.bawi.servlet;

import org.apache.log4j.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Properties;

@WebListener
public class MyPropertiesServletContextListener implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(MyPropertiesServletContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        Properties properties = new Properties();
        // env value for the DB hostname, default value is localhost, overwritten for docker multi-container deployment
        String myDbHostname = System.getenv("MY_DB_HOSTNAME") == null ? "localhost" : System.getenv("MY_DB_HOSTNAME");
        properties.setProperty("myDbHostname", myDbHostname);
        servletContextEvent.getServletContext().setAttribute("myEnvironment", properties);
        LOGGER.info("MyPropertiesServletContextListener.contextInitialized");
        System.out.println("MyPropertiesServletContextListener.contextInitialized");
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        LOGGER.info("MyPropertiesServletContextListener.contextDestroyed");
        System.out.println("MyPropertiesServletContextListener.contextDestroyed");
    }
}
