CREATE TABLE address (
    AddressID NUMBER(10) PRIMARY KEY,
    AddressLine1 VARCHAR2(255),
    AddressLine2 VARCHAR2(255),
    City VARCHAR2(50),
    StateProvinceID NUMBER(10), -- 
    PostalCode VARCHAR2(20),
    SpatialLocation VARCHAR2(255), --
    rowguid VARCHAR2(200),
    ModifiedDate DATE,
    CONSTRAINT FK_StateProvinceID FOREIGN KEY (StateProvinceID) REFERENCES StateProvince (StateProvinceID)
);

CREATE TABLE StateProvince (
    StateProvinceID NUMBER(10) NOT NULL PRIMARY KEY,
    StateProvinceCode VARCHAR2(5),
    CountryRegionCode VARCHAR2(5),
    IsOnlyStateProvinceFlag NUMBER(1),
    Name VARCHAR2(255),
    TerritoryID NUMBER(10),
    rowguid VARCHAR2(200),
    ModifiedDate DATE
);


CREATE TABLE CountryRegion (
    CountryRegionCode VARCHAR2(12) PRIMARY KEY,
    Name VARCHAR2(255),
    ModifiedDate DATE
);


CREATE TABLE BusinessEntity (
    BusinessEntityID NUMBER(10) PRIMARY KEY,
    rowguid VARCHAR2(200),
    ModifiedDate DATE
);


CREATE TABLE BusinessEntityAddress (
    BusinessEntityID NUMBER(10) NOT NULL,
    AddressID NUMBER(10) NOT NULL,
    AddressTypeID NUMBER(10),
    rowguid VARCHAR2(200),
    ModifiedDate DATE,
    CONSTRAINT FK_BusinessEntity FOREIGN KEY (BusinessEntityID) REFERENCES BusinessEntity (BusinessEntityID),
    CONSTRAINT FK_Address FOREIGN KEY (AddressID) REFERENCES Address (AddressID)
);



CREATE TABLE Department (
    DepartmentID NUMBER(10) PRIMARY KEY,
    Name VARCHAR2(255),
    GroupName VARCHAR2(255),
    ModifiedDate DATE
);

CREATE TABLE EmailAddress (
    BusinessEntityID NUMBER(10) NOT NULL,
    EmailAddressID NUMBER(10) PRIMARY KEY,
    EmailAddress VARCHAR2(255),
    rowguid VARCHAR2(200),
    ModifiedDate DATE,
    CONSTRAINT FK_BusinessEntity_EmailAddress FOREIGN KEY (BusinessEntityID) REFERENCES BusinessEntity (BusinessEntityID)
);


CREATE TABLE Employee (
    BusinessEntityID NUMBER(10) NOT NULL PRIMARY KEY,
    NationalIDNumber VARCHAR2(20),
    LoginID VARCHAR2(50),
    OrganizationNode VARCHAR2(255),
    OrganizationLevel NUMBER(10),
    JobTitle VARCHAR2(100),
    BirthDate DATE,
    MaritalStatus CHAR(1),
    Gender CHAR(1),
    HireDate DATE,
    SalariedFlag NUMBER(1),
    VacationHours NUMBER(5),
    SickLeaveHours NUMBER(5),
    CurrentFlag NUMBER(1),
    rowguid VARCHAR2(200),
    ModifiedDate DATE,
    CONSTRAINT FK_BusinessEntity_Employee FOREIGN KEY (BusinessEntityID) REFERENCES BusinessEntity (BusinessEntityID)

);


CREATE TABLE EmployeeDepartmentHistory (
    BusinessEntityID NUMBER(10) NOT NULL,
    DepartmentID NUMBER(10) NOT NULL,
    ShiftID NUMBER(10),
    StartDate DATE,
    EndDate DATE,
    ModifiedDate DATE,
    CONSTRAINT PK_EmployeeDepartmentHistory PRIMARY KEY (BusinessEntityID, DepartmentID, StartDate),
    CONSTRAINT FK_EmployeeDepartmentHistory_Employee FOREIGN KEY (BusinessEntityID) REFERENCES Employee (BusinessEntityID),
    CONSTRAINT FK_EmployeeDepartmentHistory_Department FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID)
);



CREATE TABLE EmployeePayHistory (
    BusinessEntityID NUMBER(10),
    RateChangeDate DATE,
    Rate NUMBER(10, 2),
    PayFrequency NUMBER(2),
    ModifiedDate DATE,
    CONSTRAINT PK_EmployeePayHistory PRIMARY KEY (BusinessEntityID, RateChangeDate),
    CONSTRAINT FK_EmployeePayHistory_Employee FOREIGN KEY (BusinessEntityID) REFERENCES Employee (BusinessEntityID)
);

CREATE TABLE Person (
    BusinessEntityID NUMBER(10) NOT NULL PRIMARY KEY,
    PersonType VARCHAR2(12),
    NameStyle NUMBER(1),
    Title VARCHAR2(50),
    FirstName VARCHAR2(50),
    MiddleName VARCHAR2(50),
    LastName VARCHAR2(50),
    Suffix VARCHAR2(10),
    EmailPromotion NUMBER(1),
    AdditionalContactInfo VARCHAR2(200), -- CLOB XML extensos
    Demographics VARCHAR2(200), --  CLOB XML extensos
    rowguid VARCHAR2(200) ,
    ModifiedDate DATE
);

CREATE TABLE PersonPhone (
    BusinessEntityID NUMBER(10) NOT NULL,
    PhoneNumber VARCHAR2(20),
    PhoneNumberTypeID NUMBER(10),
    ModifiedDate DATE,
    CONSTRAINT PK_PersonPhone PRIMARY KEY (BusinessEntityID, PhoneNumber),
    CONSTRAINT FK_PersonPhone_Person FOREIGN KEY (BusinessEntityID) REFERENCES Person (BusinessEntityID)
);

CREATE TABLE ProductCategory (
    ProductCategoryID NUMBER(10) NOT NULL PRIMARY KEY,
    Name VARCHAR2(255),
    rowguid VARCHAR2(200),
    ModifiedDate DATE
);

CREATE TABLE ProductSubcategory (
    ProductSubcategoryID NUMBER(10) NOT NULL PRIMARY KEY,
    ProductCategoryID NUMBER(10),
    Name VARCHAR2(255),
    rowguid VARCHAR2(200),
    ModifiedDate DATE,
    CONSTRAINT FK_ProductSubcategory_ProductCategory FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory (ProductCategoryID)
);



CREATE TABLE Product (
    ProductID NUMBER(10) NOT NULL PRIMARY KEY,
    Name VARCHAR2(255),
    ProductNumber VARCHAR2(25),
    MakeFlag NUMBER(1),
    FinishedGoodsFlag NUMBER(1),
    Color VARCHAR2(15),
    SafetyStockLevel NUMBER(10),
    ReorderPoint NUMBER(10),
    StandardCost NUMBER(10, 2), -- 
    ListPrice NUMBER(10, 2), -- 
    Size VARCHAR2(10),
    SizeUnitMeasureCode VARCHAR2(3),
    WeightUnitMeasureCode VARCHAR2(3),
    Weight NUMBER(10, 2), -- 
    DaysToManufacture NUMBER(10),
    ProductLine VARCHAR2(12),
    Class VARCHAR2(12),
    Style VARCHAR2(10),
    ProductSubcategoryID NUMBER(10),
    ProductModelID NUMBER(10),
    SellStartDate DATE,
    SellEndDate DATE,
    DiscontinuedDate DATE,
    rowguid VARCHAR2(200),
    ModifiedDate DATE,
    CONSTRAINT FK_Product_ProductSubcategory FOREIGN KEY (ProductSubcategoryID) REFERENCES ProductSubcategory (ProductSubcategoryID)

);


-- en esquema DATA_WAREHOUSE

CREATE TABLE DATA_WAREHOUSE.Customers (
    CUSTOMERS_ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(255),
    EMAILADDRESS VARCHAR2(255),
    PHONENUMBER VARCHAR2(20),
    ADDRESSLINE1 VARCHAR2(255),
    CITY VARCHAR2(100),
    POSTALCODE VARCHAR2(20),
    STATE VARCHAR2(50),
    COUNTRY VARCHAR2(50),
    LOADING_DATE DATE
);

CREATE TABLE DATA_WAREHOUSE.PRODUCT (
    PRODUCTID NUMBER(10) PRIMARY KEY,
    NAME VARCHAR2(255),
    COLOR VARCHAR2(50),
    LISTPRICE NUMBER(10, 2),
    SUBCATEGORY VARCHAR2(100),
    CATEGORY VARCHAR2(100),
    LOADING_DATE DATE
);

CREATE TABLE DATA_WAREHOUSE.EMPLOYEES (
    EMPLOYEEID NUMBER(10) PRIMARY KEY,
    JOBTITLE VARCHAR2(255),
    GROUPNAME VARCHAR2(255),
    RATE NUMBER(10, 2),
    QUANTITY NUMBER(10),
    LOADING_DATE DATE
);
