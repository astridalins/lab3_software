package epaw.lab3.service;


public class AdminService extends UserService {

    private static AdminService instance;

    private AdminService() {
        super();
    }

    public static synchronized AdminService getInstance() {
        if (instance == null) {
            instance = new AdminService();
        }
        return instance;
    }

    // ─── deleteUser ───────────────────────────────────────────────────────────
    public void deleteUser(Integer id) {
        userRepository.deleteById(id);
    }

}
