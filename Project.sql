-- CREATING TABLES AND INDEXES

create table GunTypes (  -- HERE WILL BE ALL GUNTYPES THAT WILL BE IN TABLES
    GunTypeID int identity (1,1) primary key,
    Name varchar(50)
)
create unique index idx_GunTypes_Name on GunTypes(Name)

create table Products (  -- INFORMATION ABOUT ALL WEAPONS THAT ARE/WERE IN STOCK
    ProductID int identity(1,1) primary key,
    Name varchar(50) not null,
    Country varchar(50),
    Cartridge varchar(50),
    Year varchar(70),
    UnitPrice int not null,
    QuantityInStock int,
    GunTypeID int Foreign Key references GunTypes(GunTypeID),
    Description varchar(500),
)
create index idx_Products_Name on Products(Name)
create index idx_Products_GunTypeID on Products(GunTypeID)

create table Transactions (  -- INFORMATION ABOUT ALL TRANSACTIONS LIKE BUY/SELL
    TransactionID int identity(1,1) primary Key,
    ProductID int foreign key references Products(ProductID),
    TransactionType varchar(4),
    Quantity int not null,
    TransactionDate date default getdate(),
)
create index idx_Transactions_ProductID on Transactions(ProductID)
create index idx_Transactions_TransactionDate on Transactions(TransactionDate)

create table Customers (  -- INFORMATION ABOUT CUSTOMERS
    CustomerID int identity(1,1) primary key,
    FirstName varchar(20) not null,
    Address varchar(70),
    Email varchar(255),
    Phone varchar(25)
)

create table Orders (  -- INFORMATION ABOUT ORDERS ( 'SELL' TYPE IN TRANSACTIOINS TABLE )
    OrderID int identity(1,1) Primary Key,
    CustomerID int Foreign Key references Customers(CustomerID),
    OrderDate date default getdate(),
    TotalAmount int not null,
    TransactionID int foreign key references Transactions(TransactionID)
)

create table OrderItems (  -- MORE INFORMATION ABOUT ORDERED PRODUCTS
    OrderItemID int identity(1,1) Primary Key,
    OrderID int Foreign Key references Orders(OrderID),
    ProductID int Foreign Key references Products(ProductID),
    Quantity int not null,
    UnitPrice int not null
)

create table Employees (  -- INFORMATIOIN ABOUT EMPLOYEES
    EmployeeID int identity(1,1) Primary Key,
    FirstName varchar(20) not null,
    Position varchar(15) not null,
    Salary int
)

create table Suppliers (  -- INFORTMAION ABOUT SUPPLIERS
    SupplierID int identity(1,1) Primary Key,
    Name varchar(20) not null,
    ContactPerson varchar(20) not null,
    ContactNumber varchar(25),
    Address varchar(70)
)

create table Inventory (  -- INFORMATION ABOUT BOUGHT ITEMS ( 'BUY' TYPE IN TRANSACTIONS TABLE )
    InventoryID int identity(1,1) primary key,
    ProductID int Foreign Key references Products(ProductID),
    SupplierID int Foreign Key references Suppliers(SupplierID),
    QuantityReceived int,
    TransactionID int foreign key references Transactions(TransactionID),
    ReceivedDate date
)

-- WEAPONS SORTERED IN TABLES BY THEIR TYPE

create table Handguns (
    ProductID int identity(1,1) foreign key references Products(ProductID),
    Name varchar(40) not null,
    Manufacturer varchar(70),
    Country varchar(50),
    Cartridge varchar(50),
    Year varchar(20),
    Mass varchar(100)
)

create table Rifles (
    ProductID int identity(1,1) foreign key references Products(ProductID),
    Name varchar(40) not null,
    [Manufacturer] varchar(70),
    Country varchar(50),
    Cartridge varchar(50),
    Year varchar(70),
    Mass varchar(160),
)

create table Shotguns (
    ProductID int identity(1,1) foreign key references Products(ProductID),
    Name varchar(40) not null,
    Manufacturer varchar(70),
    Country varchar(50),
    Cartridge varchar(50),
    Year varchar(20),
    Mass varchar(120)
)

create table AssaultRifles (
    ProductID int identity(1,1) foreign key references Products(ProductID),
    Name varchar(30) not null,
    Manufacturer varchar(70),
    Country varchar(50),
    Cartridge varchar(50),
    Year varchar(20),
    Mass varchar(100)
)

create table MachineGuns (
    ProductID int identity(1,1) foreign key references Products(ProductID),
    Name varchar(50) not null,
    Manufacturer varchar(110),
    Country varchar(50),
    Cartridge varchar(50),
    Feed varchar(50),
    Year varchar(20),
    Mass varchar(100)
)

create table Revolvers (
    ProductID int identity(1,1) foreign key references Products(ProductID),
    Name varchar(50) not null,
    Manufacturer varchar(70),
    Country varchar(50),
    Cartridge varchar(60),
    Chambers varchar(30),
    Year varchar(20),
    Mass varchar(100)
)

-- INSERTING THE VALUES

insert into GunTypes(Name)
Values ('HandGun'), ('Rifle'), ('Shotgun'), ('AssaultRifle'), ('MachineGun'), ('Revolver')

insert into Products(name, country, cartridge, year, unitprice, quantityinstock, guntypeid, description)
Values ('2mm Kolibri', 'Austrian Empire, Kingdom of Hungary', '2,7 mm', '1914 only', 7000, 3, 1, 'The smallest commercially available centerfire cartridge introduced in 1914.'),
    ('Akdal Ghost TR01', 'Turkey', '9×19mm Parabellum', '1990-present', 550, 14, 1, 'Compact semi-automatic pistol designed for security and law enforcement.'),
    ('ALFA Combat', 'Czechoslovakia', '9×19mm Parabellum, .40 S&W, .45 ACP', '1980' , 821, 1, 1, 'Czech-made semi-automatic pistol for military, law enforcement, and sport shooting.'),
    ('ALFA Defender', 'Czechoslovakia', '9×19mm Parabellum, .40 S&W, .45 ACP', null, 800, 0, 1, 'Czech-made semi-automatic pistol for military, law enforcement, and sport shooting.'),
    ('AMT AutoMag II', 'United States', '.22 Winchester Magnum Rimfire', '1987-1999', 900, 2, 1, 'Semi-automatic handgun chambered in .22 WMR, produced from 1987 to 1999.'),
    ('AMT AutoMag III', 'United States', '.30 Carbine 9mm Winchester Magnum', '1992-2001', 1100, 5, 1, 'Single action semi-automatic pistol chambered in .30 Carbine 9mm Winchester Magnum, produced from 1992 to 2001.'),
    ('Arsenal Firearms AF1 "Strike One"', 'Russia, Italy', '9×19mm Parabellum', '2012-present', 900, 21, 1, 'Polymer-framed, short recoil operated, striker-fired semi-automatic pistol introduced in 2012.'),
    ('Armatix iP1', 'Germany', '.22 Long Rifle', '2006', 1400, 17, 1, 'Magazine-fed semi-automatic pistol chambered for .22 Long Rifle cartridge.'),
    ('Colt C-19', 'Finland', '7.62×51mm NATO, 308 Winchester', '2015', 2500, 23, 2, 'Finnish-designed bolt-action rifle modified for the Canadian Rangers, introduced in 2015.'),
    ('CMMG Mk47 Mutant', 'United States', '7.62×39mm', '2014', 1500, 20, 2, 'Rifle chambered in 7.62×39mm, released in 2014.'),
    ('Smith & Wesson M&P10', 'United States', '.308 Winchester, 7.62×51mm NATO', '2013', 1350, 15, 2, ' Semi-automatic rifles based on the AR-10, introduced in 2013.'),
    ('Smith & Wesson M&P15-22', 'United States', '.22 Long Rifle', '2013', 450, 21, 2, '.22 Long Rifle variant of the M&P15 semi-automatic rifle, introduced in 2013.'),
    ('AK-47', 'Soviet Union', '7.62×39mm', '1949–1974 (Soviet Union), 1949–present (other countries)', 1000, 50, 2, 'Gas-operated assault rifle chambered for 7.62×39mm, produced from 1949 to present.'),
    ('35M rifle', 'Hungary', '7.92×57mm Mauser 8×56mmR', '1935', 1700, 0, 2, 'Bolt-action rifle chambered in 8×56mmR, introduced in 1935.'),
    ('1792 contract rifle', 'United States', '.49 in lead ball', '1792', 3000, 1, 2, 'Collection of rifles bought by the United States government in 1792.'),
    ('Albini-Braendlin rifle', 'Belgium', '11mm', '1867', 2200, 2, 2, 'Single-shot 11mm rifle adopted by Belgium in 1867.'),
    ('UTAS UTS-15', 'Turkey', '12 gauge', '2012', 1100, 3, 3, 'Pump-action shotgun with two 7-round magazine tubes, introduced in 2012.'),
    ('M26 Modular Accessory Shotgun System', 'United States', '12 gauge', '2002', 1500, 7, 3, 'Shotgun configured as an underbarrel ancillary weapon attachment, introduced in 2002.'),
    ('MAG-7', 'South Africa', '12 gauge', '1995', 900, 9, 3, 'Close quarters combat (CQC) weapon combining aspects of a submachine gun and a pump-action shotgun, introduced in 1995.'),
    ('Double-barreled shotgun', 'United Kingdom', '10 gauge, 12 gauge', '1875', 1200, 1, 3, 'Break-action shotgun with two parallel barrels, introduced in 1875.'),
    ('M1216', 'United States', '12 gauge', '2010', 2000, 6, 3, 'Delayed blowback semi-automatic shotgun with a 16-round detachable revolver magazine, introduced in 2010.'),
    ('Saiga-12', 'Russia', '12 gauge, 20 gauge, .410 bore', '1990s', 1000, 2, 3, 'Shotgun patterned after the Kalashnikov series of rifles, introduced in the 1990s.'),
    ('Winchester Model 1912', 'United States', '12 gauge, 16 gauge, 20 gauge, 28 gauge', '1912', 650, 0, 3, 'Internal-hammer pump-action shotgun with an external tube magazine, introduced in 1912.'),
    ('Benelli Nova', 'Italy', '12 gauge, 20 gauge', '1999', 500, 12, 3, 'Pump-action shotgun used for hunting and self-defense, introduced in 1999.'),
    ('Sturmgewehr 44', 'Nazi Germany', '7.92×33mm Kurz', '1943', 5200, 2, 4, 'Iconic Nazi rifle chambered in 7.92×33mm Kurz, introduced in 1943.'),
    ('AN-94', 'Russia', '5.45×39mm', '1994', 5500, 8, 4, 'Russian rifle chambered in 5.45×39mm, featuring a unique two-round burst mechanism.'),
    ('QBZ-95', 'China', '5.8×42mm DBP87', '1995', 2200, 18, 4, 'Chinese rifle chambered in 5.8×42mm DBP87, known for its bullpup design and reliability.'),
    ('FAMAS', 'France', '5.56×45mm NATO', '1978', 3400, 6, 4, 'French bullpup rifle chambered in 5.56×45mm NATO, renowned for its compact size.'),
    ('IMBEL IA2', 'Brazil', '5.56×45mm NATO, 7.62×51mm NATO', '2015', 1300, 43, 4, 'Brazilian rifle chambered in 5.56×45mm NATO and 7.62×51mm NATO, offering versatility and performance.'),
    ('CZ 805 BREN', 'Czech Republic', '5.56×45mm NATO, 7.62×39mm', '2009', 1950, 31, 4, 'Czech rifle chambered in 5.56×45mm NATO and 7.62×39mm, known for reliability and modular design.'),
    ('HK416', 'Germany', '5.56×45mm NATO', '2004', 2900, 24, 4, 'German rifle chambered in 5.56×45mm NATO, highly regarded for accuracy and reliability.'),
    ('SIG MCX', 'United States', '5.56×45mm NATO, .300 AAC Blackout, 7.62×39mm', '2015', 1900, 41, 4, 'American modular rifle chambered in various calibers, offering versatility and adaptability.'),
    ('M249 light machine gun', 'Belgium / United States', '5.56×45mm NATO', '1984', 6000, 5, 5, 'Light machine gun used by the United States military, known for its reliability and versatility.'),
    ('MG 42', 'Nazi Germany', '7.92×57mm Mauser', '1942', 31000, 2, 5, 'General-purpose machine gun chambered for 7.92×57mm Mauser, widely used by German forces during World War II.'),
    ('MG3', 'West Germany', '7.62×51mm NATO', '1958', 3500, 1, 5, 'West German general-purpose machine gun derived from the MG 42, widely used internationally.'),
    ('Type 99 machine gun', 'Japan', '7.7×58mm Arisaka', '1939', 5500, 9, 5, 'Japanese light machine gun used during World War II, known for its reliability and accuracy.'),
    ('Lewis gun', 'United Kingdom', '.303 British', '1914', 4200, 0, 5, 'British light machine gun used during World War I, known for its cooling system and reliability.'),
    ('MG 34', 'Nazi Germany', '7.92×57mm Mauser', '1936', 2300, 1, 5, 'German general-purpose machine gun used during World War II, known for its advanced design.'),
    ('M60 machine gun', 'United States', '7.62×51mm NATO', '1957', 4800, 4, 5, 'General-purpose machine gun used by the United States military, known for its durability and firepower.'),
    ('Degtyaryov machine gun', 'Soviet Union', '7.62×54mmR', '1927', 3000, 2, 5, 'Soviet light machine gun used during World War II, known for its simplicity and ruggedness.'),
    ('Smith & Wesson Model 686', 'United States', '.357 Magnum', '1981', 900, 4, 6, 'Classic double-action revolver chambered in .357 Magnum, renowned for reliability and accuracy.'),
    ('Colt Python', 'United States', '.357 Magnum', '1955', 1200, 2, 6, 'Iconic revolver known for its sleek design and smooth action, chambered in .357 Magnum.'),
    ('Ruger GP100', 'United States', '.357 Magnum', '1985', 800, 8, 6, 'Rugged and dependable revolver chambered in .357 Magnum, suitable for sport shooting and self-defense.'),
    ('Taurus Raging Bull', 'Brazil', '.44 Magnum', '1997', 1000, 18, 6, 'Powerful revolver chambered in .44 Magnum, designed for heavy-duty use.'),
    ('Smith & Wesson Model 500', 'United States', '.500 S&W Magnum', '2003', 1500, 24, 6, 'One of the most powerful production revolvers in the world, chambered in .500 S&W Magnum.'),
    ('Chiappa Rhino', 'Italy', '.357 Magnum', '2009', 1100, 37, 6, 'Unique revolver with a bottom-aligned barrel, chambered in .357 Magnum.'),
    ('Dan Wesson Model 15', 'United States', '.357 Magnum', '1968', 1000, 3, 6, 'Classic revolver known for accuracy and versatility, chambered in .357 Magnum.'),
    ('Ruger Redhawk', 'United States', '.44 Magnum', '1979', 850, 1, 6, 'Reliable and rugged revolver chambered in .44 Magnum, suitable for hunting ')

insert into Handguns (name, Manufacturer, Country, cartridge, year, mass)
Values ('2mm Kolibri', 'Kolibri', 'Austrian Empire, Kingdom of Hungary', '2,7 mm', '1914 only', '0.2 g (3 gr)'),
    ('Akdal Ghost TR01', 'Akdal Arms', 'Turkey', '9×19mm Parabellum', '1990-present', '750 g (26 oz)'),
    ('ALFA Combat', 'ALFA', 'Czechoslovakia', '9×19mm Parabellum, .40 S&W, .45 ACP', '1980', '850 g (1.8 lbs)'),
    ('ALFA Defender', 'Alfa Proj', 'Czechoslovakia', '9×19mm Parabellum, .40 S&W, .45 ACP', null, '750 g (1.6 lb)'),
    ('AMT AutoMag II', 'Arcadia Machine and Tool', 'United States', '.22 Winchester Magnum Rimfire', '1987-1999', '32 oz (910 g)'),
    ('AMT AutoMag III', 'Arcadia Machine & Tool', 'United States', '.30 Carbine 9mm Winchester Magnum', '1992-2001', '43 oz (1,200 g)'),
    ('Armatix iP1', 'Armatix GmbH', 'Germany', '.22 Long Rifle', '2006', '518 grams (without magazine)'),
    ('Arsenal Firearms AF1 "Strike One"', 'Arsenal Firearms', 'Russia, Italy', '9×19mm Parabellum', '2012-present', '750 g (26.5 oz) (polymer frame), 890 g (31.4 oz) (Ergal frame), 700 g (24.7 oz) Combat version')

insert into Rifles (name, manufacturer, country, cartridge, year, mass)
values ('35M rifle', null, 'Hungary', '7.92×57mm Mauser 8×56mmR', '1935', '3.98 kilograms (8.8 lb)'),
    ('1792 contract rifle', 'Primarily Pennsylvania gunsmiths', 'United States', '.49 in lead ball', '1792', '22.7 kg (50 lb)'),
    ('Albini-Braendlin rifle', 'Manufacture d’Armes de L’État', 'Belgium', '11mm', '1867', '4 kg (9 lb)'),
    ('Colt C-19', 'Colt Canada', 'Finland', '7.62×51mm NATO, .308 Winchester', '2015', '4.0 kg (8.8 lb)'),
    ('CMMG Mk47 Mutant', 'CMMG Inc.', 'United States', '7.62×39mm', '2014', '3.18 kg (7 lb)'),
    ('Smith & Wesson M&P10', 'Smith & Wesson', 'United States', '.308 Winchester, 7.62×51mm NATO', '2013', '3.50 kg (7.71 lb), 4.11 kg (9.05 lb) Performance Center variant'),
    ('Smith & Wesson M&P15-22', 'Smith & Wesson', 'United States', '.22 Long Rifle', '2013', '5.5 lbs / 2.5 kg'),
    ('AK-47', 'Kalashnikov Concern and various others including Norinco', 'Soviet Union', '7.62×39mm', '1949–1974 (Soviet Union), 1949–present (other countries)', 'Without magazine: 3.47 kg (7.7 lb) Magazine, empty: 0.43 kg (0.95 lb), 0.33 kg (0.73 lb) (steel), 0.25 kg (0.55 lb) (plastic), 0.17 kg (0.37 lb) (light alloy)')

insert into Shotguns(name, manufacturer, country, cartridge, year, mass)
values ('UTAS UTS-15', 'UTAS', 'Turkey', '12 gauge', '2012', '6.9 lb (3.1 kg) empty'),
    ('M26 Modular Accessory Shotgun System', 'C-More Competition', 'United States', '12 gauge', '2002', '3 lb (1.36 kg) underbarrel, 5 lb (2.26 kg) with collapsible stock, 3.5 lb (1.58 kg) with stock removed'),
    ('MAG-7', 'Armsel', 'South Africa', '12 gauge', '1995', '4 kg (8.2 lb)'),
    ('Double-barreled shotgun', null, 'United Kingdom', '10 gauge, 12 gauge', '1875', '2.7 kg (6 lb)'),
    ('M1216', 'SRM Arms', 'United States', '12 gauge', '2010', '7.25 lbs (3.29 kg)'),
    ('Saiga-12', 'Kalashnikov Concern', 'Russia', '12 gauge, 20 gauge, .410 bore', '1990s', '3.6 kg (7.9 lb) (Saiga-12, Saiga-12S), 3.5 kg (7.7 lb) (Saiga-12K, Saiga-12S EXP-01)'),
    ('Winchester Model 1912', 'Winchester Repeating Arms Company', 'United States', '12 gauge, 16 gauge, 20 gauge, 28 gauge', '1912', '3.2 kg (7 lb)'),
    ('Benelli Nova', 'Benelli', 'Italy', '12 gauge, 20 gauge', '1999', '8 lbs. (3.63kg)')

insert into Machineguns(name, Manufacturer, Country, cartridge, feed, year, mass)
values ('MG 42', 'Mauser Werke', 'Nazi Germany', '7.92×57mm Mauser', 'Belt', '1942', '11.57 kg (25.5 lb) empty'),
    ('M249 light machine gun', 'FN Herstal', 'Belgium / United States', '5.56×45mm NATO', 'Belt or box magazine', '1984', '7.5 kg (17 lb) empty'),
    ('MG3', 'Rheinmetall', 'West Germany', '7.62×51mm NATO', 'Belt fed', '1958', '11.5 kg (25 lb) empty'),
    ('Type 99 machine gun', 'Various', 'Japan', '7.7×58mm Arisaka', 'Belt', '1939', '15 kg (33 lb) empty'),
    ('Lewis gun', 'The Birmingham Small Arms Company Limited (BSA), Savage Arms, Royal Small Arms Factory', 'United Kingdom', '.303 British', 'Pan', '1914', '12.7 kg (28 lb) empty'),
    ('MG 34', 'Mauser Werke', 'Nazi Germany', '7.92×57mm Mauser', 'Belt', '1936', '12.1 kg (27 lb) empty'),
    ('M60 machine gun', 'Various including Saco Defense, Maremont Corporation, General Electric, US Ordnance, Ohio Ordnance Works Inc.', 'United States', '7.62×51mm NATO', 'Belt fed', '1957', '10.43 kg (23 lb) empty'),
    ('Degtyaryov machine gun', 'Various', 'Soviet Union', '7.62×54mmR', 'Belt', '1927', '9.7 kg (21 lb) empty');

insert into Revolvers(Name, Manufacturer, Country, Cartridge, Chambers, Year, Mass)
values ('Smith & Wesson Model 686', 'Smith & Wesson', 'United States', '.357 Magnum', '6', '1981', '1.24 kg (43.7 oz)'),
    ('Colt Python', 'Colt Manufacturing Company', 'United States', '.357 Magnum', '6', '1955', '1.22 kg (43 oz)'),
    ('Ruger GP100', 'Sturm, Ruger & Co.', 'United States', '.357 Magnum', '6', '1985', '1.36 kg (48 oz)'),
    ('Taurus Raging Bull', 'Taurus International', 'Brazil', '.44 Magnum', '6', '1997', '1.63 kg (57 oz)'),
    ('Smith & Wesson Model 500', 'Smith & Wesson', 'United States', '.500 S&W Magnum', '5', '2003', '1.95 kg (69 oz)'),
    ('Chiappa Rhino', 'Chiappa Firearms', 'Italy', '.357 Magnum', '6', '2009', '0.9 kg (32 oz)'),
    ('Dan Wesson Model 15', 'Dan Wesson Firearms', 'United States', '.357 Magnum', '6', '1968', '1.52 kg (54 oz)'),
    ('Ruger Redhawk', 'Sturm, Ruger & Co.', 'United States', '.44 Magnum', '6', '1979', '1.36 kg (48 oz)')

insert into AssaultRifles (name, manufacturer, country, cartridge, year, mass)
values ('Sturmgewehr 44', 'Various including C. G. Haenel, Junker, and Walther', 'Nazi Germany', '7.92×33mm Kurz', '1943', '4.62 kg (10.2 lb) empty'),
    ('AN-94', 'Izhmash', 'Russia', '5.45×39mm', '1994', '3.85 kg (8.5 lb) empty'),
    ('QBZ-95', 'Norinco', 'China', '5.8×42mm DBP87', '1995', '3.25 kg (7.2 lb) empty'),
    ('FAMAS', 'MAS', 'France', '5.56×45mm NATO', '1978', '3.61 kg (7.96 lb) empty'),
    ('IMBEL IA2', 'Indústria de Material Bélico do Brasil', 'Brazil', '5.56×45mm NATO, 7.62×51mm NATO', '2015', '3.8 kg (8.4 lb) empty'),
    ('CZ 805 BREN', 'Česká zbrojovka Uherský Brod', 'Czech Republic', '5.56×45mm NATO, 7.62×39mm', '2009', '3.6 kg (7.9 lb) empty'),
    ('HK416', 'Heckler & Koch', 'Germany', '5.56×45mm NATO', '2004', '3.07 kg (6.8 lb) empty'),
    ('SIG MCX', 'SIG Sauer', 'United States', '5.56×45mm NATO, .300 AAC Blackout, 7.62×39mm', '2015', '2.7 kg (6.0 lb) empty')

insert into Customers(firstname, address, email, phone)
values ('Jeff', '123 Maple Street', 'Jeff123@gmail.com', '051-042-124'),
    ('Bob', '456 Oak Avenue', 'Bob1021@gmail.com', '153-123-001'),
    ('Monika', '789 Pine Lane', 'Monika1531@gmail.com', '231-999-911'),
    ('Murad', '321 Birch Boulevard', 'Murad1482@gmail.com', '294-644-311'),
    ('Araz', '654 Cedar Court', 'Bill9244@gmail.com', '544-642-772'),
    ('Mark', '987 Elm Street', 'Mark9022@gmail.com', '910-944-345'),
    ('Myke', '159 Spruce Drive', 'Myke1924@gmail.com', '101-111-999'),
    ('Paul', '753 Walnut Way', 'Paul2421@gmail.com', '788-990-386')

insert into Suppliers(name, contactperson, contactnumber, address)
values ('Supplier1', 'Jack', '456-789-0123', '321 Main Street'),
    ('Supplier2', 'Emma', '567-890-1234', '456 Elm Avenue'),
    ('Supplier3', 'Chris', '678-901-2345', '789 Oak Boulevard'),
    ('Supplier4', 'Scarlett', '789-012-3456', '910 Pine Street'),
    ('Supplier5', 'Tom', '890-123-4567', '111 Maple Drive'),
    ('Supplier6', 'Zendaya', '901-234-5678', '222 Cedar Lane'),
    ('Supplier7', 'Chris', '012-345-6789', '333 Birch Road'),
    ('Supplier8', 'Brie', '123-456-7890', '444 Walnut Court')

insert Employees(firstName, position, salary)
values
    ('John', 'Manager', 72000),
    ('Jane', 'Sales', 45000),
    ('Alice', 'Accountant', 40000),
    ('Michael', 'Technician', 42000),
    ('Laura', 'HR', 46000),
    ('David', 'IT Specialist', 49000)

insert into Transactions (ProductID, TransactionType, Quantity, TransactionDate)
select p.ProductID, t.TransactionType, t.Quantity, t.TransactionDate
from (values
    ('2mm Kolibri', 'buy', 10, '2024-01-01'),
    ('Akdal Ghost TR01', 'buy', 15, '2024-01-01'),
    ('AK-47', 'buy', 120, '2024-01-01'),
    ('2mm Kolibri', 'sell', 7, '2024-01-02'),
    ('Akdal Ghost TR01', 'sell', 1, '2024-01-02'),
    ('AMT AutoMag III', 'buy', 13, '2024-01-03'),
    ('AK-47', 'sell', 20, '2024-01-03'),
    ('ALFA Defender', 'buy', 7, '2024-01-04'),
    ('ALFA Combat', 'buy', 3, '2024-01-04'),
    ('AK-47', 'sell', 40, '2024-01-04'),
    ('AMT AutoMag III', 'sell', 8, '2024-01-05'),
    ('AMT AutoMag II', 'buy', 3, '2024-01-05'),
    ('ALFA Defender', 'sell', 7, '2024-01-06'),
    ('ALFA Combat', 'sell', 2, '2024-01-06'),
    ('AMT AutoMag II', 'sell', 1, '2024-01-07'),
    ('AK-47', 'sell', 10, '2024-01-07'),
    ('Colt C-19', 'buy', 31, '2024-01-08'),
    ('Smith & Wesson M&P10', 'buy', 21, '2024-01-08'),
    ('Smith & Wesson M&P15-22', 'buy', 40, '2024-01-09'),
    ('Colt C-19', 'sell', 8, '2024-01-09'),
    ('Smith & Wesson M&P15-22', 'sell', 11, '2024-01-10'),
    ('CMMG Mk47 Mutant', 'buy', 23, '2024-01-10'),
    ('Arsenal Firearms AF1 "Strike One"', 'buy', 39, '2024-01-10'),
    ('Armatix iP1', 'buy', 19, '2024-01-11'),
    ('Smith & Wesson M&P10', 'sell', 6, '2024-01-11'),
    ('Smith & Wesson M&P15-22', 'sell', 8, '2024-01-12'),
    ('35M rifle', 'buy', 5, '2024-01-12'),
    ('CMMG Mk47 Mutant', 'sell', 3, '2024-01-12'),
    ('Albini-Braendlin rifle', 'buy', 3, '2024-01-13'),
    ('1792 contract rifle', 'buy', 3, '2024-01-13'),
    ('Arsenal Firearms AF1 "Strike One"', 'sell', 18, '2024-01-14'),
    ('Armatix iP1', 'sell', 2, '2024-01-14'),
    ('UTAS UTS-15', 'buy', 9, '2024-01-14'),
    ('Double-barreled shotgun', 'buy', 5, '2024-01-15'),
    ('M26 Modular Accessory Shotgun System', 'buy', 8, '2024-01-15'),
    ('MAG-7', 'buy', 12, '2024-01-15'),
    ('Double-barreled shotgun', 'sell', 4, '2024-01-16'),
    ('M26 Modular Accessory Shotgun System', 'sell', 1, '2024-01-16'),
    ('M1216', 'buy', 13, '2024-01-16'),
    ('UTAS UTS-15', 'sell', 7, '2024-01-17'),
    ('MAG-7', 'sell', 3, '2024-01-17'),
    ('Saiga-12', 'buy', 14, '2024-01-18'),
    ('M1216', 'sell', 7, '2024-01-18'),
    ('Winchester Model 1912', 'buy', 10, '2024-01-19'),
    ('Benelli Nova', 'buy', 13, '2024-01-19'),
    ('Sturmgewehr 44', 'buy', 4, '2024-01-19'),
    ('Saiga-12', 'sell', 12, '2024-01-20'),
    ('Benelli Nova', 'sell', 1, '2024-01-20'),
    ('AN-94', 'buy', 16, '2024-01-20'),
    ('Winchester Model 1912', 'sell', 10, '2024-01-21'),
    ('QBZ-95', 'buy', 37, '2024-01-21'),
    ('Sturmgewehr 44', 'sell', 2, '2024-01-22'),
    ('AN-94', 'sell', 8, '2024-01-22'),
    ('QBZ-95', 'sell', 19, '2024-01-22'),
    ('FAMAS', 'buy', 18, '2024-01-23'),
    ('IMBEL IA2', 'buy', 50, '2024-01-23'),
    ('CZ 805 BREN', 'buy', 36, '2024-01-23'),
    ('FAMAS', 'sell', 12, '2024-01-24'),
    ('HK416', 'buy', 30, '2024-01-24'),
    ('IMBEL IA2', 'sell', 7, '2024-01-25'),
    ('CZ 805 BREN', 'sell', 5, '2024-01-25'),
    ('SIG MCX', 'buy', 43, '2024-01-25'),
    ('M249 light machine gun', 'buy', 11, '2024-01-26'),
    ('HK416', 'sell', 6, '2024-01-26'),
    ('MG 42', 'buy', 6, '2024-01-27'),
    ('SIG MCX', 'sell', 2, '2024-01-27'),
    ('M249 light machine gun', 'sell', 6, '2024-01-27'),
    ('MG3', 'buy', 2, '2024-01-28'),
    ('Type 99 machine gun', 'buy', 18, '2024-01-28'),
    ('MG 42', 'sell', 4, '2024-01-29'),
    ('Lewis gun', 'buy', 7, '2024-01-29'),
    ('MG3', 'sell', 1, '2024-01-30'),
    ('Type 99 machine gun', 'sell', 9, '2024-01-30'),
    ('MG 34', 'buy', 4, '2024-01-31'),
    ('M60 machine gun', 'buy', 10, '2024-01-31'),
    ('Lewis gun', 'sell', 7, '2024-01-31'),
    ('Degtyaryov machine gun', 'buy', 3, '2024-02-01'),
    ('MG 34', 'sell', 3, '2024-02-01'),
    ('M60 machine gun', 'sell', 6, '2024-02-01'),
    ('Smith & Wesson Model 686', 'buy', 16, '2024-02-02'),
    ('Colt Python', 'buy', 5, '2024-02-02'),
    ('Degtyaryov machine gun', 'sell', 1, '2024-02-03'),
    ('Ruger GP100', 'buy', 16, '2024-02-03'),
    ('Smith & Wesson Model 686', 'sell', 12, '2024-02-04'),
    ('Colt Python', 'sell', 3, '2024-02-04'),
    ('Taurus Raging Bull', 'buy', 20, '2024-02-05'),
    ('Ruger GP100', 'sell', 8, '2024-02-05'),
    ('Smith & Wesson Model 500', 'buy', 41, '2024-02-06'),
    ('Chiappa Rhino', 'buy', 50, '2024-02-06'),
    ('Taurus Raging Bull', 'sell', 2, '2024-02-06'),
    ('Smith & Wesson Model 500', 'sell', 17, '2024-02-07'),
    ('Dan Wesson Model 15', 'buy', 5, '2024-02-07'),
    ('Chiappa Rhino', 'sell', 13, '2024-02-08'),
    ('Ruger Redhawk', 'buy', 5, '2024-02-08'),
    ('Dan Wesson Model 15', 'sell', 2, '2024-02-09'),
    ('Ruger Redhawk', 'sell', 4, '2024-01-10')
) as t (ProductName, TransactionType, Quantity, TransactionDate)
join Products p on t.ProductName = p.Name

insert into Inventory(ProductID, SupplierID, QuantityReceived, TransactionID, ReceivedDate)
select p.ProductID, i.SupplierID, i.QuantityReceived, i.TransactionID, i.ReceivedDate
from (values
    ('2mm Kolibri', 1, 10, 1, '2024-01-01'),
    ('Akdal Ghost TR01', 3, 15, 2, '2024-01-01'),
    ('AK-47', 1, 50, 3, '2024-01-01'),
    ('AK-47', 5, 70, 3, '2024-01-01'),
    ('AMT AutoMag III', 2, 13, 6, '2024-01-03'),
    ('ALFA Defender', 2, 7, 8, '2024-01-04'),
    ('ALFA Combat', 2, 3, 9, '2024-01-04'),
    ('AMT AutoMag II', 2, 3, 12, '2024-01-05'),
    ('Colt C-19', 2, 31, 17, '2024-01-08'),
    ('Smith & Wesson M&P10', 2, 21, 18, '2024-01-08'),
    ('Smith & Wesson M&P15-22', 2, 40, 19, '2024-01-09'),
    ('CMMG Mk47 Mutant', 2, 23, 22, '2024-01-10'),
    ('Arsenal Firearms AF1 "Strike One"', 5, 39, 23, '2024-01-10'),
    ('Armatix iP1', 5, 19, 24, '2024-01-11'),
    ('35M rifle', 3, 5, 27, '2024-01-12'),
    ('Albini-Braendlin rifle', 3, 3, 29, '2024-01-13'),
    ('1792 contract rifle', 3, 3, 30, '2024-01-13'),
    ('UTAS UTS-15', 3, 9, 33, '2024-01-14'),
    ('Double-barreled shotgun', 3, 5, 34, '2024-01-15'),
    ('M26 Modular Accessory Shotgun System', 3, 8, 35, '2024-01-15'),
    ('MAG-7', 3, 12, 36, '2024-01-15'),
    ('M1216', 3, 13, 39, '2024-01-16'),
    ('Saiga-12', 3, 14, 42, '2024-01-18'),
    ('Winchester Model 1912', 3, 10, 44, '2024-01-19'),
    ('Benelli Nova', 3, 13, 45, '2024-01-19'),
    ('Sturmgewehr 44', 3, 46, 46, '2024-01-20'),
    ('AN-94', 1, 16, 49, '2024-01-20'),
    ('QBZ-95', 5, 37, 51, '2024-01-21'),
    ('FAMAS', 8, 18, 55, '2024-01-23'),
    ('IMBEL IA2', 5, 50, 56, '2024-01-23'),
    ('CZ 805 BREN', 2, 36, 57, '2024-01-23'),
    ('HK416', 3, 30, 59, '2024-01-24'),
    ('SIG MCX', 7, 43, 62, '2024-01-25'),
    ('M249 light machine gun', 5, 11, 63, '2024-01-26'),
    ('MG 42', 1, 6, 65, '2024-01-27'),
    ('MG3', 2, 2, 68, '2024-01-28'),
    ('Type 99 machine gun', 8, 18, 68, '2024-01-28'),
    ('Lewis gun', 4, 7, 71, '2024-01-29'),
    ('MG 34', 7, 4, 74, '2024-01-31'),
    ('M60 machine gun', 2, 10, 75, '2024-01-31'),
    ('Degtyaryov machine gun', 3, 3, 77, '2024-02-01'),
    ('Smith & Wesson Model 686', 8, 16, 80, '2024-02-02'),
    ('Colt Python', 6, 5, 81, '2024-02-02'),
    ('Ruger GP100', 1, 16, 82, '2024-02-03'),
    ('Taurus Raging Bull', 5, 20, 82, '2024-02-05'),
    ('Smith & Wesson Model 500', 2, 41, 88, '2024-02-06'),
    ('Chiappa Rhino', 8, 50, 89, '2024-02-06'),
    ('Dan Wesson Model 15', 6, 5, 92, '2024-02-07'),
    ('Ruger Redhawk', 4, 5, 98, '2024-02-08')
) as i (ProductName, SupplierID, QuantityReceived, TransactionID, ReceivedDate)
join Products p on i.ProductName = p.name
join Transactions t on i.TransactionID = t.TransactionID

insert into Orders(customerid, orderdate, totalamount, transactionid)
values (1, '2024-01-01', 7, 4),
       (1, '2024-01-02', 1, 5),
       (7, '2024-01-03', 20, 7),
       (2, '2024-01-04', 40, 10),
       (8, '2024-01-05', 8, 11),
       (3, '2024-01-06', 7, 13),
       (5, '2024-01-06', 2, 14),
       (6, '2024-01-07', 1, 15),
       (7, '2024-01-07', 10, 16),
       (1, '2024-01-09', 8, 20),
       (2, '2024-01-10', 11, 21),
       (4, '2024-01-11', 6, 25),
       (7, '2024-01-12', 8, 26),
       (1, '2024-01-12', 3, 28),
       (2, '2024-01-14', 18, 31),
       (6, '2024-01-14', 2, 32),
       (8, '2024-01-16', 4, 37),
       (2, '2024-01-16', 1, 38),
       (1, '2024-01-17', 7, 40),
       (5, '2024-01-17', 3, 41),
       (3, '2024-01-18', 7, 43),
       (8, '2024-01-20', 12, 47),
       (5, '2024-01-20', 1, 48),
       (1, '2024-01-21', 10, 50),
       (7, '2024-01-22', 2, 52),
       (3, '2024-01-22', 8, 53),
       (2, '2024-01-22', 19, 54),
       (8, '2024-01-24', 12, 58),
       (1, '2024-01-25', 7, 60),
       (3, '2024-01-25', 5, 61),
       (2, '2024-01-26', 6, 64),
       (7, '2024-01-27', 2, 66),
       (5, '2024-01-27', 6, 67),
       (4, '2024-01-29', 4, 70),
       (1, '2024-01-30', 1, 72),
       (2, '2024-01-30', 9, 73),
       (8, '2024-01-31', 7, 76),
       (6, '2024-02-01', 3, 78),
       (5, '2024-02-01', 6, 79),
       (2, '2024-02-03', 1, 82),
       (1, '2024-02-04', 12, 84),
       (4, '2024-02-04', 3, 85),
       (3, '2024-02-05', 8, 87),
       (8, '2024-02-06', 2, 90),
       (5, '2024-02-07', 17, 91),
       (7, '2024-02-08', 13, 93),
       (1, '2024-02-09', 2, 95),
       (4, '2024-02-10', 4, 96)

insert into OrderItems (orderid, productid, quantity, unitprice)
select o.OrderID, p.ProductID, oi.Quantity, oi.Unitprice
from (values
    (1, '2mm Kolibri', 7, 7000),
    (2, 'Akdal Ghost TR01', 1, 550),
    (3, 'AK-47', 20, 900),
    (4, 'AK-47', 20, 900),
    (5, 'AMT AutoMag III', 8, 1100),
    (6, 'ALFA Defender', 7, 800),
    (7, 'ALFA Combat', 2, 821),
    (8, 'AMT AutoMag II', 1, 900),
    (9, 'AK-47', 10, 900),
    (10, 'Colt C-19', 8, 2500),
    (11, 'Smith & Wesson M&P15-22', 11, 450),
    (12, 'Smith & Wesson M&P10', 6, 1350),
    (13, 'Smith & Wesson M&P15-22', 8, 450),
    (14, 'CMMG Mk47 Mutant', 3, 1500),
    (15, 'Arsenal Firearms AF1 "Strike One"', 18, 900),
    (16, 'Armatix iP1', 2, 1400),
    (17, 'Double-barreled shotgun', 4, 1200),
    (18, 'M26 Modular Accessory Shotgun System', 1, 1500),
    (19, 'UTAS UTS-15', 7, 1100),
    (20, 'MAG-7', 3, 900),
    (21, 'M1216', 7, 2000),
    (22, 'Saiga-12', 12, 1000),
    (23, 'Benelli Nova', 1, 500),
    (24, 'Winchester Model 1912', 10, 650),
    (25, 'Sturmgewehr 44', 2, 5200),
    (26, 'AN-94', 8, 5500),
    (27, 'QBZ-95', 19, 2200),
    (28, 'FAMAS', 12, 3400),
    (29, 'IMBEL IA2', 7, 1300),
    (30, 'CZ 805 BREN', 5, 1950),
    (31, 'HK416', 6, 2900),
    (32, 'SIG MCX', 2, 1900),
    (33, 'M249 light machine gun', 6, 6000),
    (34, 'MG 42', 4, 31000),
    (35, 'MG3', 1, 3500),
    (36, 'Type 99 machine gun', 9, 5500),
    (37, 'Lewis gun', 7, 4200),
    (38, 'MG 34', 3, 2300),
    (39, 'M60 machine gun', 6, 4800),
    (40, 'Degtyaryov machine gun', 1, 3000),
    (41, 'Smith & Wesson Model 686', 12, 900),
    (42, 'Colt Python', 3, 1200),
    (43, 'Ruger GP100', 8, 800),
    (44, 'Taurus Raging Bull', 2, 1000),
    (45, 'Smith & Wesson Model 500', 17, 1500),
    (46, 'Chiappa Rhino', 13, 1100),
    (47, 'Dan Wesson Model 15', 2, 1000),
    (48, 'Ruger Redhawk', 4, 850)
) as oi (OrderID, ProductName, Quantity, UnitPrice)
join Products p on oi.ProductName = p.Name
join Orders o on oi.orderid = o.OrderID

----------------------------------------------------------------------------------------------

create view vw_OrderTransactions as
select
    o.orderid,
    o.customerid,
    c.firstname as customer_name,
    o.orderdate,
    o.totalamount,
    t.transactionid,
    t.quantity,
    p.productid,
    p.name as product_name,
    p.unitprice
from
    orders o
join
    customers c on o.customerid = c.customerid
join
    transactions t on o.transactionid = t.transactionid
join
    products p on t.productid = p.productid


create view vw_OrderDetails as
select OrderID, TotalAmount
from Orders
union
select ProductID, UnitPrice
from OrderItems
join Orders O on OrderItems.OrderID = O.OrderID

------------------------------------------------------------------

create procedure GetEmployee -- 1
    @EmployeeID int as
    select EmployeeID, FirstName, Position, Salary
    from Employees
    where EmployeeID = @EmployeeID

create procedure NewEmployee --2
    @FirstName varchar(20),
    @Position varchar(15),
    @Salary int as
    insert into Employees (FirstName, Position, Salary)
    values (@FirstName, @Position, @Salary)

create procedure UpdateEmployeeSalary
    @EmployeeID int,
    @NewSalary int as
    update Employees
    set Salary = @NewSalary
    where EmployeeID = @EmployeeID

-------------------------------------------------------------------
-- I just realised that i could do this, instead of inserting those big values by myself :)
create trigger trg_InsertToTransactionsBuy  -- INSERTS VALUES TO TRANSACTIONS TABLE WHEN VALUES INSERTED TO INVENTORY TABLE
    on Inventory
    after insert
    as begin
    insert into Transactions (ProductID, TransactionType, Quantity, TransactionDate)
        select ProductID, 'buy', QuantityReceived, ReceivedDate
        from inserted
end
------------------
create trigger trg_InsertToTransactionsSell  -- INSERTS VALUES TO TRANSACTIONS TABLE WHEN VALUES INSERTED TO ORDERS TABLE
    on Orders
    after insert
    as begin
    insert into Transactions (ProductID, TransactionType, Quantity, TransactionDate)
        select oi.ProductID, 'sell', oi.Quantity, o.OrderDate
            from inserted o
        join
            OrderItems oi on o.OrderID = oi.OrderID
end
-------------------
create trigger trg_UpdateQuantityOnInventoryInsert
    on Inventory
    after insert
    as begin
    update p
        set p.QuantityInStock = p.QuantityInStock + i.QuantityReceived
        from Products p
        join inserted i on p.ProductID = i.ProductID
end
--------------------
create trigger trg_UpdateQuantityOnOrderItemInsert
    on OrderItems
    after insert
    as begin
    update p
        set p.QuantityInStock = p.QuantityInStock - i.quantity
        from Products p
        join inserted i on p.ProductID = i.ProductID;
end
-----------------------------------------------------------------------------------
create view vw_ProductsBelowAverageStock as
select
    ProductID,
    Name,
    QuantityInStock
from
    Products
where
    QuantityInStock < (select AVG(QuantityInStock)
        from Products
        where QuantityInStock is not null);
-----------------------
create view vw_TotalSalesPerProduct as
select
    p.ProductID,
    p.Name,
    sum(oi.Quantity) as TotalQuantitySold
from
    Products p
join
    OrderItems oi on p.ProductID = oi.ProductID
group by
    p.ProductID,
    p.Name;