package epaw.lab3.model;

import java.io.Serializable;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;

	private String name;

	private String password;
	private String picture;
	private String colla;
	private String username;
	private String location;
	private String userType;
	private String email;
	private String posicions;

	public User() {
		super();
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	//COLLA CASTELLERA

	public String getColla() {
		return colla;
	}
	public void setColla(String colla) {
		this.colla = colla;
	}
	//Username
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	//Location
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	//UserType
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	//Email
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	//Posicions
	public String getPosicions() {
		return posicions;
	}
	public void setPosicions(String posicions) {
		this.posicions = posicions;
	}
}