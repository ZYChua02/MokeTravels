--CREATE DATABASE DBAssignment
--drop database DBAssignment

CREATE TABLE Staff
(
	StaffID			char(10)	NOT NULL,
	StaffName		varchar(30)     NULL,	
	
	CONSTRAINT PK_Staff PRIMARY KEY(StaffID)

)

CREATE TABLE TourLeader
(
	StaffID			char(10)	NOT NULL,
	LicenseNo		char(9) 	NULL,
	LicenseExpiryDate	date     	NOT NULL,	
	
	CONSTRAINT FK_TourLeader_StaffID
		FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
)



CREATE TABLE TravelAdvisor
(
	StaffID			char(10)	NOT NULL,
	CONSTRAINT FK_TravelAdvisor_StaffID
		FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
)

CREATE TABLE Customer
(
           CustID                          char(10)         NOT NULL,
           CustName                    varchar(30)    NULL,     

           CONSTRAINT PK_Customer PRIMARY KEY(CustID)
)

CREATE TABLE Organiser
(
            CustID                         char(10)          NOT NULL,
            CustEmail                    varchar(64)    NULL,
            CustContact                int                   NULL,

        CONSTRAINT PK_Orgainser PRIMARY KEY(CustID),
		CONSTRAINT FK_Organiser_CustID
			FOREIGN KEY (CustID) REFERENCES Customer(CustID)
)

CREATE TABLE Itinerary
(
	ItineraryNo		char(11)		NOT NULL,
	ItineraryDesc		varchar(200)		NULL,
	Duration		time			NOT NULL,

	CONSTRAINT PK_Itinerary PRIMARY KEY (ItineraryNo)	
)

CREATE TABLE Trip
(
	ItineraryNo		char(11)		NOT NULL,
	DepartureDate	date			NOT NULL,
	DepartureTime	Time			NOT NULL,
	AdultPrice		decimal		NULL,
	ChildPrice		decimal		NULL,
	Status			varchar(100)		NULL,
	MaxNoOfParticipants		int		NULL,
	StaffID				char(10)	NULL,

	CONSTRAINT PK_Trip PRIMARY KEY (ItineraryNo,DepartureDate),
	CONSTRAINT FK_Trip_ItineraryNo
		FOREIGN KEY(ItineraryNo) REFERENCES Itinerary(ItineraryNo),
	CONSTRAINT FK_Trip_StaffID
		FOREIGN KEY(StaffID) REFERENCES Staff(StaffID),
	
)

CREATE TABLE Booking
(
	BookingNo		char(12)		NOT NULL,
	BookingDate		date		NOT NULL,
	CustID			char(10)	NULL,
	StaffID			char(10)	NULL,
	ItineraryNo		char(11)		NULL,
	DepartureDate	date		NOT NULL,

	CONSTRAINT PK_Booking PRIMARY KEY(BookingNo),
	CONSTRAINT FK_Booking_CustID
		FOREIGN KEY (CustID) REFERENCES Customer(CustID),
	CONSTRAINT FK_Booking_StaffID
		FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
	CONSTRAINT FK_Booking_Trip
		FOREIGN KEY(ItineraryNo,DepartureDate) REFERENCES
	Trip(ItineraryNo,DepartureDate)
		
)

CREATE TABLE Passenger
(
	CustID			char(10)	NOT NULL,
	BookingNo 		char(12)		NOT NULL,
	Age			int		NULL,
	Nationality		varchar(56)	NULL,
	PassportNo		varchar(44)	NULL,
	PassportExpiry	date		NOT NULL,
	PricePaid		varchar(10)	NULL,
	
		CONSTRAINT PK_Passenger PRIMARY KEY (CustID,BookingNo),
		CONSTRAINT FK_Passenger_CustID
			FOREIGN KEY (CustID) REFERENCES Customer(CustID),
		CONSTRAINT FK_Passenger_BookingNo
			FOREIGN KEY (BookingNo) REFERENCES Booking(BookingNo)
)





CREATE TABLE Promotion
(	
	PromoCode		varchar(30)		NOT NULL,
	PromoDesc		varchar(50)		NULL,
	Discount		varchar(30)		NULL,

	CONSTRAINT PK_Promotion PRIMARY KEY(PromoCode)

)

CREATE TABLE RoomType
(
	RmTypeID		int			NOT NULL,
	RmDesc		varchar(100)		NULL,

	CONSTRAINT PK_RoomType PRIMARY KEY(RmTypeID)
)

CREATE TABLE Payment
(
            PmtNo                        char(15)                               NOT NULL,
            PmtType                    varchar(13)                  NULL,
            PmtAmt                      money                                NULL,
            PmtMethod                varchar(20)                  NULL,
            PmtDate                    date                              NOT NULL,
            CreditCardNo            char(16)                                 NULL,
            ChequeNo                 int                                 NULL,
            BookingNo                 char(12)                  NULL,

            CONSTRAINT PK_Payment PRIMARY KEY (PmtNo),
            CONSTRAINT FK_Payment_BookingNo
                       FOREIGN KEY (BookingNo) REFERENCES Booking(BookingNo)

)

CREATE TABLE Country
(
	CountryCode		int		NOT NULL,
	CountryDesc		varchar(100)	NULL,

	CONSTRAINT PK_Country PRIMARY KEY(CountryCode)
)

CREATE TABLE City
(
	CityCode		int			NOT NULL,
	CityDesc		varchar(100)		NULL,
	CountryCode		int			NULL,

	CONSTRAINT PK_City PRIMARY KEY(CityCode),
	CONSTRAINT FK_City_CountryCode
		FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode)
)


CREATE TABLE Site
(
		SiteID			char(5)		NOT NULL,
		SiteDesc		varchar(100)		NULL,
		CityCode		int			NULL,

	CONSTRAINT PK_Site PRIMARY KEY(SiteID),
	CONSTRAINT FK_Site_CityCode
			FOREIGN KEY (CityCode) REFERENCES City(CityCode)
)





CREATE TABLE Flight
(
	FlightNo		varchar(9)			NOT NULL,
	Airline			varchar(20)		NULL,
	Origin			varchar(50)		NULL,
	Destination		varchar(50)		NULL,
	FlightTime		time			NOT NULL,

	CONSTRAINT PK_Flight PRIMARY KEY(FlightNo)
)



CREATE TABLE Hotel
(
            HotelID                       int                    NOT NULL,
            HotelName                 varchar(50)     NULL,
            HotelCategory            varchar(15)     NULL,

            CONSTRAINT PK_Hotel PRIMARY KEY (HotelID)
)

CREATE TABLE StaffContactNo
(
	StaffID			char(10)		NOT NULL,
	StaffContact		int		NOT NULL,

	Constraint PK_StaffContactNo PRIMARY KEY (StaffID,StaffContact)	
)



CREATE TABLE PassengerPromotion
(
	CustID			char(10)	NOT NULL,
	BookingNo		char(12)	NOT NULL,
	PromoCode		varchar(30)	NOT NULL,

	CONSTRAINT PK_PassengerPromotion PRIMARY KEY (CustID,BookingNo,PromoCode),
	CONSTRAINT FK_PassengerPromotion_CustID
		FOREIGN KEY (CustID) REFERENCES Customer(CustID),
	CONSTRAINT FK_PassengerPromotion_BookingNo
		FOREIGN KEY (BookingNo) REFERENCES Booking(BookingNo),
	CONSTRAINT FK_PassengerPromotion_PromoCode
		FOREIGN KEY (PromoCode) REFERENCES Promotion(PromoCode)
)

CREATE TABLE PromotionForTrip
(
            PromoCode                varchar(30)     NOT NULL,
            ItineraryNo               char(11)     NOT NULL,
            DepartureDate            date                NOT NULL,

            CONSTRAINT PK_PromotionForTrip PRIMARY KEY
                                                       (PromoCode,ItineraryNo,DepartureDate),
	CONSTRAINT FK_PromotionForTrip_PromoCode
		FOREIGN KEY (PromoCode) REFERENCES Promotion(PromoCode),

	CONSTRAINT FK_PromtotionForTrip_Trip
		FOREIGN KEY(ItineraryNo,DepartureDate) REFERENCES
	Trip(ItineraryNo,DepartureDate),
           

)

CREATE TABLE StayIn
(
	HotelID			int			NOT NULL,
	ItineraryNo		char(11)	NOT NULL,
	DepartureDate	date		NOT NULL,
	CheckInDate		date		NOT NULL,
	CheckOutDate	date		NOT NULL,
	CONSTRAINT PK_StayIn PRIMARY KEY(HotelID,ItineraryNo,DepartureDate),
	CONSTRAINT FK_StayIn_HotelID
			FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
	CONSTRAINT FK_StayIn
			FOREIGN KEY(ItineraryNo,DepartureDate) REFERENCES
	Trip(ItineraryNo,DepartureDate),
)

CREATE TABLE FliesOn
(
	ItineraryNo		char(11)	NOT NULL,
	DepartureDate	date		NOT NULL,
	FlightNo		varchar(9)			NOT NULL,
	FlightDate		date		NOT NULL,

	CONSTRAINT PK_FliesOn PRIMARY KEY (ItineraryNo,DepartureDate,FlightNo),
	CONSTRAINT FK_FliesOn
		FOREIGN KEY(ItineraryNo,DepartureDate) REFERENCES
	Trip(ItineraryNo,DepartureDate),
	CONSTRAINT FK_FliesOn_FlightNo
		FOREIGN KEY(FlightNo) REFERENCES Flight(FlightNo)
	
	
)
CREATE TABLE RoomBooking
(
	RmTypeID		int				NOT NULL,
	BookingNo		char(12)		NOT NULL,
	NoOfExtraBed	int			NULL,
	NoOfRoom		int				NULL,

	CONSTRAINT PK_RoomBooking PRIMARY KEY(RmTypeID,BookingNo),
	CONSTRAINT FK_RoomBooking_RmTypeID
		FOREIGN KEY(RmTypeID) REFERENCES RoomType(RmTypeID),
	CONSTRAINT FK_RoomBooking_BookingNo
		FOREIGN KEY(BookingNo) REFERENCES Booking(BookingNo)
)

CREATE TABLE SiteDetails
(
	ItineraryNo		char(11)		NOT NULL,
	SiteID			char(5)			NOT NULL,

	CONSTRAINT PK_SiteDetails PRIMARY KEY(ItineraryNo,SiteID),
	CONSTRAINT FK_SiteDetails_ItineraryNo
		FOREIGN KEY(ItineraryNo) REFERENCES Itinerary(ItineraryNo),
	CONSTRAINT FK_SiteDetails_SiteID
		FOREIGN KEY(SiteID) REFERENCES Site(SiteID)
)







/* EACH TABLE MUST HAVE AT LEAST 10 TUPLES */

INSERT INTO Staff(StaffID, StaffName)
VALUES
	('S100000021','John Lim'),
	('S827361722','Bill Tan'),
	('S001923847','Joe Fang'),
	('S181726472','Michael Ng'),
	('S172528365','Elizabeth Berth'),
	('S182374827','David Browning'),
	('S015486741','Melanie Ho'),
	('S029345676','David Chia'),
	('S323212445','Louis Loh'),
	('S393942411','Marnie Lee'),
	/*(^10 TourLeaders) */
	('S192819283','Joey Aw'),
	('S182617265','Gewld Maarm'),
	('S816281625','Yennifer Yeo'),
	('S817252617','Brohamn Nough'),
	('S182729185','Johmis Stoler')





INSERT INTO TourLeader(StaffID,LicenseNo,LicenseExpiryDate)
VALUES
	('S100000021','A12345871','2020-08-07'),
	('S827361722','B12334578','2021-02-01'),
	('S001923847','A55676542','2022-01-12'),
	('S181726472','B01233445','2020-09-11'),
	('S172528365','C44786654','2023-11-23'),
	('S182374827','A09123214','2022-12-19'),
	('S015486741','B33130983','2021-12-20'),
	('S029345676','C66904324','2020-12-24'),
	('S323212445','A34556667','2021-05-24'),
	('S393942411','A49024430','2021-04-29')


INSERT INTO TravelAdvisor(StaffID) 
VALUES
	('S100000021'),
	('S827361722'),
	('S001923847'),
	('S181726472'),
	('S172528365'),
	('S182374827'),
	('S015486741'),
	('S029345676'),
	('S323212445'),
	('S393942411'),
	/* (^10 TourLeaders) */ 
	('S192819283'),
	('S182617265'),
	('S816281625'),
	('S817252617'),
	('S182729185')
	
	

INSERT INTO Customer(CustID,CustName)
VALUES
	('C011234596','Mable Gable'),
	('C309455966','John Howard'),
	('C349502234','Low Jung Howey Howard Ming Hui'),
	('C234910439','Chua Zhe Yu'),
	('C050379539','Tan Yuan Ming'),
	('C101988488','Jane Ng'),
	('C132431237','Lim Hok Siah'),
	('C101296665','Maline Valentino'),
	('C186743153','Kimberly Chia'),
	('C103405432','Mark Chee'),
	/*(^10 Organisers/Passengers) */

	('C011234597', 'Jenny Lim'),
	('C309455967','Valentino Daisy'),
	('C349502235','Kenneth Monroe'),
	('C102343454','Damcott Morgan Lee Chun'),
	('C102315534','Samantha Alexendra Ho'),
	('C212310312','Bailey Tan'),
	('C021312458','Nicole Lim'),
	('C012412590','Johnson Tan Swee Min'),
	('C023945546','Mary John'),
	('C032420351','David Ho')
	
	

INSERT INTO Organiser(CustID,CustEmail,CustContact)
VALUES
	('C011234596','mable@gmail.com',90123456),
	('C309455966','JohnHoward@gmail.com',86750343),
	('C349502234','LowJungHoweyHowardMingHui@hotmail.com',91392931),
	('C234910439','chua.zy@yahoo.com',90234213),
	('C050379539','tanym@mail.com',93042340),
	('C101988488','ngJane@gmail.com',91269875),
	('C132431237','limHokSiah@gmail.com',98584894),
	('C101296665','MalineValentino@gmail.com',89795433),
	('C186743153','KimberlyChia@gmail.com',69453451),
	('C103405432','MarkChee@gmail.com',93119355)

INSERT INTO
Itinerary(ItineraryNo,ItineraryDesc,Duration)
VALUES
	('00000000001', 'A trip to London and Liverpool','18:00:00'),
	('00000000002', 'A trip to Berlin and Hamburg', '20:00:00'),
	('00000000003', 'Beijing and Shanghai Food Trail', '17:00:00'),
	('00000000004', 'Vacation in Hawaii', '23:00:00'),
	('00000000005', 'Sights in United States', '22:00:00'),
	('00000000006', 'Culture in Berlin', '17:00:00'),
	('00000000007', 'Quick getaway in KL', '12:00:00'),
	('00000000008', 'Hamburg Holidays', '22:00:00'),
	('00000000009','Exploring Singapore', '15:00:00'),
	('00000000010', 'History trip to Beijing', '22:00:00')


	
INSERT INTO
Trip(ItineraryNo,DepartureDate,DepartureTime,AdultPrice,ChildPrice,Status,MaxNoOfParticipants,StaffID)
VALUES
	('00000000001','2020-03-22','03:00:00',627.00,307.24,'Avaliable',50,'S100000021'),
	('00000000002','2021-04-05','17:00:00',489.00,448.10,'Fully Booked',40,'S827361722'),
	('00000000003','2020-03-03','17:00:00',484.50,202.00,'Fully Booked',40,'S001923847'),
	('00000000004','2020-03-28','06:00:00',636.00,427.58,'Avaliable',50,'S181726472'),
	('00000000005','2023-03-22','13:00:00',488.35,413.81,'Avaliable',50,'S172528365'),           
	('00000000006','2022-11-21','11:00:00',695.00,498.00,'Cancelled',20,'S182374827'),          
	('00000000007','2021-03-04','14:00:00',521.78,353.33,'Avaliable',20,'S015486741'),
	('00000000008','2020-08-08','05:00:00',365.23,253.97,'Fully Booked',35,'S029345676'),
	('00000000009','2020-08-15','18:00:00',666.20,411.99,'Avaliable',25,'S323212445'),        
	('00000000010','2021-03-15','17:00:00',482.17,471.20,'Avaliable',40,'S393942411')





INSERT INTO
Booking(BookingNo,BookingDate,CustID,StaffID,ItineraryNo,DepartureDate)
VALUES
	('TB19071234ZS','2019-05-21','C011234596','S100000021','00000000001','2020-03-22'),
	('TB19281827ZS','2020-06-22','C309455966','S827361722','00000000002','2021-04-05'),
	('TB19283726ZS','2019-07-23','C349502234','S001923847','00000000005','2023-03-22'),
	('TB19642718ZS','2020-07-25','C234910439','S181726472','00000000006','2022-11-21'),
	('TB10987346ZS','2020-08-04','C050379539','S172528365','00000000002','2021-04-05'),
	('TB39990908ZS','2020-09-09','C101988488','S182374827','00000000003','2020-03-03'),
	('TB20998745ZS','2018-05-10','C132431237','S015486741','00000000002','2021-04-05'),
	('TB23437986ZS','2019-04-04','C101296665','S029345676','00000000006','2022-11-21'),
	('TB12655767ZS','2019-03-09','C186743153','S323212445','00000000010','2021-03-15'),
	('TB36870879ZS','2020-04-12','C103405432','S393942411','00000000007','2021-03-04')

INSERT INTO Passenger(CustID,BookingNo,Age,Nationality,PassportNo,PassportExpiry,PricePaid)
VALUES
	('C011234596','TB19071234ZS',54,'Singaporean','T01928373B','2008-11-1',2980.98),
	('C309455966','TB19281827ZS',24,'Chinese','S9273729T','2030-12-15',1200.44),
	('C349502234','TB19283726ZS',42,'Malaysian','T7274827B','2046-3-4',1320.11),
	('C234910439','TB19642718ZS',35,'Singaporean','S8271048Z','2030-4-4',910.90),
	('C050379539','TB10987346ZS',21,'Singaporean','J9374938T','2022-5-12',1421.00),              
	('C101988488','TB39990908ZS',29,'Luxembourgish','K9482847Y','2034-9-18',5134.00),
	('C132431237','TB20998745ZS',69,'Chinese','Y3974829H','2038-1-30',300.10),
	('C101296665','TB23437986ZS',50,'Chinese','H9171434B','2040-12-1',805.80),
	('C186743153','TB12655767ZS',89,'Chinese','U8392818T','2033-4-5',4000.00),
	('C103405432','TB36870879ZS',57,'Brazilian','C7687799X','2022-6-28',1800.80)
	

INSERT INTO
Promotion(PromoCode,PromoDesc,Discount)
VALUES
	('CH1NA8ZZ1SP3DIS','CN8ZZ1 SPECIAL DISC','$160 off'),
	('CH1NA8ZZEXTDIS','CN8ZZ1 EXTRA DISC','$160 off'),
	('PASSIONE','PASSION CARD S/P DISC','50%'),
	('CH1NA8ZZ1TSPES','CN8ZZ1 DISC TS Special','50%'),
	('NATADESC','DISC (Natas Travel Fair)','80%'),
	('APTM125W342','GIFTSHOP S/P DISC','10%'),
	('39JS6SYVDS9' ,'VELTIZ’S DINER DISC','20%'),
	('GYYD612838','SHOPPING MALL DISC','5%'),
	('S5P4RC7L8F7','CHRISTMAS SPECIAL','10%'),
	('P6P9I0HYUE5','NEW YEAR SPECIAL','15%')
	/* (char30,varchar50,varchar30) */

INSERT INTO
RoomType(RmtypeID,RmDesc)
VALUES
	(01,'The most expensive room, reserved for celebrities.'),
	(02,'The second most expensive room, it has a balcony'),
	(03,'For people that are rich but not by much.'),
	(04,'This room has a pretty balcony.'),
	(05,'The room.'),
	(06,'The middle class room.'),
	(07,'The slightly lower tier middle class room.'),
	(08,'This room is pretty poor it has nothing much.'),
	(09,'The room for the true middle class.'),
	(10,'Cheapest room')


INSERT INTO Payment VALUES('RPB1019999','Deposit',2980.98,'Credit Card','2019-5-21','9182383848594838',NULL,'TB19071234ZS')
INSERT INTO Payment VALUES('SRG9877214','Full Payment',1200.44,'Cash','2020-6-22',NULL,NULL,'TB19281827ZS')
INSERT INTO Payment VALUES('EOV2841000','Full Payment',1320.11,'Cheque','2019-7-23',NULL,38412,'TB19283726ZS')
INSERT INTO Payment VALUES('OPU9832473','Full Payment',910.90,'Credit Card','2020-7-25','1927890990902121',NULL,'TB19642718ZS')
INSERT INTO Payment VALUES('FPS4628462','Deposit',1400.00,'Credit Card','2022-5-12','9292010127364837',NULL,'TB10987346ZS')
INSERT INTO Payment VALUES('RPG6325124','Full Payment',5134.00,'Cash','2020-9-9',NULL,NULL,'TB39990908ZS')
INSERT INTO Payment VALUES('SPW1245678','Full Payment',300.10,'Cheque','2018-5-10',NULL,9052302,'TB20998745ZS')
INSERT INTO Payment VALUES('DEE6483567','Deposit',805.80,'Credit Card','2019-4-4','9123452078923825',NULL,'TB23437986ZS')
INSERT INTO Payment VALUES('YRT5891571','Full Payment',4000.00,'Cheque','2019-3-9',NULL,68723893,'TB12655767ZS')
INSERT INTO Payment VALUES('GHY8916714','Full Payment',1800.80,'Cash','2020-4-12',NULL,NULL,'TB36870879ZS')



INSERT INTO
Country(CountryCode,CountryDesc)
VALUES

             (65,'Singapore'),
             (1,'United States'),
             (966,'Saudi Arabia'),
             (86,'China'),
             (60,'Malaysia'),
             (352,'Luxembourg'),
             (55,'Brazil'),
             (49,'Germany'),
             (41,'Switzerland'),
             (44,'United Kingdom')


INSERT INTO
City(CityCode,CityDesc,CountryCode)
VALUES
            (65,'Singapore,Singapore',65),
            (202,'Washington, DC,United States',1),
            (20,'London,United Kingdom',44),
            (151,'Liverpool,United Kingdom',44),
            (03,'Kuala Lumpur,Malaysia',60),
            (808,'Hawaii,USA',1),
            (10,'BeiJing,China',86),
            (21,'ShangHai,China',86),
            (30,'Berlin,Germany',49),
            (40,'Hamburg,Germany',49)

INSERT INTO
Site(SiteID,SiteDesc,CityCode)
VALUES
			('89123','Merlion',65),
            ('12876','Washington Monument',202),
            ('47521','Big Ben',20),
            ('87236','The Beatles Story',151),
            ('57622','Batu Caves',03),
            ('35276','Diamond Head',808),
            ('67822','Great Wall of China',10),
            ('57629','Oriental Pearl TV Tower',21),
            ('35472','Brandenburg Gate',30),
            ('12536','Speicherstadt',40),
			('12321', 'VolsparkStadion', 40),
			('02920', 'Musemum Island', 30),
			('02839', 'Brandenburg Gate', 30),
			('01232', 'Gardens by the bay', 65),
			('52622', 'Petronas Twin Towers', 03),
			('99910', 'Marina Bay Sands', 65),
			('35342', 'Buckingham Palace', 20)
			/* (char 5,varchar100,int) */	



	 
INSERT INTO
Flight(FlightNo,Airline,Origin,Destination,FlightTime)
VALUES
	('TR199','Scoot','Singapore,Singapore','Washington, DC,United States','13:55:00'),
	('TR198','Scoot','Washington, DC,United States','London,United Kingdom','13:05:00'),
	('DL2490','Delta','London,United Kingdom','Liverpool,United Kingdom','05:30:00'),
	('DL139','Delta','Liverpool,United Kingdom','Kuala Lumpur,Malaysia','16:15:00'),
	('SQ198','Singapore Airlines','Kuala Lumpur,Malaysia','Hawaii,USA','21:15:00'),
	('SQ300','Singapore Airlines','Hawaii,USA','BeiJing,China','08:50:00'),
	('TR392','Scoot','BeiJing,China','ShangHai,China','19:45:00'),
	('TR999','Scoot','ShangHai,China','Berlin,Germany','14:15:00'),
	('DL682','Delta','Berlin,Germany','Hamburg,Germany','06:00:00'),
	('DL991','Delta','Hamburg,Germany','Singapore,Singapore','13:30:00')



INSERT INTO
Hotel(HotelId,HotelName,HotelCategory)
VALUES
	(1, 'Shangri-La Hotel Singapore', '5-star'),
	(2, 'Holiday Inn Express Liverpool', '3-star'),
	(3, 'Radisson Blu Hotel, Berlin', '4-star'),
	(4, 'Ascott Sentral Kuala Lumpur' , '4-star'),
	(5, 'Hamilton Hotel Washington DC' , '4-star'),
	(6, 'HIlton Waikoloa Village,Hawaii' , '4-star'),
	(7, 'Cube Lodges,Berlin' , '4-star'),
	(8, 'Marina Bay Sands, Singapore' , '5-star'),
	(9, 'InterContinental Shanghai Pudong' , '4-star'),
	(10, 'Holiday Inn Hamburg' , '4-star')
	
	

INSERT INTO
StaffContactNo(StaffID,StaffContact)
VALUES
	('S100000021',98987878),
	('S827361722',91728263),
	('S001923847',81269182),
	('S181726472',98463843),
	('S172528365',98632736),
	('S182374827',97532759),
	('S015486741',95987364),
	('S029345676',82344521),
	('S323212445',80909742),
	('S393942411',84746363),
	/*(^10 TourLeaders) */ 
	('S192819283',91726142),
	('S182617265',90762876),
	('S816281625',90988765),
	('S817252617',87095241),
	('S182729185',82652964)

	/* (vc12,vc12) */

INSERT INTO
PassengerPromotion(CustID,BookingNo,PromoCode)
VALUES
	('C011234596','TB19071234ZS','CH1NA8ZZ1SP3DIS'),
	('C309455966','TB19281827ZS', 'CH1NA8ZZ1SP3DIS'),
	('C349502234','TB19283726ZS', 'PASSIONE'),
	('C234910439','TB19642718ZS','CH1NA8ZZ1TSPES'),
	('C050379539','TB10987346ZS','NATADESC'),
	('C101988488','TB39990908ZS','APTM125W342'),
	('C132431237','TB20998745ZS', '39JS6SYVDS9'),
	('C101296665','TB23437986ZS', 'GYYD612838'),
	('C186743153','TB12655767ZS','S5P4RC7L8F7'),
	('C103405432','TB36870879ZS','P6P9I0HYUE5')
	/* (^10 Organisers/Passengers) */


	

	/* (c10,vc12,vc30) */

INSERT INTO
PromotionForTrip(PromoCode,ItineraryNo,DepartureDate)
VALUES
	('PASSIONE', '00000000001', '2020-03-22'),
	('NATADESC', '00000000002', '2021-04-05'),
	('APTM125W342', '00000000003', '2020-03-03'),
	('39JS6SYVDS9', '00000000004', '2020-03-28'),
	('S5P4RC7L8F7' , '00000000005', '2023-03-22'),
	('GYYD612838', '00000000006', '2022-11-21'),
	('GYYD612838', '00000000007', '2021-03-04'),
	('CH1NA8ZZ1TSPES', '00000000008', '2020-08-08'),
	('39JS6SYVDS9', '00000000009', '2020-08-15'),
	('GYYD612838', '00000000010', '2021-03-15')
	/* (vc30,vc11,date) */


INSERT INTO
StayIn(HotelID,ItineraryNo,DepartureDate,CheckInDate,CheckOutDate)
VALUES
	(1,'00000000010','2021-03-15','2021-03-15','2021-03-22'),
    (2,'00000000001','2020-03-22','2020-03-22','2020-03-25'),
    (3,'00000000002','2021-04-05','2021-04-05','2021-04-08'),
    (4,'00000000007','2021-03-04','2021-03-04','2021-03-18'),
    (5,'00000000005','2023-03-22','2023-03-22','2023-03-25'),
    (6,'00000000004','2020-03-28','2020-03-28','2020-04-01'),
    (7,'00000000006','2022-11-21','2022-11-21','2022-11-30'),
    (8,'00000000009','2020-08-15','2020-08-15','2020-08-19'),
    (9,'00000000003','2020-03-03','2020-03-03','2020-03-09'),
    (10,'00000000008','2020-08-08','2020-08-08','2020-08-12')
	/* (int,vc11,date,date,date) */

INSERT INTO
FliesOn(ItineraryNo,DepartureDate,FlightNo,FlightDate) 
VALUES
	('00000000001', '2020-03-22', 'TR198', '2020-03-21'),
	('00000000002', '2021-04-05', 'TR999', '2020-04-03'),
	('00000000003', '2020-03-03', 'SQ300', '2020-03-03'),
	('00000000004', '2020-03-28', 'SQ198', '2020-03-28'),
	('00000000005', '2023-03-22', 'TR199', '2023-03-22'),
	('00000000006', '2022-11-21', 'TR999', '2022-11-21'),
	('00000000007', '2021-03-04', 'SQ198', '2021-03-04'),
	('00000000008', '2020-08-08', 'DL682', '2020-08-08'),
	('00000000009', '2020-08-15', 'DL991', '2020-08-15'),
	('00000000010', '2021-03-15', 'SQ300', '2021-03-15')
	/* (vc11,date,int,date) */

INSERT INTO
RoomBooking(RmTypeID,BookingNo,NoOfExtraBed,NoOfRoom)
VALUES
	(01,'TB19071234ZS',04,20),
	(02,'TB19281827ZS',02,30),
	(03,'TB19283726ZS',00,30),
	(04,'TB19642718ZS',09,25),
	(05,'TB10987346ZS',01,20),
	(06,'TB39990908ZS',13,40),
	(07,'TB20998745ZS',00,20),
	(08,'TB23437986ZS',05,20),
	(09,'TB12655767ZS',07,25),
	(10,'TB36870879ZS',08,25)
	
	

INSERT INTO
SiteDetails(ItineraryNo,SiteID)
VALUES
	('00000000001','47521'),
	('00000000002','35472'),
	('00000000003','57629'),
	('00000000004','35276'),
	('00000000005','12876'),
	('00000000006','35472'),
	('00000000007','57622'),
	('00000000008','12536'),
	('00000000009','89123'),
	('00000000010','67822'),
	('00000000002','12321'),
	('00000000002','02839'),
	('00000000002','02920'),
	('00000000009','01232'),
	('00000000007','52622'),
	('00000000009','99910'),
	('00000000002','35342')
	
	
	/* (vc11,c5) */



select*
from Staff

select*
from TourLeader

select*
from TravelAdvisor

select*
from Customer

select*
from Organiser

select*
from Itinerary

select*
from Trip

select*
from Booking

select*
from Passenger

select*
from Promotion

select*
from RoomType

select*
from Country

select*
from City

select*
from Site

select*
from Flight

select*
from Hotel

select*
from StaffContactNo

select*
from PassengerPromotion

select*
from PromotionForTrip

select*
from StayIn

select*
from FliesOn

select*
from RoomBooking

select*
from SiteDetails




