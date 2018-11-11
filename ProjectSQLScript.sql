﻿CREATE DATABASE ElectronicSupermarket

USE [ElectronicSupermarket]
GO

CREATE TABLE [dbo].[WAREHOUSE](
			[PRODUCT_ID] [varchar] (255) PRIMARY KEY,
			[INSTOCK_QUANTITY] [int] NOT NULL
)

CREATE TABLE [dbo].[SUPPLIER](
			[SUPPLIER_ID] [varchar] PRIMARY KEY,
			[SUPPLIER_NAME] [nvarchar] (255) UNIQUE,
			[CONTACT_NAME] [nvarchar] (255),
			[SUPPLIER_PHONE] [varchar] (15),
			[SUPPLIER_EMAIL] [varchar] (255),
			[SUPPLIER_ADDRESS] [nvarchar] (255),
			[SUPPLIER_STATUS] [varchar] (50)
			CONSTRAINT chk_phone CHECK (SUPPLIER_PHONE NOT LIKE '%[^0-9]%')
)

CREATE TABLE [dbo].[CATEGORY](
			[CATEGORY_ID] [int] PRIMARY KEY,
			[CATEGORY_NAME] [nvarchar] (255) NOT NULL
)

CREATE TABLE [dbo].[PRODUCT](
			[PRODUCT_ID] [varchar] (255) PRIMARY KEY ,
			[PRODUCT_NAME] [nvarchar] (255) NOT NULL UNIQUE,
			[CATEGORY_ID] [int] ,
			[PRODUCT_IMAGE] [varbinary] (MAX),
			[PRODUCT_PRICE] [numeric] (18,3),
			[SUPPLIER_ID] [int],
			[PRODUCT_DESC] [nvarchar] (255),
			[PRODUCT_STATUS] [varchar] (50)
			FOREIGN KEY (PRODUCT_ID) REFERENCES WAREHOUSE(PRODUCT_ID),
			FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
)

UPDATE PRODUCT
SET PRODUCT_IMAGE =
      (SELECT * FROM OPENROWSET(BULK N'D:\Works\C#\Project\LTUDC5_PhatLongCuongThinh\laptopimg1.jpg', SINGLE_BLOB) AS P_IMAGE)
WHERE PRODUCT_ID = 'lptp001';

UPDATE PRODUCT
SET PRODUCT_IMAGE =
      (SELECT * FROM OPENROWSET(BULK N'D:\Works\C#\Project\LTUDC5_PhatLongCuongThinh\laptopimg2.jpg', SINGLE_BLOB) AS P_IMAGE)
WHERE PRODUCT_ID = 'lptp002';

CREATE TABLE [dbo].[STATISTIC](
			[STATISTIC_ID] [nvarchar] PRIMARY KEY,
			[STATISTIC_EMLOYEE] [nvarchar] (255) UNIQUE,
			[STATISTIC_BILL] [nvarchar] (255),
			[STATISTIC_PRICE] [int],
			[USER_ID] [nvarchar]
)

CREATE TABLE [dbo].[USER] (
			[USER_ID] [varchar] (255) PRIMARY KEY,
			[USER_NAME] [nvarchar] (255) NOT NULL UNIQUE,
			[USER_PASS] [varchar] (255) NOT NULL,
			[USER_TYPE] [varchar] (255),
			[USER_STATUS] [varchar] (50) NOT NULL
			FOREIGN KEY (USER_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
)

CREATE TABLE [dbo].[EMPLOYEE](
			[EMPLOYEE_ID] [varchar] (255) PRIMARY KEY ,
			[EMPLOYEE_NAME] [nvarchar] (255) NOT NULL UNIQUE,
			[EMPLOYEE_IMAGE] [varbinary] (MAX),
			[EMPLOYEE_EMAIL] [nvarchar] (255),
			[EMPLOYEE_PHONE] [varchar] (15),
			[EMPLOYEE_DATE] [datetime],
			[EMPLOYEE_ADDRESS] [nvarchar] (255)
			CONSTRAINT chk_phone CHECK (EMPLOYEE_PHONE NOT LIKE '%[^0-9]%')
)

CREATE TABLE [dbo].[BILL](
			[BILL_ID] [nvarchar] PRIMARY KEY,
			[USER_KEY] [nvarchar],
			[USER_NAME] [nvarchar],
			[PRODUCT_ID] [nvarchar],
			[EMPLOYEE_ID] [nvarchar],
			[BILL_DATE] [date],
			[BILL_METHOD] [nvarchar] (255),
			[BILL_PAY] [nvarchar] (255)	
)