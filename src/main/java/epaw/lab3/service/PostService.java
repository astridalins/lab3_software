package epaw.lab3.service;

import epaw.lab3.model.Post;
import epaw.lab3.repository.PostRepository;

import java.util.List;
import java.util.Optional;

public class PostService {

    private static PostService instance;
    private PostRepository postRepository;

    private PostService() { this.postRepository = PostRepository.getInstance(); }

    public static synchronized PostService getInstance() {
        if (instance == null) instance = new PostService();
        return instance;
    }

    // ── add ───────────────────────────────────────────────────────────────────
    public void add(Post post) {
        postRepository.save(post);
    }

    // ── delete ────────────────────────────────────────────────────────────────
    public void delete(Integer id, Integer userId) {
        postRepository.delete(id, userId);
    }

    public void deleteAsAdmin(Integer id) {
        postRepository.deleteAsAdmin(id);
    }

    public void update(Integer id, Integer userId, String content) {
        postRepository.update(id, userId, content);
    }

    // ── forum posts ───────────────────────────────────────────────────────────
    public List<Post> getPrivatPosts(Integer userId) {
        return postRepository.findPrivat(userId);
    }

    public List<Post> getAllPrivatPosts(Integer adminId) {
        return postRepository.findAllPrivat(adminId);
    }

    public List<Post> getAllCollaPosts(Integer adminId) {
        return postRepository.findAllColla(adminId);
    }

    public List<Post> getCollaPosts(String colla, Integer userId) {
        if (colla == null || colla.isBlank()) return List.of();
        return postRepository.findColla(colla, userId);
    }

    public List<Post> getTotsPosts(Integer userId) {
        return postRepository.findTots(userId);
    }

    // ── likes ─────────────────────────────────────────────────────────────────
    public int like(Integer userId, Integer postId) {
        return postRepository.addLike(userId, postId);
    }

    public int unlike(Integer userId, Integer postId) {
        return postRepository.removeLike(userId, postId);
    }

    // ── replies ───────────────────────────────────────────────────────────────
    public List<Post> getRepliesByPost(Integer parentId, Integer viewerUserId) {
        return postRepository.findReplies(parentId, viewerUserId);
    }

    public List<Post> getRepliesByUser(Integer userId, Integer viewerUserId) {
        return postRepository.findRepliesByUser(userId, viewerUserId);
    }

    // ── posts by user (profile view) ─────────────────────────────────────────
    public List<Post> getPublicPostsByUser(Integer targetUserId, Integer viewerUserId) {
        return postRepository.findPublicByUser(targetUserId, viewerUserId);
    }

    public List<Post> getPrivatPostsByUser(Integer targetUserId, Integer viewerUserId) {
        return postRepository.findPrivatByUser(targetUserId, viewerUserId);
    }

    // ── legacy (Timeline/Posts tab) ───────────────────────────────────────────
    public List<Post> getPostsByUser(Integer userId, Integer start, Integer end) {
        Optional<List<Post>> posts = postRepository.findByUser(userId, start, end);
        return posts.orElse(null);
    }
}
