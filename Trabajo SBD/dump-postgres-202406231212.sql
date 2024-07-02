--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Ubuntu 16.3-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-0ubuntu0.24.04.1)

-- Started on 2024-06-23 12:12:18 CDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 24761)
-- Name: asistente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistente (
    no_tarjeta integer NOT NULL,
    no_chef_jefe integer NOT NULL,
    clave_acces integer NOT NULL,
    confirmacion_asis boolean NOT NULL,
    id_participante integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE public.asistente OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN asistente.no_tarjeta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.asistente.no_tarjeta IS 'Identifica al asistente por su numero de tarjeta';


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN asistente.no_chef_jefe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.asistente.no_chef_jefe IS 'Identifica al jefe de cada asistente a traves de su numero d tarjeta';


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN asistente.clave_acces; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.asistente.clave_acces IS 'Clave para acceder a la pagina del evento';


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN asistente.confirmacion_asis; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.asistente.confirmacion_asis IS 'Indica si el asistente ha confirmado su asistencia al evento';


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN asistente.id_participante; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.asistente.id_participante IS 'Identificador del participante';


--
-- TOC entry 216 (class 1259 OID 24768)
-- Name: chef; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chef (
    "no-tarjeta" integer NOT NULL,
    clave_acces integer NOT NULL,
    tarjetas_asistentes integer NOT NULL
);


ALTER TABLE public.chef OWNER TO postgres;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN chef."no-tarjeta"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.chef."no-tarjeta" IS 'Identificamos al chef por su numero de tarjeta';


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN chef.clave_acces; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.chef.clave_acces IS 'Clave para acceder a la pagina del evento';


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN chef.tarjetas_asistentes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.chef.tarjetas_asistentes IS 'Tdentifica a los asistentes de cada chef';


--
-- TOC entry 217 (class 1259 OID 24775)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento (
    nombre character varying DEFAULT '1'::character varying NOT NULL,
    id_patrocinadores integer NOT NULL,
    fecha date NOT NULL,
    id_asistentes_confirmados integer NOT NULL
);


ALTER TABLE public.evento OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN evento.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.evento.nombre IS 'Nombre de este evento nos sirve como su identificador';


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN evento.id_patrocinadores; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.evento.id_patrocinadores IS 'Identifica a los organizadores del evento';


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN evento.fecha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.evento.fecha IS 'Fecha del evento';


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN evento.id_asistentes_confirmados; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.evento.id_asistentes_confirmados IS 'Identifica a los asistentes q confirmaron';


--
-- TOC entry 218 (class 1259 OID 24789)
-- Name: ingredientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredientes (
    nombreingr character varying NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE public.ingredientes OWNER TO postgres;

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN ingredientes.nombreingr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.ingredientes.nombreingr IS 'Identificaremos al ingrediente por su nombre';


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN ingredientes.descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.ingredientes.descripcion IS 'Descripcion del ingrediente';


--
-- TOC entry 226 (class 1259 OID 24860)
-- Name: organiador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organiador (
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    no_tarjeta_orga integer NOT NULL
);


ALTER TABLE public.organiador OWNER TO postgres;

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE organiador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.organiador IS 'esta tabla representa la generalizacion entre los organizadores';


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN organiador.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organiador.nombre IS 'Nombres de los organizadores';


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN organiador.apellido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organiador.apellido IS 'Apellidos de los organizadores';


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN organiador.no_tarjeta_orga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organiador.no_tarjeta_orga IS 'Identificador de los organizadores';


--
-- TOC entry 219 (class 1259 OID 24796)
-- Name: organizador1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizador1 (
    nombre character varying NOT NULL,
    "1er_apellido" character varying NOT NULL,
    no_tarjeta_orga integer DEFAULT 7979 NOT NULL,
    clave_acces integer NOT NULL
);


ALTER TABLE public.organizador1 OWNER TO postgres;

--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN organizador1.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador1.nombre IS 'Nombre del organizador';


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN organizador1."1er_apellido"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador1."1er_apellido" IS 'Primer apellido del organizador';


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN organizador1.no_tarjeta_orga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador1.no_tarjeta_orga IS 'Identificamos a este organizador por su numero de tarjeta';


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN organizador1.clave_acces; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador1.clave_acces IS 'Clave para acceder a la pagina del evento';


--
-- TOC entry 220 (class 1259 OID 24804)
-- Name: organizador2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizador2 (
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    no_tarjeta_orga integer DEFAULT 8989 NOT NULL,
    clave_acces integer NOT NULL
);


ALTER TABLE public.organizador2 OWNER TO postgres;

--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN organizador2.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador2.nombre IS 'Nombre del organizador';


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN organizador2.apellido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador2.apellido IS 'Apellido del organizador';


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN organizador2.no_tarjeta_orga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador2.no_tarjeta_orga IS 'Identifica al organizador';


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN organizador2.clave_acces; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador2.clave_acces IS 'Clave para acceder a la pagina del evento';


--
-- TOC entry 221 (class 1259 OID 24812)
-- Name: organizador3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizador3 (
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    no_tarjeta_orga integer NOT NULL,
    clave_de_acceso integer NOT NULL
);


ALTER TABLE public.organizador3 OWNER TO postgres;

--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN organizador3.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador3.nombre IS 'Nombre del organizador';


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN organizador3.apellido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador3.apellido IS 'Apellido del organizador';


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN organizador3.no_tarjeta_orga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador3.no_tarjeta_orga IS 'Identifica al organizador por su numero de tarjeta';


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN organizador3.clave_de_acceso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.organizador3.clave_de_acceso IS 'Clave para acceder a la pagina del evento';


--
-- TOC entry 222 (class 1259 OID 24825)
-- Name: participante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participante (
    no_tarjeta integer NOT NULL,
    clave_de_acces integer NOT NULL,
    nombre_evento character varying NOT NULL
);


ALTER TABLE public.participante OWNER TO postgres;

--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN participante.no_tarjeta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.participante.no_tarjeta IS 'Identificaremos a los participantes por su numero de tarjeta';


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN participante.clave_de_acces; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.participante.clave_de_acces IS 'Clave para acceder a la paguina del evento';


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN participante.nombre_evento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.participante.nombre_evento IS 'Nombre del evento';


--
-- TOC entry 223 (class 1259 OID 24832)
-- Name: patrocinador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patrocinador (
    nombre character varying NOT NULL,
    ido integer NOT NULL,
    apllido character varying NOT NULL,
    clave_acces integer NOT NULL
);


ALTER TABLE public.patrocinador OWNER TO postgres;

--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN patrocinador.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.patrocinador.nombre IS 'Nombre del patrocinador';


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN patrocinador.ido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.patrocinador.ido IS 'Identificamos al patrocinador por su id';


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN patrocinador.apllido; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.patrocinador.apllido IS 'Apellido del patrocinador';


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN patrocinador.clave_acces; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.patrocinador.clave_acces IS 'Clave para acceder a la pagina del evento';


--
-- TOC entry 224 (class 1259 OID 24839)
-- Name: receta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receta (
    nombre_receta character varying NOT NULL,
    ingredientes character varying NOT NULL,
    descripcion character varying
);


ALTER TABLE public.receta OWNER TO postgres;

--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN receta.nombre_receta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.receta.nombre_receta IS 'Identificaremos a la receta por su nombre';


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN receta.ingredientes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.receta.ingredientes IS 'Ingredientes que tendra la receta';


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN receta.descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.receta.descripcion IS 'Breve descripcion de la receta';


--
-- TOC entry 225 (class 1259 OID 24848)
-- Name: utiliza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utiliza (
    id_utiliza integer NOT NULL,
    nombre_ingredientes character varying NOT NULL,
    recetas character varying NOT NULL
);


ALTER TABLE public.utiliza OWNER TO postgres;

--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN utiliza.id_utiliza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.utiliza.id_utiliza IS 'Identificador unico de la relacion';


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN utiliza.nombre_ingredientes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.utiliza.nombre_ingredientes IS 'Ingredientes utilizados';


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN utiliza.recetas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.utiliza.recetas IS 'Recetas que utilizan el ingrediente';


--
-- TOC entry 3513 (class 0 OID 24761)
-- Dependencies: 215
-- Data for Name: asistente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.asistente VALUES (9876, 8754, 1234, true, 9876, 'Leonel');
INSERT INTO public.asistente VALUES (4565, 6777, 4321, true, 4565, 'Pedrito');
INSERT INTO public.asistente VALUES (6534, 3452, 1234, false, 6534, 'Leo');
INSERT INTO public.asistente VALUES (5556, 8754, 1233, false, 5556, 'Ñego');


--
-- TOC entry 3514 (class 0 OID 24768)
-- Dependencies: 216
-- Data for Name: chef; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chef VALUES (8754, 1234, 5556);
INSERT INTO public.chef VALUES (3452, 4665, 6534);
INSERT INTO public.chef VALUES (4556, 4278, 9808);
INSERT INTO public.chef VALUES (6777, 7970, 4565);


--
-- TOC entry 3515 (class 0 OID 24775)
-- Dependencies: 217
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.evento VALUES ('Sabor Cubano', 7878, '2024-06-30', 1234);


--
-- TOC entry 3516 (class 0 OID 24789)
-- Dependencies: 218
-- Data for Name: ingredientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3524 (class 0 OID 24860)
-- Dependencies: 226
-- Data for Name: organiador; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organiador VALUES ('Zahidel', 'Pedroso', 7979);
INSERT INTO public.organiador VALUES ('Yulesky', 'Gonzales', 8989);
INSERT INTO public.organiador VALUES ('Eliodani', 'Izquierdo', 9999);


--
-- TOC entry 3517 (class 0 OID 24796)
-- Dependencies: 219
-- Data for Name: organizador1; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organizador1 VALUES ('Zahidel', 'Pedroso', 7979, 1234);


--
-- TOC entry 3518 (class 0 OID 24804)
-- Dependencies: 220
-- Data for Name: organizador2; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organizador2 VALUES ('Yulesky', 'Gonzales', 8989, 1234);


--
-- TOC entry 3519 (class 0 OID 24812)
-- Dependencies: 221
-- Data for Name: organizador3; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.organizador3 VALUES ('Eliodani', 'Izquierdo', 9999, 1234);


--
-- TOC entry 3520 (class 0 OID 24825)
-- Dependencies: 222
-- Data for Name: participante; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3521 (class 0 OID 24832)
-- Dependencies: 223
-- Data for Name: patrocinador; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patrocinador VALUES ('Lieter', 1111, 'Macha', 1233);
INSERT INTO public.patrocinador VALUES ('Ernesto', 2222, 'Rodriguez', 1234);
INSERT INTO public.patrocinador VALUES ('Yuya', 3333, 'Pupi', 1234);
INSERT INTO public.patrocinador VALUES ('Dayma', 3434, 'Zamora', 1234);
INSERT INTO public.patrocinador VALUES ('Tere', 5342, 'Gomez', 1234);


--
-- TOC entry 3522 (class 0 OID 24839)
-- Dependencies: 224
-- Data for Name: receta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3523 (class 0 OID 24848)
-- Dependencies: 225
-- Data for Name: utiliza; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3335 (class 2606 OID 24765)
-- Name: asistente asistente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asistente
    ADD CONSTRAINT asistente_pk PRIMARY KEY (no_tarjeta);


--
-- TOC entry 3337 (class 2606 OID 24767)
-- Name: asistente asistente_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asistente
    ADD CONSTRAINT asistente_unique UNIQUE (no_chef_jefe, clave_acces, id_participante);


--
-- TOC entry 3339 (class 2606 OID 24772)
-- Name: chef chef_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chef
    ADD CONSTRAINT chef_pk PRIMARY KEY ("no-tarjeta");


--
-- TOC entry 3341 (class 2606 OID 24774)
-- Name: chef chef_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chef
    ADD CONSTRAINT chef_unique UNIQUE (tarjetas_asistentes);


--
-- TOC entry 3343 (class 2606 OID 24782)
-- Name: evento evento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pk PRIMARY KEY (nombre);


--
-- TOC entry 3345 (class 2606 OID 24784)
-- Name: evento evento_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_unique UNIQUE (id_asistentes_confirmados);


--
-- TOC entry 3347 (class 2606 OID 24786)
-- Name: evento evento_unique_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_unique_1 UNIQUE (id_patrocinadores);


--
-- TOC entry 3349 (class 2606 OID 24788)
-- Name: evento evento_unique_2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_unique_2 UNIQUE (fecha);


--
-- TOC entry 3351 (class 2606 OID 24795)
-- Name: ingredientes ingredientes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredientes
    ADD CONSTRAINT ingredientes_pk PRIMARY KEY (nombreingr);


--
-- TOC entry 3369 (class 2606 OID 24866)
-- Name: organiador organiador_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organiador
    ADD CONSTRAINT organiador_pk PRIMARY KEY (no_tarjeta_orga);


--
-- TOC entry 3353 (class 2606 OID 24803)
-- Name: organizador1 organizador1_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizador1
    ADD CONSTRAINT organizador1_pk PRIMARY KEY (no_tarjeta_orga);


--
-- TOC entry 3355 (class 2606 OID 24811)
-- Name: organizador2 organizador2_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizador2
    ADD CONSTRAINT organizador2_pk PRIMARY KEY (no_tarjeta_orga);


--
-- TOC entry 3357 (class 2606 OID 24818)
-- Name: organizador3 organizador3_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizador3
    ADD CONSTRAINT organizador3_pk PRIMARY KEY (no_tarjeta_orga);


--
-- TOC entry 3361 (class 2606 OID 24838)
-- Name: patrocinador organizador_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinador
    ADD CONSTRAINT organizador_pk PRIMARY KEY (ido);


--
-- TOC entry 3359 (class 2606 OID 24829)
-- Name: participante participante_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT participante_pk PRIMARY KEY (no_tarjeta);


--
-- TOC entry 3363 (class 2606 OID 24845)
-- Name: receta receta_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receta
    ADD CONSTRAINT receta_pk PRIMARY KEY (nombre_receta);


--
-- TOC entry 3365 (class 2606 OID 24847)
-- Name: receta receta_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receta
    ADD CONSTRAINT receta_unique UNIQUE (ingredientes);


--
-- TOC entry 3367 (class 2606 OID 24852)
-- Name: utiliza utiliza_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utiliza
    ADD CONSTRAINT utiliza_pk PRIMARY KEY (id_utiliza);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE ingredientes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.ingredientes TO organizador1;


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE participante; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.participante TO organizador3;


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE patrocinador; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.patrocinador TO organizador3;


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE receta; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.receta TO organizador1;


--
-- TOC entry 2081 (class 826 OID 24755)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT USAGE ON SEQUENCES TO organizador;


-- Completed on 2024-06-23 12:12:18 CDT

--
-- PostgreSQL database dump complete
--

