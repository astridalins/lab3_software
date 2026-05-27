package epaw.lab3.service;

import epaw.lab3.model.Post;
import epaw.lab3.repository.PostRepository;

import java.util.List;
import java.util.Optional;

public class PostService {

    private static PostService instance;
    private PostRepository postRepository;

    private PostService() {
        this.postRepository = PostRepository.getInstance();
    }

    public static synchronized PostService getInstance() {
        if (instance == null) {
            instance = new PostService();
        }
        return instance;
    }

    public void add(Post post) {
        postRepository.save(post);
    }

    public void delete(Integer id, Integer userId) {
        postRepository.delete(id, userId);
    }

    public List<Post> getPostsByUser(Integer userId, Integer start, Integer end) {
        Optional<List<Post>> posts = postRepository.findByUser(userId, start, end);
        return posts.orElse(null);
    }
}
