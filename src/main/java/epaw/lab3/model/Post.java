package epaw.lab3.model;

import java.sql.Timestamp;

public class Post implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private int uid;           // maps to post.user_id
    private String uname;      // joined from users.name
    private String userPicture;// joined from users.picture
    private Timestamp postDateTime; // maps to post.created_at
    private String content;    // maps to post.text
    private int visibility;    // maps to post.private  (0=tots, 1=privat, 2=colla)
    private int likeCount;     // computed: COUNT(likes)
    private int likedByMe;     // computed: 1 if current user liked, 0 otherwise

    public Post() {}

    public Integer getId() { return this.id; }
    public void setId(Integer id) { this.id = id; }

    public int getUid() { return this.uid; }
    public void setUid(int uid) { this.uid = uid; }

    public String getUname() { return this.uname; }
    public void setUname(String uname) { this.uname = uname; }

    public String getUserPicture() { return this.userPicture; }
    public void setUserPicture(String userPicture) { this.userPicture = userPicture; }

    public Timestamp getPostDateTime() { return this.postDateTime; }
    public void setPostDateTime(Timestamp postDateTime) { this.postDateTime = postDateTime; }

    public String getContent() { return this.content; }
    public void setContent(String content) { this.content = content; }

    public int getVisibility() { return this.visibility; }
    public void setVisibility(int visibility) { this.visibility = visibility; }

    public int getLikeCount() { return this.likeCount; }
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }

    public int getLikedByMe() { return this.likedByMe; }
    public void setLikedByMe(int likedByMe) { this.likedByMe = likedByMe; }
}
