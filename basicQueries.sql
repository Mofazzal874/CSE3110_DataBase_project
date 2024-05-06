-- Description of each table
select * from users;
select * from touristplaces;
select * from tourguides;
select * from hotels;
select * from agencies;
select * from packages;

-- Add a column named phone_number of type varchar2(20) to the users table
alter table users add phone_number varchar2(20);

-- Rename the column email to user_email in the users table
alter table users rename column email to user_email;

-- Modify the data type of the column stars to number(5) in the touristplaces table
alter table touristplaces modify stars number(5);

-- Drop the column age from the tourguides table
alter table tourguides drop column age;

-- Update Data in a Table
update users set spentTotal = 300 where id = 1;

-- Deleting Row from a Table
delete from touristplaces where id = 1;

-- Find the distinct area from the touristplaces table
select distinct operatingArea from touristplaces;

-- LIKE % Command
select * from users where user_email like '%@gmail.com';

-- WITH Clause Display the number of packages offered by each agency
with PackageCount as (
select AgencyId, count(*) as num_packages
from packages
group by AgencyId
)
select * from PackageCount;

-- Aggregate Functions
-- Count
select count(*) as total_agencies from agencies;

-- Min
select min(price) as min_price from packages;

-- Avg
select avg(price) as avg_price from packages;

-- Max
select max(stars) as max_stars from touristplaces;

-- Group By, Having Display the count of users based on their account status where the count is greater than 1.
select accountStatus, count() as num_users
from users
group by accountStatus
having count() > 1;

-- Find agencies with isInternational value 'YES'
select * from agencies where isInternational = 'YES';

-- Find packages with price less than 1500
select * from packages where price < 1500;

-- Inner Join , Display the details of packages along with the respective agencies.
select p., a.
from packages p, agencies a
where p.AgencyId = a.id;

-- Outer Join , Display all users along with their respective agencies, even if they don't have an agency assigned.
select u., a.
from users u, agencies a
where u.userId = a.id(+);

-- Natural Join, Display the name of the tourist places along with their operating area.
select tp.name, tp.operatingArea, t.area
from touristplaces tp
natural join tourguides t;

-- Self Join
select u1.username as user1, u2.username as user2
from users u1, users u2
where u1.spentTotal = u2.spentTotal
and u1.id <> u2.id;

-- INTERSECT
select id, name
from touristplaces
where operatingArea = 'Beach'
intersect
select id, name
from touristplaces
where stars > 4;