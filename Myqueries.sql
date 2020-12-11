
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



































