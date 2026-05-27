package epaw.lab3.model;

import java.sql.Timestamp;

public class Post implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private int uid;        // maps to post.user_id
    private String uname;   // joined from users.name
    private Timestamp postDateTime; // maps to post.created_at
    private String content; // maps to post.text

    public Post() {}

    public Integer getId() { return this.id; }
    public void setId(Integer id) { this.id = id; }

    public int getUid() { return this.uid; }
    public void setUid(int uid) { this.uid = uid; }

    public String getUname() { return this.uname; }
    public void setUname(String uname) { this.uname = uname; }

    public Timestamp getPostDateTime() { return this.postDateTime; }
    public void setPostDateTime(Timestamp postDateTime) { this.postDateTime = postDateTime; }

    public String getContent() { return this.content; }
    public void setContent(String content) { this.content = content; }
}
