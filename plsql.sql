
-- PL/SQL variable declaration and print value for retrieving information about a specific user:
SET SERVEROUTPUT ON
DECLARE
    v_username Users.username%TYPE;
    v_email Users.email%TYPE;
    v_spent_total Users.spentTotal%TYPE;
    v_account_status Users.accountStatus%TYPE;
BEGIN
    SELECT username, email, spentTotal, accountStatus
    INTO v_username, v_email, v_spent_total, v_account_status
    FROM Users
    WHERE id = 1; -- Specify the user ID here
    DBMS_OUTPUT.PUT_LINE('Username: ' || v_username);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('Spent Total: ' || v_spent_total);
    DBMS_OUTPUT.PUT_LINE('Account Status: ' || v_account_status);
END;
/
-- Insert and set default values for adding a new agency:

SET SERVEROUTPUT ON
DECLARE
    v_id Agencies.id%TYPE := 16; -- Specify the agency ID here
    v_name Agencies.name%TYPE := 'Global Adventures';
    v_is_international Agencies.isInternational%TYPE := 'YES';
    v_country Agencies.country%TYPE := 'United States';
    v_user_id Agencies.userId%TYPE := 11; -- Specify the user ID here
BEGIN
    INSERT INTO Agencies (id, name, isInternational, country, userId)
    VALUES (v_id, v_name, v_is_international, v_country, v_user_id);
    DBMS_OUTPUT.PUT_LINE('New agency inserted successfully.');
END;
/
-- Cursor and row count for fetching and displaying information about all packages:

SET SERVEROUTPUT ON
DECLARE 
    v_id Packages.id%TYPE;
    v_name Packages.name%TYPE;
    v_agency_id Packages.AgencyId%TYPE;
    v_area Packages.Area%TYPE;
    v_details Packages.Details%TYPE;
    v_duration Packages.Duration%TYPE;
    v_price Packages.Price%TYPE;
    v_row_count INTEGER := 0;
BEGIN
    FOR package_rec IN (SELECT * FROM Packages) LOOP
        v_id := package_rec.id;
        v_name := package_rec.name;
        v_agency_id := package_rec.AgencyId;
        v_area := package_rec.Area;
        v_details := package_rec.Details;
        v_duration := package_rec.Duration;
        v_price := package_rec.Price;

        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Name: ' || v_name || ', Agency ID: ' || v_agency_id || ', Area: ' || v_area || ', Details: ' || v_details || ', Duration: ' || v_duration || ', Price: ' || v_price);
        v_row_count := v_row_count + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total rows fetched: ' || v_row_count);
END;
/
-- Variable Declaration and Print Value
declare
    v_name varchar2(50);
begin
    v_name := 'John Doe';
    Dbms_output.put_line('Name: ' || v_name);
end;

-- Insert and Set Default Value
insert into users (id, username, email, spentTotal, accountStatus)
values (1, 'testuser', 'test@example.com', 0, 'active');

-- Row Type and Fetch Records
declare
    v_user users%ROWTYPE;
begin
    select * into v_user from users where id = 1;
    dbms_output.put_line('User Email: ' || v_user.email);
end;

-- Cursor to Fetch Records and Get Count
declare
    cursor c_users is select * from users;
    v_count number := 0;
    v_rec users%ROWTYPE;
begin
    for v_rec in c_users loop
        v_count := v_count + 1;
    end loop;
    dbms_output.put_line('Total Users: ' || v_count);
end;



-- IF-ELSEIF-ELSE Construct
declare
    v_num number := 10;
begin
    if v_num < 0 then
        dbms_output.put_line('Negative');
    elsif v_num = 0 then
        dbms_output.put_line('Zero');
    else
        dbms_output.put_line('Positive');
    end if;
end;

-- Create a Procedure to Insert a Record into the Agencies Table
create or replace PROCEDURE insert_agency (
    p_id in agencies.id%type,
    p_name in agencies.name%type,
    p_international in agencies.isInternational%type,
    p_country in agencies.country%type,
    p_user_id in agencies.userId%type
)
as
begin
    insert into agencies (id, name, isInternational, country, userId)
    values (p_id, p_name, p_international, p_country, p_user_id);
end insert_agency;

-- Define a Function to Calculate the Age of a User based on their Date of Birth
create or replace function calculate_age (
    p_dob in date
) return number
as
    v_age number;
begin
    select floor(months_between(sysdate, p_dob) / 12) into v_age from dual;
    return v_age;
end calculate_age;

-- Trigger that Automatically Updates the Spent Total of a User when a Package is Inserted
create or replace trigger update_spent_total
after insert on packages
for each row
begin
    update users
    set spentTotal = spentTotal + :new.price
    where id = (select userId from agencies where id = :new.agencyId);
end;

-- Trigger that Prevents Updating the Username of a User
create or replace trigger prevent_username_update
before update of username on users
for each row
begin
    if :old.username != :new.username then
        raise_application_error(-20001, 'Username cannot be updated.');
    end if;
end;

-- Trigger that Logs the Deletion of a Hotel into a Separate Table
create or replace trigger log_hotel_deletion
after delete on hotels
for each row
begin
    insert into hotel_deletion_log (hotel_id, deletion_date)
    values (:old.id, sysdate);
end;

-- Finally
set serveroutput on;
begin
    dbms_output.put_line('Project Name:');
    dbms_output.put_line('--------------');
    dbms_output.put_line('TravelMate Database Project');
    dbms_output.put_line('Created by:');
    dbms_output.put_line('------------');
    dbms_output.put_line('Your Name');
    dbms_output.put_line('Roll: ');
    dbms_output.put_line('----');
    dbms_output.put_line('Your Roll Number');
    dbms_output.put_line('--------------------------------------------------');
end;
/

