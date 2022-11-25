-- ������ ������ ��������� postgresql
SELECT version();

-- 1. �������� ������ � ���� ������ "weather"
-- 1.1 �������� ������� Weather
create table weather (
"Date" timestamp not null,
T_temperature numeric null,
Po_pressure numeric null,
P_pressure numeric null,
Pa_baric_tendency numeric null,
U_humidity numeric null,
DD_wind_rhumb varchar(500) null,
Ff_wind_speed numeric null,
ff10_wind_gust numeric null,
ff3_wind_gust numeric null,
N_cloudiness varchar(500) null,
WW_actual_weather varchar(500) null,
W1_actual_weather varchar(500) null,
W2_actual_weather varchar(500) null,
Tn_min_temperature numeric null,
Tx_max_temperature numeric null,
Cl_strato_clouds varchar(500) null,
Nh_number_clouds varchar(500) null,
H_height_clouds varchar(500) null,
Cm_alto_clouds varchar(500) null,
Ch_cirrus_clouds varchar(500) null,
VV_visibility_range varchar(500) null,
Td_dew_point_temp numeric null,
RRR_precipitation varchar(50) null,
tR_precipitation_time numeric null,
E_soil_surface_nosnow varchar(500) null,
Tg_min_ground_temp numeric null,
E1_soil_surface_withsnow varchar(500) null,
sss_snow_depth varchar(500) null,
MeteoID varchar(50) null
);


-- 1.2 �������� ������� Settlement
create table settlement (
letter_id varchar(500) not null,
digit_id varchar(10) not null,
federal_distr varchar(100) null,
region varchar(100) null,
name_municip varchar(500) null,
municipality varchar(500) null,
settlement varchar(500) null,
tipe varchar(50) null,
population numeric null,
children numeric null,
latitude_dms varchar(50) null,
longitude_dms varchar(50) null,
latitude numeric null,
longitude numeric null,
oktmo varchar(50) null,
dadata varchar(10) null,
rosstat varchar(10) null,
meteoid varchar(50) null
);


-- 1.3 �������� ������� Yield
create table yield (
letter_id varchar(500) not null,
digit_id varchar(10) not null,
agriculture varchar(50) null,
federal_distr varchar(100) null,
region varchar(100) null,
name_municip varchar(500) null,
municipal varchar(500) null,
category varchar(500) null,
"year" varchar(10) null,
yield numeric null,
round_yield numeric null
);


-- 2. ���������� ������ � ������� ����
-- 2.1 ���������� ������ � ������� "weather" (�� csv-�����)
copy weather 
from 'C:\Temp/Weather_2021_2.csv'
delimiter ','
csv header;


-- 2.2 ���������� ������ � ������� "settlement" (�� csv-�����)
copy settlement
from 'C:\Temp/settl_id.csv'
delimiter ';'
csv header;


-- 2.3 ���������� ������ � ������� "yield" (�� csv-�����)
copy yield
from 'C:\Temp/target.csv'
delimiter ';'
csv header;


-- 3. ���������� ������� � �������� ���� ������
-- 3.1 �������� ������� ��� ������� "Date" � ������� "weather"
create index date_idx ON weather ("Date");


-- 3.2 �������� ������� ��� ������� "Meteo ID" � ������� "weather"
create index meteoid_idx ON weather ("meteoid");





