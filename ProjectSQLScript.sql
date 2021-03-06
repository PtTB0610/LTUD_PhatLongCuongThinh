--TẠO CSDL ElectronicSupermarket
CREATE DATABASE ElectronicSupermarket
Go

USE [ElectronicSupermarket]
GO
--Tạo table WAREHOUSE
CREATE TABLE [dbo].[WAREHOUSE](
			[PRODUCT_ID] [varchar] (255) PRIMARY KEY,
			[INSTOCK_QUANTITY] [int] NOT NULL
)
GO

--Tạo Table SUPPILER
CREATE TABLE [dbo].[SUPPLIER](
			[SUPPLIER_ID] [int] PRIMARY KEY,
			[SUPPLIER_NAME] [nvarchar] (255) UNIQUE,
			[SUPPLIER_PHONE] [varchar] (15),
			[SUPPLIER_EMAIL] [varchar] (255),
			[SUPPLIER_ADDRESS] [nvarchar] (255),
			[SUPPLIER_STATUS] [varchar] (50)			
)
GO

--Tạo table Category
CREATE TABLE [dbo].[CATEGORY](
			[CATEGORY_ID] [int] PRIMARY KEY,
			[CATEGORY_NAME] [nvarchar] (255) NOT NULL,
			[CATEGORY_STATUS] [varchar] (50)
)
GO

CREATE TABLE [dbo].[PRODUCT](
			[PRODUCT_ID] [varchar] (255) PRIMARY KEY ,
			[PRODUCT_NAME] [nvarchar] (255) NOT NULL UNIQUE,
			[CATEGORY_ID] [int] ,
			[PRODUCT_IMAGE] [varchar] (255),
			[PRODUCT_PRICE] [numeric] (18,3),
			[SUPPLIER_ID] [int],
			[PRODUCT_DESC] [nvarchar] (255),
			[PRODUCT_STATUS] [varchar] (50)
)
GO

--Tạo table USER
CREATE TABLE [dbo].[USER] (
			[USER_ID] [varchar] (255) PRIMARY KEY,
			[USER_NAME] [varchar] (255) NOT NULL UNIQUE,
			[USER_PASS] [varchar] (255) NOT NULL,
			[USER_TYPE] [varchar] (255),
			[USER_STATUS] [varchar] (50) NOT NULL
)
GO




CREATE TABLE [dbo].[BILL] (
			[BILL_ID] [nvarchar] (255) PRIMARY KEY,
			[BILL_DATE] [datetime],
			[CUSTOMER_ID] [nvarchar] (255),
			[CUSTOMER_NAME] [nvarchar] (255),
			[PRODUCT_ID] [varchar] (255),
			[PRODUCT_NAME] [nvarchar] (255),
			[EMPLOYEE_ID] [varchar] (255),
			[EMPLOYEE_NAME] [nvarchar] (255),
			[PAYMENT_METHOD_ID][nvarchar] (255),			
)


CREATE TABLE [dbo].[CUSTOMER] (
			[CUSTOMER_ID] [nvarchar] (255) PRIMARY KEY,
			[CUSTOMER_NAME] [nvarchar] (255) NOT NULL UNIQUE,
			[CUSTOMER_EMAIL] [nvarchar] (255),
			[CUSTOMER_PHONE] [varchar] (15),
			[CUSTOMER_DATE] [datetime],
			[CUSTOMER_ADDRESS] [nvarchar] (255)
			
)



CREATE TABLE [dbo].[PAYMENT] (
			[PAYMENT_ID] [nvarchar] (255) PRIMARY KEY,
			[PAYMENT_NAME] [nvarchar] (255) NOT NULL UNIQUE,
			[DISCOUNT] [float]	
)



-- THONG KE VA NHAN VIEN
CREATE TABLE [dbo].[STATISTIC](
			[STATISTIC_ID] [nvarchar] (255) PRIMARY KEY,
			[STATISTIC_EMPLOYEE] [nvarchar] (255) UNIQUE,
			[STATISTIC_BILL] [nvarchar] (255),
			[STATISTIC_PRICE] [int],
			[USER_ID] [varchar] (255)
)

GO

CREATE TABLE [dbo].[EMPLOYEE](
			[EMPLOYEE_ID] [varchar] (255) PRIMARY KEY ,
			[EMPLOYEE_NAME] [nvarchar] (255) NOT NULL UNIQUE,
			[EMPLOYEE_EMAIL] [nvarchar] (255),
			[EMPLOYEE_PHONE] [varchar] (15),
			[EMPLOYEE_DATE] [datetime],
			[EMPLOYEE_ADDRESS] [nvarchar] (255)
)
GO







--Thêm ràng buộc kiểm tra cho SUPPLIER
ALTER TABLE [dbo].[SUPPLIER]
ADD CONSTRAINT chk_phone CHECK (SUPPLIER_PHONE NOT LIKE '%[^0-9]%');
GO

--Thêm khóa ngoại cho PRODUCT
ALTER TABLE [dbo].[PRODUCT]
ADD FOREIGN KEY (PRODUCT_ID) REFERENCES WAREHOUSE(PRODUCT_ID),
	FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID),
	FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID);
	GO

ALTER TABLE [dbo].[USER]
ADD FOREIGN KEY (USER_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID);
GO

ALTER TABLE [dbo].[BILL]
ADD FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
			FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
			FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID),
			FOREIGN KEY (CUSTOMER_NAME) REFERENCES CUSTOMER(CUSTOMER_NAME),
			FOREIGN KEY (PRODUCT_NAME) REFERENCES PRODUCT(PRODUCT_NAME),
			FOREIGN KEY (EMPLOYEE_NAME) REFERENCES EMPLOYEE(EMPLOYEE_NAME),
			FOREIGN KEY (PAYMENT_METHOD_ID) REFERENCES PAYMENT(PAYMENT_ID);

ALTER TABLE [dbo].[STATISTIC]
ADD FOREIGN KEY (USER_ID) REFERENCES [dbo].[USER](USER_ID);
			
ALTER TABLE [dbo].[EMPLOYEE]
ADD CONSTRAINT chk_EMPphone CHECK (EMPLOYEE_PHONE NOT LIKE '%[^0-9]%');
GO

--Tạo StoreProcudure
--Lấy danh sách warehouse
CREATE PROC SP_LAYDSWAREHOUSE
AS SELECT * FROM [dbo].[WAREHOUSE]
GO
--Thêm vào danh sách warehouse
CREATE PROC SP_THEMDSWAREHOUSE(@P_ID varchar (255), @SLUONG int)
AS INSERT INTO [dbo].[WAREHOUSE](PRODUCT_ID,INSTOCK_QUANTITY)
VALUES (@P_ID,@SLUONG)
GO
--Xóa trong danh sách warehouse
CREATE PROC SP_XOAWAREHOUSE(@P_ID varchar (255))
AS DELETE FROM [dbo].[WAREHOUSE] WHERE WAREHOUSE.PRODUCT_ID = @P_ID
GO
--Sửa trong warehouse
CREATE PROC SP_SUAWAREHOUSE(@P_ID varchar (255), @SLUONG int)
AS UPDATE [dbo].[WAREHOUSE] SET INSTOCK_QUANTITY = @SLUONG WHERE PRODUCT_ID = @P_ID
GO
--Kiểm tra SP
exec SP_LAYDSWAREHOUSE
exec SP_THEMDSWAREHOUSE 'laptop001', 100
exec SP_THEMDSWAREHOUSE 'laptop002', 100
exec SP_XOAWAREHOUSE 'laptop002'
exec SP_SUAWAREHOUSE 'laptop001', 200
GO
--Tạo StoredProceduce
--Lấy tất cả Supplier
CREATE PROC SP_LAYTATCASUPPLIER
AS SELECT * FROM [dbo].[SUPPLIER]
GO
--Lấy danh sách Supplier
CREATE PROC SP_LAYDSSUPPLIER
AS SELECT * FROM [dbo].[SUPPLIER] WHERE SUPPLIER_STATUS = 'active'
GO
--Thêm vào Supplier
CREATE PROC SP_THEMSUPPLIER(@S_ID int , @S_NAME nvarchar (255),@S_PHONE varchar(15),
@S_EMAIL varchar (255), @S_ADDRESS nvarchar(255), @S_STATUS varchar(50))
AS INSERT INTO [dbo].[SUPPLIER](SUPPLIER_ID, SUPPLIER_NAME,SUPPLIER_PHONE, SUPPLIER_EMAIL, SUPPLIER_ADDRESS, SUPPLIER_STATUS)
VALUES (@S_ID, @S_NAME,@S_PHONE,@S_EMAIL,@S_ADDRESS,@S_STATUS)
GO
--Xóa Supplier (trạng thái = inactive)
CREATE PROC SP_XOASUPPLIER(@S_ID int)
AS UPDATE [dbo].[SUPPLIER]
SET SUPPLIER_STATUS = 'inactive' WHERE SUPPLIER_ID = @S_ID
GO
--Sửa Supplier
CREATE PROC SP_SUASUPPLIER(@S_ID int , @S_NAME nvarchar (255),@S_PHONE varchar(15),
@S_EMAIL varchar (255), @S_ADDRESS nvarchar(255), @S_STATUS varchar(50))
AS UPDATE [dbo].[SUPPLIER]
SET SUPPLIER_NAME = @S_NAME, SUPPLIER_PHONE = @S_PHONE, SUPPLIER_EMAIL = @S_EMAIL,
SUPPLIER_ADDRESS = @S_ADDRESS, @S_STATUS = @S_STATUS WHERE SUPPLIER_ID = @S_ID
GO
--Kiểm tra SP
exec SP_LAYTATCASUPPLIER
exec SP_LAYDSSUPPLIER
exec SP_THEMSUPPLIER 1,'ASUS',009009,'asus@email.com','123 some where','active'
exec SP_THEMSUPPLIER 2,'ACER',009009,'acer@email.com','123 some where','active'
exec SP_THEMSUPPLIER 3,'HP',009009,'hp@email.com','123 some where','inactive'
exec SP_XOASUPPLIER 1
exec SP_SUASUPPLIER 1,'ASUS',009009,'asus@email.com','123 some where','active'
GO
--Tạo StoreProceduce
--Lấy tất cả Category
CREATE PROC SP_LAYTATCACATEGORY
AS SELECT * FROM [dbo].[CATEGORY]
GO
--Lấy danh sách Category
CREATE PROC SP_LAYDSCATEGORY
AS SELECT * FROM [dbo].[CATEGORY] WHERE CATEGORY_STATUS = 'active'
GO
--Thêm vào CATEGORY
CREATE PROC SP_THEMCATEGORY(@C_ID int , @C_NAME nvarchar (255),@C_STATUS varchar(50))
AS INSERT INTO [dbo].[CATEGORY](CATEGORY_ID, CATEGORY_NAME,CATEGORY_STATUS)
VALUES (@C_ID, @C_NAME,@C_STATUS)
GO
--Xóa Category (trạng thái = inactive)
CREATE PROC SP_XOACATEGORY(@C_ID int)
AS UPDATE [dbo].[CATEGORY]
SET CATEGORY_STATUS = 'inactive' WHERE CATEGORY_ID = @C_ID
GO
--Sửa Category 
CREATE PROC SP_SUACATEGORY(@C_ID int,@C_NAME varchar (255), @C_STATUS varchar(50))
AS UPDATE [dbo].[CATEGORY]
SET CATEGORY_NAME = @C_NAME, CATEGORY_STATUS = @C_STATUS WHERE CATEGORY_ID = @C_ID
GO
--Kiểm tra SP
exec SP_LAYTATCACATEGORY
exec SP_LAYDSCATEGORY
exec SP_THEMCATEGORY 1,'Laptop','active'
exec SP_THEMCATEGORY 2,'Điện thoại','inactive'
exec SP_SUACATEGORY 2,'Máy Bàn','active'
GO
--Tạo StoreProcudure
--Lấy tất cả PRODUCT
CREATE PROC SP_LAYTATCAPRODUCT
AS SELECT * FROM [dbo].[PRODUCT]
GO
--Lấy danh sách PRODUCT active
CREATE PROC SP_LAYDSPRODUCT
AS SELECT * FROM [dbo].[PRODUCT] WHERE PRODUCT_STATUS = 'active'
GO
--Thêm vào danh sách PRODUCT
CREATE PROC SP_THEMDSPRODUCT(@P_ID varchar (255), @P_NAME nvarchar(255), @C_ID int , @P_IMAGE varchar(255),
@P_PRICE numeric (18,3), @S_ID int, @P_DESC nvarchar (255), @P_STATUS varchar (50))
AS INSERT INTO [dbo].[PRODUCT](PRODUCT_ID,PRODUCT_NAME,CATEGORY_ID,PRODUCT_IMAGE,PRODUCT_PRICE,SUPPLIER_ID,PRODUCT_DESC,PRODUCT_STATUS)
VALUES (@P_ID,@P_NAME,@C_ID,@P_IMAGE,@P_PRICE,@S_ID,@P_DESC,@P_STATUS)
GO
--Xóa PRODUCT (trạng thái = inactive)
CREATE PROC SP_XOAPRODUCT(@P_ID varchar (255))
AS UPDATE [dbo].[PRODUCT]
	SET PRODUCT_STATUS = 'inactive' WHERE PRODUCT_ID = @P_ID
GO
--Sửa trong PRODUCT
CREATE PROC SP_SUAPRODUCT(@P_ID varchar (255), @P_NAME nvarchar(255), @C_ID int , @P_IMAGE varchar (255),
@P_PRICE numeric (18,3), @S_ID int, @P_DESC nvarchar (255), @P_STATUS varchar (50))
AS UPDATE [dbo].[PRODUCT]
	SET PRODUCT_NAME = @P_NAME, CATEGORY_ID = @C_ID, PRODUCT_IMAGE = @P_IMAGE,
	PRODUCT_PRICE = @P_PRICE, SUPPLIER_ID = @S_ID, PRODUCT_DESC = @P_DESC, PRODUCT_STATUS = @P_STATUS WHERE PRODUCT_ID = @P_ID
GO
--Kiểm tra SP
exec SP_LAYTATCAPRODUCT
exec SP_LAYDSPRODUCT
exec SP_THEMDSPRODUCT 'laptop001','Laptop',1,'C:\abc.jpg',1500000,1,'Laptop Acer','active'
exec SP_THEMDSPRODUCT 'laptop002','Laptop 2',1,'C:\def.jpg',2000000,1,'Laptop Asus','active'
exec SP_XOAPRODUCT 'laptop001'
exec SP_SUAPRODUCT 'laptop001','Laptop',1,0,1500000,1,'Laptop Acer','active'
GO
--Lấy tất cả USER
CREATE PROC SP_LAYTATCAUSER
AS SELECT * FROM [dbo].[USER]
GO
--Lấy danh sách USER
CREATE PROC SP_LAYDSUSER
AS SELECT * FROM [dbo].[USER] WHERE USER_STATUS = 'active'
GO
--Thêm vào danh sách USER
CREATE PROC SP_THEMDSUSER(@U_ID varchar (255), @U_NAME varchar (255), @U_PASS varchar (255), @U_TYPE varchar (255),
@U_STATUS varchar (50))
AS INSERT INTO [dbo].[USER](USER_ID,USER_NAME,USER_PASS,USER_TYPE,USER_STATUS)
VALUES (@U_ID,@U_NAME,@U_PASS,@U_TYPE,@U_STATUS)
GO
--Xóa USER (trạng thái = inactive)
CREATE PROC SP_XOAUSER(@U_ID varchar (255))
AS UPDATE [dbo].[USER] SET USER_STATUS = 'inactive' WHERE USER_ID = @U_ID
GO
--Sửa trong USER
CREATE PROC SP_SUAUSER(@U_ID varchar (255), @U_NAME varchar (255), @U_PASS varchar (255), @U_TYPE varchar (255),
@U_STATUS varchar (50))
AS UPDATE [dbo].[USER] SET USER_NAME = @U_NAME, USER_PASS = @U_PASS, USER_TYPE = @U_TYPE,
 USER_STATUS = @U_STATUS WHERE USER_ID = @U_ID
GO
--Kiểm tra SP
exec SP_LAYTATCAUSER
exec SP_LAYDSUSER
exec SP_THEMDSUSER 'nv001','admin','admin','Admin','active'
exec SP_THEMDSUSER 'nv002','user1','user1','User','active'
exec SP_THEMDSUSER 'nv003','user2','user2','User','inactive'
exec SP_XOAUSER 'nv003'
exec SP_SUAUSER 'nv001','admin','admin','Admin','active'
exec SP_SUAUSER 'nv002','user1','user1','User','active'
exec SP_SUAUSER 'nv003','user2','user2','User','active'


--tao storeprodure
--lay danh sach hoa don
GO
CREATE PROC sp_LayDSBILL
AS
SELECT * FROM [dbo].BILL

--them danh sach trong hoa don
GO
CREATE PROC sp_ThemDSBILL(@billID nvarchar (255), @billDATE datetime, @cusID nvarchar (255), @cusName nvarchar (255),@proID varchar (255),@proName nvarchar (255), @empID varchar (255), @emplName nvarchar (255), @payMethod nvarchar (255))
as
INSERT INTO [dbo].BILL(BILL_ID,BILL_DATE, CUSTOMER_ID,CUSTOMER_NAME,PRODUCT_ID,PRODUCT_NAME,EMPLOYEE_ID,EMPLOYEE_NAME,PAYMENT_METHOD_ID)
VALUES (@billID, @billDATE, @cusID, @cusName, @proID, @proName, @empID, @emplName, @payMethod)

--xoa danh sach cua bang hoa don
GO
CREATE PROC sp_XoaDSBILL(@billID nvarchar (255))
AS
DELETE FROM [dbo].BILL WHERE BILL_ID = @billID

--sua danh sach trong hoa don
GO
CREATE PROC sp_SuaDSBILL (@billID nvarchar (255),@billDATE date)
AS
UPDATE [dbo].BILL SET BILL_DATE = @billDATE WHERE BILL_ID = @billID

--tao storeprocedure customer
--get list customer
GO
CREATE PROC sp_getDSCUSTOMER
AS
SELECT *FROM CUSTOMER



-- sp_add customer
GO
CREATE PROC sp_addCUSTOMER(@cus_id nvarchar(255) , @cus_name nvarchar(255), @cus_email nvarchar(255), @cus_phone varchar(255) ,@cus_date datetime , @cus_address varchar(255) )
AS 
INSERT INTO CUSTOMER(CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_EMAIL,CUSTOMER_PHONE,CUSTOMER_DATE,CUSTOMER_ADDRESS)
VALUES (@cus_id, @cus_name, @cus_email, @cus_phone,@cus_date,@cus_address)

 
-- SP Xoa Customer
GO
CREATE PROC sp_XoaCustomer(@cus_id nvarchar(255)) 
AS
DELETE FROM CUSTOMER
WHERE CUSTOMER_ID = @cus_id


-- SP Sua Customer
GO
CREATE PROC sp_SuaCustomer(@cus_id nvarchar(255),@cus_name nvarchar(255), @cus_email nvarchar(255), @cus_phone varchar(255) ,@cus_date datetime , @cus_address varchar(255) ) 
AS
UPDATE CUSTOMER
SET CUSTOMER_NAME = @cus_name,
	CUSTOMER_EMAIL = @cus_email,
	CUSTOMER_PHONE = @cus_phone,
	CUSTOMER_DATE = @cus_date,
	CUSTOMER_ADDRESS = @cus_address
WHERE CUSTOMER_ID = @cus_id

--tao storeprocedure PAYMENT
--get list PAYMENT
GO
CREATE PROC sp_getPAYMENT
AS
SELECT *FROM PAYMENT


-- sp_add PAYMENT
GO
CREATE PROC sp_addPAYMENT(@pay_id nvarchar (255), @pay_name nvarchar (255), @discount float)
AS 
INSERT INTO PAYMENT(PAYMENT_ID,PAYMENT_NAME,DISCOUNT)
VALUES (@pay_id, @pay_name, @discount)


 
-- SP Xoa PAYMENT
GO
CREATE PROC sp_XoaPAYMENT(@cus_id nvarchar(255)) 
AS
DELETE FROM PAYMENT
WHERE PAYMENT_ID = @cus_id


-- SP Sua PAYMENT
GO
CREATE PROC sp_SuaPAYMENT(@pay_id nvarchar (255), @pay_name nvarchar (255), @discount float) 
AS
UPDATE PAYMENT
SET PAYMENT_NAME = @pay_name,
	DISCOUNT = @discount
WHERE PAYMENT_ID = @pay_id



--Su Dung SP
EXEC sp_addCUSTOMER N's001', N'Thinh' , N'Thinh@gmail.com',N'0908123456','10/10/1999','Long An'
EXEC sp_addCUSTOMER N's002', N'Long' , N'Long@gmail.com',N'0908987654','11/11/1997','Dong Nai'
EXEC sp_SuaCustomer N's002', N'Phat' , N'Phat@gmail.com',N'0908123456','12/12/1999','Ho Chi Minh'
EXEC sp_getDSCUSTOMER

EXEC sp_addPayment N'p01',N'Thanh Toan Online',0.05
EXEC sp_addPayment N'p02',N'Mua Truc tuyen',0
EXEC sp_addPayment N'p03',N'Tra Gop',1.1

EXEC sp_SuaPAYMENT N'p01',N'Thanh Toan Online',0.06
EXEC sp_getPAYMENT

GO
-- TAO STOREPROCEDUCE
-- LAY DANH SACH THONG KE
CREATE PROC sp_LayDSThongKe
AS
SELECT *
FROM STATISTIC

GO
-- SP THEM THONG KE
CREATE PROC sp_ThemThongKe(@statistic_id nvarchar (255), @statistic_employee nvarchar (255),
							@statistic_bill nvarchar (255), @statistic_price int, @user_id varchar (255))
AS
INSERT INTO STATISTIC(STATISTIC_ID,STATISTIC_EMPLOYEE,STATISTIC_BILL,STATISTIC_PRICE,USER_ID)
VALUES (@statistic_id,@statistic_employee,@statistic_bill,@statistic_price,@user_id)

EXEC sp_ThemThongKe N'T2', N'LONG', N'BILL1', 500000, 'UserLong'
EXEC sp_LayDSThongKe

GO
-- SP XOA THONG KE 
CREATE PROC sp_XoaThongKe(@statistic_id nvarchar (255))
AS
DELETE FROM STATISTIC
WHERE STATISTIC_ID = @statistic_id

EXEC sp_XoaThongKe N'T1'
EXEC sp_LayDSThongKe

GO
-- SP SUA THONG KE
CREATE PROC sp_SuaThongKe(@statistic_id nvarchar (255), @statistic_employee nvarchar (255),@statistic_bill nvarchar (255), @statistic_price int, @user_id varchar (255))
AS
UPDATE STATISTIC
SET STATISTIC_EMPLOYEE = @statistic_employee,
	STATISTIC_BILL = @statistic_bill,
	STATISTIC_PRICE = @statistic_price,
	USER_ID = @user_id
WHERE STATISTIC_ID = @statistic_id

EXEC sp_SuaThongKe N'T1', N'THINH', N'BILL2', 300000, 'UserThinh'
EXEC sp_SuaThongKe N'T2', N'PHAT', N'BILL1', 350000, 'UserPhat'
EXEC sp_LayDSThongKe

GO

-- TAO STOREPROCEDUCE
-- LAY DANH SACH NHAN VIEN
CREATE PROC sp_LayDSNhanVien
AS
SELECT *
FROM EMPLOYEE

GO
-- SP THEM NHAN VIEN
CREATE PROC sp_ThemNhanVien(@employee_id varchar (255), @employee_name nvarchar (255), 
							@employee_email nvarchar (255), @employee_phone varchar (15), 
							@employee_date datetime, @employee_address nvarchar (255))
AS
INSERT INTO EMPLOYEE(EMPLOYEE_ID, EMPLOYEE_NAME, EMPLOYEE_EMAIL, EMPLOYEE_PHONE, EMPLOYEE_DATE, EMPLOYEE_ADDRESS)
VALUES (@employee_id, @employee_name, @employee_email, @employee_phone, @employee_date, @employee_address)

EXEC sp_ThemNhanVien 'NV1', N'Tuan Cuong', N'tcuong@gmail.com', '0902078366', '10/18/1999', N'Thu Duc'
EXEC sp_LayDSNhanVien

GO
-- SP XOA NHAN VIEN
CREATE PROC sp_XoaNhanVien(@employee_id varchar (255))
AS
DELETE FROM EMPLOYEE
WHERE EMPLOYEE_ID = @employee_id

EXEC sp_XoaNhanVien 'NV1'
EXEC sp_LayDSNhanVien

GO
-- SP SUA THONG TIN NHAN VIEN
CREATE PROC sp_SuaThongTinNhanVien(@employee_id varchar (255), @employee_name nvarchar (255), 
							@employee_email nvarchar (255), @employee_phone varchar (15), 
							@employee_date datetime, @employee_address nvarchar (255))
AS
UPDATE EMPLOYEE
SET EMPLOYEE_NAME = @employee_name, 
	EMPLOYEE_EMAIL = @employee_email,
	EMPLOYEE_PHONE = @employee_phone,
	EMPLOYEE_DATE = @employee_date,
	EMPLOYEE_ADDRESS = @employee_address
WHERE EMPLOYEE_ID = @employee_id

EXEC sp_SuaThongTinNhanVien 'NV1', N'Nguyen Tuan Cuong', N'tTTcuong@gmail.com', '0902078377', '10/20/1999', N'QUAN 9'
EXEC sp_LayDSNhanVien
