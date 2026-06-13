package epaw.lab3.service;

import epaw.lab3.model.Diada;
import epaw.lab3.repository.DiadaRepository;

import java.util.List;

public class DiadaService {

    private final DiadaRepository repo = new DiadaRepository();

    public List<Diada> getAllDiades() {
        return repo.findAll();
    }

    public Diada getDiadaById(int id) {
        return repo.findById(id);
    }

    public void createDiada(String name, String dia, String location, String colla) {
        Diada d = new Diada();
        d.setName(name);
        d.setDia(dia);
        d.setLocation(location);
        d.setColla(colla);
        repo.save(d);
    }

    public void deleteDiada(int id) {
        repo.deleteById(id);
    }
}
