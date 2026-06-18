package epaw.lab3.service;

import epaw.lab3.model.Like;
import epaw.lab3.repository.LikeRepository;

public class LikeService {

    private static LikeService instance;
    private LikeRepository likeRepository;

    private LikeService() {
        this.likeRepository = LikeRepository.getInstance();
    }

    public static synchronized LikeService getInstance() {
        if (instance == null) {
            instance = new LikeService();
        }
        return instance;
    }

    // ── like ──────────────────────────────────────────────────────────────────
    public int like(Integer userId, Integer postId) {
        likeRepository.save(new Like(userId, postId));
        return likeRepository.getCount(postId);
    }

    // ── unlike ────────────────────────────────────────────────────────────────
    public int unlike(Integer userId, Integer postId) {
        likeRepository.delete(new Like(userId, postId));
        return likeRepository.getCount(postId);
    }
}
