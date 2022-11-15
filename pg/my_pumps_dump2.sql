--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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
-- Name: flow_sensors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flow_sensors (
    id integer NOT NULL,
    tag_name text NOT NULL,
    model text,
    min_range real,
    max_range real,
    current_value real NOT NULL,
    pump_id integer
);


ALTER TABLE public.flow_sensors OWNER TO postgres;

--
-- Name: flow_sensors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flow_sensors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flow_sensors_id_seq OWNER TO postgres;

--
-- Name: flow_sensors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flow_sensors_id_seq OWNED BY public.flow_sensors.id;


--
-- Name: flow_timeseries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flow_timeseries (
    sensor_id integer NOT NULL,
    "time" integer NOT NULL,
    value real
);


ALTER TABLE public.flow_timeseries OWNER TO postgres;

--
-- Name: motors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motors (
    id integer NOT NULL,
    tag_name text NOT NULL,
    model text,
    max_speed real,
    pump_id integer NOT NULL
);


ALTER TABLE public.motors OWNER TO postgres;

--
-- Name: motors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.motors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.motors_id_seq OWNER TO postgres;

--
-- Name: motors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.motors_id_seq OWNED BY public.motors.id;


--
-- Name: pump_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pump_models (
    id integer NOT NULL,
    make text NOT NULL,
    model text NOT NULL,
    max_flow real
);


ALTER TABLE public.pump_models OWNER TO postgres;

--
-- Name: pump_models_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pump_models_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pump_models_id_seq OWNER TO postgres;

--
-- Name: pump_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pump_models_id_seq OWNED BY public.pump_models.id;


--
-- Name: pumps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pumps (
    id integer NOT NULL,
    tag_name text NOT NULL,
    model_id integer NOT NULL
);


ALTER TABLE public.pumps OWNER TO postgres;

--
-- Name: pumps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pumps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pumps_id_seq OWNER TO postgres;

--
-- Name: pumps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pumps_id_seq OWNED BY public.pumps.id;


--
-- Name: speed_sensors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.speed_sensors (
    id integer NOT NULL,
    tag_name text NOT NULL,
    type text,
    current_value real NOT NULL,
    motor_id integer NOT NULL
);


ALTER TABLE public.speed_sensors OWNER TO postgres;

--
-- Name: speed_sensors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.speed_sensors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.speed_sensors_id_seq OWNER TO postgres;

--
-- Name: speed_sensors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.speed_sensors_id_seq OWNED BY public.speed_sensors.id;


--
-- Name: speed_timeseries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.speed_timeseries (
    sensor_id integer NOT NULL,
    "time" integer NOT NULL,
    value real
);


ALTER TABLE public.speed_timeseries OWNER TO postgres;

--
-- Name: vendors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.vendors OWNER TO postgres;

--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_id_seq OWNER TO postgres;

--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- Name: vendors_pump_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors_pump_models (
    vendor_id integer NOT NULL,
    model_id integer NOT NULL,
    pump_price real NOT NULL
);


ALTER TABLE public.vendors_pump_models OWNER TO postgres;

--
-- Name: flow_sensors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_sensors ALTER COLUMN id SET DEFAULT nextval('public.flow_sensors_id_seq'::regclass);


--
-- Name: motors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motors ALTER COLUMN id SET DEFAULT nextval('public.motors_id_seq'::regclass);


--
-- Name: pump_models id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pump_models ALTER COLUMN id SET DEFAULT nextval('public.pump_models_id_seq'::regclass);


--
-- Name: pumps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pumps ALTER COLUMN id SET DEFAULT nextval('public.pumps_id_seq'::regclass);


--
-- Name: speed_sensors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speed_sensors ALTER COLUMN id SET DEFAULT nextval('public.speed_sensors_id_seq'::regclass);


--
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- Data for Name: flow_sensors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flow_sensors (id, tag_name, model, min_range, max_range, current_value, pump_id) FROM stdin;
1	40FT1001A	OMEGA FTB600B	0	30	15	1
2	40FT1001B	OMEGA FTB600B	0	30	15	1
3	27FT2004	Fill-Rite TT10AN	\N	\N	25	2
4	63FT2017A	\N	0	1920	25	3
22	67FT1020	ZachTechFT	\N	200	102.1	\N
\.


--
-- Data for Name: flow_timeseries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flow_timeseries (sensor_id, "time", value) FROM stdin;
1	0	61.894974
1	10	25.403353
1	20	49.31952
1	31	63.47912
1	41	18.792889
1	51	25.958357
1	61	68.94114
1	71	49.594448
1	81	77.66921
1	92	4.95559
1	102	27.497725
1	112	28.259062
1	122	98.38947
1	132	22.581066
1	142	5.120957
1	153	60.85264
1	163	94.49873
1	173	13.150812
1	183	74.158516
1	193	55.539093
1	203	45.10236
1	214	90.34011
1	224	57.077766
1	234	16.651411
1	244	99.44467
1	254	54.206078
1	264	90.28517
1	275	8.713272
1	285	75.952736
1	295	27.011824
1	305	16.881418
1	315	52.68329
1	325	42.832417
1	336	46.12229
1	346	52.290924
1	356	10.5662985
1	366	30.276402
1	376	60.306976
1	386	81.82612
1	397	69.95236
1	407	33.953613
1	417	60.045982
1	427	8.825028
1	437	5.297039
1	447	82.19627
1	458	17.190687
1	468	81.28941
1	478	34.602543
1	488	92.390236
1	498	5.6458926
1	508	45.17108
1	519	84.8127
1	529	97.87123
1	539	10.721958
1	549	75.20747
1	559	89.83691
1	569	82.11141
1	580	47.69536
1	590	52.930756
1	600	89.184875
2	0	75.89256
2	10	31.913755
2	20	82.78737
2	31	53.989437
2	41	73.83947
2	51	60.321793
2	61	81.48917
2	71	80.388794
2	81	87.98016
2	92	87.96607
2	102	95.27214
2	112	76.072525
2	122	81.89961
2	132	50.253197
2	142	22.01151
2	153	29.445574
2	163	20.421541
2	173	47.56683
2	183	58.99259
2	193	70.69546
2	203	75.469925
2	214	41.11303
2	224	30.956097
2	234	47.905956
2	244	79.226166
2	254	27.350624
2	264	0.90888727
2	275	74.01254
2	285	59.14622
2	295	51.767162
2	305	49.812626
2	315	65.47147
2	325	14.279049
2	336	5.996443
2	346	29.792547
2	356	21.9967
2	366	3.049324
2	376	49.165966
2	386	87.22157
2	397	11.418383
2	407	79.66961
2	417	80.96441
2	427	55.28536
2	437	80.39143
2	447	97.927864
2	458	95.84426
2	468	7.260259
2	478	31.32701
2	488	37.591915
2	498	37.56711
2	508	28.301535
2	519	5.5741796
2	529	74.1575
2	539	29.583033
2	549	41.71716
2	559	49.71806
2	569	46.94078
2	580	15.461169
2	590	32.35804
2	600	42.15115
3	0	9.67804
3	10	81.107124
3	20	58.312588
3	31	16.733927
3	41	5.8971853
3	51	68.92829
3	61	3.4409735
3	71	6.646544
3	81	23.163002
3	92	43.43056
3	102	56.989815
3	112	98.553604
3	122	79.83185
3	132	28.234205
3	142	54.4088
3	153	19.350294
3	163	23.944214
3	173	36.21614
3	183	8.409169
3	193	26.124231
3	203	9.6605015
3	214	30.217676
3	224	79.05675
3	234	3.134909
3	244	69.39441
3	254	65.879196
3	264	2.6041994
3	275	35.92632
3	285	60.49879
3	295	50.442448
3	305	48.99275
3	315	89.88993
3	325	4.9054794
3	336	29.686926
3	346	63.039215
3	356	5.7141805
3	366	25.518538
3	376	68.04589
3	386	42.891033
3	397	16.594688
3	407	79.51648
3	417	58.098988
3	427	15.335782
3	437	86.616394
3	447	95.05675
3	458	80.67711
3	468	7.3115425
3	478	93.20433
3	488	9.614786
3	498	80.39142
3	508	88.23034
3	519	79.38328
3	529	93.61075
3	539	77.55578
3	549	63.30212
3	559	83.99653
3	569	67.53694
3	580	46.893578
3	590	13.122795
3	600	77.45578
4	0	89.227425
4	10	61.962387
4	20	54.78735
4	31	62.700096
4	41	58.77782
4	51	77.13556
4	61	10.263115
4	71	68.65129
4	81	32.75364
4	92	2.4274209
4	102	50.734177
4	112	98.70049
4	122	13.974385
4	132	63.087513
4	142	84.731705
4	153	1.661999
4	163	71.91658
4	173	47.26838
4	183	5.112868
4	193	95.97073
4	203	21.19144
4	214	65.60649
4	224	78.16488
4	234	58.166756
4	244	3.676294
4	254	36.077747
4	264	12.682931
4	275	1.7491726
4	285	26.301685
4	295	24.686342
4	305	67.80669
4	315	42.241604
4	325	75.55759
4	336	35.056786
4	346	30.170025
4	356	75.697395
4	366	2.1037931
4	376	6.762285
4	386	1.3284001
4	397	10.553326
4	407	92.90178
4	417	94.73279
4	427	37.734867
4	437	35.01272
4	447	62.659683
4	458	19.741076
4	468	28.09849
4	478	16.555653
4	488	33.252243
4	498	34.296364
4	508	2.8435078
4	519	80.692184
4	529	60.41074
4	539	38.97146
4	549	26.824385
4	559	2.5523522
4	569	81.57615
4	580	23.740488
4	590	89.56762
4	600	61.9883
22	0	46.877377
22	10	70.01063
22	20	63.348713
22	31	27.305634
22	41	7.2275987
22	51	10.344099
22	61	46.090508
22	71	57.974464
22	81	20.083017
22	92	42.13613
22	102	61.98543
22	112	44.320244
22	122	59.328495
22	132	10.411649
22	142	61.189342
22	153	80.896126
22	163	92.12139
22	173	24.813147
22	183	83.83034
22	193	73.31371
22	203	31.280079
22	214	51.174778
22	224	98.3076
22	234	39.382008
22	244	70.31995
22	254	39.24847
22	264	53.408398
22	275	34.915203
22	285	74.1835
22	295	90.57031
22	305	23.586105
22	315	53.12882
22	325	63.37573
22	336	30.153248
22	346	4.9621177
22	356	40.77515
22	366	32.87949
22	376	14.294777
22	386	18.46001
22	397	57.535328
22	407	31.078384
22	417	96.50175
22	427	87.48621
22	437	96.86222
22	447	74.38322
22	458	40.390945
22	468	69.78213
22	478	73.40541
22	488	12.441874
22	498	98.70179
22	508	52.120895
22	519	81.24264
22	529	5.773677
22	539	34.41345
22	549	54.076496
22	559	99.301025
22	569	87.41195
22	580	75.38785
22	590	89.86966
22	600	64.257515
\.


--
-- Data for Name: motors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motors (id, tag_name, model, max_speed, pump_id) FROM stdin;
1	40M1001A	AMT 2851-96	900	1
2	27M2004	AMT 2851-96	1800	2
3	63M2017A	MARCH MDXT-3	3600	3
16	67M1020	ZachTechMotorXL	7200	5
\.


--
-- Data for Name: pump_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pump_models (id, make, model, max_flow) FROM stdin;
1	Sulzer	CZ 150-251	420
2	Goulds	WS5032D4	550
3	Grundfos	59896343	17
\.


--
-- Data for Name: pumps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pumps (id, tag_name, model_id) FROM stdin;
1	40P1001A	1
2	27P2004	2
3	63P2017A	3
5	67P1020	1
\.


--
-- Data for Name: speed_sensors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.speed_sensors (id, tag_name, type, current_value, motor_id) FROM stdin;
1	27ST2004	Photo	1780	2
2	63ST2017A	Magnetic	3561	3
3	63ST2017B	Magnetic	3558	3
\.


--
-- Data for Name: speed_timeseries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.speed_timeseries (sensor_id, "time", value) FROM stdin;
1	0	1.1439465
1	10	63.64778
1	20	18.850908
1	31	95.131
1	41	67.71355
1	51	53.568447
1	61	47.972664
1	71	83.82522
1	81	64.77801
1	92	89.43917
1	102	11.859202
1	112	32.70739
1	122	90.68687
1	132	36.93676
1	142	16.022362
1	153	11.227667
1	163	1.6519922
1	173	27.806139
1	183	31.760746
1	193	78.54632
1	203	88.5563
1	214	75.61061
1	224	94.30715
1	234	17.613613
1	244	12.354248
1	254	73.27113
1	264	10.372049
1	275	18.938921
1	285	91.309204
1	295	87.43077
1	305	63.9193
1	315	77.9858
1	325	67.70078
1	336	63.676746
1	346	43.14308
1	356	21.00951
1	366	49.79157
1	376	80.66291
1	386	71.12241
1	397	56.397816
1	407	68.34468
1	417	92.78825
1	427	33.964935
1	437	44.110485
1	447	29.164915
1	458	70.887665
1	468	1.8201513
1	478	26.34198
1	488	34.327
1	498	18.125504
1	508	88.58637
1	519	6.026733
1	529	93.01431
1	539	70.52336
1	549	64.87165
1	559	15.600391
1	569	42.078148
1	580	53.059547
1	590	38.308952
1	600	72.37233
2	0	59.986626
2	10	60.83721
2	20	8.472794
2	31	20.535452
2	41	94.62912
2	51	11.747782
2	61	99.64746
2	71	83.44988
2	81	58.902775
2	92	29.101768
2	102	93.56103
2	112	9.921939
2	122	93.299576
2	132	47.309113
2	142	58.119133
2	153	32.14939
2	163	50.11749
2	173	57.19908
2	183	10.119732
2	193	40.873047
2	203	66.63184
2	214	74.12085
2	224	56.198757
2	234	98.93064
2	244	4.0116034
2	254	63.60752
2	264	99.55597
2	275	8.720561
2	285	49.614162
2	295	68.955734
2	305	69.25403
2	315	5.245778
2	325	24.021666
2	336	12.2763605
2	346	93.61499
2	356	97.72041
2	366	69.712234
2	376	0.8470732
2	386	17.05313
2	397	48.524677
2	407	18.54152
2	417	64.41592
2	427	38.911552
2	437	3.4620152
2	447	29.245329
2	458	14.472293
2	468	63.59786
2	478	93.587906
2	488	92.37831
2	498	93.96322
2	508	41.63486
2	519	92.27441
2	529	6.683611
2	539	29.405071
2	549	37.464363
2	559	18.50878
2	569	60.638687
2	580	1.2939692
2	590	94.02286
2	600	20.640665
3	0	93.28023
3	10	77.01566
3	20	65.621506
3	31	87.20413
3	41	16.509052
3	51	67.25897
3	61	78.36445
3	71	36.349766
3	81	61.13024
3	92	63.710594
3	102	65.535034
3	112	39.65876
3	122	89.77234
3	132	22.294266
3	142	68.62722
3	153	32.581314
3	163	40.785034
3	173	46.56208
3	183	8.508303
3	193	61.65608
3	203	35.109695
3	214	71.08503
3	224	17.22712
3	234	94.14515
3	244	54.417503
3	254	64.78083
3	264	91.90019
3	275	98.22733
3	285	74.013466
3	295	49.87239
3	305	25.20923
3	315	18.229174
3	325	62.672188
3	336	53.70896
3	346	14.090146
3	356	78.34901
3	366	84.51911
3	376	61.182037
3	386	91.32001
3	397	74.11665
3	407	3.2168732
3	417	42.083828
3	427	0.068500936
3	437	7.0876746
3	447	34.696575
3	458	82.60186
3	468	5.5427155
3	478	0.17285134
3	488	48.9703
3	498	14.613353
3	508	93.87479
3	519	30.845043
3	529	78.223206
3	539	91.79723
3	549	67.17417
3	559	9.077591
3	569	32.179703
3	580	27.937674
3	590	63.781414
3	600	82.48344
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendors (id, name) FROM stdin;
1	24hr Supply
2	Pump Products
3	Supply House
\.


--
-- Data for Name: vendors_pump_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendors_pump_models (vendor_id, model_id, pump_price) FROM stdin;
1	1	1600
1	2	2200
2	1	1650
2	3	1600
3	3	1800
3	1	1500
\.


--
-- Name: flow_sensors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flow_sensors_id_seq', 22, true);


--
-- Name: motors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motors_id_seq', 16, true);


--
-- Name: pump_models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pump_models_id_seq', 3, true);


--
-- Name: pumps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pumps_id_seq', 5, true);


--
-- Name: speed_sensors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.speed_sensors_id_seq', 3, true);


--
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendors_id_seq', 3, true);


--
-- Name: flow_sensors flow_sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_sensors
    ADD CONSTRAINT flow_sensors_pkey PRIMARY KEY (id);


--
-- Name: flow_sensors flow_sensors_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_sensors
    ADD CONSTRAINT flow_sensors_tag_name_key UNIQUE (tag_name);


--
-- Name: flow_timeseries flow_timeseries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_timeseries
    ADD CONSTRAINT flow_timeseries_pkey PRIMARY KEY ("time", sensor_id);


--
-- Name: motors motors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motors
    ADD CONSTRAINT motors_pkey PRIMARY KEY (id);


--
-- Name: motors motors_pump_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motors
    ADD CONSTRAINT motors_pump_id_key UNIQUE (pump_id);


--
-- Name: motors motors_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motors
    ADD CONSTRAINT motors_tag_name_key UNIQUE (tag_name);


--
-- Name: pump_models pump_models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pump_models
    ADD CONSTRAINT pump_models_pkey PRIMARY KEY (id);


--
-- Name: pumps pumps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pumps
    ADD CONSTRAINT pumps_pkey PRIMARY KEY (id);


--
-- Name: pumps pumps_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pumps
    ADD CONSTRAINT pumps_tag_name_key UNIQUE (tag_name);


--
-- Name: speed_sensors speed_sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speed_sensors
    ADD CONSTRAINT speed_sensors_pkey PRIMARY KEY (id);


--
-- Name: speed_sensors speed_sensors_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speed_sensors
    ADD CONSTRAINT speed_sensors_tag_name_key UNIQUE (tag_name);


--
-- Name: speed_timeseries speed_timeseries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speed_timeseries
    ADD CONSTRAINT speed_timeseries_pkey PRIMARY KEY ("time", sensor_id);


--
-- Name: vendors vendors_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_name_key UNIQUE (name);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: vendors_pump_models vendors_pump_models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors_pump_models
    ADD CONSTRAINT vendors_pump_models_pkey PRIMARY KEY (vendor_id, model_id);


--
-- Name: flow_time_b_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flow_time_b_index ON public.flow_timeseries USING btree ("time");


--
-- Name: flow_time_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flow_time_hash_index ON public.flow_timeseries USING btree (sensor_id);


--
-- Name: speed_time_b_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX speed_time_b_index ON public.flow_timeseries USING btree ("time");


--
-- Name: speed_time_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX speed_time_hash_index ON public.flow_timeseries USING btree (sensor_id);


--
-- Name: flow_sensors fk_flow_sensors_pumps; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_sensors
    ADD CONSTRAINT fk_flow_sensors_pumps FOREIGN KEY (pump_id) REFERENCES public.pumps(id);


--
-- Name: motors fk_motors_pumps; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motors
    ADD CONSTRAINT fk_motors_pumps FOREIGN KEY (pump_id) REFERENCES public.pumps(id);


--
-- Name: pumps fk_pumps_pump_models; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pumps
    ADD CONSTRAINT fk_pumps_pump_models FOREIGN KEY (model_id) REFERENCES public.pump_models(id);


--
-- Name: speed_sensors fk_speed_sensors_motors; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speed_sensors
    ADD CONSTRAINT fk_speed_sensors_motors FOREIGN KEY (motor_id) REFERENCES public.motors(id);


--
-- Name: vendors_pump_models fk_vendors_pump_models_pumps; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors_pump_models
    ADD CONSTRAINT fk_vendors_pump_models_pumps FOREIGN KEY (model_id) REFERENCES public.pump_models(id);


--
-- Name: vendors_pump_models fk_vendors_pump_models_vendors; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors_pump_models
    ADD CONSTRAINT fk_vendors_pump_models_vendors FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: flow_timeseries flow_timeseries_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_timeseries
    ADD CONSTRAINT flow_timeseries_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES public.flow_sensors(id);


--
-- Name: speed_timeseries speed_timeseries_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speed_timeseries
    ADD CONSTRAINT speed_timeseries_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES public.speed_sensors(id);


--
-- PostgreSQL database dump complete
--

