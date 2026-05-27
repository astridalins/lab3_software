package epaw.lab3.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.SessionCookieConfig;

@WebListener
public class SessionConfigListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        SessionCookieConfig cookieConfig = sce.getServletContext().getSessionCookieConfig();
        cookieConfig.setMaxAge(3600);   // 1 hora
        cookieConfig.setHttpOnly(true); // no accessible via JS
        System.out.println("[Jetty] Sessio persistent configurada (MaxAge: 1h)");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}
}
