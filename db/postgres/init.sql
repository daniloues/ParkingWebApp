CREATE TABLE public.area (id_area integer NOT NULL,
                                          id_area_padre integer, nombre CHARACTER varying(155),
                                                                                  descripcion text);


CREATE SEQUENCE public.area_id_area_seq AS integer
START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER SEQUENCE public.area_id_area_seq OWNED BY public.area.id_area;


CREATE TABLE public.espacio (id_espacio bigint NOT NULL,
                                               id_area integer, nombre CHARACTER varying(155),
                                                                                 observaciones text, activo boolean DEFAULT TRUE);


CREATE TABLE public.espacio_caracteristica (id_espacio_caracteristica bigint NOT NULL,
                                                                             id_espacio bigint, id_tipo_espacio integer, descripcion text, valor text);


CREATE SEQUENCE public.espacio_caracteristica_id_espacio_caracteristica_seq
START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER SEQUENCE public.espacio_caracteristica_id_espacio_caracteristica_seq OWNED BY public.espacio_caracteristica.id_espacio_caracteristica;


CREATE SEQUENCE public.espacio_id_espacio_seq
START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER SEQUENCE public.espacio_id_espacio_seq OWNED BY public.espacio.id_espacio;


CREATE TABLE public.reserva (id_reserva bigint NOT NULL,
                                               id_espacio bigint, desde timestamp WITH TIME ZONE DEFAULT now(),
                                                                                                         hasta timestamp WITH TIME ZONE,
                                                                                                                                   observaciones text, id_tipo_reserva integer);


CREATE TABLE public.reserva_historial (id_reserva_historial bigint NOT NULL,
                                                                   id_reserva bigint, id_tipo_reserva_secuencia bigint, fecha_alcanzado timestamp WITH TIME ZONE,
                                                                                                                                                            activo boolean);


CREATE SEQUENCE public.reserva_id_reserva_seq
START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER SEQUENCE public.reserva_id_reserva_seq OWNED BY public.reserva.id_reserva;


CREATE TABLE public.tipo_espacio (id_tipo_espacio integer NOT NULL,
                                                          nombre CHARACTER varying(155));


CREATE TABLE public.tipo_reserva (id_tipo_reserva integer NOT NULL,
                                                          nombre CHARACTER varying(155),
                                                                           publico boolean, descripcion text);


CREATE SEQUENCE public.tipo_reserva_id_tipo_reserva_seq AS integer
START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER SEQUENCE public.tipo_reserva_id_tipo_reserva_seq OWNED BY public.tipo_reserva.id_tipo_reserva;


CREATE TABLE public.tipo_reserva_secuencia (id_tipo_reserva_secuencia bigint NOT NULL,
                                                                             id_tipo_reserva_secuencia_padre bigint, indica_fin boolean, nombre CHARACTER varying(155),
                                                                                                                                                          id_tipo_reserva integer);


CREATE SEQUENCE public.tipo_reserva_secuencia_id_tipo_reserva_secuencia_seq
START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER SEQUENCE public.tipo_reserva_secuencia_id_tipo_reserva_secuencia_seq OWNED BY public.tipo_reserva_secuencia.id_tipo_reserva_secuencia;


ALTER TABLE ONLY public.area
ALTER COLUMN id_area
SET DEFAULT nextval('public.area_id_area_seq'::regclass);


ALTER TABLE ONLY public.espacio
ALTER COLUMN id_espacio
SET DEFAULT nextval('public.espacio_id_espacio_seq'::regclass);


ALTER TABLE ONLY public.espacio_caracteristica
ALTER COLUMN id_espacio_caracteristica
SET DEFAULT nextval('public.espacio_caracteristica_id_espacio_caracteristica_seq'::regclass);


ALTER TABLE ONLY public.reserva
ALTER COLUMN id_reserva
SET DEFAULT nextval('public.reserva_id_reserva_seq'::regclass);


ALTER TABLE ONLY public.tipo_reserva
ALTER COLUMN id_tipo_reserva
SET DEFAULT nextval('public.tipo_reserva_id_tipo_reserva_seq'::regclass);


ALTER TABLE ONLY public.tipo_reserva_secuencia
ALTER COLUMN id_tipo_reserva_secuencia
SET DEFAULT nextval('public.tipo_reserva_secuencia_id_tipo_reserva_secuencia_seq'::regclass);


INSERT INTO public.tipo_reserva (id_tipo_reserva, nombre, publico, descripcion)
VALUES (1, 'Privada UES', FALSE, '');


INSERT INTO public.tipo_reserva (id_tipo_reserva, nombre, publico, descripcion)
VALUES (2, 'Corta Duración', TRUE, 'Parqueo público de corta duración (menos de 3 horas)');


SELECT pg_catalog.setval('public.area_id_area_seq', 1, FALSE);


SELECT pg_catalog.setval('public.espacio_caracteristica_id_espacio_caracteristica_seq', 1, FALSE);


SELECT pg_catalog.setval('public.espacio_id_espacio_seq', 1, FALSE);


SELECT pg_catalog.setval('public.reserva_id_reserva_seq', 1, FALSE);


SELECT pg_catalog.setval('public.tipo_reserva_id_tipo_reserva_seq', 2, TRUE);


SELECT pg_catalog.setval('public.tipo_reserva_secuencia_id_tipo_reserva_secuencia_seq', 1, FALSE);


ALTER TABLE ONLY public.area ADD CONSTRAINT pk_area PRIMARY KEY (id_area);


ALTER TABLE ONLY public.espacio ADD CONSTRAINT pk_espacio PRIMARY KEY (id_espacio);


ALTER TABLE ONLY public.espacio_caracteristica ADD CONSTRAINT pk_espacio_caracteristica PRIMARY KEY (id_espacio_caracteristica);


ALTER TABLE ONLY public.reserva ADD CONSTRAINT pk_reserva PRIMARY KEY (id_reserva);


ALTER TABLE ONLY public.reserva_historial ADD CONSTRAINT pk_reserva_historial PRIMARY KEY (id_reserva_historial);


ALTER TABLE ONLY public.tipo_espacio ADD CONSTRAINT pk_tipo_espacio PRIMARY KEY (id_tipo_espacio);


ALTER TABLE ONLY public.tipo_reserva ADD CONSTRAINT pk_tipo_reserva PRIMARY KEY (id_tipo_reserva);


ALTER TABLE ONLY public.tipo_reserva_secuencia ADD CONSTRAINT pk_tipo_reserva_secuencia PRIMARY KEY (id_tipo_reserva_secuencia);


CREATE INDEX fki_fk_area_area ON public.area USING btree (id_area_padre);


CREATE INDEX fki_fk_reserva_tipo_reserva ON public.reserva USING btree (id_tipo_reserva);


CREATE INDEX fki_fk_tipo_reserva_secuencia_tipo_reserva_secuencia ON public.tipo_reserva_secuencia USING btree (id_tipo_reserva_secuencia_padre);


ALTER TABLE ONLY public.area ADD CONSTRAINT fk_area_area
FOREIGN KEY (id_area_padre) REFERENCES public.area(id_area) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.espacio ADD CONSTRAINT fk_espacio_area
FOREIGN KEY (id_area) REFERENCES public.area(id_area) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.espacio_caracteristica ADD CONSTRAINT fk_espacio_caracteristica_espacio
FOREIGN KEY (id_espacio) REFERENCES public.espacio(id_espacio) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.espacio_caracteristica ADD CONSTRAINT fk_espacio_caracteristica_tipo_espacio
FOREIGN KEY (id_tipo_espacio) REFERENCES public.tipo_espacio(id_tipo_espacio) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.reserva ADD CONSTRAINT fk_reserva_espacio
FOREIGN KEY (id_espacio) REFERENCES public.espacio(id_espacio) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.reserva_historial ADD CONSTRAINT fk_reserva_historial_reserva
FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.reserva_historial ADD CONSTRAINT fk_reserva_historial_tipo_reserva_secuencia
FOREIGN KEY (id_tipo_reserva_secuencia) REFERENCES public.tipo_reserva_secuencia(id_tipo_reserva_secuencia) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.reserva ADD CONSTRAINT fk_reserva_tipo_reserva
FOREIGN KEY (id_tipo_reserva) REFERENCES public.tipo_reserva(id_tipo_reserva) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.tipo_reserva_secuencia ADD CONSTRAINT fk_tipo_reserva_secuencia_tipo_reserva
FOREIGN KEY (id_tipo_reserva) REFERENCES public.tipo_reserva(id_tipo_reserva) ON
UPDATE CASCADE ON
DELETE RESTRICT;


ALTER TABLE ONLY public.tipo_reserva_secuencia ADD CONSTRAINT fk_tipo_reserva_secuencia_tipo_reserva_secuencia
FOREIGN KEY (id_tipo_reserva_secuencia_padre) REFERENCES public.tipo_reserva_secuencia(id_tipo_reserva_secuencia) ON
UPDATE CASCADE ON
DELETE RESTRICT;


CREATE SEQUENCE IF NOT EXISTS public.reserva_historial_id_reserva_historial_seq INCREMENT 1
START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 OWNED BY reserva_historial.id_reserva_historial;


ALTER SEQUENCE public.reserva_historial_id_reserva_historial_seq OWNER TO postgres;


ALTER TABLE public.reserva_historial
ALTER COLUMN id_reserva_historial
SET DEFAULT nextval('reserva_historial_id_reserva_historial_seq'::regclass)