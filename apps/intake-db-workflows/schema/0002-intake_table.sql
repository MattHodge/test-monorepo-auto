USE intake;

create table if not exists intake
(
	id int auto_increment,
	host text null,
	metric_name text null,
	value int null,
	constraint table_name_pk
		primary key (id)
);


