package epaw.lab3.service;

import epaw.lab3.model.Review;
import epaw.lab3.repository.ReviewRepository;

import java.util.List;

public class ReviewService {

    private final ReviewRepository repo = new ReviewRepository();

    public List<Review> getByDiada(int diadaId)          { return repo.findByDiada(diadaId); }
    public boolean hasReviewed(int diadaId, int userId)  { return repo.hasReviewed(diadaId, userId); }
    public Double getAverage(int diadaId)                { return repo.getAverage(diadaId); }
    public void save(int diadaId, int userId, int value) { repo.save(diadaId, userId, value); }
}
