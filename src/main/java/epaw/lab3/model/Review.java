package epaw.lab3.model;

public class Review {

    private int id;
    private int diadaId;
    private int userId;
    private int value;
    private int espectador;
    private String createdAt;
    private String uname;

    public Review() {}

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }

    public int getDiadaId()                 { return diadaId; }
    public void setDiadaId(int diadaId)     { this.diadaId = diadaId; }

    public int getUserId()                  { return userId; }
    public void setUserId(int userId)       { this.userId = userId; }

    public int getValue()                   { return value; }
    public void setValue(int value)         { this.value = value; }

    public int getEspectador()              { return espectador; }
    public void setEspectador(int e)        { this.espectador = e; }

    public String getCreatedAt()            { return createdAt; }
    public void setCreatedAt(String c)      { this.createdAt = c; }

    public String getUname()               { return uname; }
    public void setUname(String uname)     { this.uname = uname; }

    /** Returns only the date part (YYYY-MM-DD) for display. */
    public String getCreatedDate() {
        if (createdAt == null || createdAt.length() < 10) return createdAt;
        return createdAt.substring(0, 10);
    }
}
