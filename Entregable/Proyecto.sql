DROP TABLE diagnostico CASCADE CONSTRAINTS;

DROP TABLE diagnostico_ge CASCADE CONSTRAINTS;

DROP TABLE empleado CASCADE CONSTRAINTS;

DROP TABLE evaluacion CASCADE CONSTRAINTS;

DROP TABLE genero CASCADE CONSTRAINTS;

DROP TABLE lista_tratamiento CASCADE CONSTRAINTS;

DROP TABLE paciente CASCADE CONSTRAINTS;

DROP TABLE profesion CASCADE CONSTRAINTS;

DROP TABLE sintoma CASCADE CONSTRAINTS;

DROP TABLE tratamiento CASCADE CONSTRAINTS;

CREATE SEQUENCE TEST_ID_SEQ
INCREMENT BY 1
START WITH 1
MAXVALUE 999999999
NOCYCLE
NOCACHE;

CREATE TABLE diagnostico (
    id_diagnostico NUMBER NOT NULL PRIMARY KEY,
    nombre_diag VARCHAR(25 CHAR) NOT NULL
);

CREATE TABLE diagnostico_ge (
    id_diagnostico_ge NUMBER NOT NULL PRIMARY KEY,
    rango NUMBER NOT NULL,
    sintoma NUMBER NOT NULL,
    diagnostico NUMBER NOT NULL
);

CREATE TABLE empleado (
    id_empleado NUMBER NOT NULL PRIMARY KEY,
    nombre_em VARCHAR(30) NOT NULL,
    apellidos_em VARCHAR(30) NOT NULL,
    direccion_em VARCHAR(50) NOT NULL,
    telefono_em  VARCHAR(15),
    fecha_nac_em DATE NOT NULL,
    profesion NUMBER NOT NULL
);


CREATE TABLE evaluacion (
    empleado NUMBER NOT NULL,
    paciente NUMBER NOT NULL,
    fecha_ev DATE NOT NULL, 
    diagnostico_ge NUMBER NOT NULL
);


CREATE TABLE genero (
    id_genero NUMBER NOT NULL PRIMARY KEY,
    nombre_ge  CHAR NOT NULL
);


CREATE TABLE lista_tratamiento (
    id_lista NUMBER NOT NULL PRIMARY KEY,
    paciente NUMBER NOT NULL,
    tratamiento NUMBER
);

CREATE TABLE paciente (
    id_paciente NUMBER NOT NULL PRIMARY KEY,
    nombre_pa VARCHAR(30) NOT NULL,
    apellidos_pa VARCHAR(30) NOT NULL,
    direccion_pa VARCHAR(50) NOT NULL,
    telefono_pa VARCHAR(20),
    fecha_nac_pa DATE NOT NULL,
    altura NUMBER NOT NULL,
    peso NUMBER NOT NULL,
    genero NUMBER NOT NULL
);


CREATE TABLE profesion (
    id_profesion NUMBER NOT NULL PRIMARY KEY,
    nombre_profesion VARCHAR(30) NOT NULL
);


CREATE TABLE sintoma (
    id_sintoma     NUMBER NOT NULL PRIMARY KEY,
    nombre_sintoma VARCHAR(30) NOT NULL
);


CREATE TABLE tratamiento (
    id_trat    NUMBER NOT NULL PRIMARY KEY,
    nombre_tra VARCHAR(30) NOT NULL
);


ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pk PRIMARY KEY (empleado, paciente);


ALTER TABLE diagnostico_ge
    ADD CONSTRAINT diag_ge_diag_fk FOREIGN KEY (diagnostico)
        REFERENCES diagnostico (id_diagnostico);

ALTER TABLE diagnostico_ge
    ADD CONSTRAINT diag_ge_sint_fk FOREIGN KEY (sintoma)
        REFERENCES sintoma (id_sintoma);

ALTER TABLE empleado
    ADD CONSTRAINT empleado_profesion_fk FOREIGN KEY (profesion)
        REFERENCES profesion (id_profesion);

ALTER TABLE evaluacion
    ADD CONSTRAINT ev_diag_ge_fk FOREIGN KEY (diagnostico_ge)
        REFERENCES diagnostico_ge (id_diagnostico_ge);

ALTER TABLE evaluacion
    ADD CONSTRAINT ev_empleado_fk FOREIGN KEY (empleado)
        REFERENCES empleado (id_empleado);

ALTER TABLE evaluacion
    ADD CONSTRAINT ev_paciente_fk FOREIGN KEY (paciente)
        REFERENCES paciente (id_paciente);

ALTER TABLE lista_tratamiento
    ADD CONSTRAINT lista_tra_paciente_fk FOREIGN KEY (paciente)
        REFERENCES paciente (id_paciente);

ALTER TABLE lista_tratamiento
    ADD CONSTRAINT lista_trat_trat_fk FOREIGN KEY (tratamiento)
        REFERENCES tratamiento (id_trat);

ALTER TABLE paciente
    ADD CONSTRAINT paciente_genero_fk FOREIGN KEY (genero)
        REFERENCES genero (id_genero);
