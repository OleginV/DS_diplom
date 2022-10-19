-- �������� ������ ��� ��������

-- 1. �������� ������ � ���������� �������
select *
  from settlement s;


-- 2. �������� � ������ �� ����������� �� ������������� �������
select *
  from yield y;


-- 3. �������� ������ � ���������������������� ���������� � �������� ������������
-- CTE � ����������� ID ������������
with meteo as (
	select s.meteoid as meteoid
	from settlement s inner join yield y on s.digit_id = y.digit_id
	where left(y.digit_id, 1) = '1'
	group by s.meteoid
)
-- �������� ������ ��������������� �� �������
select
-- ����
	date_trunc('week', w."Date")::date as "date",
	extract('year' from w."Date") as years,
-- �����������
	min(w.t_temperature) as min_air_temp,
	max(w.t_temperature) as max_air_temp,
	avg(w.t_temperature) as avg_air_temp,
	min(w.tn_min_temperature) as min_temp,
	max(w.tx_max_temperature) as max_temp,
	min(w.td_dew_point_temp) as min_dew_point_temp,
	max(w.td_dew_point_temp) as max_dew_point_temp,
	avg(w.td_dew_point_temp) as avg_dew_point_temp,
	min(w.tg_min_ground_temp) as min_ground_temp,
	max(w.tg_min_ground_temp) as max_ground_temp,
	avg(w.tg_min_ground_temp) as avg_ground_temp,
-- ��������
	min(w.po_pressure) as min_po_press,
	max(w.po_pressure) as max_po_press,	
	avg(w.po_pressure) as avg_po_press,
	min(w.p_pressure) as min_p_press,
	max(w.p_pressure) as max_p_press,	
	avg(w.p_pressure) as avg_p_press,
	min(w.pa_baric_tendency) as min_baric_tendency,
	max(w.pa_baric_tendency) as max_baric_tendency,	
	avg(w.pa_baric_tendency) as avg_baric_tendency,
-- ���������
	min(w.u_humidity) as min_u_humidity,
	max(w.u_humidity) as max_u_humidity,	
	avg(w.u_humidity) as avg_u_humidity,
-- �����
	avg(case 
		when w.dd_wind_rhumb like('�����, ������ � �������') then 90*pi()/180
		when w.dd_wind_rhumb like('�����, ������ � ���') then 180*pi()/180
		when w.dd_wind_rhumb like('�����, ������ � ������') then 270*pi()/180
		when w.dd_wind_rhumb like('�����, ������ � ������') then 360*pi()/180
		when w.dd_wind_rhumb like('%� ������-������-�������') then 30*pi()/180 
		when w.dd_wind_rhumb like('%� ������-�������') then 45*pi()/180
		when w.dd_wind_rhumb like('%� �������-������-�������') then 60*pi()/180
		when w.dd_wind_rhumb like('%� �������-���-�������') then 120*pi()/180
		when w.dd_wind_rhumb like('%� ���-�������') then 135*pi()/180
		when w.dd_wind_rhumb like('%� ���-���-�������') then 150*pi()/180
		when w.dd_wind_rhumb like('%� ���-���-������') then 210*pi()/180
		when w.dd_wind_rhumb like('%� ���-������') then 225*pi()/180
		when w.dd_wind_rhumb like('%� ������-���-������') then 240*pi()/180
		when w.dd_wind_rhumb like('%� ������-������-������') then 300*pi()/180
		when w.dd_wind_rhumb like('%� ������-������') then 315*pi()/180
		when w.dd_wind_rhumb like('%� ������-������-������') then 330*pi()/180
	else 0 end) as wind_rumb_radians,
	min(w.ff_wind_speed) as min_wind_speed,
	max(w.ff_wind_speed) as max_wind_speed,	
	avg(w.ff_wind_speed) as avg_wind_speed,
	min(w.ff10_wind_gust) as min_wind_gust_before,
	max(w.ff10_wind_gust) as max_wind_gust_before,	
	avg(w.ff10_wind_gust) as avg_wind_gust_before,
	min(w.ff3_wind_gust) as min_wind_gust_between,
	max(w.ff3_wind_gust) as max_wind_gust_between,	
	avg(w.ff3_wind_gust) as avg_wind_gust_between,
-- ����������
	min(case 
		when w.n_cloudiness like('10%  ��� �����, �� �� 0') then 0.1
		when w.n_cloudiness like('20�30%.') then 0.25
		when w.n_cloudiness like('40%.') then 0.4
		when w.n_cloudiness like('50%.') then 0.5
		when w.n_cloudiness like('60%.') then 0.6 
		when w.n_cloudiness like('70 � 80%.') then 0.75
		when w.n_cloudiness like('90  ��� �����, �� �� 100%') then 0.9
		when w.n_cloudiness like('100%.') then 1
		when w.n_cloudiness like('���� �� ����� ��-�� ������ �/��� ������ ����������������� �������.') then 1.1
	else 0 end) as min_cloudiness,
	max(case 
		when w.n_cloudiness like('10%  ��� �����, �� �� 0') then 0.1
		when w.n_cloudiness like('20�30%.') then 0.25
		when w.n_cloudiness like('40%.') then 0.4
		when w.n_cloudiness like('50%.') then 0.5
		when w.n_cloudiness like('60%.') then 0.6 
		when w.n_cloudiness like('70 � 80%.') then 0.75
		when w.n_cloudiness like('90  ��� �����, �� �� 100%') then 0.9
		when w.n_cloudiness like('100%.') then 1
		when w.n_cloudiness like('���� �� ����� ��-�� ������ �/��� ������ ����������������� �������.') then 1.1
	else 0 end) as max_cloudiness,
	avg(case 
		when w.n_cloudiness like('10%  ��� �����, �� �� 0') then 0.1
		when w.n_cloudiness like('20�30%.') then 0.25
		when w.n_cloudiness like('40%.') then 0.4
		when w.n_cloudiness like('50%.') then 0.5
		when w.n_cloudiness like('60%.') then 0.6 
		when w.n_cloudiness like('70 � 80%.') then 0.75
		when w.n_cloudiness like('90  ��� �����, �� �� 100%') then 0.9
		when w.n_cloudiness like('100%.') then 1
		when w.n_cloudiness like('���� �� ����� ��-�� ������ �/��� ������ ����������������� �������.') then 1.1
	else 0 end) as avg_cloudiness,
	avg(case 
		when w.cl_strato_clouds like('������-��������%') then 5
		when w.cl_strato_clouds like('�������%') then 4
		when w.cl_strato_clouds like('�������-�������%') then 3
		when w.cl_strato_clouds like('��������%') then 2
	else 1 end) as avg_cl_clouds,
	min(case 
		when w.nh_number_clouds like('10%  ��� �����, �� �� 0') then 0.1
		when w.nh_number_clouds like('20�30%.') then 0.25
		when w.nh_number_clouds like('40%.') then 0.4
		when w.nh_number_clouds like('50%.') then 0.5
		when w.nh_number_clouds like('60%.') then 0.6 
		when w.nh_number_clouds like('70 � 80%.') then 0.75
		when w.nh_number_clouds like('90  ��� �����, �� �� 100%') then 0.9
		when w.nh_number_clouds like('100%.') then 1
		when w.nh_number_clouds like('���� �� ����� ��-�� ������ �/��� ������ ����������������� �������.') then 1.1
	else 0 end) as min_nh_clouds,
	max(case 
		when w.nh_number_clouds like('10%  ��� �����, �� �� 0') then 0.1
		when w.nh_number_clouds like('20�30%.') then 0.25
		when w.nh_number_clouds like('40%.') then 0.4
		when w.nh_number_clouds like('50%.') then 0.5
		when w.nh_number_clouds like('60%.') then 0.6 
		when w.nh_number_clouds like('70 � 80%.') then 0.75
		when w.nh_number_clouds like('90  ��� �����, �� �� 100%') then 0.9
		when w.nh_number_clouds like('100%.') then 1
		when w.nh_number_clouds like('���� �� ����� ��-�� ������ �/��� ������ ����������������� �������.') then 1.1
	else 0 end) as max_nh_clouds,
	avg(case 
		when w.nh_number_clouds like('10%  ��� �����, �� �� 0') then 0.1
		when w.nh_number_clouds like('20�30%.') then 0.25
		when w.nh_number_clouds like('40%.') then 0.4
		when w.nh_number_clouds like('50%.') then 0.5
		when w.nh_number_clouds like('60%.') then 0.6 
		when w.nh_number_clouds like('70 � 80%.') then 0.75
		when w.nh_number_clouds like('90  ��� �����, �� �� 100%') then 0.9
		when w.nh_number_clouds like('100%.') then 1
		when w.nh_number_clouds like('���� �� ����� ��-�� ������ �/��� ������ ����������������� �������.') then 1.1
	else 0 end) as avg_nh_clouds,
	min(case 
		when w.h_height_clouds like('����� 50') then 25
		when w.h_height_clouds like('50-100') then 75
		when w.h_height_clouds like('100-200') then 150
		when w.h_height_clouds like('200-300') then 250
		when w.h_height_clouds like('300-600') then 450 
		when w.h_height_clouds like('600-1000') then 800
		when w.h_height_clouds like('1000-1500') then 1250
		when w.h_height_clouds like('1500-2000') then 1750
		when w.h_height_clouds like('2000-2500') then 2250
		when w.h_height_clouds like('2500%') then 2500
	else 0 end) as min_height_clouds,
	max(case 
		when w.h_height_clouds like('����� 50') then 25
		when w.h_height_clouds like('50-100') then 75
		when w.h_height_clouds like('100-200') then 150
		when w.h_height_clouds like('200-300') then 250
		when w.h_height_clouds like('300-600') then 450 
		when w.h_height_clouds like('600-1000') then 800
		when w.h_height_clouds like('1000-1500') then 1250
		when w.h_height_clouds like('1500-2000') then 1750
		when w.h_height_clouds like('2000-2500') then 2250
		when w.h_height_clouds like('2500%') then 2500
	else 0 end) as max_height_clouds,
	avg(case 
		when w.h_height_clouds like('����� 50') then 25
		when w.h_height_clouds like('50-100') then 75
		when w.h_height_clouds like('100-200') then 150
		when w.h_height_clouds like('200-300') then 250
		when w.h_height_clouds like('300-600') then 450 
		when w.h_height_clouds like('600-1000') then 800
		when w.h_height_clouds like('1000-1500') then 1250
		when w.h_height_clouds like('1500-2000') then 1750
		when w.h_height_clouds like('2000-2500') then 2250
		when w.h_height_clouds like('2500%') then 2500
	else 0 end) as avg_height_clouds,
	avg(case 
		when w.cm_alto_clouds like('�������������%') then 5
		when w.cm_alto_clouds like('��������������%') then 4
		when w.cm_alto_clouds like('������%') then 3
		when w.cm_alto_clouds like('�������������%������� ���%') then 2
	else 1 end) as avg_cm_clouds,
	avg(case 
		when w.ch_cirrus_clouds like('�������� �������%') or w.ch_cirrus_clouds like('�������-�������%') then 5
		when w.ch_cirrus_clouds like('�������-��������%') then 4
		when w.ch_cirrus_clouds like('�������� (����� � ���� �����)%') then 3
		when w.ch_cirrus_clouds like('�������� �����������%') or w.ch_cirrus_clouds like('�������� ����������%') then 2
		when w.ch_cirrus_clouds like('��������%���.') then 1
	else 1 end) as avg_ch_clouds,
-- ���������
	min(w.vv_visibility_range::numeric) as min_visibility_range,
	max(w.vv_visibility_range::numeric) as max_visibility_range,
	avg(w.vv_visibility_range::numeric) as avg_visibility_range,
-- ������
	sum(w.rrr_precipitation::numeric) as sum_precipitation,
	avg(w.rrr_precipitation::numeric) as avg_precipitation,
	avg(w.tr_precipitation_time) as avg_precipitation_time,
-- ��������� �����
	avg(case 
		when w.e_soil_surface_nosnow like('����������� �����%') then 10
		when w.e_soil_surface_nosnow like('C����') then 9
		when w.e_soil_surface_nosnow like('C���� (��� ������,%') then 8
		when w.e_soil_surface_nosnow like('����������� ����� �����%') then 7
		when w.e_soil_surface_nosnow like('��������� ��� ������� ����%') then 6
		when w.e_soil_surface_nosnow like('������ ����%') then 5
		when w.e_soil_surface_nosnow like('����������� ����� ����%') then 4
		when w.e_soil_surface_nosnow like('����������� ����� �������%') then 3
		when w.e_soil_surface_nosnow like('����������� ����� �����%') then 2
		when w.e_soil_surface_nosnow like('����������� �����%') then 1
		when w.e_soil_surface_nosnow like('����������� ����� ���������%') then -1
		when w.e_soil_surface_nosnow like('������� ������%') then -2
	else 0 end) as avg_soil_surface,
	avg(case 
		when w.e1_soil_surface_withsnow like('������ ���� ������%') then 10
		when w.e1_soil_surface_withsnow like('�������� ���� ������%') then 9
		when w.e1_soil_surface_withsnow like('���� ��������� ����������� ����� ���������%') then 8
		when w.e1_soil_surface_withsnow like('����� ����������� ���� ��������� �� ������� ����%') then 7
		when w.e1_soil_surface_withsnow like('����� ����������� ���� ��������� ������ ��������%') then 6
		when w.e1_soil_surface_withsnow like('����������� ����� ��������������� ������� �����%') then 5
		when w.e1_soil_surface_withsnow like('������ ���� ������������ ��� ������� �����%') then 4
		when w.e1_soil_surface_withsnow like('�������� ���� ������������ ��� ������� �����%') then 3
		when w.e1_soil_surface_withsnow like('����������� ��� ������ ����%�� ����� �� ������� ���������%') then 2
		when w.e1_soil_surface_withsnow like('����������� ��� ������ ����%�������� ����������� �����%') then 1
	else 0 end) as avg_soil_surface_withsnow,
-- ID ������������
	w.meteoid
  from weather w inner join meteo m on w.meteoid = m.meteoid
group by date_trunc('week', w."Date"), extract('year' from w."Date"), w.meteoid;

