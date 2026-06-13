package epaw.lab3.model;

public class Diada {

    private int id;
    private String name;
    private String dia;
    private String location;
    private String colla;
    private String createdAt;

    public Diada() {}

    public int getId()               { return id; }
    public void setId(int id)        { this.id = id; }

    public String getName()                { return name; }
    public void setName(String name)       { this.name = name; }

    public String getDia()                 { return dia; }
    public void setDia(String dia)         { this.dia = dia; }

    public String getLocation()            { return location; }
    public void setLocation(String loc)    { this.location = loc; }

    public String getColla()               { return colla; }
    public void setColla(String colla)     { this.colla = colla; }

    public String getCreatedAt()           { return createdAt; }
    public void setCreatedAt(String c)     { this.createdAt = c; }

    /** Returns the colla field split on commas, trimmed. */
    public String[] getColles() {
        if (colla == null || colla.isBlank()) return new String[0];
        String[] parts = colla.split(",");
        for (int i = 0; i < parts.length; i++) parts[i] = parts[i].trim();
        return parts;
    }
}
