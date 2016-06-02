DROP TABLE OEFENMOMENT;
DROP TABLE VRAAG_BEANTWOORD;
DROP TABLE VRAAG;
DROP TABLE TOETS;
DROP TABLE LEERLING_KLAS;
DROP TABLE KLAS;
DROP TABLE VAK;
DROP TABLE LEERLING;
DROP TABLE TIP_VD_DAG;

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
    LaatstIngelogd  DATETIME        NOT NULL,
    
    CONSTRAINT UQ_LEERLING  UNIQUE(gebruikersnaam),
    
    CONSTRAINT PK_LEERLING  PRIMARY KEY (ID)
);

/*CREATE TABLE VAK
(
    ID              INT             NOT NULL     AUTO_INCREMENT,
    Naam            VARCHAR(30)     NOT NULL,
    Leerjaar        INT             NOT NULL,
    Niveau          VARCHAR(8)      NOT NULL,
    
    CONSTRAINT PK_VAK       PRIMARY KEY (ID),
    
    CONSTRAINT UQ_VAK       UNIQUE (Naam, Leerjaar, Niveau)
);*/

CREATE TABLE KLAS
(
    ID              INT             NOT NULL    AUTO_INCREMENT,
    GegevenVak      VARCHAR(255)             NOT NULL,
    
    CONSTRAINT PK_KLAS      PRIMARY KEY (ID)
);

CREATE TABLE LEERLING_KLAS
(
    Leerling_ID     INT             NOT NULL,
    Klas_ID         INT             NOT NULL,
    
    CONSTRAINT PK_LEERLINGKLAS  PRIMARY KEY (Leerling_ID, Klas_ID),
    
    CONSTRAINT FK_LEERLINGKLASLEERLING  FOREIGN KEY (Leerling_ID)   REFERENCES LEERLING(ID),
    CONSTRAINT FK_LEERLINGKLASKLAS      FOREIGN KEY (Klas_ID)       REFERENCES KLAS(ID)
);

CREATE TABLE TOETS
(
    ID                  INT             NOT NULL    AUTO_INCREMENT,
    Naam                VARCHAR(255)    NOT NULL,
    Aanmaakdatum        DATETIME        NOT NULL,
    Toetsdatum          DATETIME        NOT NULL,
    Klas_ID             INT             NOT NULL,
    
    CONSTRAINT PK_TOETS         PRIMARY KEY (ID),
    
    CONSTRAINT FK_TOETSKLAS     FOREIGN KEY(Klas_ID)                REFERENCES KLAS(ID)
);

CREATE TABLE VRAAG
(
    ID                  INT             NOT NULL    AUTO_INCREMENT,
    Vraag               VARCHAR(255)    NOT NULL,
    Antwoord            VARCHAR(255)    NOT NULL,
    ContextZin          VARCHAR(500)    NULL,
    ContextAfb          VARCHAR(120)    NULL,
    
    CONSTRAINT PK_VRAAG         PRIMARY KEY (ID)
);

CREATE TABLE TOETS_VRAAG
(
    Toets_ID            INT             NOT NULL,
    Vraag_ID            INT             NOT NULL,
    
    CONSTRAINT PK_TOETSVRAAG            PRIMARY KEY (Toets_ID, Vraag_ID),
    
    CONSTRAINT FK_TOETSVRAAGTOETS       FOREIGN KEY (Toets_ID)      REFERENCES TOETS(ID),
    CONSTRAINT FK_TOETSVRAAGVRAAG       FOREIGN KEY (Vraag_ID)      REFERENCES VRAAG(ID)
);

CREATE TABLE OEFENMOMENT
(
    ID                  INT             NOT NULL    AUTO_INCREMENT,
    Tijdstip            DATETIME        NOT NULL,
    Tijdsduur           TIME            NOT NULL,
    Leerling_ID         INT             NOT NULL,
    
    CONSTRAINT PK_OEFENMOMENT           PRIMARY KEY (ID),
    
    CONSTRAINT FK_OEFENLEERLING            FOREIGN KEY (Leerling_ID)   REFERENCES LEERLING(ID)
    
);

CREATE TABLE VRAAG_BEANTWOORD
(
    ID                  INT             NOT NULL    AUTO_INCREMENT,
    Vraag_ID            INT             NOT NULL,
    GegevenAntwoord     VARCHAR(255)    NOT NULL,
    Tijdsduur           TIME            NOT NULL,
    Datum               DATETIME        NULL,
    GoedBeantwoord      BOOLEAN         NOT NULL,
    Oefenmoment         INT             NOT NULL,
    
    CONSTRAINT PK_VRAAGBEANTWOORD       PRIMARY KEY (ID),
    
    CONSTRAINT FK_VBVRAAG               FOREIGN KEY (Vraag_ID)      REFERENCES VRAAG(ID),
    CONSTRAINT FK_VBOEFEN               FOREIGN KEY (Oefenmoment)   REFERENCES OEFENMOMENT(ID)
);

INSERT INTO `leerling` (`ID`, `Gebruikersnaam`, `Wachtwoord`, `LaatstIngelogd`) VALUES
(6, 'Sander', 'sanderiscool', '2016-05-27 11:57:17'),
(7, 'Bram', 'bramiscool', '2016-05-27 11:57:17'),
(8, 'Rob', 'robiscool', '2016-05-27 11:57:17'),
(9, 'Stan', 'staniscool', '2016-05-27 11:57:17'),
(10, 'Joris', 'jorisiscool', '2016-05-27 11:57:17');

/*INSERT INTO `vak` (`ID`, `Naam`, `Leerjaar`, `Niveau`) VALUES
(1, 'Engels', 4, 'Havo');*/

INSERT INTO `klas` (`ID`, `GegevenVak`) VALUES
(1, 'Engels');

INSERT INTO `leerling_klas` (`Leerling_ID`, `Klas_ID`) VALUES
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1);

INSERT INTO `toets` (`ID`, `Naam`, `Aanmaakdatum`, `Toetsdatum`, `Klas_ID`) VALUES
(1, 'Unit 1', '2016-05-27 12:02:07', '2016-05-30 11:00:00', 1);

INSERT INTO `vraag` (`ID`, `Vraag`, `Antwoord`, `ContextZin`, `ContextAfb`) VALUES
(1, 'independence', 'onafhankelijkheid', NULL, NULL),
(2, 'city', 'stad', 'Welcome to the city Amsterdam', NULL),
(3, 'rhythm', 'ritme', 'That music has nice rhythm', NULL);

INSERT INTO `toets_vraag` (`Toets_ID`, `Vraag_ID`) VALUES
(1, 1),
(1, 2),
(1, 3);