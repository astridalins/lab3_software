package epaw.lab3.service;

import epaw.lab3.model.Follows;
import epaw.lab3.model.User;
import epaw.lab3.repository.FollowsRepository;

import java.util.List;

public class FollowsService {

    private static FollowsService instance;
    private FollowsRepository followsRepository;

    private FollowsService() {
        this.followsRepository = FollowsRepository.getInstance();
    }

    public static synchronized FollowsService getInstance() {
        if (instance == null) {
            instance = new FollowsService();
        }
        return instance;
    }

    // ── follow ────────────────────────────────────────────────────────────────
    public void follow(Integer followerId, Integer followedId) {
        followsRepository.save(new Follows(followerId, followedId));
    }

    // ── unfollow ──────────────────────────────────────────────────────────────
    public void unfollow(Integer followerId, Integer followedId) {
        followsRepository.delete(new Follows(followerId, followedId));
    }

    // ── getFollowedUsers ──────────────────────────────────────────────────────
    public List<User> getFollowedUsers(Integer userId, Integer start, Integer end) {
        return followsRepository.findFollowed(userId, start, end).orElse(null);
    }

    // ── getNotFollowedUsers ───────────────────────────────────────────────────
    public List<User> getNotFollowedUsers(Integer userId, Integer start, Integer end) {
        return followsRepository.findNotFollowed(userId, start, end).orElse(null);
    }

    // ── isFollowing ───────────────────────────────────────────────────────────
    public boolean isFollowing(Integer followerId, Integer followedId) {
        return followsRepository.isFollowing(followerId, followedId);
    }
}
