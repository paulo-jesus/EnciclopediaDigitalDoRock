
CREATE TABLE Administrador (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senhaHash VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Instrumento (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE EstiloMusical (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    administrador_id INT,
    FOREIGN KEY (administrador_id) REFERENCES Administrador(id) ON DELETE SET NULL
);

CREATE TABLE Artista (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    dataNascimento DATE,
    paisOrigem VARCHAR(100),
    bio TEXT,
    administrador_id INT,
    FOREIGN KEY (administrador_id) REFERENCES Administrador(id) ON DELETE SET NULL
);

CREATE TABLE Banda (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    descricao TEXT,
    anoFormacao INT,
    paisOrigem VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    influenciasTexto TEXT,
    administrador_id INT,
    FOREIGN KEY (administrador_id) REFERENCES Administrador(id) ON DELETE SET NULL
);

CREATE TABLE Album (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    anoLancamento INT,
    gravadora VARCHAR(100),
    observacoes TEXT,
    banda_id INT,
    administrador_id INT,
    FOREIGN KEY (banda_id) REFERENCES Banda(id) ON DELETE CASCADE
    FOREIGN KEY (administrador_id) REFERENCES Administrador(id) ON DELETE SET NULL
);

CREATE TABLE Musica (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    duracaoSegundos INT,
    compositor VARCHAR(255),
    letraResumo TEXT,
    album_id INT NOT NULL,
    administrador_id INT,
    FOREIGN KEY (album_id) REFERENCES Album(id) ON DELETE CASCADE
    FOREIGN KEY (administrador_id) REFERENCES Administrador(id) ON DELETE SET NULL
);


CREATE TABLE banda_estilo (
    banda_id INT NOT NULL,
    estilo_id INT NOT NULL,
    PRIMARY KEY (banda_id, estilo_id),
    FOREIGN KEY (banda_id) REFERENCES Banda(id) ON DELETE CASCADE,
    FOREIGN KEY (estilo_id) REFERENCES EstiloMusical(id) ON DELETE CASCADE
);

CREATE TABLE banda_artista (
    banda_id INT NOT NULL,
    artista_id INT NOT NULL,


    PRIMARY KEY (banda_id, artista_id),
    FOREIGN KEY (banda_id) REFERENCES Banda(id) ON DELETE CASCADE,
    FOREIGN KEY (artista_id) REFERENCES Artista(id) ON DELETE CASCADE
);

CREATE TABLE album_artista (
    album_id INT NOT NULL,
    artista_id INT NOT NULL,

    PRIMARY KEY (album_id, artista_id),
    FOREIGN KEY (album_id) REFERENCES Album(id) ON DELETE CASCADE,
    FOREIGN KEY (artista_id) REFERENCES Artista(id) ON DELETE CASCADE
);

CREATE TABLE artista_instrumento (
    artista_id INT NOT NULL,
    instrumento_id INT NOT NULL,
    PRIMARY KEY (artista_id, instrumento_id),
    FOREIGN KEY (artista_id) REFERENCES Artista(id) ON DELETE CASCADE,
    FOREIGN KEY (instrumento_id) REFERENCES Instrumento(id) ON DELETE CASCADE
);