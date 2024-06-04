USE wineshopproject;

#SQL project - CFG Kickstarter
#6 tables looking at data from 3 wine shops

#Table 1: 'Shops' tells us about each shop and has ShopID(primary key), ShopName and Location
CREATE TABLE Shops (
ShopID varchar(20) PRIMARY KEY,
ShopName varchar(50) NOT NULL,
Location varchar(50) NOT NULL
);

INSERT INTO Shops (ShopID, ShopName, Location)
VALUES ('WG001', 'Wines on the Green', 'Angel'), ('HW002', 'Hansen Wines', 'Chingford'), ('WW003', 'Weird Wines', 'Walthamstow');

SELECT * FROM Shops;

#Table 2: Will tell us about each wine and will have WineID(primary key), the name of the wine, which country it is from and the price per bottle
CREATE TABLE Wines (
WineID varchar(20) PRIMARY KEY,
WineName varchar(50) NOT NULL,
Country varchar(20) NOT NULL,
Price float NOT NULL);

INSERT INTO Wines (WineID, WineName, Country, Price)
VALUES ('red1', 'Gamay', 'France', 18.50), 
('red2', 'pinot noir', 'England', 22.00), 
('red3', 'Tempranillo', 'Spain', 15.00), 
('red4', 'Touriga Nacional', 'Portugal', 16.00), 
('white1', 'Bacchus', 'England', 15.00),
('white2', 'Furmint', 'Hungary', 17.50),
('white3', 'Gruner Veltliner', 'Austria', 19.00),
('sparkling1', 'Chalklands', 'England', 31.00),
('sparkling2', 'Canterbury Rose', 'England', 29.00),
('sparkling3', 'Pet Nat', 'Portugal', 17.00),
('sparkling4', 'Champagne', 'France', 45.00),
('sparkling5', 'Cava', 'Spain', 16.00),
('sparkling6', 'Pink Cava', 'Spain', 15.00);

#Realised I wrote pinot noir in lower case and it bothered me
UPDATE Wines
SET WineName = 'Pinot Noir'
WHERE wineID = 'red2';

SELECT * FROM Wines;

#Table 3: Tells us which wines are for sale in each shop. It has the columns ShopID (Foreign Key referencing Shops) and WineID (Foreign Key referencing Wines)
CREATE TABLE Wines_Shops (
ShopID varchar(20), FOREIGN KEY (ShopID) REFERENCES Shops(ShopID),
WineID varchar(20), FOREIGN KEY (WineID) REFERENCES Wines(WineID));

INSERT INTO Wines_Shops (ShopID, WineID)
VALUES ('WG001', 'red1'),
('WG001', 'red2'),
('WG001', 'red4'),
('WG001', 'white1'),
('WG001', 'white2'),
('WG001', 'sparkling1'),
('WG001', 'sparkling2'),
('WG001', 'sparkling3'),
('WG001', 'sparkling4'),
('HW002', 'red1'),
('HW002', 'red2'),
('HW002', 'red3'),
('HW002', 'red4'),
('HW002', 'white1'),
('HW002', 'white2'),
('HW002', 'white3'),
('HW002', 'sparkling1'),
('HW002', 'sparkling2'),
('HW002', 'sparkling3'),
('HW002', 'sparkling4'),
('HW002', 'sparkling5'),
('HW002', 'sparkling6'),
('WW003', 'red2'),
('WW003', 'red3'),
('WW003', 'red4'),
('WW003', 'white1'),
('WW003', 'white2'),
('WW003', 'white3'),
('WW003', 'sparkling1'),
('WW003', 'sparkling2'),
('WW003', 'sparkling5'),
('WW003', 'sparkling6');

SELECT * FROM Wines_Shops;

#Table 4: 'Sales' tells us how many bottles were sold in each shop during 2023. This will help us look at which wines are the most and least popular. 
#This can help us decide which wines should be replaced and look at whether there is a market for English wines for example.
CREATE TABLE Sales2023 (
ShopID varchar(20), FOREIGN KEY (ShopID) REFERENCES Shops(ShopID),
WineID varchar(20), FOREIGN KEY (WineID) REFERENCES Wines(WineID),
Number_of_bottles_sold INT);

INSERT INTO Sales2023 (ShopID, WineID, Number_of_bottles_sold)
VALUES ('WG001', 'red1', 168),
('WG001', 'red2', 454),
('WG001', 'red4', 237),
('WG001', 'white1', 713),
('WG001', 'white2', 497),
('WG001', 'sparkling1', 154),
('WG001', 'sparkling2', 132),
('WG001', 'sparkling3', 174),
('WG001', 'sparkling4', 45),
('HW002', 'red1', 371),
('HW002', 'red2', 239),
('HW002', 'red3', 187),
('HW002', 'red4', 98),
('HW002', 'white1', 235),
('HW002', 'white2', 189),
('HW002', 'white3', 321),
('HW002', 'sparkling1', 78),
('HW002', 'sparkling2', 43),
('HW002', 'sparkling3', 110),
('HW002', 'sparkling4', 67),
('HW002', 'sparkling5', 104),
('HW002', 'sparkling6', 88),
('WW003', 'red2', 477),
('WW003', 'red3', 330),
('WW003', 'red4', 189),
('WW003', 'white1', 401),
('WW003', 'white2', 372),
('WW003', 'white3', 245),
('WW003', 'sparkling1', 110),
('WW003', 'sparkling2', 56),
('WW003', 'sparkling5', 134),
('WW003', 'sparkling6', 162);

SELECT * FROM Sales2023;

#Table 5: 'Staff' has the columns StaffID (primary key), name, ShopID (foreign key), ProRataHours, total£sold(maybe)
CREATE TABLE Staff (
StaffID varchar(5) PRIMARY KEY,
StaffName varchar(50) NOT NULL,
ShopID varchar(20), FOREIGN KEY (ShopID) REFERENCES Shops(ShopID),
ProRataHours DECIMAL(2,1) DEFAULT '1.0',
Total£Sold DECIMAL(6,2) NOT NULL);

INSERT INTO Staff (StaffID, StaffName, ShopID, ProRataHours, Total£Sold)
VALUES ('S01', 'Tilly', 'HW002', 1.0, 2145.00),
('S03', 'Megan', 'WG001', 1.0, 2315.00),
('S04', 'Sabina', 'WW003', 0.6,  717.50),
('S05', 'Chineye', 'HW002', 0.6, 695.50),
('S06', 'Neil', 'WG001', 1, 2417.50),
('S08', 'Sam', 'WW003', 1, 1890.00),
('S09', 'Yonas', 'HW002', 0.6, 717.50),
('S10', 'Siva', 'WW003','0.6', 957.50);

SELECT * FROM Staff;

#Table 6: Box discounts. If customers buy a box of 6 wines (same wine) they get 10% discount, if they buy 12, 18 or 24 wines (same WineID) they get 20% discount
#Staff members who sell a box also get a £2 bonus per box
CREATE TABLE Box_discount (
SalesID VARCHAR(5) PRIMARY KEY,
StaffID VARCHAR(5),
WineID VARCHAR(20),
ShopID VARCHAR(20),
Number_of_boxes INT NOT NULL,
Discount INT NOT NULL);

INSERT INTO Box_discount (SalesID, StaffID, WineID, ShopID, Number_of_boxes, Discount)
VALUES ('1106','S03', 'red1', 'WG001', 1, 10), 
('1156','S01', 'sparkling3', 'HW002', 2, 20),
('1177','S06', 'sparkling4', 'WG001', 1, 10),
('1210','S08', 'red4', 'WW003', 1, 10),
('1231','S08', 'sparkling6', 'WW003', 1, 10),
('1275','S010', 'red2', 'WW003', 1, 10),
('1283','S01', 'sparkling1', 'HW002', 1, 10),
('1326','S05', 'red2', 'HW002', 1, 10);

SELECT * FROM Box_discount;


		#Using any type of the joins create a view that combines multiple tables in a logical way
#JOIN showing which staff works where
CREATE VIEW StaffLocation
AS 
SELECT
s.Location, 
st.StaffName
FROM Shops AS s
INNER JOIN
Staff AS st
ON
s.ShopID =
st.ShopID;

SELECT * FROM StaffLocation;

		#In your database, create a stored function that can be applied to a query in your DB
#Wines with a price of over £20 are in my experience much more difficult to sell. 
#Which wines will be harder to sell due to price being > £20.00 
DELIMITER //
CREATE FUNCTION hard_to_sell_wines(price float)
RETURNS varchar(3)
DETERMINISTIC
BEGIN
    DECLARE hard_to_sell varchar(10);
    IF price > 20 THEN
		SET hard_to_sell = 'Yes';
	ELSEIF price <= 20 THEN
		SET hard_to_sell = 'No';
	END IF;
    RETURN (hard_to_sell);
END //
DELIMITER ;

SELECT 
    WineName,
    hard_to_sell_wines(price) AS HardToSell
FROM
    Wines;
    
	#Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis 
#How many English wines were sold across all 3 shops (subquery)? I.e. is there a market for English wines? 
SELECT WineID, SUM(number_of_bottles_sold) AS Bottles_sold
FROM Sales2023
WHERE WineID IN (SELECT WineID
FROM Wines
WHERE country = 'England')
GROUP BY WineID;

#Pick at least 2 or these:
	#In your database, create a stored procedure and demonstrate how it runs
DELIMITER //
CREATE PROCEDURE InsertValues 
(
IN WineID varchar(20),
IN WineName varchar(50),
IN Country varchar(20),
IN Price float
)
BEGIN
INSERT INTO Wines(WineID, WineName, Country, Price)
VALUES (WineID, WineName, Country, Price);
END//
DELIMITER ;

#How to use this stored procedure - this will save time when adding new wines compared to an insert into/values statement.

CALL InsertValues ('white4', 'Chardonnay', 'England', 19.00);

SELECT * from Wines; #We can see that the English Chardonnay has been added

	#In your database, create a trigger and demonstrate how it runs
#The company requires all staff to work a minimum of 0.6 pro rata hours. If a new staff member is added and they request less hours than this, 
#the TRIGGER will update the hours to be 0.6 according to company policy.
DELIMITER //
CREATE TRIGGER minimum_hours
BEFORE INSERT ON Staff
FOR EACH ROW
IF NEW.ProRataHours < 0.6 THEN SET NEW.ProRataHours = 0.6;
END IF; //

#A new staff member has requested less than 0.6 hours
INSERT INTO Staff (StaffID, StaffName, ShopID, ProRataHours, Total£Sold)
VALUES ('S11', 'Charles', 'HW002', 0.4, 0.00);

SELECT * FROM Staff; #New staff member Charles had his request denied and is working Pro Rata Hours of 0.6
    
	#Create a view that uses at least 3-4 base tables; prepare and demonstrate a query that uses the view to produce a logically arranged result set for analysis.
CREATE VIEW Box_bonus
AS
SELECT bd.SalesID, 
bd.StaffID,
st.StaffName,
bd.Number_of_boxes,
w.WineName,
s.ShopName
FROM Box_discount AS bd
JOIN Wines AS w ON w.WineID = bd.WineID
JOIN Shops AS s ON s.ShopID = bd.ShopID
JOIN Staff AS st ON bd.StaffID = st.StaffID;

SELECT * FROM Box_bonus; #This give us a lot of useful information about the boxes of wine sold

#But in order to pay staff their bonuses you really only need their name and how many boxes they have sold
CREATE VIEW Staff_bonus
AS
SELECT bb.StaffName, SUM(bb.Number_of_boxes) AS boxes_sold
FROM Box_bonus AS bb
GROUP BY bb.StaffName;

SELECT * FROM Staff_bonus;
 
	#Prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis
#Which wines have sold less than 300 bottles in total in 2023 across all three shops
SELECT sa.WineID, SUM(sa.Number_of_bottles_sold) AS Total_sold, w.WineName, w.Price
FROM Sales2023 AS sa
JOIN Wines AS w ON sa.WineID = w.WineID
GROUP BY WineID
HAVING SUM(sa.Number_of_bottles_sold) < 300;
