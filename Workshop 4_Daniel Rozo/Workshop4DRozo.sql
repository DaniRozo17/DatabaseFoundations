create table if not exists Video(
	id_videos serial primary key,
	name varchar(100) not null,
	description varchar(200),
	date_upload int not null,
	likes int default 0,
	dislikes int default 0,
	user_fk uuid not null,
	genre_fk int not null,
	channel_fk int not null,
	foreign key (user_fk) references Users(id_number),
	foreign key (genre_fk) references MusicalGenre(id_genre),
	foreign key (channel_fk) references Channel(id_channel)
);

drop table Video;

create table if not exists Comments(
	id_comment serial primary key,
	content varchar(300) not null,
	date_creation int not null,
	likes int default 0,
	dislikes int default 0,
	user_fk uuid not null,
	video_fk int not null,
	foreign key (user_fk) references Users(id_number),
	foreign key (video_fk) references Video(id_videos)
);

drop table comments;

create table if not exists Playlist(
	id_playlist serial primary key,
	name varchar(30) not null,
	likes int default 0,
	user_fk uuid not null,
	foreign key (user_fk) references Users(id_number)
);

drop table Playlist;

create table if not exists Users(
	id_number UUID default gen_random_uuid(),  
	name varchar(50) not null,
	email varchar(50) unique, 
	phone varchar(50),
	nickname varchar(20) unique not null,
	password varchar(30) not null,
	musical_genre_fk int not null,
	country_fk int not null,
	primary key (id_number),
	foreign key (musical_genre_fk) references musicalgenre(id_genre),
	foreign key (country_fk) references Country(codeID)
);

create table if not exists Community(
	id_community serial primary key,
	name varchar(250) unique not null,
	description varchar(200)
);

create table if not exists Channel(
	id_channel serial primary key,
	name varchar(30) not null,
	description varchar(200),
	user_fk uuid not null,
	foreign key (user_fk) references Users(id_number)
);

create table if not exists MusicalGenre(
	id_genre serial primary key,
	name varchar(15) not null,
	description varchar(100)
);

create table if not exists BackAccount(
	UniqueID serial primary key,
	bank_name varchar(200),
	account_number varchar(30),
	user_fk uuid not null,
	country_fk int not null,
	foreign key (user_fk) references Users(id_number),
	foreign key (country_fk) references Country(codeID)
);

create table if not exists Country(
	codeID serial primary key,
	name varchar(50) unique not null
);


create table if not exists community_user_rel (
	community_fk int not null,
	user_fk uuid not null,
	primary key (community_fk, user_fk),
	foreign key (community_fk) references Community(id_community),
	foreign key (user_fk) references Users(id_number),
	expiration_date int
);

create table if not exists playlist_video_rel (
	playlist_fk int not null,
	video_fk int not null,
	primary key (playlist_fk, video_fk),
	foreign key (playlist_fk) references Playlist(id_playlist),
	foreign key (video_fk) references Video(id_videos)
);

create table if not exists suscriber_rel (
	user_fk uuid not null,
	channel_fk int not null,
	primary key (user_fk, channel_fk),
	foreign key (user_fk) references Users(id_number),
	foreign key (channel_fk) references Channel(id_channel),
	pay bool default false,
	pay_cost float,
	date_suscriptions int not null
);


--LLenar de información la tabla 
insert into Country (codeID, name) values (57, 'Colombia');
insert into Country (codeID, name) values (34, 'Nigeria');
insert into Country (codeID, name) values (12, 'Canada');
insert into Country (codeID, name) values (59, 'Peru');
insert into Country (codeID, name) values (27, 'Alemania');

insert into musicalgenre (id_genre, name, description) values (1,'Balada','Es romantica');
insert into musicalgenre (id_genre, name, description) values (2,'Bachata','Es rapida');
insert into musicalgenre (id_genre, name, description) values (3,'Gospel','Es bonita');
insert into musicalgenre (id_genre, name, description) values (4,'Rock','Es ruidoso');
insert into musicalgenre (id_genre, name, description) values (5,'Salsa','Es pegajosa');

insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('David', 'dvid@gmail.com', '3102669897','ElCarck','12456',1,57);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Daniel', 'duid@gmail.com', '3102699897','ElCuuarck','12457',2,57);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Daniela', 'lvid@gmail.com', '3103669897','ElCakurck','12458',3,57);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Davo', 'avid@gmail.com', '3102668897','ElCaoorck','12459',4,57);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Duvan', 'uvid@gmail.com', '3122669897','ElCarppck','12451',1,27);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Davinci', 'vvid@gmail.com', '3132669897','ElññCarck','12452',2,27);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Sara', 'svid@gmail.com', '3142669897','ElCarckkk','12453',3,27);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Michel', 'mvid@gmail.com', '3152669897','ElCaggrck','12454',4,27);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Esteban', 'evid@gmail.com', '3162669897','ElyyCarck','12455',5,27);
insert into Users (name, email, phone, nickname, password, musical_genre_fk, country_fk) values ('Johan', 'jvid@gmail.com', '3172669897','ElCiiarck','12450',1,34);


insert into Video (name, description, date_upload, likes, dislikes) values ('Como hacer papás fritas','aqui aprenderemos a cocinar lo basico xD', 24, 178, 54);
INSERT INTO tabla1 (name, password) VALUES ('Diego', 1234);

--1. All the videos uploaded for any user from an specific country
select video.name as Videos_Colombia
from video 
join usuario u on video.usuario_fk = usuario.id_number
join country c on usuario.country_fk = country.codeid 
where country.code = 57; 


