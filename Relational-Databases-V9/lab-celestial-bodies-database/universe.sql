--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    age_in_millions_of_years integer,
    distance_from_earth_in_lightyears integer,
    has_life boolean,
    is_spherical boolean,
    reflectivity numeric(4,3)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    age_in_millions_of_years integer,
    distance_from_earth_in_millkm integer,
    has_life boolean,
    is_spherical boolean,
    reflectivity numeric(4,3),
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: nebula; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.nebula (
    nebula_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    age_in_millions_of_years integer,
    distance_from_earth_in_millkm integer,
    has_life boolean,
    is_spherical boolean,
    reflectivity numeric(4,3)
);


ALTER TABLE public.nebula OWNER TO freecodecamp;

--
-- Name: nebula_nebula_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.nebula_nebula_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nebula_nebula_id_seq OWNER TO freecodecamp;

--
-- Name: nebula_nebula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.nebula_nebula_id_seq OWNED BY public.nebula.nebula_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    age_in_millions_of_years integer,
    distance_from_earth_in_millkm integer,
    has_life boolean,
    is_spherical boolean,
    reflectivity numeric(4,3),
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    age_in_millions_of_years integer,
    distance_from_earth_in_lightyears integer,
    has_life boolean,
    is_spherical boolean,
    reflectivity numeric(4,3),
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: nebula nebula_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.nebula ALTER COLUMN nebula_id SET DEFAULT nextval('public.nebula_nebula_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Vía Láctea', 'Nuestra galaxia, espiral barrada con ~200 mil millones de estrellas', 13600, NULL, true, true, 0.200);
INSERT INTO public.galaxy VALUES (3, 'Sombrero (M104)', 'Galaxia espiral con núcleo brillante y halo extenso', 13000, 29, false, true, 0.300);
INSERT INTO public.galaxy VALUES (2, 'Andrómeda (M31)', 'Galaxia espiral más cercana, colisionará con la Vía Láctea en 4.500 Ma', 10000, 3, NULL, true, 0.250);
INSERT INTO public.galaxy VALUES (4, 'Messier 87 (M87)', 'Galaxia elíptica gigante con agujero negro supermasivo', 13700, 53, false, true, 0.150);
INSERT INTO public.galaxy VALUES (5, 'Galaxias primitivas JWST', 'Seis galaxias masivas descubiertas por James Webb, formadas 500–700 Ma tras el Big Bang', 12000, 13000, false, true, 0.200);
INSERT INTO public.galaxy VALUES (6, 'Triangulum (M33)', 'Galaxia espiral pequeña, parte del Grupo Local', 10000, 3, NULL, true, 0.250);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Selene', 'Única luna terrestre', 4500, NULL, false, true, 0.120, 1);
INSERT INTO public.moon VALUES (2, 'Ío', 'Volcánica, muy activa', 4500, 628, false, true, 0.630, 5);
INSERT INTO public.moon VALUES (3, 'Europa', 'Océano bajo hielo', 4500, 628, true, true, 0.670, 5);
INSERT INTO public.moon VALUES (4, 'Ganimedes', 'Mayor luna del Sistema Solar', 4500, 628, true, true, 0.430, 5);
INSERT INTO public.moon VALUES (5, 'Calisto', 'Superficie muy craterizada', 4500, 628, false, true, 0.170, 5);
INSERT INTO public.moon VALUES (6, 'Titán', 'Atmósfera densa, lagos de metano', 4500, 1200, true, true, 0.220, 6);
INSERT INTO public.moon VALUES (7, 'Encélado', 'Chorros de agua helada', 4500, 1200, true, true, 0.810, 6);
INSERT INTO public.moon VALUES (8, 'Mimas', 'Cráter enorme “Estrella de la Muerte”', 4500, 1200, false, true, 0.960, 6);
INSERT INTO public.moon VALUES (9, 'Rea', 'Superficie helada', 4500, 1200, false, true, 0.740, 6);
INSERT INTO public.moon VALUES (10, 'Japeto', 'Mitad clara, mitad oscura', 4500, 1200, false, true, 0.050, 6);
INSERT INTO public.moon VALUES (11, 'Tritón', 'Órbita retrógrada, géiseres', 4500, 4300, true, true, 0.760, 8);
INSERT INTO public.moon VALUES (12, 'Nereida', 'Órbita muy excéntrica', 4500, 4300, false, false, 0.160, 8);
INSERT INTO public.moon VALUES (13, 'Fobos', 'Pequeña, irregular', 4500, 225, false, false, 0.070, 4);
INSERT INTO public.moon VALUES (14, 'Deimos', 'Más pequeña que Fobos', 4500, 225, false, false, 0.080, 4);
INSERT INTO public.moon VALUES (15, 'Miranda', 'Superficie fracturada', 4500, 2900, false, true, 0.320, 7);
INSERT INTO public.moon VALUES (16, 'Ariel', 'Superficie helada', 4500, 2900, false, true, 0.390, 7);
INSERT INTO public.moon VALUES (17, 'Umbriel', 'Oscura, helada', 4500, 2900, false, true, 0.210, 7);
INSERT INTO public.moon VALUES (18, 'Titania', 'Mayor luna de Urano', 4500, 2900, false, true, 0.270, 7);
INSERT INTO public.moon VALUES (19, 'Oberón', 'Cráteres y montañas', 4500, 2900, false, true, 0.310, 7);
INSERT INTO public.moon VALUES (20, 'Charón', 'Casi del tamaño de Plutón', 4500, 5900, true, true, 0.350, 9);


--
-- Data for Name: nebula; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.nebula VALUES (1, 'Nebulosa de Orión (M42)', 'Región de formación estelar en la constelación de Orión', 3, 1344, false, false, 0.200);
INSERT INTO public.nebula VALUES (2, 'Nebulosa del Cangrejo (M1)', 'Restos de supernova observada en 1054', 1, 6500, false, false, 0.100);
INSERT INTO public.nebula VALUES (3, 'Nebulosa de la Hélice (NGC 7293)', 'Nebulosa planetaria, restos de una estrella moribunda', 10, 650, false, true, 0.300);
INSERT INTO public.nebula VALUES (4, 'Nebulosa de la Laguna (M8)', 'Región de formación estelar en Sagitario', 2, 4100, NULL, false, 0.250);
INSERT INTO public.nebula VALUES (5, 'Nebulosa de la Quilla (Carina, NGC 3372)', 'Una de las más grandes y brillantes, alberga Eta Carinae', 4, 7500, NULL, false, 0.200);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (3, 'Tierra', 'Nuestro planeta, atmósfera rica en oxígeno', 4500, NULL, true, true, 0.306, 1);
INSERT INTO public.planet VALUES (6, 'Saturno', 'Gigante gaseoso con anillos espectaculares', 4500, 1450, false, true, 0.470, 1);
INSERT INTO public.planet VALUES (7, 'Urano', 'Gigante helado, rotación inclinada', 4500, 2900, false, true, 0.510, 1);
INSERT INTO public.planet VALUES (8, 'Neptuno', 'Gigante helado, vientos extremos', 4500, 4500, false, true, 0.410, 1);
INSERT INTO public.planet VALUES (9, 'Plutón', 'Mundo helado, atmósfera tenue', 4500, 4500, NULL, true, 0.520, 1);
INSERT INTO public.planet VALUES (10, 'Ceres', 'En el cinturón de asteroides, hielo y sales', 4500, 413, NULL, true, 0.090, 1);
INSERT INTO public.planet VALUES (11, 'Eris', 'Más masivo que Plutón, muy lejano', 4500, 10100, false, true, 0.960, 1);
INSERT INTO public.planet VALUES (12, 'Haumea', 'Forma elipsoidal, superficie helada', 4500, 6450, false, false, 0.730, 1);
INSERT INTO public.planet VALUES (1, 'Mercurio', 'Más cercano al Sol, muy caliente', 4500, 150, false, true, 0.142, 1);
INSERT INTO public.planet VALUES (2, 'Venus', 'Atmósfera densa, efecto invernadero extremo', 4500, 150, false, true, 0.650, 1);
INSERT INTO public.planet VALUES (4, 'Marte', 'Planeta rojo, posible agua subterránea', 4500, 229, NULL, true, 0.250, 1);
INSERT INTO public.planet VALUES (5, 'Júpiter', 'Gigante gaseoso, sin superficie sólida', 4500, 778, false, true, 0.520, 1);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sol', 'Nuestra estrella, tipo G2V, fuente de energía para la Tierra', 4600, NULL, false, true, 0.300, 1);
INSERT INTO public.star VALUES (2, 'Sirio A', 'Estrella más brillante del cielo nocturno, tipo A1V', 250, 9, false, true, 0.400, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 'Supergigante roja en Orión, cercana a explotar como supernova', 10, 642, false, true, 0.100, 1);
INSERT INTO public.star VALUES (4, 'Proxima Centauri', 'Enana roja, estrella más cercana al Sol', 4850, 4, false, true, 0.200, 1);
INSERT INTO public.star VALUES (5, 'Rigel', 'Supergigante azul en Orión, muy luminosa', 8, 860, false, true, 0.350, 1);
INSERT INTO public.star VALUES (6, 'Vega', 'Estrella brillante en la constelación de Lira, tipo A0V', 455, 25, false, true, 0.500, 1);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: nebula_nebula_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.nebula_nebula_id_seq', 5, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: nebula nebula_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.nebula
    ADD CONSTRAINT nebula_name_key UNIQUE (name);


--
-- Name: nebula nebula_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.nebula
    ADD CONSTRAINT nebula_pkey PRIMARY KEY (nebula_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

