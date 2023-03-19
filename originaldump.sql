--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22
-- Dumped by pg_dump version 10.22

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: choose; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.choose (
    rid character varying(8) NOT NULL,
    vid character varying(8) NOT NULL,
    validity character varying(8) NOT NULL
);


ALTER TABLE public.choose OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    nic character varying(15) NOT NULL,
    fname character varying(8) NOT NULL,
    lname character varying(15) NOT NULL,
    dlicense character varying(10),
    address character varying(30) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    eid integer NOT NULL,
    ename character varying(80) NOT NULL,
    address character varying(30),
    salary numeric NOT NULL,
    contactno character varying(11) NOT NULL,
    responsibility character varying(20)
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: rent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rent (
    rentid character varying(8) NOT NULL,
    refund double precision,
    paymethod character varying(5),
    paydate character varying(15) NOT NULL,
    payamount numeric NOT NULL,
    damagecompensition numeric,
    nic character varying(15) NOT NULL,
    vid character varying(8) NOT NULL,
    CONSTRAINT rent_payamount_check CHECK ((payamount > (0)::numeric)),
    CONSTRAINT rent_refund_check CHECK ((refund > (0)::double precision))
);


ALTER TABLE public.rent OWNER TO postgres;

--
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    rid character varying(8) NOT NULL,
    picklocation character varying(25),
    pickupdate character varying(15) NOT NULL,
    returndate character varying(15) NOT NULL,
    reservedate character varying(15) NOT NULL,
    vehicleid character varying(8) NOT NULL,
    employeeid integer NOT NULL,
    nic character varying(15) NOT NULL
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- Name: vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle (
    vid character varying(8) NOT NULL,
    plateno character varying(7) NOT NULL,
    dailyprice numeric,
    model character varying(10),
    vtype character varying(6) NOT NULL,
    eid integer NOT NULL,
    nic character varying(15) NOT NULL,
    CONSTRAINT vehicle_dailyprice_check CHECK ((dailyprice > (0)::numeric))
);


ALTER TABLE public.vehicle OWNER TO postgres;

--
-- Name: customer customer_dlicense_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_dlicense_key UNIQUE (dlicense);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (nic);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (eid);


--
-- Name: vehicle pk_vehicle; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT pk_vehicle PRIMARY KEY (vid);


--
-- Name: rent rent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rent
    ADD CONSTRAINT rent_pkey PRIMARY KEY (rentid);


--
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (rid);


--
-- Name: choose fk_choose1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.choose
    ADD CONSTRAINT fk_choose1 FOREIGN KEY (rid) REFERENCES public.reservation(rid);


--
-- Name: rent fk_rent1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rent
    ADD CONSTRAINT fk_rent1 FOREIGN KEY (nic) REFERENCES public.customer(nic);


--
-- Name: rent fk_rent2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rent
    ADD CONSTRAINT fk_rent2 FOREIGN KEY (vid) REFERENCES public.vehicle(vid);


--
-- Name: reservation fk_reserve2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reserve2 FOREIGN KEY (employeeid) REFERENCES public.employee(eid);


--
-- Name: reservation fk_reserve3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reserve3 FOREIGN KEY (nic) REFERENCES public.customer(nic);


--
-- Name: vehicle fk_vehicle1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle1 FOREIGN KEY (eid) REFERENCES public.employee(eid);


--
-- Name: vehicle fk_vehicle2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle2 FOREIGN KEY (nic) REFERENCES public.customer(nic);


--
-- PostgreSQL database dump complete
--

