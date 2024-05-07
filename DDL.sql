-- Create a table for Users
create table users (
user_id number primary key,
username varchar2(100) not null,
email varchar2(50) not null,
spent_total number,
account_status varchar2(10) check (account_status in ('active', 'inactive', 'pending'))
);

-- Create a table for TouristPlaces
create table touristplaces (
place_id number primary key,
name varchar2(100),
description varchar2(500),
stars number(32),
price number(24),
operating_area varchar2(50),
package_id number references packages(id)
);

-- Alter the Users table to add a new column
alter table users add (phone_number varchar2(20));

-- Drop the TouristPlaces table
drop table touristplaces;


-- Rename the Users table to Customers
rename users to customers;

-- Create a view for active users
create view active_users as
select * from customers
where account_status = 'active';
