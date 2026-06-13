package epaw.lab3.service;

import epaw.lab3.model.Colla;
import epaw.lab3.repository.CollaRepository;

import java.util.List;

public class CollaService {

    private static CollaService instance;
    private final CollaRepository repo = new CollaRepository();

    private CollaService() {}

    public static synchronized CollaService getInstance() {
        if (instance == null) instance = new CollaService();
        return instance;
    }

    public List<Colla> getTotes() {
        return repo.findAll();
    }
}
