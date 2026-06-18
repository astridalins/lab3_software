package epaw.lab3.model;

public class Follows {

    private int followerId;
    private int followedId;
    private String followedAt;

    public Follows() {}

    public Follows(int followerId, int followedId) {
        this.followerId = followerId;
        this.followedId = followedId;
    }

    public int getFollowerId() { return followerId; }
    public void setFollowerId(int followerId) { this.followerId = followerId; }

    public int getFollowedId() { return followedId; }
    public void setFollowedId(int followedId) { this.followedId = followedId; }

    public String getFollowedAt() { return followedAt; }
    public void setFollowedAt(String followedAt) { this.followedAt = followedAt; }
}
