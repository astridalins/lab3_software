package epaw.lab3.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.SessionCookieConfig;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebListener
public class SessionConfigListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        SessionCookieConfig cookieConfig = sce.getServletContext().getSessionCookieConfig();
        cookieConfig.setMaxAge(3600);
        cookieConfig.setHttpOnly(true);

        try {
            Files.createDirectories(Paths.get("EXTERNAL_RESOURCES", "posts"));
        } catch (Exception e) {
            System.err.println("[Jetty] No s'ha pogut crear EXTERNAL_RESOURCES/posts: " + e.getMessage());
        }

        System.out.println("[Jetty] Sessio persistent configurada (MaxAge: 1h)");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}
}
