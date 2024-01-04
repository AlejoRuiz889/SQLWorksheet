CREATE DATABASE ligafutbolcorhuila;

CREATE TABLE persona (
    id SERIAL PRIMARY KEY,
    nacionalidad VARCHAR(255) NOT NULL,
    pri_nombre VARCHAR(255) NOT NULL,
    seg_nombre VARCHAR(255),
    pri_apellido VARCHAR(50) NOT NULL,
    seg_apellido VARCHAR(50),
    fecha_naci DATE NOT NULL);


CREATE TABLE jugador(
    id_persona INTEGER PRIMARY KEY,
    num_cami INTEGER NOT NULL,
    apodo VARCHAR(255),
    alturacm NUMERIC(5,2) NOT NULL,
    posicion VARCHAR(50) NOT NULL,
    pesokg NUMERIC(5,2) NOT NULL,
    id_equipo INTEGER,
    FOREIGN KEY (id_persona) REFERENCES persona(id) ) INHERITS (persona);

CREATE TABLE entrenador_pertenece_equipo(
    id_persona INTEGER PRIMARY KEY,
    nombre_equipo VARCHAR(50) UNIQUE NOT NULL,
    year_inicio_act DATE NOT NULL,
    id_entre INTEGER,
    exp_entre  INTEGER NOT NULL,
    id_estadio INTEGER,
    FOREIGN KEY (id_persona) REFERENCES persona(id) ) INHERITS (persona);

CREATE TABLE estadio(
    id SERIAL PRIMARY KEY,
    nombre_est VARCHAR(255) UNIQUE NOT NULL,
    capacidad_max INTEGER NOT NULL,
    id_ciudad INTEGER );

ALTER TABLE entrenador_pertenece_equipo
ADD CONSTRAINT estadio_entrenador_pertenece_equipo_fk
FOREIGN KEY (id_estadio)
References estadio(id);

CREATE TABLE ciudad(
    id SERIAL PRIMARY KEY,
    municipio VARCHAR(100) NOT NULL,
    barrio VARCHAR(255),
    calle VARCHAR(255),
    numero VARCHAR(20));

ALTER TABLE estadio
ADD CONSTRAINT ciudad_estadio_fk
FOREIGN KEY (id_ciudad)
References ciudad(id);


CREATE TABLE equipo_loc(
    id INTEGER PRIMARY KEY,
    asis_loc INTEGER NOT NULL,
    tiros_loc INTEGER NOT NULL,
    tarjetaama_loc INTEGER NOT NULL,
    tarjetaroja_loc INTEGER NOT NULL,
    falta_loc INTEGER NOT NULL,
    posesion_vis INTEGER NOT NULL,
    gol_loc INTEGER NOT NULL,
    FOREIGN KEY (id) REFERENCES entrenador_pertenece_equipo(id_persona) ) INHERITS (entrenador_pertenece_equipo);

CREATE TABLE equipo_vis(
    id INTEGER PRIMARY KEY,
    asis_vis INTEGER NOT NULL,
    tiros_vis INTEGER NOT NULL,
    tarjetaama_vis INTEGER NOT NULL,
    tarjetaroja_vis INTEGER NOT NULL,
    falta_vis INTEGER NOT NULL,
    posesion_vis INTEGER NOT NULL,
    gol_vis INTEGER NOT NULL,
    FOREIGN KEY (id) REFERENCES entrenador_pertenece_equipo(id_persona) ) INHERITS (entrenador_pertenece_equipo);

CREATE TABLE partido(
    id SERIAL PRIMARY KEY,
    tiempo_part TIME NOT NULL,
    extra_pri_tiempo INTEGER NOT NULL,
    extra_seg_tiempo INTEGER NOT NULL,
    fecha_partido DATE NOT NULL,
    id_estadio INTEGER,
    id_equipo_vis INTEGER,
    id_equipo_loc INTEGER,
    id_resultado INTEGER );

CREATE TABLE resultado(
    id SERIAL PRIMARY KEY,
    marcador_parcial VARCHAR(5) NOT NULL,
    marcador_final VARCHAR(5) NOT NULL,
    id_jornada INTEGER );

CREATE TABLE arbitro(
    id SERIAL PRIMARY KEY,
    pri_nom_arb VARCHAR(255) NOT NULL,
    seg_nom_arb VARCHAR(255),
    pri_ape_arb VARCHAR(50) NOT NULL,
    seg_ape_arb VARCHAR(50),
    pos_arb VARCHAR(100),
    nacionalidad VARCHAR(100) NOT NULL);

    CREATE TABLE arbitro_partido (
    id_arbitro INTEGER,
    id_partido INTEGER,
    PRIMARY KEY (id_arbitro, id_partido),
    FOREIGN KEY (id_arbitro) REFERENCES arbitro(id),
    FOREIGN KEY (id_partido) REFERENCES partido(id));

CREATE TABLE jornada(
    id SERIAL PRIMARY KEY,
    no_jornada INTEGER NOT NULL,
    part_jugados INTEGER NOT NULL,
    part_ganados INTEGER NOT NULL,
    part_perdidos INTEGER NOT NULL,
    puntos INTEGER NOT NULL,
    diferencia_goles INTEGER NOT NULL,
    goles_en_contra INTEGER NOT NULL,
    goles_a_favor INTEGER NOT NULL,
    id_temporada INTEGER );

CREATE TABLE temporada(
    id SERIAL PRIMARY KEY,
    year_temp DATE NOT NULL);



ALTER TABLE partido
ADD CONSTRAINT estadio_partido_fk
FOREIGN KEY (id_estadio)
References estadio(id);

ALTER TABLE partido
ADD CONSTRAINT equipo_vis_partido_fk
FOREIGN KEY (id_equipo_vis)
References equipo_vis(id);

ALTER TABLE partido
ADD CONSTRAINT equipo_loc_partido_fk
FOREIGN KEY (id_equipo_loc)
References equipo_loc(id);

ALTER TABLE partido
ADD CONSTRAINT partido_resultado_fk
FOREIGN KEY (id_resultado)
References resultado(id);

ALTER TABLE resultado
ADD CONSTRAINT jornada_resultado_fk
FOREIGN KEY (id_jornada)
References jornada(id);

ALTER TABLE jornada
ADD CONSTRAINT temporada_jornada_fk
FOREIGN KEY (id_temporada)
References temporada(id);


