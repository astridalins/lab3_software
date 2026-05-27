package epaw.lab3.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import epaw.lab3.model.User;
import epaw.lab3.repository.UserRepository;
import jakarta.servlet.http.Part;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class UserService {

    private static UserService instance;
    private UserRepository userRepository;

    private UserService() {
        this.userRepository = UserRepository.getInstance();
    }

    public static synchronized UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    private static final String PASSWORD_REGEX =
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$";

    // ─── validate ─────────────────────────────────────────────────────────────
    public Map<String, String> validate(User user) {
        Map<String, String> errors = new HashMap<>();

        // Name
        String name = user.getName();
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "El nom no pot estar buit.");
        } else if (name.length() < 5 || name.length() > 20) {
            errors.put("name", "El nom ha de tenir entre 5 i 20 caràcters.");
        }

        // Username
        String username = user.getUsername();
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "El username no pot estar buit.");
        } else if (username.length() < 4) {
            errors.put("username", "El username ha de tenir mínim 4 caràcters.");
        } else if (userRepository.existsByUsername(username)) {
            errors.put("username", "Aquest username ja existeix.");
        }

        // Location
        String location = user.getLocation();
        if (location == null || location.trim().isEmpty()) {
            errors.put("location", "La localitat no pot estar buida.");
        } else if (!location.matches("[a-zA-ZÀ-ÿ\\s]+")) {
            errors.put("location", "La localitat només pot contenir lletres.");
        }

        // UserType (expects uppercase: CASTELLER or ESPECTADOR)
        String userType = user.getUserType();
        List<String> typesValids = List.of("CASTELLER", "ESPECTADOR");
        if (userType == null || userType.trim().isEmpty()) {
            errors.put("userType", "Has de seleccionar un tipus d'usuari.");
        } else if (!typesValids.contains(userType)) {
            errors.put("userType", "El tipus d'usuari no és vàlid.");
        }

        // Email
        String email = user.getEmail();
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "L'email no pot estar buit.");
        } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            errors.put("email", "El format de l'email no és vàlid.");
        } else if (userRepository.existsByEmail(email)) {
            errors.put("email", "Aquest email ja està registrat.");
        }

        // Posicions (only for CASTELLER)
        if ("CASTELLER".equals(userType)) {
            String posicions = user.getPosicions();
            List<String> posicionsValides = List.of(
                "baixos", "contraforts", "agulles", "laterals", "ventalls",
                "segons", "terços", "quarts", "quints", "sisens", "setens",
                "dosos", "acotxador", "enxaneta", "folre", "manilles"
            );
            if (posicions == null || posicions.trim().isEmpty()) {
                errors.put("posicions", "Com a casteller, has d'indicar les teves posicions.");
            } else {
                for (String pos : posicions.split(",")) {
                    if (!posicionsValides.contains(pos.trim())) {
                        errors.put("posicions", "Alguna posició seleccionada no és vàlida.");
                        break;
                    
                    }
                }
            }

            // Colla (only for CASTELLER, optional but validated if provided)
            String colla = user.getColla();
            if (colla != null && !colla.trim().isEmpty()) {
                if (!userRepository.collaExists(colla)) {
                    errors.put("colla", "Has de seleccionar una colla vàlida de la llista.");
                }
            }
        }

        // Password
        String password = user.getPassword();
        if (password == null || !password.matches(PASSWORD_REGEX)) {
            errors.put("password", "La contrasenya ha de tenir mínim 8 caràcters, majúscula, minúscula, número i símbol (!@#$%^&*).");
        }

        return errors;
    }

    // ─── register ─────────────────────────────────────────────────────────────
    public Map<String, String> register(User user) {
        // Normalize userType: form sends lowercase ('casteller','espectador')
        // DB expects uppercase ('CASTELLER','ESPECTADOR')
        if (user.getUserType() != null) {
            user.setUserType(user.getUserType().toUpperCase());
        }

        Map<String, String> errors = validate(user);
        if (errors.isEmpty()) {
            userRepository.save(user);
        } else {
            System.out.println("[REGISTER] Validation errors: " + errors);
        }
        return errors;
    }

    // ─── login ────────────────────────────────────────────────────────────────
    public Map<String, String> login(User user) {
        Map<String, String> errors = new HashMap<>();
        if (!userRepository.checkLogin(user)) {
            errors.put("password", "El nom d'usuari o la contrasenya no coincideixen.");
        }
        return errors;
    }

    // ─── getAllUsers ──────────────────────────────────────────────────────────
    public java.util.List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // ─── follow ───────────────────────────────────────────────────────────────
    public void follow(Integer followerId, Integer followedId) {
        userRepository.followUser(followerId, followedId);
    }

    // ─── unfollow ─────────────────────────────────────────────────────────────
    public void unfollow(Integer followerId, Integer followedId) {
        userRepository.unfollowUser(followerId, followedId);
    }

    // ─── getFollowedUsers ─────────────────────────────────────────────────────
    public java.util.List<User> getFollowedUsers(Integer userId, Integer start, Integer end) {
        return userRepository.findFollowed(userId, start, end).orElse(null);
    }

    // ─── getNotFollowedUsers ──────────────────────────────────────────────────
    public java.util.List<User> getNotFollowedUsers(Integer userId, Integer start, Integer end) {
        return userRepository.findNotFollowed(userId, start, end).orElse(null);
    }

    // ─── saveProfilePicture ───────────────────────────────────────────────────
    public String saveProfilePicture(Part filePart, String username) {
        if (filePart == null || filePart.getSize() <= 0) {
            return null;
        }
        try {
            String fileName = filePart.getSubmittedFileName();
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = username + extension;

            String resourcesDir = "EXTERNAL_RESOURCES";
            Files.createDirectories(Paths.get(resourcesDir));

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Paths.get(resourcesDir, newFileName),
                           StandardCopyOption.REPLACE_EXISTING);
            }
            return newFileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
