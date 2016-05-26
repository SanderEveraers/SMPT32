CREATE TABLE TIP_VD_DAG
(
  	ID		INT				NOT NULL	AUTO_INCREMENT,
  	Tip		VARCHAR(500)	NOT NULL,
    
    CONSTRAINT PK_TIPVDDAG	PRIMARY KEY (ID)
);

CREATE TABLE LEERLING
(
    ID		        INT				NOT NULL	AUTO_INCREMENT,
    Gebruikersnaam  VARCHAR(30)     NOT NULL,
    Wachtwoord      VARCHAR(64)     NOT NULL,
    LaatstIngelogd  DATE            NOT NULL,
    
    CONSTRAINT UQ_LEERLING  UNIQUE(gebruikersnaam),
    
    CONSTRAINT PK_LEERLING  PRIMARY KEY (ID)
);

CREATE TABLE VAK
(
    ID              INT             NOT NULL     AUTO_INCREMENT,
    Naam            VARCHAR(30)     NOT NULL,
    Leerjaar        INT             NOT NULL,
    Niveau          VARCHAR(8)      NOT NULL,
    
    CONSTRAINT PK_VAK       PRIMARY KEY (ID),
    
    CONSTRAINT UQ_VAK       UNIQUE (Naam, Leerjaar, Niveau)
);

CREATE TABLE KLAS
(
    ID              INT             NOT NULL    AUTO_INCREMENT,
    GegevenVak      INT             NOT NULL,
    
    CONSTRAINT PK_KLAS      PRIMARY KEY (ID),
    
    CONSTRAINT FK_VAKKLAS   FOREIGN KEY (GegevenVak) REFERENCES VAK(ID)
);

CREATE TABLE LEERLING_KLAS
(
    Leerling_ID     INT             NOT NULL,
    Klas_ID         INT             NOT NULL,
    
    CONSTRAINT PK_LEERLINGKLAS  PRIMARY KEY (Leerling_ID, Klas_ID),
    
    CONSTRAINT FK_LEERLINGKLASLEERLING  FOREIGN KEY (Leerling_ID)   REFERENCES LEERLING(ID),
    CONSTRAINT FK_LEERLINGKLASKLAS      FOREIGN KEY (Klas_ID)       REFERENCES KLAS(ID)
);