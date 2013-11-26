--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE activities (
    id integer NOT NULL,
    user_id integer,
    action character varying(255),
    trackable_id integer,
    trackable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activities_id_seq OWNED BY activities.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    user_id integer,
    question_id integer,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    content character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: file_handlers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE file_handlers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer DEFAULT 0,
    is_cover boolean DEFAULT false,
    file_name character varying(255) NOT NULL,
    file_path character varying(255) NOT NULL,
    file_type character varying(255) NOT NULL,
    file_size character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    properties hstore
);


--
-- Name: file_handlers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE file_handlers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_handlers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE file_handlers_id_seq OWNED BY file_handlers.id;


--
-- Name: friends; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE friends (
    id integer NOT NULL,
    provider character varying(255),
    uid character varying(255),
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: friends_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friends_id_seq OWNED BY friends.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifications (
    id integer NOT NULL,
    user_id integer,
    news boolean DEFAULT true,
    tips boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email_subscribe_to_you boolean DEFAULT true,
    email_comments_on_your_story boolean DEFAULT true,
    email_product_is_featured boolean DEFAULT true,
    email_recommends_your_product boolean DEFAULT true,
    email_purchase_your_product boolean DEFAULT true,
    email_request_sold_out_product boolean DEFAULT true
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: order_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_events (
    id integer NOT NULL,
    order_id integer,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: order_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE order_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE order_events_id_seq OWNED BY order_events.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    order_no character varying(255) NOT NULL,
    transaction_id integer DEFAULT 0,
    amount numeric NOT NULL,
    product_id integer NOT NULL,
    product_type character varying(255) NOT NULL,
    user_id integer DEFAULT 0,
    referrer_id character varying(255) DEFAULT 0,
    referrer_commission numeric DEFAULT 0,
    quantity integer DEFAULT 1 NOT NULL,
    payment_status character varying(255) DEFAULT 'processing'::character varying,
    full_name character varying(255),
    email character varying(255),
    street_address character varying(255),
    city character varying(255),
    post_code character varying(255),
    shipping_service character varying(255),
    tracking_id character varying(255),
    offer_discount_off numeric,
    transaction_fee numeric NOT NULL,
    order_total numeric NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    publisher_id integer,
    shipped_at timestamp without time zone,
    referred_from character varying(255),
    state character varying(255),
    country character varying(255),
    custom_attributes hstore,
    shipping_price numeric,
    amount_paid numeric
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_categories (
    id integer NOT NULL,
    category character varying(255),
    category_type character varying(255),
    amount character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_categories_id_seq OWNED BY product_categories.id;


--
-- Name: product_custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_custom_fields (
    id integer NOT NULL,
    name character varying(255),
    product_id integer,
    required boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: product_custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_custom_fields_id_seq OWNED BY product_custom_fields.id;


--
-- Name: product_offers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_offers (
    id integer NOT NULL,
    code character varying(255),
    amount_off numeric,
    quantity integer,
    product_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: product_offers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_offers_id_seq OWNED BY product_offers.id;


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_variants (
    id integer NOT NULL,
    name character varying(255),
    option character varying(255),
    price_change numeric,
    quantity integer,
    product_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_variants_id_seq OWNED BY product_variants.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    store_id integer NOT NULL,
    category_id integer NOT NULL,
    product_title character varying(255) NOT NULL,
    product_type character varying(255) NOT NULL,
    description text NOT NULL,
    quantity integer,
    unlimited boolean DEFAULT false,
    views integer,
    sales character varying(255),
    pricing character varying(255),
    amount numeric DEFAULT 0,
    amount_from numeric DEFAULT 0,
    auction_id integer DEFAULT 0,
    random_no character varying(255),
    buyer_will_get character varying(255),
    custom_message text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    commision integer DEFAULT 10,
    sold integer DEFAULT 0,
    initial_quantity integer,
    unique_views integer DEFAULT 0
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    user_id integer,
    body character varying(255),
    answered boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    questioned_id integer
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE recommendations (
    id integer NOT NULL,
    product_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: recommendations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE recommendations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE recommendations_id_seq OWNED BY recommendations.id;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE relationships (
    id integer NOT NULL,
    subscriber_id integer,
    publisher_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE relationships_id_seq OWNED BY relationships.id;


--
-- Name: requests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE requests (
    id integer NOT NULL,
    user_id integer DEFAULT 0,
    publisher_id integer NOT NULL,
    email character varying(255) NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    note character varying(255)
);


--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE requests_id_seq OWNED BY requests.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: shipping_profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE shipping_profiles (
    id integer NOT NULL,
    option character varying(255),
    cost numeric,
    product_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "time" integer DEFAULT 0
);


--
-- Name: shipping_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE shipping_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipping_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shipping_profiles_id_seq OWNED BY shipping_profiles.id;


--
-- Name: social_connections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE social_connections (
    id integer NOT NULL,
    user_id integer,
    provider character varying(255),
    token character varying(255),
    provider_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    auth_secret character varying(255)
);


--
-- Name: social_connections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE social_connections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: social_connections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE social_connections_id_seq OWNED BY social_connections.id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stores (
    id integer NOT NULL,
    user_id integer,
    store_name character varying(255),
    delivery_returns text,
    more_info text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    currency character varying(255),
    terms_conditions boolean,
    store_url character varying(255),
    show_recommendations boolean,
    ask_questions boolean,
    ask_page_title character varying(255),
    views integer DEFAULT 0,
    unique_views integer DEFAULT 0,
    custom_theme_content text,
    payout_email character varying(255),
    store_terms text,
    original_theme_id integer DEFAULT 0,
    current_theme_id integer DEFAULT 0,
    custom_appearance hstore
);


--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stores_id_seq OWNED BY stores.id;


--
-- Name: themes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE themes (
    id integer NOT NULL,
    theme_content text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    theme_name character varying(255),
    user_id integer,
    custom_appearance hstore
);


--
-- Name: themes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE themes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: themes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE themes_id_seq OWNED BY themes.id;


--
-- Name: traffics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE traffics (
    id integer NOT NULL,
    store_id integer DEFAULT 0,
    product_id integer DEFAULT 0,
    ip_address character varying(255),
    owner_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    view integer DEFAULT 1,
    referrer character varying(255)
);


--
-- Name: traffics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE traffics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: traffics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE traffics_id_seq OWNED BY traffics.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE transactions (
    id integer NOT NULL,
    card_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    payment_token character varying(255),
    card_id character varying(255),
    last_4_digits character varying(255),
    order_id integer,
    email character varying(255)
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;


--
-- Name: user_addresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_addresses (
    id integer NOT NULL,
    user_id integer,
    street character varying(255),
    city character varying(255),
    state character varying(255),
    code character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    country character varying(255)
);


--
-- Name: user_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_addresses_id_seq OWNED BY user_addresses.id;


--
-- Name: user_card_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_card_details (
    id integer NOT NULL,
    user_id integer,
    card_id character varying(255),
    card_type character varying(255),
    last_4_digits character varying(255),
    shipping_address_present boolean DEFAULT false,
    street_address character varying(255),
    city character varying(255),
    state character varying(255),
    post_code character varying(255),
    country character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_card_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_card_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_card_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_card_details_id_seq OWNED BY user_card_details.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    provider character varying(255),
    provider_id character varying(255),
    token character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    username character varying(255),
    bio text,
    location character varying(255),
    website character varying(255),
    gender character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    balance character varying(255) DEFAULT 0,
    auth_secret character varying(255),
    timezone character varying(255),
    verified boolean,
    picture character varying(255),
    account_activation_code character varying(255) DEFAULT NULL::character varying,
    avatar_id integer DEFAULT 0,
    referer character varying(255),
    country character varying(255),
    localization character varying(255),
    card_details_id integer DEFAULT 0,
    user_address_id integer DEFAULT 0,
    ref_id character varying(255),
    uncleared_balance numeric DEFAULT 0
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities ALTER COLUMN id SET DEFAULT nextval('activities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY file_handlers ALTER COLUMN id SET DEFAULT nextval('file_handlers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friends ALTER COLUMN id SET DEFAULT nextval('friends_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY order_events ALTER COLUMN id SET DEFAULT nextval('order_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_categories ALTER COLUMN id SET DEFAULT nextval('product_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_custom_fields ALTER COLUMN id SET DEFAULT nextval('product_custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_offers ALTER COLUMN id SET DEFAULT nextval('product_offers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_variants ALTER COLUMN id SET DEFAULT nextval('product_variants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY recommendations ALTER COLUMN id SET DEFAULT nextval('recommendations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships ALTER COLUMN id SET DEFAULT nextval('relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requests ALTER COLUMN id SET DEFAULT nextval('requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shipping_profiles ALTER COLUMN id SET DEFAULT nextval('shipping_profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY social_connections ALTER COLUMN id SET DEFAULT nextval('social_connections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stores ALTER COLUMN id SET DEFAULT nextval('stores_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY themes ALTER COLUMN id SET DEFAULT nextval('themes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY traffics ALTER COLUMN id SET DEFAULT nextval('traffics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transactions ALTER COLUMN id SET DEFAULT nextval('transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_addresses ALTER COLUMN id SET DEFAULT nextval('user_addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_card_details ALTER COLUMN id SET DEFAULT nextval('user_card_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: file_handlers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY file_handlers
    ADD CONSTRAINT file_handlers_pkey PRIMARY KEY (id);


--
-- Name: friends_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY friends
    ADD CONSTRAINT friends_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY order_events
    ADD CONSTRAINT order_events_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: product_custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_custom_fields
    ADD CONSTRAINT product_custom_fields_pkey PRIMARY KEY (id);


--
-- Name: product_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_offers
    ADD CONSTRAINT product_offers_pkey PRIMARY KEY (id);


--
-- Name: product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: shipping_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY shipping_profiles
    ADD CONSTRAINT shipping_profiles_pkey PRIMARY KEY (id);


--
-- Name: social_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY social_connections
    ADD CONSTRAINT social_connections_pkey PRIMARY KEY (id);


--
-- Name: stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: themes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (id);


--
-- Name: traffics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY traffics
    ADD CONSTRAINT traffics_pkey PRIMARY KEY (id);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_addresses
    ADD CONSTRAINT user_addresses_pkey PRIMARY KEY (id);


--
-- Name: user_card_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_card_details
    ADD CONSTRAINT user_card_details_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: file_handlers_properties; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX file_handlers_properties ON file_handlers USING gin (properties);


--
-- Name: index_activities_on_trackable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_trackable_id ON activities USING btree (trackable_id);


--
-- Name: index_activities_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_user_id ON activities USING btree (user_id);


--
-- Name: index_comments_on_content; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_content ON comments USING btree (content);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_file_handlers_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_file_handlers_on_product_id ON file_handlers USING btree (product_id);


--
-- Name: index_file_handlers_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_file_handlers_on_user_id ON file_handlers USING btree (user_id);


--
-- Name: index_friends_on_provider; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friends_on_provider ON friends USING btree (provider);


--
-- Name: index_friends_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friends_on_user_id ON friends USING btree (user_id);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notifications_on_user_id ON notifications USING btree (user_id);


--
-- Name: index_order_events_on_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_events_on_order_id ON order_events USING btree (order_id);


--
-- Name: index_orders_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_product_id ON orders USING btree (product_id);


--
-- Name: index_orders_on_referrer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_referrer_id ON orders USING btree (referrer_id);


--
-- Name: index_orders_on_transaction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_transaction_id ON orders USING btree (transaction_id);


--
-- Name: index_product_categories_on_category; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_categories_on_category ON product_categories USING btree (category);


--
-- Name: index_product_categories_on_category_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_categories_on_category_type ON product_categories USING btree (category_type);


--
-- Name: index_product_custom_fields_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_custom_fields_on_name ON product_custom_fields USING btree (name);


--
-- Name: index_product_custom_fields_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_custom_fields_on_product_id ON product_custom_fields USING btree (product_id);


--
-- Name: index_product_offers_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_offers_on_product_id ON product_offers USING btree (product_id);


--
-- Name: index_product_variants_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_variants_on_name ON product_variants USING btree (name);


--
-- Name: index_product_variants_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_variants_on_product_id ON product_variants USING btree (product_id);


--
-- Name: index_products_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_category_id ON products USING btree (category_id);


--
-- Name: index_products_on_product_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_product_title ON products USING btree (product_title);


--
-- Name: index_products_on_product_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_product_type ON products USING btree (product_type);


--
-- Name: index_products_on_random_no; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_random_no ON products USING btree (random_no);


--
-- Name: index_products_on_store_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_store_id ON products USING btree (store_id);


--
-- Name: index_products_on_views; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_views ON products USING btree (views);


--
-- Name: index_recommendations_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_recommendations_on_product_id ON recommendations USING btree (product_id);


--
-- Name: index_recommendations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_recommendations_on_user_id ON recommendations USING btree (user_id);


--
-- Name: index_relationships_on_publisher_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_relationships_on_publisher_id ON relationships USING btree (publisher_id);


--
-- Name: index_relationships_on_subscriber_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_relationships_on_subscriber_id ON relationships USING btree (subscriber_id);


--
-- Name: index_relationships_on_subscriber_id_and_publisher_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_relationships_on_subscriber_id_and_publisher_id ON relationships USING btree (subscriber_id, publisher_id);


--
-- Name: index_requests_on_publisher_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_requests_on_publisher_id ON requests USING btree (publisher_id);


--
-- Name: index_shipping_profiles_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_shipping_profiles_on_product_id ON shipping_profiles USING btree (product_id);


--
-- Name: index_social_connections_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_social_connections_on_user_id ON social_connections USING btree (user_id);


--
-- Name: index_stores_on_store_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stores_on_store_url ON stores USING btree (store_url);


--
-- Name: index_stores_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stores_on_user_id ON stores USING btree (user_id);


--
-- Name: index_traffics_on_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_traffics_on_owner_id ON traffics USING btree (owner_id);


--
-- Name: index_traffics_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_traffics_on_product_id ON traffics USING btree (product_id);


--
-- Name: index_traffics_on_store_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_traffics_on_store_id ON traffics USING btree (store_id);


--
-- Name: index_users_on_balance; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_balance ON users USING btree (balance);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_first_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_first_name ON users USING btree (first_name);


--
-- Name: index_users_on_last_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_last_name ON users USING btree (last_name);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: orders_custom_attributes; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX orders_custom_attributes ON orders USING gin (custom_attributes);


--
-- Name: stores_custom_appearance; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX stores_custom_appearance ON stores USING gin (custom_appearance);


--
-- Name: themes_custom_appearance; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX themes_custom_appearance ON themes USING gin (custom_appearance);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130425060527');

INSERT INTO schema_migrations (version) VALUES ('20130426110500');

INSERT INTO schema_migrations (version) VALUES ('20130427062752');

INSERT INTO schema_migrations (version) VALUES ('20130429050113');

INSERT INTO schema_migrations (version) VALUES ('20130429104357');

INSERT INTO schema_migrations (version) VALUES ('20130509083558');

INSERT INTO schema_migrations (version) VALUES ('20130513090808');

INSERT INTO schema_migrations (version) VALUES ('20130527113018');

INSERT INTO schema_migrations (version) VALUES ('20130528060451');

INSERT INTO schema_migrations (version) VALUES ('20130604055104');

INSERT INTO schema_migrations (version) VALUES ('20130604064920');

INSERT INTO schema_migrations (version) VALUES ('20130605054732');

INSERT INTO schema_migrations (version) VALUES ('20130612072336');

INSERT INTO schema_migrations (version) VALUES ('20130617130335');

INSERT INTO schema_migrations (version) VALUES ('20130618212922');

INSERT INTO schema_migrations (version) VALUES ('20130618230522');

INSERT INTO schema_migrations (version) VALUES ('20130619181605');

INSERT INTO schema_migrations (version) VALUES ('20130619203216');

INSERT INTO schema_migrations (version) VALUES ('20130621171235');

INSERT INTO schema_migrations (version) VALUES ('20130703220238');

INSERT INTO schema_migrations (version) VALUES ('20130703220428');

INSERT INTO schema_migrations (version) VALUES ('20130821124529');

INSERT INTO schema_migrations (version) VALUES ('20130821124840');

INSERT INTO schema_migrations (version) VALUES ('20130823064052');

INSERT INTO schema_migrations (version) VALUES ('20130823215054');

INSERT INTO schema_migrations (version) VALUES ('20130824052350');

INSERT INTO schema_migrations (version) VALUES ('20130828105135');

INSERT INTO schema_migrations (version) VALUES ('20130828105557');

INSERT INTO schema_migrations (version) VALUES ('20130829095923');

INSERT INTO schema_migrations (version) VALUES ('20130908115202');

INSERT INTO schema_migrations (version) VALUES ('20130910105022');

INSERT INTO schema_migrations (version) VALUES ('20130910110837');

INSERT INTO schema_migrations (version) VALUES ('20130910145429');

INSERT INTO schema_migrations (version) VALUES ('20130911173512');

INSERT INTO schema_migrations (version) VALUES ('20130913121418');

INSERT INTO schema_migrations (version) VALUES ('20130915064014');

INSERT INTO schema_migrations (version) VALUES ('20130915065931');

INSERT INTO schema_migrations (version) VALUES ('20130916103949');

INSERT INTO schema_migrations (version) VALUES ('20130916111233');

INSERT INTO schema_migrations (version) VALUES ('20130918103617');

INSERT INTO schema_migrations (version) VALUES ('20130919070426');

INSERT INTO schema_migrations (version) VALUES ('20130919130811');

INSERT INTO schema_migrations (version) VALUES ('20130921190959');

INSERT INTO schema_migrations (version) VALUES ('20130922065239');

INSERT INTO schema_migrations (version) VALUES ('20130923093153');

INSERT INTO schema_migrations (version) VALUES ('20130924081444');

INSERT INTO schema_migrations (version) VALUES ('20130925155209');

INSERT INTO schema_migrations (version) VALUES ('20130926115801');

INSERT INTO schema_migrations (version) VALUES ('20130926203817');

INSERT INTO schema_migrations (version) VALUES ('20130926223420');

INSERT INTO schema_migrations (version) VALUES ('20130929160135');

INSERT INTO schema_migrations (version) VALUES ('20130929160246');

INSERT INTO schema_migrations (version) VALUES ('20130929164139');

INSERT INTO schema_migrations (version) VALUES ('20130929164311');

INSERT INTO schema_migrations (version) VALUES ('20131003111401');

INSERT INTO schema_migrations (version) VALUES ('20131003202221');

INSERT INTO schema_migrations (version) VALUES ('20131003213638');

INSERT INTO schema_migrations (version) VALUES ('20131003235828');

INSERT INTO schema_migrations (version) VALUES ('20131004084508');

INSERT INTO schema_migrations (version) VALUES ('20131004094502');

INSERT INTO schema_migrations (version) VALUES ('20131004095455');

INSERT INTO schema_migrations (version) VALUES ('20131004134142');

INSERT INTO schema_migrations (version) VALUES ('20131005163206');

INSERT INTO schema_migrations (version) VALUES ('20131009123352');

INSERT INTO schema_migrations (version) VALUES ('20131010092151');

INSERT INTO schema_migrations (version) VALUES ('20131010094409');

INSERT INTO schema_migrations (version) VALUES ('20131010104004');

INSERT INTO schema_migrations (version) VALUES ('20131013120539');

INSERT INTO schema_migrations (version) VALUES ('20131013121525');

INSERT INTO schema_migrations (version) VALUES ('20131013122200');

INSERT INTO schema_migrations (version) VALUES ('20131014070138');

INSERT INTO schema_migrations (version) VALUES ('20131014070350');

INSERT INTO schema_migrations (version) VALUES ('20131015114954');

INSERT INTO schema_migrations (version) VALUES ('20131015124108');

INSERT INTO schema_migrations (version) VALUES ('20131017075603');

INSERT INTO schema_migrations (version) VALUES ('20131017080257');

INSERT INTO schema_migrations (version) VALUES ('20131017121551');

INSERT INTO schema_migrations (version) VALUES ('20131018131405');

INSERT INTO schema_migrations (version) VALUES ('20131018161120');

INSERT INTO schema_migrations (version) VALUES ('20131023091018');

INSERT INTO schema_migrations (version) VALUES ('20131024091519');

INSERT INTO schema_migrations (version) VALUES ('20131024091615');

INSERT INTO schema_migrations (version) VALUES ('20131024140229');

INSERT INTO schema_migrations (version) VALUES ('20131024140315');

INSERT INTO schema_migrations (version) VALUES ('20131025110817');

INSERT INTO schema_migrations (version) VALUES ('20131027083814');

INSERT INTO schema_migrations (version) VALUES ('20131029195339');

INSERT INTO schema_migrations (version) VALUES ('20131029202142');

INSERT INTO schema_migrations (version) VALUES ('20131030085356');

INSERT INTO schema_migrations (version) VALUES ('20131030091023');

INSERT INTO schema_migrations (version) VALUES ('20131030104616');

INSERT INTO schema_migrations (version) VALUES ('20131030104726');

INSERT INTO schema_migrations (version) VALUES ('20131030193948');

INSERT INTO schema_migrations (version) VALUES ('20131101155853');