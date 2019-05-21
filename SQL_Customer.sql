-- drop database Customers; -- only run this if you're starting over

create database Customers;
-- switch to the customers database (It's case sensitive)
use Customers;

-- import customers.csv into a table called Customer (case-sensitive)
-- Right-click on tables and select import, use the wizard to import the csv file
-- see how many customers are in our table: (use back ticks for strings)
select count(*) as `Customer Count` from Customer;

-- how many unique companies are in our table?
select count(distinct company)as 'Distinct Companies' from Customer;

select * from customer;

-- add an Id to the customer table
alter table Customer add CustomerId int not null primary key auto_increment;

-- add a column for the CompanyID to the customers table
alter table Customer add CompanyID int;

-- notice that the companyId is null
select companyID, company from Customer;

-- create a table for the companies
-- this statement will also create a companyID column which will
-- increment when you insert a new record
create table Company (
companyID int NOT NULL AUTO_INCREMENT, -- The colum isn't null and increments automatically
Company varchar(255),
primary key (companyID)-- assigning companyID as a primary key inside the Company table; its also present in another table but isn't a PKcompany
);

-- see what's in your company table now
select * from Company; -- nothing in the company table (both comapnyID and Comapany is null)

-- generate a sql statement which shows which companies will be added to the new customer table
select distinct company from Customer where length(company)>0 and company is not null  order by company; -- ordered alphabetically

-- add the above companies from customers to the company table
insert into Company (company) select distinct company from Customer where length(company)>0 and company is not null  order by company; -- "insert into Company (company)" gets added to the line above

-- look at what you've done
select * from Company;

-- another way to select is to list the fields
select companyID, Company from Company;

/*
If you get ...
Error Code: 1175. You are using safe update mode and you tried 
to update a table without a WHERE that uses a KEY column 
To disable safe mode, toggle the option in 
Preferences -> SQL Editor and reconnect.

To reconnect: Query Menu -> Reconnect to Server
*/
select * from customer; -- review what currently inside customer table 

select * from company;   -- review what currently inside company table 

-- update the compnayId in the customers table
update Customer c set c.companyID = (select t.companyID from  -- called a corelated supquery: query inside a query
Company t where t.company=c.company);

-- query to check your data
select c.companyID,c.company,t.companyID,t.Company from
Customer c inner join Company t on c.CompanyID=t.CompanyID;

-- remove the company column from the customers table. It is no longer needed
alter table Customer drop column company;

-- You can generate fullname as:
select CONCAT(`FirstName`,' ',`LastName`) as `Full Name` from Customer;

-- notice you won't see the company (or fullname) column
select * from Customer;

-- the company column and the id are in Company
select * from Company;

-- a query to bring it all back together
select CONCAT(`FirstName`,' ',`LastName`) as `Full Name`, company from Customer 
inner join Company on 
customer.companyid=Company.companyid;




-- create database Customers;

-- use Customers;
 
select count(*) as 'Customer Count' from Customer; 

select count(distinct city) as 'Distinct Cities' from Customer;

-- alter table Customer add CustomerId int not null primary key auto_increment;
-- alter table Customer add CompanyID int; 

select City, State, Position from Customer;

-- alter table Customer add CustomerId int not null primary key auto_increment;


create table custCity (
cityID int NOT NULL AUTO_INCREMENT,
City_name varchar(100),
primary key (cityID)
);

-- drop table City; 

select distinct City from Customer where length(city)>0 and city is not null order by city; 

insert into custCity(city_name) select distinct city from Customer where length(city)>0 and city is not null order by city;

select * from customer;


create table custState (
stateID int NOT NULL AUTO_INCREMENT,
State_name varchar (200),
primary key (stateID)
);
-- drop table custState; 
select * from custState;

select  distinct State from Customer where length(state)>0 and state is not null order by state;

insert into custState(state_name) select distinct state from Customer where length(state)>0 and state is not null order by state;

select * from custState;


create table custPosition (
positionID int NOT NULL AUTO_INCREMENT,
Position_name varchar(200),
primary key (positionID)
);

select * from custPosition;

select * from customer;

select distinct Position from Customer where length(position)>0 and position is not null order by position; 

insert into custPosition(position_name) select distinct position from Customer where length(position)>0 and position is not null order by position;

select * from custPosition;

alter table customer add cityID int;

update Customer c set c.cityID = (select t.cityID from  -- called a corelated supquery: query inside a query
custCity t where t.city_name=c.city);

select c.cityID, c.city, t.cityID,t.city_name from Customer c inner join custcity t on c.cityID=t.cityID;

ALTER TABLE customer
DROP COLUMN city;

select * from customer;

alter table customer add stateID int;

update Customer c set c.stateID= (select s.StateID from
custState s where s.State_name=c.state);

select c.stateID, c.state, s.stateID,s.state_name from customer c inner join custState s on c.stateID=s.stateID;

alter table customer
drop column state;

select * from customer;


alter table customer add positionID int;

update Customer c set c.positionID= (select p.positionID from
custPosition p where p.position_name=c.position);

select c.stateID, c.position, p.positionID,p.position_name from customer c inner join custPosition p on c.positionID=p.positionID;

alter table customer
drop column position;

select * from customer;

 