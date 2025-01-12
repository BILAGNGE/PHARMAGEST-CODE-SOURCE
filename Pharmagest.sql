PGDMP          
            |         
   PHARMAGEST    16.2    16.2 ]    b           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            c           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            d           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            e           1262    41417 
   PHARMAGEST    DATABASE        CREATE DATABASE "PHARMAGEST" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE "PHARMAGEST";
                postgres    false            �            1255    41418    update_login_historique()    FUNCTION     �  CREATE FUNCTION public.update_login_historique() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM login_historique WHERE id_utilisateur = NEW.id_utilisateur) THEN
        UPDATE login_historique
        SET date_heure = CURRENT_TIMESTAMP,
            nom_utilisateur = NEW.nom_utilisateur,
            role = NEW.role
        WHERE id_utilisateur = NEW.id_utilisateur;
    ELSE
        INSERT INTO login_historique (id_utilisateur, nom_utilisateur, role, date_heure)
        VALUES (NEW.id_utilisateur, NEW.nom_utilisateur, NEW.role, CURRENT_TIMESTAMP);
    END IF;
    RETURN NULL; -- Changement ici
END;
$$;
 0   DROP FUNCTION public.update_login_historique();
       public          postgres    false            �            1259    41419    approvisionnement    TABLE     �  CREATE TABLE public.approvisionnement (
    id_approvisionnement integer NOT NULL,
    id_medicament integer,
    id_fournisseur integer,
    quantite_commandee integer NOT NULL,
    date_approvisionnement date DEFAULT CURRENT_DATE,
    statut character varying(20) DEFAULT 'en attente'::character varying,
    prix_fournisseur numeric(10,2),
    quantite_recue integer,
    commentaire character varying(255)
);
 %   DROP TABLE public.approvisionnement;
       public         heap    postgres    false            �            1259    41424 *   approvisionnement_id_approvisionnement_seq    SEQUENCE     �   CREATE SEQUENCE public.approvisionnement_id_approvisionnement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public.approvisionnement_id_approvisionnement_seq;
       public          postgres    false    215            f           0    0 *   approvisionnement_id_approvisionnement_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE public.approvisionnement_id_approvisionnement_seq OWNED BY public.approvisionnement.id_approvisionnement;
          public          postgres    false    216            �            1259    41425    client    TABLE     �  CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client character varying(50) NOT NULL,
    prenom_client character varying(50) NOT NULL,
    date_naissance_client date,
    adresse_client character varying(200),
    telephone_client character varying(20),
    date_creation date DEFAULT CURRENT_DATE,
    statut character varying(20) DEFAULT 'actif'::character varying
);
    DROP TABLE public.client;
       public         heap    postgres    false            �            1259    41430    client_id_client_seq    SEQUENCE     �   CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.client_id_client_seq;
       public          postgres    false    217            g           0    0    client_id_client_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;
          public          postgres    false    218            �            1259    41431    famille    TABLE     �   CREATE TABLE public.famille (
    id_famille integer NOT NULL,
    nom_famille character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);
    DROP TABLE public.famille;
       public         heap    postgres    false            �            1259    41436    famille_id_famille_seq    SEQUENCE     �   CREATE SEQUENCE public.famille_id_famille_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.famille_id_famille_seq;
       public          postgres    false    219            h           0    0    famille_id_famille_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.famille_id_famille_seq OWNED BY public.famille.id_famille;
          public          postgres    false    220            �            1259    41437    forme    TABLE     �   CREATE TABLE public.forme (
    id_forme integer NOT NULL,
    nom_forme character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);
    DROP TABLE public.forme;
       public         heap    postgres    false            �            1259    41442    forme_id_forme_seq    SEQUENCE     �   CREATE SEQUENCE public.forme_id_forme_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.forme_id_forme_seq;
       public          postgres    false    221            i           0    0    forme_id_forme_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.forme_id_forme_seq OWNED BY public.forme.id_forme;
          public          postgres    false    222            �            1259    41443    fournisseur    TABLE     �  CREATE TABLE public.fournisseur (
    id_fournisseur integer NOT NULL,
    nom_fournisseur character varying(255) NOT NULL,
    email_fournisseur character varying(255) NOT NULL,
    tel_fournisseur character varying(20) NOT NULL,
    adresse_fournisseur character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);
    DROP TABLE public.fournisseur;
       public         heap    postgres    false            �            1259    41450    fournisseur_id_fournisseur_seq    SEQUENCE     �   CREATE SEQUENCE public.fournisseur_id_fournisseur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.fournisseur_id_fournisseur_seq;
       public          postgres    false    223            j           0    0    fournisseur_id_fournisseur_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.fournisseur_id_fournisseur_seq OWNED BY public.fournisseur.id_fournisseur;
          public          postgres    false    224            �            1259    41451    ligne_vente    TABLE     �   CREATE TABLE public.ligne_vente (
    id_ligne_vente integer NOT NULL,
    id_vente integer,
    id_medicament integer,
    quantite integer,
    prix_unitaire numeric(10,2),
    prix_total numeric(10,2)
);
    DROP TABLE public.ligne_vente;
       public         heap    postgres    false            �            1259    41454    ligne_vente_id_ligne_vente_seq    SEQUENCE     �   CREATE SEQUENCE public.ligne_vente_id_ligne_vente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.ligne_vente_id_ligne_vente_seq;
       public          postgres    false    225            k           0    0    ligne_vente_id_ligne_vente_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.ligne_vente_id_ligne_vente_seq OWNED BY public.ligne_vente.id_ligne_vente;
          public          postgres    false    226            �            1259    41455    login_historique    TABLE     �   CREATE TABLE public.login_historique (
    id_login integer NOT NULL,
    id_utilisateur integer,
    nom_utilisateur character varying(255),
    role character varying(50),
    date_heure timestamp without time zone
);
 $   DROP TABLE public.login_historique;
       public         heap    postgres    false            �            1259    41458    login_historique_id_login_seq    SEQUENCE     �   CREATE SEQUENCE public.login_historique_id_login_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.login_historique_id_login_seq;
       public          postgres    false    227            l           0    0    login_historique_id_login_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.login_historique_id_login_seq OWNED BY public.login_historique.id_login;
          public          postgres    false    228            �            1259    41459 
   medicament    TABLE     �  CREATE TABLE public.medicament (
    id_medicament integer NOT NULL,
    nom_medicament character varying(255) NOT NULL,
    description_medicament text,
    id_fournisseur integer,
    id_famille integer,
    id_forme integer,
    statut character varying(20) DEFAULT 'actif'::character varying,
    quantite_medicament integer,
    prix_vente numeric(10,2),
    prix_fournisseur numeric(10,2)
);
    DROP TABLE public.medicament;
       public         heap    postgres    false            �            1259    41465    medicament_id_medicament_seq    SEQUENCE     �   CREATE SEQUENCE public.medicament_id_medicament_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.medicament_id_medicament_seq;
       public          postgres    false    229            m           0    0    medicament_id_medicament_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.medicament_id_medicament_seq OWNED BY public.medicament.id_medicament;
          public          postgres    false    230            �            1259    41466    utilisateurs    TABLE     �   CREATE TABLE public.utilisateurs (
    id_utilisateur integer NOT NULL,
    nom_utilisateur character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    date_creation date
);
     DROP TABLE public.utilisateurs;
       public         heap    postgres    false            �            1259    41471    utilisateurs_id_utilisateur_seq    SEQUENCE     �   CREATE SEQUENCE public.utilisateurs_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.utilisateurs_id_utilisateur_seq;
       public          postgres    false    231            n           0    0    utilisateurs_id_utilisateur_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.utilisateurs_id_utilisateur_seq OWNED BY public.utilisateurs.id_utilisateur;
          public          postgres    false    232            �            1259    41472    vente    TABLE     �   CREATE TABLE public.vente (
    id_vente integer NOT NULL,
    id_client integer,
    type_vente character varying(50),
    montant_total numeric(10,2),
    date_vente date,
    statut character varying(20)
);
    DROP TABLE public.vente;
       public         heap    postgres    false            �            1259    41475    vente_id_vente_seq    SEQUENCE     �   CREATE SEQUENCE public.vente_id_vente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.vente_id_vente_seq;
       public          postgres    false    233            o           0    0    vente_id_vente_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.vente_id_vente_seq OWNED BY public.vente.id_vente;
          public          postgres    false    234            �            1259    41476    ventes_payees    TABLE       CREATE TABLE public.ventes_payees (
    id_vente_payee integer NOT NULL,
    id_vente integer NOT NULL,
    id_client integer,
    type_vente character varying(50) NOT NULL,
    montant_total numeric(10,2) NOT NULL,
    date_vente date NOT NULL,
    date_paiement date NOT NULL
);
 !   DROP TABLE public.ventes_payees;
       public         heap    postgres    false            �            1259    41479     ventes_payees_id_vente_payee_seq    SEQUENCE     �   CREATE SEQUENCE public.ventes_payees_id_vente_payee_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.ventes_payees_id_vente_payee_seq;
       public          postgres    false    235            p           0    0     ventes_payees_id_vente_payee_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.ventes_payees_id_vente_payee_seq OWNED BY public.ventes_payees.id_vente_payee;
          public          postgres    false    236            �           2604    41480 &   approvisionnement id_approvisionnement    DEFAULT     �   ALTER TABLE ONLY public.approvisionnement ALTER COLUMN id_approvisionnement SET DEFAULT nextval('public.approvisionnement_id_approvisionnement_seq'::regclass);
 U   ALTER TABLE public.approvisionnement ALTER COLUMN id_approvisionnement DROP DEFAULT;
       public          postgres    false    216    215            �           2604    41481    client id_client    DEFAULT     t   ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);
 ?   ALTER TABLE public.client ALTER COLUMN id_client DROP DEFAULT;
       public          postgres    false    218    217            �           2604    41482    famille id_famille    DEFAULT     x   ALTER TABLE ONLY public.famille ALTER COLUMN id_famille SET DEFAULT nextval('public.famille_id_famille_seq'::regclass);
 A   ALTER TABLE public.famille ALTER COLUMN id_famille DROP DEFAULT;
       public          postgres    false    220    219            �           2604    41483    forme id_forme    DEFAULT     p   ALTER TABLE ONLY public.forme ALTER COLUMN id_forme SET DEFAULT nextval('public.forme_id_forme_seq'::regclass);
 =   ALTER TABLE public.forme ALTER COLUMN id_forme DROP DEFAULT;
       public          postgres    false    222    221            �           2604    41484    fournisseur id_fournisseur    DEFAULT     �   ALTER TABLE ONLY public.fournisseur ALTER COLUMN id_fournisseur SET DEFAULT nextval('public.fournisseur_id_fournisseur_seq'::regclass);
 I   ALTER TABLE public.fournisseur ALTER COLUMN id_fournisseur DROP DEFAULT;
       public          postgres    false    224    223            �           2604    41485    ligne_vente id_ligne_vente    DEFAULT     �   ALTER TABLE ONLY public.ligne_vente ALTER COLUMN id_ligne_vente SET DEFAULT nextval('public.ligne_vente_id_ligne_vente_seq'::regclass);
 I   ALTER TABLE public.ligne_vente ALTER COLUMN id_ligne_vente DROP DEFAULT;
       public          postgres    false    226    225            �           2604    41486    login_historique id_login    DEFAULT     �   ALTER TABLE ONLY public.login_historique ALTER COLUMN id_login SET DEFAULT nextval('public.login_historique_id_login_seq'::regclass);
 H   ALTER TABLE public.login_historique ALTER COLUMN id_login DROP DEFAULT;
       public          postgres    false    228    227            �           2604    41487    medicament id_medicament    DEFAULT     �   ALTER TABLE ONLY public.medicament ALTER COLUMN id_medicament SET DEFAULT nextval('public.medicament_id_medicament_seq'::regclass);
 G   ALTER TABLE public.medicament ALTER COLUMN id_medicament DROP DEFAULT;
       public          postgres    false    230    229            �           2604    41488    utilisateurs id_utilisateur    DEFAULT     �   ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateurs_id_utilisateur_seq'::regclass);
 J   ALTER TABLE public.utilisateurs ALTER COLUMN id_utilisateur DROP DEFAULT;
       public          postgres    false    232    231            �           2604    41489    vente id_vente    DEFAULT     p   ALTER TABLE ONLY public.vente ALTER COLUMN id_vente SET DEFAULT nextval('public.vente_id_vente_seq'::regclass);
 =   ALTER TABLE public.vente ALTER COLUMN id_vente DROP DEFAULT;
       public          postgres    false    234    233            �           2604    41490    ventes_payees id_vente_payee    DEFAULT     �   ALTER TABLE ONLY public.ventes_payees ALTER COLUMN id_vente_payee SET DEFAULT nextval('public.ventes_payees_id_vente_payee_seq'::regclass);
 K   ALTER TABLE public.ventes_payees ALTER COLUMN id_vente_payee DROP DEFAULT;
       public          postgres    false    236    235            J          0    41419    approvisionnement 
   TABLE DATA           �   COPY public.approvisionnement (id_approvisionnement, id_medicament, id_fournisseur, quantite_commandee, date_approvisionnement, statut, prix_fournisseur, quantite_recue, commentaire) FROM stdin;
    public          postgres    false    215   @z       L          0    41425    client 
   TABLE DATA           �   COPY public.client (id_client, nom_client, prenom_client, date_naissance_client, adresse_client, telephone_client, date_creation, statut) FROM stdin;
    public          postgres    false    217   �z       N          0    41431    famille 
   TABLE DATA           Q   COPY public.famille (id_famille, nom_famille, statut, date_creation) FROM stdin;
    public          postgres    false    219   n|       P          0    41437    forme 
   TABLE DATA           K   COPY public.forme (id_forme, nom_forme, statut, date_creation) FROM stdin;
    public          postgres    false    221   ~       R          0    41443    fournisseur 
   TABLE DATA           �   COPY public.fournisseur (id_fournisseur, nom_fournisseur, email_fournisseur, tel_fournisseur, adresse_fournisseur, statut, date_creation) FROM stdin;
    public          postgres    false    223   �~       T          0    41451    ligne_vente 
   TABLE DATA           s   COPY public.ligne_vente (id_ligne_vente, id_vente, id_medicament, quantite, prix_unitaire, prix_total) FROM stdin;
    public          postgres    false    225   ��       V          0    41455    login_historique 
   TABLE DATA           g   COPY public.login_historique (id_login, id_utilisateur, nom_utilisateur, role, date_heure) FROM stdin;
    public          postgres    false    227   �       X          0    41459 
   medicament 
   TABLE DATA           �   COPY public.medicament (id_medicament, nom_medicament, description_medicament, id_fournisseur, id_famille, id_forme, statut, quantite_medicament, prix_vente, prix_fournisseur) FROM stdin;
    public          postgres    false    229   ��       Z          0    41466    utilisateurs 
   TABLE DATA           j   COPY public.utilisateurs (id_utilisateur, nom_utilisateur, mot_de_passe, role, date_creation) FROM stdin;
    public          postgres    false    231   ?�       \          0    41472    vente 
   TABLE DATA           c   COPY public.vente (id_vente, id_client, type_vente, montant_total, date_vente, statut) FROM stdin;
    public          postgres    false    233   ��       ^          0    41476    ventes_payees 
   TABLE DATA           �   COPY public.ventes_payees (id_vente_payee, id_vente, id_client, type_vente, montant_total, date_vente, date_paiement) FROM stdin;
    public          postgres    false    235   ��       q           0    0 *   approvisionnement_id_approvisionnement_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.approvisionnement_id_approvisionnement_seq', 21, true);
          public          postgres    false    216            r           0    0    client_id_client_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.client_id_client_seq', 16, true);
          public          postgres    false    218            s           0    0    famille_id_famille_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.famille_id_famille_seq', 27, true);
          public          postgres    false    220            t           0    0    forme_id_forme_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.forme_id_forme_seq', 12, true);
          public          postgres    false    222            u           0    0    fournisseur_id_fournisseur_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.fournisseur_id_fournisseur_seq', 10, true);
          public          postgres    false    224            v           0    0    ligne_vente_id_ligne_vente_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ligne_vente_id_ligne_vente_seq', 42, true);
          public          postgres    false    226            w           0    0    login_historique_id_login_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.login_historique_id_login_seq', 361, true);
          public          postgres    false    228            x           0    0    medicament_id_medicament_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.medicament_id_medicament_seq', 11, true);
          public          postgres    false    230            y           0    0    utilisateurs_id_utilisateur_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.utilisateurs_id_utilisateur_seq', 48, true);
          public          postgres    false    232            z           0    0    vente_id_vente_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.vente_id_vente_seq', 23, true);
          public          postgres    false    234            {           0    0     ventes_payees_id_vente_payee_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.ventes_payees_id_vente_payee_seq', 20, true);
          public          postgres    false    236            �           2606    41492 (   approvisionnement approvisionnement_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_pkey PRIMARY KEY (id_approvisionnement);
 R   ALTER TABLE ONLY public.approvisionnement DROP CONSTRAINT approvisionnement_pkey;
       public            postgres    false    215            �           2606    41494    client client_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            postgres    false    217            �           2606    41496    famille famille_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.famille
    ADD CONSTRAINT famille_pkey PRIMARY KEY (id_famille);
 >   ALTER TABLE ONLY public.famille DROP CONSTRAINT famille_pkey;
       public            postgres    false    219            �           2606    41498    forme forme_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.forme
    ADD CONSTRAINT forme_pkey PRIMARY KEY (id_forme);
 :   ALTER TABLE ONLY public.forme DROP CONSTRAINT forme_pkey;
       public            postgres    false    221            �           2606    41500    fournisseur fournisseur_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pkey PRIMARY KEY (id_fournisseur);
 F   ALTER TABLE ONLY public.fournisseur DROP CONSTRAINT fournisseur_pkey;
       public            postgres    false    223            �           2606    41502    ligne_vente ligne_vente_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.ligne_vente
    ADD CONSTRAINT ligne_vente_pkey PRIMARY KEY (id_ligne_vente);
 F   ALTER TABLE ONLY public.ligne_vente DROP CONSTRAINT ligne_vente_pkey;
       public            postgres    false    225            �           2606    41504 4   login_historique login_historique_id_utilisateur_key 
   CONSTRAINT     y   ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_id_utilisateur_key UNIQUE (id_utilisateur);
 ^   ALTER TABLE ONLY public.login_historique DROP CONSTRAINT login_historique_id_utilisateur_key;
       public            postgres    false    227            �           2606    41506 &   login_historique login_historique_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_pkey PRIMARY KEY (id_login);
 P   ALTER TABLE ONLY public.login_historique DROP CONSTRAINT login_historique_pkey;
       public            postgres    false    227            �           2606    41508    medicament medicament_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_pkey PRIMARY KEY (id_medicament);
 D   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_pkey;
       public            postgres    false    229            �           2606    41510    utilisateurs utilisateurs_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id_utilisateur);
 H   ALTER TABLE ONLY public.utilisateurs DROP CONSTRAINT utilisateurs_pkey;
       public            postgres    false    231            �           2606    41512    vente vente_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_pkey PRIMARY KEY (id_vente);
 :   ALTER TABLE ONLY public.vente DROP CONSTRAINT vente_pkey;
       public            postgres    false    233            �           2606    41514     ventes_payees ventes_payees_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.ventes_payees
    ADD CONSTRAINT ventes_payees_pkey PRIMARY KEY (id_vente_payee);
 J   ALTER TABLE ONLY public.ventes_payees DROP CONSTRAINT ventes_payees_pkey;
       public            postgres    false    235            �           2620    41515 $   utilisateurs update_login_historique    TRIGGER     �   CREATE TRIGGER update_login_historique AFTER INSERT OR UPDATE ON public.utilisateurs FOR EACH ROW EXECUTE FUNCTION public.update_login_historique();
 =   DROP TRIGGER update_login_historique ON public.utilisateurs;
       public          postgres    false    231    237            �           2606    41516 7   approvisionnement approvisionnement_id_fournisseur_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_id_fournisseur_fkey FOREIGN KEY (id_fournisseur) REFERENCES public.fournisseur(id_fournisseur);
 a   ALTER TABLE ONLY public.approvisionnement DROP CONSTRAINT approvisionnement_id_fournisseur_fkey;
       public          postgres    false    215    223    4770            �           2606    41521 6   approvisionnement approvisionnement_id_medicament_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicament(id_medicament);
 `   ALTER TABLE ONLY public.approvisionnement DROP CONSTRAINT approvisionnement_id_medicament_fkey;
       public          postgres    false    4778    229    215            �           2606    41526 *   ligne_vente ligne_vente_id_medicament_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ligne_vente
    ADD CONSTRAINT ligne_vente_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicament(id_medicament);
 T   ALTER TABLE ONLY public.ligne_vente DROP CONSTRAINT ligne_vente_id_medicament_fkey;
       public          postgres    false    225    4778    229            �           2606    41531 %   ligne_vente ligne_vente_id_vente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ligne_vente
    ADD CONSTRAINT ligne_vente_id_vente_fkey FOREIGN KEY (id_vente) REFERENCES public.vente(id_vente);
 O   ALTER TABLE ONLY public.ligne_vente DROP CONSTRAINT ligne_vente_id_vente_fkey;
       public          postgres    false    4782    233    225            �           2606    41536 5   login_historique login_historique_id_utilisateur_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateurs(id_utilisateur);
 _   ALTER TABLE ONLY public.login_historique DROP CONSTRAINT login_historique_id_utilisateur_fkey;
       public          postgres    false    4780    231    227            �           2606    41541 %   medicament medicament_id_famille_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_famille_fkey FOREIGN KEY (id_famille) REFERENCES public.famille(id_famille);
 O   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_id_famille_fkey;
       public          postgres    false    219    229    4766            �           2606    41546 #   medicament medicament_id_forme_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_forme_fkey FOREIGN KEY (id_forme) REFERENCES public.forme(id_forme);
 M   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_id_forme_fkey;
       public          postgres    false    221    229    4768            �           2606    41551 )   medicament medicament_id_fournisseur_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_fournisseur_fkey FOREIGN KEY (id_fournisseur) REFERENCES public.fournisseur(id_fournisseur);
 S   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_id_fournisseur_fkey;
       public          postgres    false    4770    229    223            �           2606    41556    vente vente_id_client_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);
 D   ALTER TABLE ONLY public.vente DROP CONSTRAINT vente_id_client_fkey;
       public          postgres    false    4764    233    217            J   �   x�eα
�0����],�&IGW�.����3� ��l� ����,��&ݞ��p��犎"�W\�!�!��(�	��������#�Ilf8���~���ƥ*M���R�>���K�r*Qi���q�L�Ɛ��QJ���7      L   ~  x�}�Mn�0�׏S� u�_�,QTUEB��ƀ)�R9	*G�Q8��T/�{�{�	��v�]�F;����p�P�Bk�ڠJ���_wq[��9.T	�0�ɩ�j�f�"-h��i���+	&��@zo\O���V�j|����h��T�X
��-��l�r,�n��1m�Ix
ۢg�.}>�B[���|8/��[�|ޅn���5!t�Ba�0��PdVf�ú�1�}�tp��͵��B�!Y���`�o]GV;Ɯ -�-���W�w��!N�\o|Xx���5�1%&
&��zJ�O,{)���M����?6�+h��(0%�����su�s�KD�ie�e$_�|�N	�e��E<OF�Ɂ�sӛ6�<�^��J���������Ѥ      N   �  x�}�Kn�0���S�*,��d�A�E#Nv�L%Z@�C����s�b9	��h����σ�p۶Vjn�&X:�Y�u�������>4���f2��@��ٕ�ۚ�D�Ϗ��1��-v��$s��Е� )e6d}�)n��T�GW���+�cK�OeL�+?�+����[]緯ổ������r)�X�� �߻0��?�C�V,
x8�q(��U������6`[�S��t^kxr�۟�̳
zJg����7��Sh�м;�-����U��ˆP�9�+x��R�}ρsi��y�rtI7�s6&��v�U�ೊ�v�ȓ�3�j=��� �6���M/M�`c`��35�R-���5C�`ϱl4�#w��j�&r���Bn���Q�@fo_ӦF�I���-�w�PS      P   �   x�m�M
�0����������Lch�̐����{a�Ջ��|��o�j�-��⛞f7z�?ޯ'��t��?e`�؁�\� P�&�T��p�������x�����T�	�h#aj=���G*�-�Ăh�%�q�@����D(�ܶJ�/19S;      R   �  x�m�͎�0F��S� 3#���i�.&J���q�3��eC4y��9�b�؈I!;|�w?(��F�k�R��<vp���P���y�RJe��Q�A&���Nv��pq��c����F������{��	ݤ�:׉�{'Z�섆�m��qQ�P���e(�ɳZy�	�J�pIG�V8/U��5��ZT���{�#H���(�2��(��"�MF/��Nu�3`R2b~�7��ߠd���{�brѨ	�9;BS�q��uv�.�I��#g�?fp�k�H�3���3Sr4͋r�t��^9c���H�!t/�������g��@P��̞:k�I[p{)�$񪴼���r�%����C�Ұ�g�)��5�����jyVܾ��e�l��:q�!��-+���w)��0��a��>�x��_�ȏ^��I�o-�L���u��O����A 8;m/�Ѿ�`y�U©������?�      T   0  x�m�ّ1D�Q0.:�\6�8���=�T���5�1LL����W�$����jRu�O�Q'�g<�S�𾢯���3�D�N�(/�O�����CG�Ù�JYtC,�����X8�F�_3��օ[����|�2�F̷?Zbs<�>�������z��g!�8�0Z��cb!hn螌��:���{��tW�~��钦s�S�wg��p?�pQL�I�N��0;�m)
���w�
{v��>4GX��'������%�[EM�h�N;~�a�r�Z�E)�wxe_3�߫���4��      V   �   x�e�Kn�@���� #���Y�D$�QK��������l�fqP�ǲ=`��}F��	i`I����a*E�@`Z�?�:/��Gǀ���RMG�b@�կǫogQY��V�o�r��z�%sE�(b{l{��0S�J�|�4�:��/O�Q-������e��֗�g8�XU7]˹�R~cKJ�      X   �  x����J�0��ӧ��ҴM�{\QT��%��n Mj����'�/�l�uQ)i2�����8����T�!�E�d<�L	m�i�2��bh���vr�sgj�:"d$� �2��z�Gn�����6�����bAa���y
�߅�C��c
�tX9�Bءvq-[*�.3�P\��ׅ�W� l���|r�R���ƽ��9!-BN��H��&���o��������h�}8}�5E5��A���> U�ӚQ�h�	�H�i�
E5��?���2u�A)��^Z�r�q���tJ	ҙ�'P�>�Y����n��Վ���Ґ���ry$���+��5�P8{:v�~2�,gU�s�9<	��a?�J�_�_�����=��
V'��_Q}c�      Z   ^   x�3�L�KɄe�y)��E�1~\��ٙ�`�����21�,I-.�pQ#Μ��d�Pjƙ��Y\��Z�sA��PAd$nwD�=1z\\\ �52      \   �   x�u�1�0��=(r�8# $V�
�	$$��9�ah��Z=Y�;n� �}���v��c?����y�LZ֖�����HB�~��jQZ(���V:��쥎��h��x%E��^��@o�����m�aM�z��V�����g�����}Єxv6�a!�%y{,�w�%��f]��LPo�(����O��f�F�x��y���ٜ��vˤO�i>Y^$`      ^   {   x�}�1�0����\ d�&!���C�.���R�8?Tl��O~a�������2�yAHک���jl5�K���TV��N������D�R��P����޲$�U�Pr)u��?��Rޝ��*vH�     