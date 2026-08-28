--
-- PostgreSQL database dump
--

\restrict AtdsAoYFEbfjo2cS24RFslCQGJ8dde9BXMWM2YUFtjwSgHE4eTCgbMOdn6TG0cF

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: conversation_types; Type: TABLE; Schema: public; Owner: kadea_chat_dev
--

CREATE TABLE public.conversation_types (
    id bigint NOT NULL,
    label character varying(100) NOT NULL,
    description character varying(250)
);


ALTER TABLE public.conversation_types OWNER TO kadea_chat_dev;

--
-- Name: conversation_types_id_seq; Type: SEQUENCE; Schema: public; Owner: kadea_chat_dev
--

CREATE SEQUENCE public.conversation_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversation_types_id_seq OWNER TO kadea_chat_dev;

--
-- Name: conversation_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kadea_chat_dev
--

ALTER SEQUENCE public.conversation_types_id_seq OWNED BY public.conversation_types.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: kadea_chat_dev
--

CREATE TABLE public.conversations (
    id bigint NOT NULL,
    conversation_type_id bigint NOT NULL,
    title character varying(100),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conversations OWNER TO kadea_chat_dev;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: kadea_chat_dev
--

CREATE SEQUENCE public.conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_id_seq OWNER TO kadea_chat_dev;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kadea_chat_dev
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: message_recipients; Type: TABLE; Schema: public; Owner: kadea_chat_dev
--

CREATE TABLE public.message_recipients (
    recipient_id bigint NOT NULL,
    message_id bigint NOT NULL,
    message_status_id bigint NOT NULL,
    read_at timestamp with time zone
);


ALTER TABLE public.message_recipients OWNER TO kadea_chat_dev;

--
-- Name: message_status; Type: TABLE; Schema: public; Owner: kadea_chat_dev
--

CREATE TABLE public.message_status (
    id bigint NOT NULL,
    label character varying(100) NOT NULL,
    description character varying(250)
);


ALTER TABLE public.message_status OWNER TO kadea_chat_dev;

--
-- Name: message_status_id_seq; Type: SEQUENCE; Schema: public; Owner: kadea_chat_dev
--

CREATE SEQUENCE public.message_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_status_id_seq OWNER TO kadea_chat_dev;

--
-- Name: message_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kadea_chat_dev
--

ALTER SEQUENCE public.message_status_id_seq OWNED BY public.message_status.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: kadea_chat_dev
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    sender_id bigint CONSTRAINT messages_user_id_not_null NOT NULL,
    conversation_id bigint NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    message_type character varying(20) DEFAULT 'text'::character varying NOT NULL
);


ALTER TABLE public.messages OWNER TO kadea_chat_dev;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: kadea_chat_dev
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO kadea_chat_dev;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kadea_chat_dev
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: kadea_chat_dev
--

CREATE TABLE public.participants (
    user_id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    joined_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role character varying(25),
    CONSTRAINT check_participant_role CHECK ((((role)::text = 'admin'::text) OR ((role)::text = 'member'::text)))
);


ALTER TABLE public.participants OWNER TO kadea_chat_dev;

--
-- Name: users; Type: TABLE; Schema: public; Owner: kadea_chat_dev
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    last_name character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(100),
    email character varying(250) NOT NULL,
    password_hash character varying(300) NOT NULL,
    avatar_url character varying(250),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    phone_number character varying(25),
    bio text,
    birth_date date NOT NULL,
    is_online boolean DEFAULT false NOT NULL,
    last_seen_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_birth_date_check CHECK ((EXTRACT(year FROM age((birth_date)::timestamp with time zone)) >= (18)::numeric))
);


ALTER TABLE public.users OWNER TO kadea_chat_dev;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: kadea_chat_dev
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO kadea_chat_dev;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kadea_chat_dev
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: conversation_types id; Type: DEFAULT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.conversation_types ALTER COLUMN id SET DEFAULT nextval('public.conversation_types_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: message_status id; Type: DEFAULT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.message_status ALTER COLUMN id SET DEFAULT nextval('public.message_status_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: conversation_types; Type: TABLE DATA; Schema: public; Owner: kadea_chat_dev
--

INSERT INTO public.conversation_types VALUES (1, 'private', 'Conversation entre deux personnes');
INSERT INTO public.conversation_types VALUES (2, 'group', 'Conversation entre plusieurs personnes');


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: kadea_chat_dev
--

INSERT INTO public.conversations VALUES (1, 1, NULL, '2026-08-25 20:35:27.985838+01', '2026-08-25 20:35:27.985838+01');
INSERT INTO public.conversations VALUES (2, 2, 'Projet Messagerie', '2026-08-25 20:35:45.35388+01', '2026-08-25 20:35:45.35388+01');
INSERT INTO public.conversations VALUES (3, 2, 'groupe famille', '2026-08-25 21:14:50.445327+01', '2026-08-25 21:14:50.445327+01');
INSERT INTO public.conversations VALUES (4, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (5, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (6, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (7, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (8, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (9, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (10, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (11, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (12, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (13, 1, NULL, '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (14, 2, 'Dev Team Backend', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (15, 2, 'Projet Mobile Flutter', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (16, 2, 'Famille & Reseau', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (17, 2, 'Support Technique SI', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (18, 2, 'Design & UX Feedback', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (19, 2, 'Organisation Hackathon', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (20, 2, 'Club Cybersecurite', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (21, 2, 'Annonces Officieuses', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (22, 2, 'Formations IT 2026', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');
INSERT INTO public.conversations VALUES (23, 2, 'Equipe Base de Donnees', '2026-08-25 21:17:54.119937+01', '2026-08-25 21:17:54.119937+01');


--
-- Data for Name: message_recipients; Type: TABLE DATA; Schema: public; Owner: kadea_chat_dev
--

INSERT INTO public.message_recipients VALUES (2, 1, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 7, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 5, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 2, 1, NULL);
INSERT INTO public.message_recipients VALUES (2, 11, 1, NULL);
INSERT INTO public.message_recipients VALUES (2, 10, 1, NULL);
INSERT INTO public.message_recipients VALUES (2, 8, 1, NULL);
INSERT INTO public.message_recipients VALUES (50, 12, 1, NULL);
INSERT INTO public.message_recipients VALUES (50, 11, 1, NULL);
INSERT INTO public.message_recipients VALUES (50, 9, 1, NULL);
INSERT INTO public.message_recipients VALUES (50, 8, 1, NULL);
INSERT INTO public.message_recipients VALUES (3, 6, 1, NULL);
INSERT INTO public.message_recipients VALUES (3, 4, 1, NULL);
INSERT INTO public.message_recipients VALUES (3, 1, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 17, 1, NULL);
INSERT INTO public.message_recipients VALUES (5, 16, 1, NULL);
INSERT INTO public.message_recipients VALUES (2, 19, 1, NULL);
INSERT INTO public.message_recipients VALUES (10, 18, 1, NULL);
INSERT INTO public.message_recipients VALUES (12, 20, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 25, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 24, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 23, 1, NULL);
INSERT INTO public.message_recipients VALUES (2, 25, 1, NULL);
INSERT INTO public.message_recipients VALUES (2, 24, 1, NULL);
INSERT INTO public.message_recipients VALUES (2, 22, 1, NULL);
INSERT INTO public.message_recipients VALUES (3, 25, 1, NULL);
INSERT INTO public.message_recipients VALUES (3, 23, 1, NULL);
INSERT INTO public.message_recipients VALUES (3, 22, 1, NULL);
INSERT INTO public.message_recipients VALUES (4, 24, 1, NULL);
INSERT INTO public.message_recipients VALUES (4, 23, 1, NULL);
INSERT INTO public.message_recipients VALUES (4, 22, 1, NULL);
INSERT INTO public.message_recipients VALUES (5, 29, 1, NULL);
INSERT INTO public.message_recipients VALUES (5, 28, 1, NULL);
INSERT INTO public.message_recipients VALUES (5, 27, 1, NULL);
INSERT INTO public.message_recipients VALUES (6, 29, 1, NULL);
INSERT INTO public.message_recipients VALUES (6, 28, 1, NULL);
INSERT INTO public.message_recipients VALUES (6, 26, 1, NULL);
INSERT INTO public.message_recipients VALUES (7, 29, 1, NULL);
INSERT INTO public.message_recipients VALUES (7, 27, 1, NULL);
INSERT INTO public.message_recipients VALUES (7, 26, 1, NULL);
INSERT INTO public.message_recipients VALUES (8, 28, 1, NULL);
INSERT INTO public.message_recipients VALUES (8, 27, 1, NULL);
INSERT INTO public.message_recipients VALUES (8, 26, 1, NULL);
INSERT INTO public.message_recipients VALUES (9, 33, 1, NULL);
INSERT INTO public.message_recipients VALUES (9, 32, 1, NULL);
INSERT INTO public.message_recipients VALUES (9, 31, 1, NULL);
INSERT INTO public.message_recipients VALUES (10, 33, 1, NULL);
INSERT INTO public.message_recipients VALUES (10, 32, 1, NULL);
INSERT INTO public.message_recipients VALUES (10, 30, 1, NULL);
INSERT INTO public.message_recipients VALUES (11, 33, 1, NULL);
INSERT INTO public.message_recipients VALUES (11, 31, 1, NULL);
INSERT INTO public.message_recipients VALUES (11, 30, 1, NULL);
INSERT INTO public.message_recipients VALUES (12, 32, 1, NULL);
INSERT INTO public.message_recipients VALUES (12, 31, 1, NULL);
INSERT INTO public.message_recipients VALUES (12, 30, 1, NULL);
INSERT INTO public.message_recipients VALUES (1, 9, 3, NULL);
INSERT INTO public.message_recipients VALUES (1, 10, 3, NULL);
INSERT INTO public.message_recipients VALUES (1, 12, 3, NULL);


--
-- Data for Name: message_status; Type: TABLE DATA; Schema: public; Owner: kadea_chat_dev
--

INSERT INTO public.message_status VALUES (1, 'sent', 'Message envoye au serveur');
INSERT INTO public.message_status VALUES (2, 'delivered', 'Message livre au destinataire');
INSERT INTO public.message_status VALUES (3, 'read', 'Message lu par le destinataire');


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: kadea_chat_dev
--

INSERT INTO public.messages VALUES (1, 1, 1, false, 'premier message de la bdd de joel', '2026-08-25 20:57:02.807238+01', '2026-08-25 20:57:02.807238+01', 'text');
INSERT INTO public.messages VALUES (2, 3, 1, false, 'Tout me parait bon, on peut valider.', '2026-08-27 09:04:46.947167+01', '2026-08-27 09:04:46.947167+01', 'text');
INSERT INTO public.messages VALUES (3, 22, 23, false, 'La migration PostgreSQL s est bien passee.', '2026-08-27 09:04:46.947167+01', '2026-08-27 09:04:46.947167+01', 'text');
INSERT INTO public.messages VALUES (4, 1, 1, false, 'Salut Ruth, tu as pu regarder le dernier rapport ?', '2026-08-27 09:07:40.741717+01', '2026-08-27 09:07:40.741717+01', 'text');
INSERT INTO public.messages VALUES (5, 3, 1, false, 'Oui Joel, je viens de terminer la lecture.', '2026-08-27 09:07:40.741717+01', '2026-08-27 09:07:40.741717+01', 'text');
INSERT INTO public.messages VALUES (6, 1, 1, false, 'Super, tu en penses quoi ?', '2026-08-27 09:07:40.741717+01', '2026-08-27 09:07:40.741717+01', 'text');
INSERT INTO public.messages VALUES (7, 3, 1, false, 'Tout me parait bon, on peut valider.', '2026-08-27 09:07:40.741717+01', '2026-08-27 09:07:40.741717+01', 'text');
INSERT INTO public.messages VALUES (8, 1, 2, false, 'Bienvenue a tous sur le projet messagerie !', '2026-08-27 09:09:42.094856+01', '2026-08-27 09:09:42.094856+01', 'text');
INSERT INTO public.messages VALUES (9, 2, 2, false, 'Merci Joel ! Hate de commencer.', '2026-08-27 09:10:50.356654+01', '2026-08-27 09:10:50.356654+01', 'text');
INSERT INTO public.messages VALUES (10, 50, 2, false, 'Bonjour le groupe, l API est prete ?', '2026-08-27 09:11:11.910818+01', '2026-08-27 09:11:11.910818+01', 'text');
INSERT INTO public.messages VALUES (11, 1, 2, false, 'Oui, la base de donnees est configuree.', '2026-08-27 09:11:11.910818+01', '2026-08-27 09:11:11.910818+01', 'text');
INSERT INTO public.messages VALUES (12, 2, 2, false, 'Parfait, je commence le design de l interface.', '2026-08-27 09:11:11.910818+01', '2026-08-27 09:11:11.910818+01', 'text');
INSERT INTO public.messages VALUES (13, 1, 3, false, 'Coucou la famille ! Qui est libre ce week-end ?', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (14, 2, 3, false, 'Moi je suis disponible samedi !', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (15, 4, 3, false, 'Je passe en fin d apres-midi.', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (16, 1, 4, false, 'Salut Patrick, tu as un moment pour passer sur le serveur ?', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (17, 5, 4, false, 'Oui je me connecte dans 10 minutes.', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (18, 2, 5, false, 'Nathalie, n oublie pas la reunion de 14h.', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (19, 10, 5, false, 'C est note, merci pour le rappel !', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (20, 3, 6, false, 'Bonjour Deborah, as-tu recu les accinuit.', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (21, 11, 13, false, 'Erick, la reunion est decalee a demain 10h.', '2026-08-27 10:11:54.526453+01', '2026-08-27 10:11:54.526453+01', 'text');
INSERT INTO public.messages VALUES (22, 1, 14, false, 'Equipe backend, pensez a documenter vos routes SQL.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (23, 2, 14, false, 'C est bon pour le module d authentification.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (24, 3, 14, false, 'Je m occupe des requetes des messages.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (25, 4, 14, false, 'Attention aux index sur les cles etrangeres.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (26, 5, 15, false, 'On teste la version iOS aujourd hui ?', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (27, 6, 15, false, 'L emulateur marche nikel chez moi.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (28, 7, 15, false, 'Attention aux marges sur les petits ecrans.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (29, 8, 15, false, 'Je corrige le bug du scroll horizontal.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (30, 9, 16, false, 'Un utilisateur remonte une lenteur sur la recherche.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (31, 10, 16, false, 'Je regarde les logs du serveur.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (32, 11, 16, false, 'On a un pic de connexions depuis 11h.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (33, 12, 16, false, 'Le cache Redis va regler le probleme.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (34, 13, 17, false, 'Qui participe au Hackathon ce mois-ci ?', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (35, 14, 17, false, 'Mon equipe est deja au complet !', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (36, 15, 18, false, 'Pensez a renouveler vos mots de passe.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (37, 16, 19, false, 'Nouveau document disponible sur le drive.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (38, 17, 20, false, 'La session de formation commence a 15h.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (39, 18, 20, false, 'Je serai un peu en retard.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (40, 19, 21, false, 'Les contraintes de cles etrangeres sont activees.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (41, 21, 22, false, 'Des retours sur le composant React ?', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');
INSERT INTO public.messages VALUES (42, 22, 23, false, 'La migration PostgreSQL s est bien passee.', '2026-08-27 10:13:51.858452+01', '2026-08-27 10:13:51.858452+01', 'text');


--
-- Data for Name: participants; Type: TABLE DATA; Schema: public; Owner: kadea_chat_dev
--

INSERT INTO public.participants VALUES (1, 1, '2026-08-25 20:45:51.003465+01', 'admin');
INSERT INTO public.participants VALUES (1, 2, '2026-08-25 20:45:51.003465+01', 'member');
INSERT INTO public.participants VALUES (2, 2, '2026-08-25 20:45:51.003465+01', 'member');
INSERT INTO public.participants VALUES (50, 2, '2026-08-25 20:45:51.003465+01', 'member');
INSERT INTO public.participants VALUES (3, 1, '2026-08-25 20:45:51.003465+01', 'member');
INSERT INTO public.participants VALUES (58, 10, '2026-08-25 21:21:11.324614+01', 'member');
INSERT INTO public.participants VALUES (1, 4, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (5, 4, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (2, 5, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (10, 5, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (3, 6, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (12, 6, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (4, 7, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (15, 7, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (1, 8, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (20, 8, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (1, 14, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (2, 14, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (3, 14, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (4, 14, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (5, 15, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (6, 15, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (7, 15, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (8, 15, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (9, 16, '2026-08-25 21:23:40.24424+01', 'admin');
INSERT INTO public.participants VALUES (10, 16, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (11, 16, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (12, 16, '2026-08-25 21:23:40.24424+01', 'member');
INSERT INTO public.participants VALUES (46, 3, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (2, 3, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (96, 9, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (33, 9, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (62, 10, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (38, 11, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (89, 11, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (85, 12, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (5, 12, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (79, 13, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (46, 13, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (97, 17, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (59, 17, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (89, 18, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (100, 18, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (74, 19, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (19, 19, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (33, 20, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (11, 20, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (99, 21, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (38, 21, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (33, 22, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (60, 22, '2026-08-27 17:45:57.638092+01', 'member');
INSERT INTO public.participants VALUES (73, 23, '2026-08-27 17:45:57.638092+01', 'admin');
INSERT INTO public.participants VALUES (45, 23, '2026-08-27 17:45:57.638092+01', 'member');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: kadea_chat_dev
--

INSERT INTO public.users VALUES (1, 'Joel', 'MITONDO', 'MOHINDO', 'joelmitondo100@gmail.com', 'motdepasse@12345', 'https://photo.com', '2026-08-25 18:37:27.916381+01', '2026-08-25 18:37:27.916381+01', NULL, '+243823310484', 'la programmation est ma vie', '1997-12-27', false, '2026-08-25 18:37:27.916381+01');
INSERT INTO public.users VALUES (2, 'VEBEN', 'Isaac', 'KABAMBA', 'isaac.veben@email.com', 'hash_password_123', 'https://avatar.com/isaac.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000001', 'Passionne de tech', '1995-04-12', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (3, 'NTUKU', 'Fils', 'MUKOKO', 'fils.ntuku@email.com', 'hash_password_123', 'https://avatar.com/fils.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000002', 'Developpeur Fullstack', '1998-08-23', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (4, 'MUMPE', 'Marie', 'GRACE', 'marie.mumpe@email.com', 'hash_password_123', 'https://avatar.com/marie.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000003', 'UI/UX Designer', '2001-02-15', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (5, 'MITONDO', 'Ruth', 'ESTHER', 'ruth.mitondo@email.com', 'hash_password_123', 'https://avatar.com/ruth.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000004', 'Graphiste', '2002-11-05', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (6, 'MITONDO', 'Therese', 'SARAH', 'therese.mitondo@email.com', 'hash_password_123', 'https://avatar.com/therese.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000005', 'Gestionnaire de projet', '1996-06-30', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (7, 'MITONDO', 'Djeny', 'DORCAS', 'djeny.mitondo@email.com', 'hash_password_123', 'https://avatar.com/djeny.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000006', 'Etudiante en informatique', '2003-09-18', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (8, 'EGMON', 'Prospere', NULL, 'prospere.egmon@email.com', 'hash_password_123', 'https://avatar.com/prospere.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000007', 'Administrateur systeme', '1992-01-20', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (9, 'IMBHA', 'Christian', 'KALEB', 'christian.imbha@email.com', 'hash_password_123', 'https://avatar.com/christian.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000008', 'Analyste de donnees', '1994-07-14', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (10, 'KABANGU', 'David', 'JOSUE', 'david.kabangu@email.com', 'hash_password_123', 'https://avatar.com/david.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000009', 'Ingenieur Reseau', '1997-03-22', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (11, 'MBEYA', 'Rachelle', 'NEHEMIE', 'rachelle.mbeya@email.com', 'hash_password_123', 'https://avatar.com/rachelle.jpg', '2026-08-25 18:46:21.27056+01', '2026-08-25 18:46:21.27056+01', NULL, '+243810000010', 'Data Scientist', '1999-10-10', false, '2026-08-25 18:46:21.27056+01');
INSERT INTO public.users VALUES (12, 'MUKENDI', 'Patrick', 'KABEYA', 'patrick.mukendi@email.com', 'hash_password_123', 'https://avatar.com/patrick.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000011', 'Passionne de cybersecurite', '1993-05-14', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (13, 'TSHILOMBO', 'Nathalie', 'MUTOMBO', 'nathalie.tshilombo@email.com', 'hash_password_123', 'https://avatar.com/nathalie.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000012', 'Chef de projet IT', '1996-09-02', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (14, 'KAPINGA', 'Deborah', 'MASENGU', 'deborah.kapinga@email.com', 'hash_password_123', 'https://avatar.com/deborah.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000013', 'Architecte logiciel', '1999-12-19', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (15, 'KABEYA', 'Jonathan', 'ILUNGA', 'jonathan.kabeya@email.com', 'hash_password_123', 'https://avatar.com/jonathan.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000014', 'Developpeur Mobile', '1994-03-27', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (16, 'MBALA', 'Grace', 'MWAMBA', 'grace.mbala@email.com', 'hash_password_123', 'https://avatar.com/grace.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000015', 'Specialiste Cloud', '2000-07-08', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (17, 'MWANZA', 'Cedric', 'KASONGO', 'cedric.mwanza@email.com', 'hash_password_123', 'https://avatar.com/cedric.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000016', 'Analyste BI', '1991-11-11', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (18, 'LUMUMBA', 'Roland', 'EMERY', 'roland.lumumba@email.com', 'hash_password_123', 'https://avatar.com/roland.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000017', 'Ingenieur DevOps', '1997-01-30', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (19, 'KASAI', 'Naomie', 'TSHIELA', 'naomie.kasai@email.com', 'hash_password_123', 'https://avatar.com/naomie.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000018', 'Designer produit', '2001-08-25', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (20, 'BOKOTA', 'Herve', 'MPUTU', 'herve.bokota@email.com', 'hash_password_123', 'https://avatar.com/herve.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000019', 'Developpeur Backend', '1995-10-04', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (21, 'KANYINDA', 'Clarisse', 'BULONG', 'clarisse.kanyinda@email.com', 'hash_password_123', 'https://avatar.com/clarisse.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000020', 'Scrum Master', '1998-04-17', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (22, 'NDAYA', 'Erick', 'KABAMBA', 'erick.ndaya@email.com', 'hash_password_123', 'https://avatar.com/erick.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000021', 'Specialiste QA', '1992-06-22', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (23, 'LUBOYA', 'Syntyche', 'KANKU', 'syntyche.luboya@email.com', 'hash_password_123', 'https://avatar.com/syntyche.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000022', 'Developpeuse Frontend', '2002-03-15', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (24, 'NKONGOLO', 'Samuel', 'MUKADI', 'samuel.nkongolo@email.com', 'hash_password_123', 'https://avatar.com/samuel.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000023', 'Administrateur de bases de donnees', '1990-12-01', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (25, 'TSHIBANGU', 'Rachel', 'NSINGI', 'rachel.tshibangu@email.com', 'hash_password_123', 'https://avatar.com/rachel.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000024', 'Consultante ERP', '1997-09-09', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (26, 'KALONJI', 'Gideon', 'KANYINDA', 'gideon.kalonji@email.com', 'hash_password_123', 'https://avatar.com/gideon.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000025', 'Developpeur Python', '1996-02-14', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (27, 'BULONG', 'Victoire', 'NZUZI', 'victoire.bulong@email.com', 'hash_password_123', 'https://avatar.com/victoire.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000026', 'Ingenieure IA', '2001-11-28', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (28, 'KABULO', 'Gloire', 'MWEMA', 'gloire.kabulo@email.com', 'hash_password_123', 'https://avatar.com/gloire.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000027', 'Administrateur Reseau', '1994-08-05', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (29, 'MOMBO', 'Prisca', 'KIMPA', 'prisca.mombo@email.com', 'hash_password_123', 'https://avatar.com/prisca.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000028', 'Redactrice Web', '1999-05-19', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (30, 'NGANDU', 'Yannick', 'KADIMA', 'yannick.ngandu@email.com', 'hash_password_123', 'https://avatar.com/yannick.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000029', 'Tech Lead', '1993-10-10', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (31, 'KIKUNI', 'Evelyne', 'MALANI', 'evelyne.kikuni@email.com', 'hash_password_123', 'https://avatar.com/evelyne.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000030', 'Community Manager', '2003-01-07', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (32, 'MBAYO', 'Daniel', 'KASONGO', 'daniel.mbayo@email.com', 'hash_password_123', 'https://avatar.com/daniel.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000031', 'Developpeur Java', '1995-07-21', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (33, 'MUKUNA', 'Lydie', 'TSHIALA', 'lydie.mukuna@email.com', 'hash_password_123', 'https://avatar.com/lydie.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000032', 'Analyste Fonctionnel', '1998-12-03', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (34, 'MPUTU', 'Salomon', 'BOKETSHI', 'salomon.mputu@email.com', 'hash_password_123', 'https://avatar.com/salomon.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000033', 'Expert Securite Web', '1991-04-18', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (35, 'KABASELE', 'Miradi', 'MPANDA', 'miradi.kabasele@email.com', 'hash_password_123', 'https://avatar.com/miradi.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000034', 'Designer 3D', '2002-06-30', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (36, 'KASONGO', 'Ben', 'KIALA', 'ben.kasongo@email.com', 'hash_password_123', 'https://avatar.com/ben.jpg', '2026-08-25 18:51:18.288164+01', '2026-08-25 18:51:18.288164+01', NULL, '+243810000035', 'Developpeur Fullstack', '1997-03-11', false, '2026-08-25 18:51:18.288164+01');
INSERT INTO public.users VALUES (37, 'TSHISWAKA', 'Fiston', 'KALALA', 'fiston.tshiswaka@email.com', 'hash_password_123', 'https://avatar.com/fiston.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000036', 'Architecte SI', '1992-02-18', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (38, 'MULAMBA', 'Vanessa', 'NSONA', 'vanessa.mulamba@email.com', 'hash_password_123', 'https://avatar.com/vanessa.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000037', 'UX Researcher', '1999-07-25', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (39, 'KILOLO', 'Arnaud', 'MWEMBA', 'arnaud.kilolo@email.com', 'hash_password_123', 'https://avatar.com/arnaud.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000038', 'Developpeur C++', '1994-11-09', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (40, 'MUTOMBO', 'Dorcas', 'KETA', 'dorcas.mutombo@email.com', 'hash_password_123', 'https://avatar.com/dorcas.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000039', 'Consultante BI', '2001-04-14', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (41, 'NSAPU', 'Bienvenu', 'MBAYA', 'bienvenu.nsapu@email.com', 'hash_password_123', 'https://avatar.com/bienvenu.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000040', 'Ingenieur Systems', '1990-08-31', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (42, 'TSHIKA', 'Jessica', 'MBUYI', 'jessica.tshika@email.com', 'hash_password_123', 'https://avatar.com/jessica.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000041', 'Product Owner', '1996-01-22', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (43, 'MUKADI', 'Steve', 'KAPUKU', 'steve.mukadi@email.com', 'hash_password_123', 'https://avatar.com/steve.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000042', 'Developpeur Go', '1995-12-05', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (44, 'KAZADI', 'Gemma', 'TUSSE', 'gemma.kazadi@email.com', 'hash_password_123', 'https://avatar.com/gemma.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000043', 'Integratrice Web', '2003-03-19', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (45, 'LUKUSA', 'Teddy', 'MUKENGESHAYI', 'teddy.lukusa@email.com', 'hash_password_123', 'https://avatar.com/teddy.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000044', 'Specialiste Kubernetes', '1993-09-17', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (46, 'BEYA', 'Ketsia', 'MASENGA', 'ketsia.beya@email.com', 'hash_password_123', 'https://avatar.com/ketsia.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000045', 'Analyste Cyberscurite', '2000-10-28', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (47, 'ILUNGA', 'Joel', 'MWINKEU', 'joel.ilunga@email.com', 'hash_password_123', 'https://avatar.com/joel_i.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000046', 'Developpeur PHP', '1997-06-11', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (48, 'MBUYI', 'Benedicte', 'MALABA', 'benedicte.mbuyi@email.com', 'hash_password_123', 'https://avatar.com/benedicte.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000047', 'Graphiste Motion', '2002-05-02', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (49, 'KILANGALANGA', 'Franck', 'LUMU', 'franck.kilangalanga@email.com', 'hash_password_123', 'https://avatar.com/franck.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000048', 'Ingenieur Telecom', '1991-03-13', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (50, 'KANDA', 'Bernice', 'NKITA', 'bernice.kanda@email.com', 'hash_password_123', 'https://avatar.com/bernice.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000049', 'Copywriter', '1998-09-30', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (51, 'MPIANA', 'Rodrick', 'KABONGO', 'rodrick.mpiana@email.com', 'hash_password_123', 'https://avatar.com/rodrick.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000050', 'Developpeur Rust', '1996-07-07', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (52, 'MASENGU', 'Divine', 'KASANGANA', 'divine.masengu@email.com', 'hash_password_123', 'https://avatar.com/divine.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000051', 'Chef de Projet Digital', '1997-12-24', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (53, 'MUKENGESHAYI', 'Junior', 'TSHIBAMBA', 'junior.mukengeshayi@email.com', 'hash_password_123', 'https://avatar.com/junior.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000052', 'Developpeur Android', '1994-04-03', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (54, 'KAPUKU', 'Syntia', 'NTUMBA', 'syntia.kapuku@email.com', 'hash_password_123', 'https://avatar.com/syntia.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000053', 'Data Engineer', '2001-01-16', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (55, 'MUKOKA', 'Enock', 'KADIMA', 'enock.mukoka@email.com', 'hash_password_123', 'https://avatar.com/enock.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000054', 'Architecte Security', '1992-10-08', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (56, 'NDOMBELE', 'Eunice', 'NSIMBA', 'eunice.ndombele@email.com', 'hash_password_123', 'https://avatar.com/eunice.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000055', 'Community Manager', '2003-08-12', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (57, 'KALAMBAYI', 'Kevin', 'TSHIMANGA', 'kevin.kalambayi@email.com', 'hash_password_123', 'https://avatar.com/kevin.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000056', 'Developpeur iOS', '1995-05-29', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (58, 'TSHIBOLA', 'Sharon', 'KAPINGA', 'sharon.tshibola@email.com', 'hash_password_123', 'https://avatar.com/sharon.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000057', 'UI Designer', '2000-02-17', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (59, 'KABAMBA', 'Neville', 'MUTOMBO', 'neville.kabamba@email.com', 'hash_password_123', 'https://avatar.com/neville.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000058', 'DevOps Specialist', '1993-11-21', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (60, 'MOMBO', 'Deborah', 'LOMANI', 'deborah.mombo@email.com', 'hash_password_123', 'https://avatar.com/deborah_m.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000059', 'SEO Specialist', '1998-06-04', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (61, 'BADIBANGA', 'Josue', 'KANYINDA', 'josue.badibanga@email.com', 'hash_password_123', 'https://avatar.com/josue.jpg', '2026-08-25 18:52:24.523057+01', '2026-08-25 18:52:24.523057+01', NULL, '+243810000060', 'Developpeur Flutter', '1996-03-26', false, '2026-08-25 18:52:24.523057+01');
INSERT INTO public.users VALUES (62, 'KABANGA', 'Precieux', 'MUKADI', 'precieux.kabanga@email.com', 'hash_password_123', 'https://avatar.com/precieux.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000061', 'Developpeur Vue.js', '1995-01-15', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (63, 'TSHITENGE', 'Syntyche', 'KAPINGA', 'syntyche.tshitenge@email.com', 'hash_password_123', 'https://avatar.com/syntyche_t.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000062', 'Ingenieure Cloud', '1998-07-20', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (64, 'MUKENGE', 'Gedeon', 'NSAPU', 'gedeon.mukenge@email.com', 'hash_password_123', 'https://avatar.com/gedeon.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000063', 'Administrateur Linux', '1993-04-10', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (65, 'KAPENDA', 'Chrissie', 'MUKONOLE', 'chrissie.kapenda@email.com', 'hash_password_123', 'https://avatar.com/chrissie.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000064', 'Product Designer', '2001-09-05', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (66, 'TSHIMANGA', 'Dieudonne', 'KALONJI', 'dieudonne.tshimanga@email.com', 'hash_password_123', 'https://avatar.com/dieudonne.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000065', 'Analyste BI Senior', '1990-12-18', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (67, 'MOMBO', 'Keren', 'NSINGI', 'keren.mombo@email.com', 'hash_password_123', 'https://avatar.com/keren.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000066', 'Webmaster', '2002-03-30', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (68, 'KABWE', 'Papy', 'MUTEBA', 'papy.kabwe@email.com', 'hash_password_123', 'https://avatar.com/papy.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000067', 'Developpeur C# / .NET', '1992-06-14', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (69, 'MBUYAMBA', 'Aline', 'TSHIALA', 'aline.mbuyama@email.com', 'hash_password_123', 'https://avatar.com/aline.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000068', 'Tester QA', '1997-11-23', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (70, 'NKASHAMA', 'Glody', 'ILUNGA', 'glody.nkashama@email.com', 'hash_password_123', 'https://avatar.com/glody.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000069', 'Architecte Microservices', '1994-08-08', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (71, 'TSHIBANDA', 'Eveline', 'MBOMBO', 'eveline.tshibanda@email.com', 'hash_password_123', 'https://avatar.com/eveline.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000070', 'Scrum Master', '1999-02-17', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (72, 'BOKILA', 'Yan', 'MUKOKO', 'yan.bokila@email.com', 'hash_password_123', 'https://avatar.com/yan.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000071', 'Developpeur React', '1996-05-29', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (73, 'LUKOKI', 'Bernadette', 'KIZITA', 'bernadette.lukoki@email.com', 'hash_password_123', 'https://avatar.com/bernadette.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000072', 'UX Writer', '2000-10-12', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (74, 'MPYANA', 'Moise', 'KABONGO', 'moise.mpyana@email.com', 'hash_password_123', 'https://avatar.com/moise.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000073', 'Expert Cybersecurite', '1991-03-04', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (75, 'NSINGI', 'Chantal', 'MWAMBA', 'chantal.nsingi@email.com', 'hash_password_123', 'https://avatar.com/chantal.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000074', 'Chef de Projet', '1995-12-01', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (76, 'KAZADI', 'Tresor', 'TSHIMANGA', 'tresor.kazadi@email.com', 'hash_password_123', 'https://avatar.com/tresor.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000075', 'Developpeur Angular', '1993-10-25', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (77, 'MUKANZA', 'Dorothee', 'KAPINGA', 'dorothee.mukanza@email.com', 'hash_password_123', 'https://avatar.com/dorothee.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000076', 'Analyste Fonctionnelle', '1998-04-09', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (78, 'MUTEBA', 'Oswald', 'KABEYA', 'oswald.muteba@email.com', 'hash_password_123', 'https://avatar.com/oswald.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000077', 'Ingenieur Reseau Senior', '1989-07-19', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (79, 'TSHIBOLA', 'Priscilla', 'NKITA', 'priscilla.tshibola@email.com', 'hash_password_123', 'https://avatar.com/priscilla.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000078', 'Designer UI/UX', '2003-01-31', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (80, 'KABASELE', 'Serge', 'MPOYI', 'serge.kabasele@email.com', 'hash_password_123', 'https://avatar.com/serge.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000079', 'Developpeur Node.js', '1994-09-14', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (81, 'NKITA', 'Rebecca', 'MASENGU', 'rebecca.nkita@email.com', 'hash_password_123', 'https://avatar.com/rebecca.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000080', 'Data Analyst', '2001-06-06', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (82, 'KILUNDU', 'Lucien', 'MBALA', 'lucien.kilundu@email.com', 'hash_password_123', 'https://avatar.com/lucien.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000081', 'Specialiste Systemes', '1992-11-30', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (83, 'MWAMBA', 'Eunice', 'KASONGO', 'eunice.mwamba@email.com', 'hash_password_123', 'https://avatar.com/eunice_m.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000082', 'Developpeuse Mobile', '1997-08-15', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (84, 'BEYA', 'Donatien', 'MUKADI', 'donatien.beya@email.com', 'hash_password_123', 'https://avatar.com/donatien.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000083', 'Architecte Base de Donnees', '1990-05-22', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (85, 'KALALA', 'Miriam', 'TSHIELA', 'miriam.kalala@email.com', 'hash_password_123', 'https://avatar.com/miriam.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000084', 'Redactrice Technique', '1999-01-08', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (86, 'KABEYA', 'Sylvain', 'MUTOMBO', 'sylvain.kabeya@email.com', 'hash_password_123', 'https://avatar.com/sylvain.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000085', 'Developpeur Python/Django', '1996-03-17', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (87, 'TSHIELA', 'Abigail', 'MBUYI', 'abigail.tshiela@email.com', 'hash_password_123', 'https://avatar.com/abigail.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000086', 'Consultante ERP', '2002-09-27', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (88, 'MULOMBO', 'Leon', 'KANYINDA', 'leon.mulombo@email.com', 'hash_password_123', 'https://avatar.com/leon.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000087', 'Ingenieur DevOps', '1993-02-11', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (89, 'KASONGO', 'Esther', 'KAPUKU', 'esther.kasongo@email.com', 'hash_password_123', 'https://avatar.com/esther.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000088', 'Community Manager', '2000-04-24', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (90, 'MPOYI', 'Adolphe', 'TSHIMANGA', 'adolphe.mpoyi@email.com', 'hash_password_123', 'https://avatar.com/adolphe.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000089', 'Developpeur Java/Spring', '1991-07-03', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (91, 'KAPUKU', 'Naomi', 'NSINGI', 'naomi.kapuku@email.com', 'hash_password_123', 'https://avatar.com/naomi.jpg', '2026-08-25 18:55:11.707049+01', '2026-08-25 18:55:11.707049+01', NULL, '+243810000090', 'Specialiste QA', '1998-10-19', false, '2026-08-25 18:55:11.707049+01');
INSERT INTO public.users VALUES (92, 'KABONGO', 'Nathan', 'MUKENDI', 'nathan.kabongo@email.com', 'hash_password_123', 'https://avatar.com/nathan.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000091', 'Developpeur Fullstack', '1996-05-14', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (93, 'TSHIBUABUA', 'Gracia', 'MASENGU', 'gracia.tshibuabua@email.com', 'hash_password_123', 'https://avatar.com/gracia.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000092', 'UI/UX Designer', '2001-11-09', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (94, 'LUMUMBA', 'Patrice', 'EMERY', 'patrice.lumumba@email.com', 'hash_password_123', 'https://avatar.com/patrice.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000093', 'Specialiste Securite', '1993-02-28', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (95, 'MBUYI', 'Jemima', 'KAPINGA', 'jemima.mbuyi@email.com', 'hash_password_123', 'https://avatar.com/jemima.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000094', 'Scrum Master', '1999-08-17', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (96, 'KASONGO', 'Caleb', 'MUTEBA', 'caleb.kasongo@email.com', 'hash_password_123', 'https://avatar.com/caleb.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000095', 'Ingenieur Cloud', '1995-10-04', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (97, 'NKONGOLO', 'Vanessa', 'TSHIELA', 'vanessa.nkongolo@email.com', 'hash_password_123', 'https://avatar.com/vanessa_n.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000096', 'Data Analyst', '2002-04-21', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (98, 'MUKADI', 'Jonathan', 'ILUNGA', 'jonathan.mukadi@email.com', 'hash_password_123', 'https://avatar.com/jonathan_m.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000097', 'Developpeur Backend', '1994-12-30', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (99, 'KABEYA', 'Syntyche', 'NSINGI', 'syntyche.kabeya@email.com', 'hash_password_123', 'https://avatar.com/syntyche_k.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000098', 'Community Manager', '2000-07-11', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (100, 'TSHIMANGA', 'Ruben', 'KALONJI', 'ruben.tshimanga@email.com', 'hash_password_123', 'https://avatar.com/ruben.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+243810000099', 'Architecte Reseau', '1991-09-03', false, '2026-08-25 18:55:43.522124+01');
INSERT INTO public.users VALUES (101, 'MPANDA', 'Deborah', 'MUKOKO', 'deborah.mpanda@email.com', 'hash_password_123', 'https://avatar.com/deborah_p.jpg', '2026-08-25 18:55:43.522124+01', '2026-08-25 18:55:43.522124+01', NULL, '+2438100000100', 'Chef de Projet IT', '1997-01-26', false, '2026-08-25 18:55:43.522124+01');


--
-- Name: conversation_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kadea_chat_dev
--

SELECT pg_catalog.setval('public.conversation_types_id_seq', 2, true);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kadea_chat_dev
--

SELECT pg_catalog.setval('public.conversations_id_seq', 23, true);


--
-- Name: message_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kadea_chat_dev
--

SELECT pg_catalog.setval('public.message_status_id_seq', 3, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kadea_chat_dev
--

SELECT pg_catalog.setval('public.messages_id_seq', 42, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kadea_chat_dev
--

SELECT pg_catalog.setval('public.users_id_seq', 101, true);


--
-- Name: conversation_types conversation_types_label_key; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.conversation_types
    ADD CONSTRAINT conversation_types_label_key UNIQUE (label);


--
-- Name: conversation_types conversation_types_pkey; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.conversation_types
    ADD CONSTRAINT conversation_types_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: message_recipients message_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.message_recipients
    ADD CONSTRAINT message_recipients_pkey PRIMARY KEY (recipient_id, message_id);


--
-- Name: message_status message_status_label_key; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.message_status
    ADD CONSTRAINT message_status_label_key UNIQUE (label);


--
-- Name: message_status message_status_pkey; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.message_status
    ADD CONSTRAINT message_status_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: participants participants_pkey; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (user_id, conversation_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_conversation_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_conversation_type_id_fkey FOREIGN KEY (conversation_type_id) REFERENCES public.conversation_types(id);


--
-- Name: message_recipients message_recipients_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.message_recipients
    ADD CONSTRAINT message_recipients_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.messages(id) ON DELETE CASCADE;


--
-- Name: message_recipients message_recipients_message_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.message_recipients
    ADD CONSTRAINT message_recipients_message_status_id_fkey FOREIGN KEY (message_status_id) REFERENCES public.message_status(id);


--
-- Name: message_recipients message_recipients_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.message_recipients
    ADD CONSTRAINT message_recipients_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: participants participants_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE;


--
-- Name: participants participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kadea_chat_dev
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict AtdsAoYFEbfjo2cS24RFslCQGJ8dde9BXMWM2YUFtjwSgHE4eTCgbMOdn6TG0cF

