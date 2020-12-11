--Tan Yuan Ming

/* Query 1 */
--Select the cost from each booking number order by cost ascending

select BookingNo, PmtAmt as 'Cost' from Payment where BookingNo IN (SELECT BookingNo from Booking) ORDER BY [Cost] ASC

/* Query 2*/
--Select name of tour leaders according to staff id
--Accompany tour leader tours to china during december 2019
select t.StaffID,s.StaffName from TourLeader t INNER JOIN Staff s ON t.StaffID = s.StaffID

/*Query 3*/
--Select number of flight number and number of itinerary number in total

Select COUNT(f.FlightNo) as 'Fight Number',COUNT(fo.ItineraryNo) as ' Number of Itinerary' 
from Flight f INNER JOIN FliesOn fo ON f.FlightNo = fo.FlightNo

--Chua Zhe Yu
/* Query 1 */
--List the number of customers involved in each tour, the destination of each tour,
--the name of the tour guide that is in charge order by the number of customers descending

select count(*) as 'No of customers', CountryDesc as 'Country', StaffName as 'Tour Leader'
from Customer c inner join Passenger p
on c.CustID = p.CustID inner join Booking b
on p.BookingNo = b.BookingNo inner join Staff s
on b.StaffID = s.StaffID inner join TourLeader tl
on s.StaffID = tl.StaffID inner join Itinerary i
on b.ItineraryNo = i.ItineraryNo inner join SiteDetails sd
on i.ItineraryNo = sd.ItineraryNo inner join Site si
on sd.SiteID = si.SiteID inner join City ci
on si.CityCode = ci.CityCode inner join Country co
on ci.CountryCode = co.CountryCode
group by CountryDesc, StaffName
order by [No of customers] desc


/* Query 2 */
--List the Departure Date, Duration, Information of tour and the adult price of the tour

select distinct t.DepartureDate, DATEDIFF(day, CheckInDate, CheckOutDate) as 'Duration', ItineraryDesc as 'Information', AdultPrice as 'Adult Price'
from Trip t inner join Booking b
on b.ItineraryNo = t.ItineraryNo inner join StayIn si
on b.ItineraryNo = si.ItineraryNo inner join Itinerary i
on b.ItineraryNo = i.ItineraryNo
--where (DATEPART(MONTH,t.DepartureDate) between '3' and '4' and (DATEPART(Year, t.DepartureDate)
where t.DepartureDate between '2020-03-01' and '2020-04-30' 



/* Query 3 */
--List the number of sites throughout a particular tour 

select ItineraryDesc as 'Name of Tour', count(SiteDesc) as 'Number of Sites'
from Itinerary i inner join SiteDetails sd
on i.ItineraryNo = sd.ItineraryNo inner join Site s
on sd.SiteID = s.SiteID
group by ItineraryDesc

--Ng Tze Keat    
/* Query 1 */
--List customer name, passport expiry date, and departure date for all customers who are passengers
--and have made a booking, whose passports expire within 6 months of their return date.

Select CustName,PassportExpiry,Booking.DepartureDate,DateDIFF(m,Booking.DepartureDate,PassportExpiry) AS 'Number of extra months passport needs'
from Customer
INNER JOIN Passenger ON Passenger.CustID=Customer.CustID
INNER JOIN Booking ON Booking.CustID=Passenger.CustID
where PassportExpiry<Booking.DepartureDate AND DateDIFF(m,Booking.DepartureDate,PassportExpiry)>6
ORDER BY CustName ASC
--passports expiring within 6 months before departure date



/* Query 2 */
--List all names,IDs, and emails of Customers who are also Organisers. 

Select Customer.CustID,Customer.CustName,CustEmail
from Customer
INNER JOIN Organiser ON Customer.CustID=Organiser.CustID

ORDER BY CustName

/* Query 3 */
--Display number of passengers who are above 30 but below 50.

select COUNT(t.CustID) AS 'Passengers who are above 30 but below 50'
From Passenger o
INNER JOIN Passenger t ON o.CustID=t.CustID
where t.Age>30 AND o.age<50

--Sim Jie Ren    
/* Query 1 */
--List all bookings with a promotion for the current year in order of highest discount

Select b.BookingNo, b.BookingDate, p.PromoCode, pr.Discount from Booking b
INNER JOIN PassengerPromotion p
on b.BookingNo = p.BookingNo 
INNER JOIN Promotion pr
on p.PromoCode = pr.PromoCode
where DATEDIFF(Year,BookingDate,GETDATE()) = 0
order by Discount desc


/* Query 2 */
--List all the names of all Tour Leaders whose license are expiring next year

Select t.StaffID, t.LicenseExpiryDate, s.StaffName from TourLeader t
INNER JOIN Staff s
on t.StaffID = s.StaffID
where DATEDIFF(YEAR,LicenseExpiryDate,GETDATE()) = -1



/* Query 3 */
--List the emails of the customer who paid with
--promotions for the current year

Select b.BookingDate, o.CustID,o.CustEmail,p.PromoCode from Organiser o
INNER JOIN PassengerPromotion p
on o.CustID = p.CustID 
INNER JOIN Booking b
on b.BookingNo = p.BookingNo
where DATEPART(Year,GETDATE()) = DATEPART(Year,BookingDate)
--List of customers without promotions last year

--Gladys Chua Ling Hui

--List
--HotelNo,CustID,CustName,BookingNo,RoomTypeID and ‘Duration of Stay’ for number of days the guest took to checkout from the checkin day. Display the results in descending order of ‘ Duration of Stay’
/*Query 1*/
Select HotelID,RmTypeID, Customer.CustID, CustName, Booking.BookingNo , DateDiff(day,CheckInDate,CheckOutDate) AS "Duration Of Stay" from StayIn  INNER JOIN Booking on StayIn.ItineraryNo = Booking.ItineraryNo inner JOIN RoomBooking ON Booking.BookingNo = RoomBooking.BookingNo inner join Customer  on Booking.CustID = Customer.CustID order by [Duration Of Stay] desc

/*Query 2*/ 
--List FlightNo,Destination,FlightDate,FlightTime,‘ Number of passengers in one flight’’, group by descending of FlightNo,Destination,FlightDate
Select  FliesOn.FlightNo,Destination,FlightDate,FlightTime,Count(*)as "Number of Passengers in one flight" 
from Flight inner join FliesOn 
ON FliesOn.FlightNo = Flight.FlightNo group by FliesOn.FlightNo,Destination,FlightDate,FlightTime
order by [Number of Passengers in one flight] desc


/*Query 3*/
--group by pmttypes
--List PmtMethod, total number of bookings paid by each method as “No. of Bookings made by relevant payment method” and total payments made by each method as “No. of payments made by each method. Group by paymethod order by descending order of “No. of payments made by each method”
Select PmtMethod,PmtType ,count(Booking.BookingNo) as "No. of bookings made by relevant payment method", 
Count(PmtMethod) as "No. of payments made by each method" 
from Payment  inner join Booking on 
Payment.BookingNo = Booking.BookingNo group by PmtMethod,PmtType order by [No. of payments made by each method] desc



select count(*) as 'No of customers', CountryDesc as 'Country', StaffName as 'Tour Leader'
from Customer c inner join Passenger p
on c.CustID = p.CustID inner join Booking b
on p.BookingNo = b.BookingNo inner join Staff s
on b.StaffID = s.StaffID inner join TourLeader tl
on s.StaffID = tl.StaffID inner join Itinerary i
on b.ItineraryNo = i.ItineraryNo inner join SiteDetails sd
on i.ItineraryNo = sd.ItineraryNo inner join Site si
on sd.SiteID = si.SiteID inner join City ci
on si.CityCode = ci.CityCode inner join Country co
on ci.CountryCode = co.CountryCode inner join Trip t
on t.ItineraryNo = b.ItineraryNo
where t.DepartureDate between '2020-01-01' and '2020-12-31'
group by CountryDesc, StaffName
order by [No of customers] desc

































/* Query 1 */
select count(*) as 'No of customers', CountryDesc as 'Country', StaffName as 'Tour Leader'
from Customer c inner join Passenger p
on c.CustID = p.CustID inner join Booking b
on p.BookingNo = b.BookingNo inner join Staff s
on b.StaffID = s.StaffID inner join TourLeader tl
on s.StaffID = tl.StaffID inner join Itinerary i
on b.ItineraryNo = i.ItineraryNo inner join SiteDetails sd
on i.ItineraryNo = sd.ItineraryNo inner join Site si
on sd.SiteID = si.SiteID inner join City ci
on si.CityCode = ci.CityCode inner join Country co
on ci.CountryCode = co.CountryCode
group by CountryDesc, StaffName
order by [No of customers] desc


/* Query 2 */
select distinct t.DepartureDate, DATEDIFF(day, CheckInDate, CheckOutDate) as 'Duration', ItineraryDesc as 'Information', AdultPrice as 'Adult Price'
from Trip t inner join Booking b
on b.ItineraryNo = t.ItineraryNo inner join StayIn si
on b.ItineraryNo = si.ItineraryNo inner join Itinerary i
on b.ItineraryNo = i.ItineraryNo
where DATEPART(MONTH,t.DepartureDate) between '3' and '4'





/* Query 3 */
select ItineraryDesc as 'Name of Tour', count(SiteDesc) as 'Number of Sites'
from Itinerary i inner join SiteDetails sd
on i.ItineraryNo = sd.ItineraryNo inner join Site s
on sd.SiteID = s.SiteID
group by ItineraryDesc




