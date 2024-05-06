-- Insert new record into Users table
insert into users values (1, 'john_doe', 'john@example.com', 200, 'active');

-- Update the email of a user in Users table
update users set email = 'jane@example.com' where user_id = 2;

-- Delete a record from Users table
delete from users where user_id = 3;

-- Merge data from two tables into one
merge into customers c
using users u
on (c.user_id = u.user_id)
when matched then
update set c.email = u.email
when not matched then
insert (user_id, username, email, spent_total, account_status)
values (u.user_id, u.username, u.email, u.spent_total, u.account_status);

-- Select all active users
select * from users where account_status = 'active';

-- Call a stored procedure
call calculate_total_spent(1);