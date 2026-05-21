DROP DATABASE IF EXISTS casteller_social;

CREATE DATABASE casteller_social;

USE casteller_social;

-- =========================
-- COLLA
-- =========================
CREATE TABLE colla (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

-- =========================
-- USERS
-- =========================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(20) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,

    location VARCHAR(100),

    userType ENUM('ADMIN', 'COLLA', 'USER') NOT NULL,

    positions VARCHAR(100),
    picture VARCHAR(255),

    colla_id INT,

);

-- =========================
-- ADMIN
-- =========================
CREATE TABLE admin (
    user_id INT PRIMARY KEY,
    is_admin BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE

);

-- =========================
-- POSTS
-- =========================
CREATE TABLE post (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,

    parent_id INT NULL, --reaccions a otros posts
    diada_id INT, --quina diada es
    colla_id INT, --quina colla es
    private BOOLEAN,

    text VARCHAR(500),
    image_path VARCHAR(500),
    created_at DATE,
   

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (diada_id)
        REFERENCES diada(id)
        ON DELETE CASCADE,

    FOREIGN KEY (parent_id)
        REFERENCES post(id)
        ON DELETE CASCADE,
        
    FOREIGN KEY (colla_id)
        REFERENCES colla(id)
        ON DELETE CASCADE
    
);

-- =========================
-- LIKES
-- =========================
CREATE TABLE likes (
    user_id INT,
    post_id INT,

    PRIMARY KEY (user_id, post_id),

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (post_id)
        REFERENCES post(id)
        ON DELETE CASCADE
);

-- =========================
-- FOLLOWS
-- =========================
CREATE TABLE follows (
    follower_id INT,
    followed_id INT,

    followed_at DATE,

    PRIMARY KEY (follower_id, followed_id),

    FOREIGN KEY (follower_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (followed_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

-- =========================
-- DIADA
-- =========================
CREATE TABLE diada (
    id INT AUTO_INCREMENT PRIMARY KEY,

    dia DATE NOT NULL,
    location VARCHAR(100),
    colla VARCHAR(100),

    created_at DATE
);

-- =========================
-- REVIEW
-- =========================
CREATE TABLE review (
    id INT AUTO_INCREMENT PRIMARY KEY,

    diada_id INT NOT NULL,
    user_id INT NOT NULL,

    value INT,
    comment VARCHAR(255),
    espectador BOOLEAN NOT NULL,

    created_at DATE,

    FOREIGN KEY (diada_id)
        REFERENCES diada(id)
        ON DELETE CASCADE,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);