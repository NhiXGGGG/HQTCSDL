﻿CREATE DATABASE QLVT
ON ( 
	NAME = QLVT_dat,
	FILENAME = 'D:\QLVatTuDAT.mdf',
	SIZE = 50MB,
	MAXSIZE = 200MB,
	FILEGROWTH = 10MB )
LOG ON (
	NAME = QLVT_log,
	FILENAME = 'D:\QLVatTuLOG.ldf',
	SIZE = 10MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 5MB )
USE QLVT
GO
CREATE TABLE VatTu(
	MaVT	char(4)	PRIMARY KEY,
	TenVT	nvarchar(100) UNIQUE,
	DvTinh	nvarchar(10) DEFAULT '""',
	PhanTram	real CHECK(PhanTram >= 0 and PhanTram <= 100 ) )
CREATE TABLE NHaCC(
	MaNCC	char(3)	PRIMARY KEY,
	TenNCC	nvarchar(100)	 UNIQUE,
	DiaChi	nvarchar(200) UNIQUE,
	DienThoai	varchar(20) NOT NULL DEFAULT N'Chưa có' )
CREATE TABLE DonDH(
	SoDH	char(4) PRIMARY KEY,
	NgayDH	date DEFAULT GETDATE(),
	MaNCC		char(3) FOREIGN KEY (MaNCC) REFERENCES NHaCC(MaNCC) ON UPDATE CASCADE ON DELETE CASCADE)
CREATE TABLE CTDonDH (
	SoDH	char(4),
	MaVT	char(4),
	SLDat int NOT NULL CHECK(SLDat > 0),
	PRIMARY KEY (SoDH, MaVT),
	FOREIGN KEY (SoDH) REFERENCES DonDH(SoDH) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT) ON UPDATE CASCADE ON DELETE CASCADE )
CREATE TABLE PNhap (
	SoPN	char(4) PRIMARY KEY,
	NgayNhap	date	NOT NULL,
	SoDH	char(4) FOREIGN KEY (SoDH) REFERENCES DonDH(SoDH) ON UPDATE CASCADE ON DELETE CASCADE )
CREATE TABLE CTPNhap (
	SoPN	char(4),
	MaVT	char(4),
	SLNhap	int NOT NULL CHECK(SLNhap > 0),
	Dgnhap	money NOT NULL CHECK(Dgnhap > 0) )
CREATE TABLE PXuat (
	SoPX	char(4)	PRIMARY KEY,
	NgayXuat	date	NOT NULL,
	TenKH	nvarchar(100)	NOT NULL )
CREATE TABLE CTPXuat (
	SoPX	char(4),
	MaVT	char(4),
	SlXuat	int CHECK(SlXuat > 0)	NOT NULL,
	DgXuat	money CHECK(DgXuat > 0) NOT NULL,
	FOREIGN KEY (SoPX) REFERENCES PXuat(SoPX) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT) ON UPDATE CASCADE ON DELETE CASCADE )
CREATE TABLE TonKho (
	NamThang	char(6),
	MaVT	char(4),
	SLDau	int NOT NULL CHECK(SLDau >= 0)	DEFAULT 0,
	TongSLN	int NOT NULL CHECK(TongSLN >= 0)	DEFAULT 0,
	TongSLX	int NOT NULL CHECK(TongSLX >= 0)	DEFAULT 0,
	SLCuoi	int,
	PRIMARY KEY (NamThang, MaVT),
	FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT) ON UPDATE CASCADE ON DELETE CASCADE )
USE QLVT
INSERT INTO NHaCC(MaNCC, TenNCC, DiaChi, DienThoai) VALUES ('C01',N'Lê Minh Trí', N'54 Hậu Giang Q6 HCM', '8781024')
SELECT * FROM NHACC
INSERT INTO NHaCC VALUES ('C02',N'Trần Minh Thạch', N'145 Hùng Vương Mỹ Tho', '7698154'),
						 ('C03',N'Hồng Phương', N'154/85 Lê Lai Q1 HCM', '9600125'),
						 ('C04',N'Nhật Thắng', N'198/40 Hương Lộ 14 QTB HCM', '8757757'),
						 ('C05',N'Lưu Nguyệt Quế', N'178 Nguyễn Văn Luông Đà Lạt', '7964251'),
						 ('C07',N'Cao Minh Trung', N'125 Lê Quang Sung Nha Trang',DEFAULT)
INSERT INTO VatTu(MaVT, TenVT, DvTinh, PhanTram) VALUES ('DD01',N'Đầu DVD Hitachi 1 đĩa', N'Bộ', 40)
SELECT * FROM VatTu
INSERT INTO VatTu VALUES ('DD02',N'Đầu DVD Hitachi 3 đĩa', N'Bộ', 40),
						 ('TL15',N'Tủ lạnh Sanyo 150 lít', N'Cái', 25),
						 ('TL90',N'Tủ lạnh Sanyo 90 lít', N'Cái', 20),
						 ('TV14',N'Tivi Sony 14 inches', N'Cái', 15),
						 ('TV21',N'Tivi Sony 21 inches', N'Cái', 10),
						 ('TV29',N'Tivi Sony 29 inches', N'Cái', 10),
						 ('VD01',N'Đầu VCD Sony 1 đĩa', N'Bộ', 30),
						 ('VD02',N'Đầu VCD Sony 3 đĩa', N'Bộ', 30)
INSERT INTO DonDH(SoDH, NgayDH, MaNCC) VALUES ('D001','01/15/2002', 'C03')
SELECT * FROM DonDH
INSERT INTO DonDH VALUES ('D002','01/30/2002', 'C01'),
						 ('D003','02/10/2002', 'C02'),
						 ('D004','02/17/2002', 'C05'),
						 ('D005','03/01/2002', 'C02'),
						 ('D006','03/12/2002', 'C05')
INSERT INTO PNhap(SoPN, NgayNhap, SoDH) VALUES ('N001','01/17/2002', 'D001')
SELECT * FROM PNhap
INSERT INTO PNhap VALUES ('N002','01/20/2002', 'D001'),
						 ('N003','01/31/2002', 'D002'),
						 ('N004','02/15/2002', 'D003')
INSERT INTO CTDonDH(SoDH, MaVT, SLDat) VALUES ('D001','DD01',10)
SELECT * FROM CTDonDH
INSERT INTO CTDonDH VALUES ('D001','DD02',15),
						   ('D002','VD02',30),
						   ('D003','TV14',10),
						   ('D003','TV29',20),
						   ('D004','TL90',10),
						   ('D005','TV14',10),
						   ('D005','TV29',20),
						   ('D006','TV14',10),
						   ('D006','TV29',20),
						   ('D006','VD01',20)
INSERT INTO CTPNhap(SoPN, MaVT, SLNhap, Dgnhap) VALUES ('N001','DD01',8, 2500000)
SELECT * FROM CTPNhap
INSERT INTO CTPNhap VALUES ('N001','DD02', 10, 3500000),
						   ('N002','DD01', 2, 2500000),
						   ('N002','DD02', 5, 3500000),
						   ('N003','VD02', 30, 2500000),
						   ('N004','TV14', 5, 2500000),
						   ('N004','TV29', 12, 3500000)
INSERT INTO PXuat(SoPX, NgayXuat, TenKH) VALUES ('X001','01/17/2002', N'Nguyễn Ngọc Phương Nhi')
SELECT * FROM PXuat
INSERT INTO PXuat VALUES ('X002','01/25/2002', N'Nguyễn Hồng Phương'),
						 ('X003','01/31/2002', N'Nguyễn Tuấn Tú')
INSERT INTO CTPXuat(SoPX, MaVT, SlXuat, DgXuat) VALUES ('X001','DD01', 2, 3500000)
SELECT * FROM CTPXuat
INSERT INTO CTPXuat VALUES ('X002','DD01', 1, 3500000),
						   ('X002','DD02', 5, 4900000),
						   ('X003','DD01', 3, 3500000),
						   ('X003','DD02', 2, 4900000),
						   ('X003','VD02', 10, 3250000)
INSERT INTO TonKho(NamThang, MaVT, SLDau, TongSLN, TongSLX, SLCuoi) VALUES ('200201','DD01', 0, 10, 6, 4)
SELECT * FROM TonKho
INSERT INTO TonKho VALUES ('200201','DD02', 0, 15, 7, 8)
						  ('200201','VD02', 0, 30, 10, 20),
						  ('200202','DD01', 4, 0, 0, 4),
						  ('200202','DD02', 8, 0, 0, 8),
						  ('200202','VD02', 20, 0, 0, 20),
						  ('200202','TV14', 5, 0, 0, 5),
						  ('200202','TV29', 12, 0, 0, 12)
-- CÂU 4
--a
UPDATE NHaCC
SET DienThoai = '098473645'
WHERE MaNCC = 'C01'
--b
DELETE FROM NHaCC
WHERE DienThoai LIKE N'Chua có'
--c
UPDATE CTPXuat
SET DgXuat = DgXuat - 1000000.00
WHERE SlXuat >= 3

--a
create view vw_DMVT as 
select MaVT, TenVT from VatTu
select * from vw_DMVT

--b
create view vw_DonDH_TongSLDatNhap 
as 
select SoDH, sum(SLDat) as TongSLD, TongSLN from CTDonDH
inner join TonKho
on CTDonDH.MaVT = TonKho.MaVT
group by TonKho.MaVT, SoDH, TongSLN
select * from vw_DonDH_TongSLDatNhap

--b cua co--
create view vw_DonDH_TongSLDatNhap
as
Select SoDH, Sum(SLDAT) As TSLDAT, Sum(SLNHAP) as TSLNHAP
from CTDonDH inner join VatTu on CTDonDH.MaVT=VatTu.MaVT
inner join CTPNhap On CTPNhap.MaVT=VatTu.MaVT
Group by SoDH
Select * From vw_DonDH_TongSLDatNhap

--c
/*CREATE VIEW DaNhapDu(@SLDat int, @SLNhap int)
RETURNS char(12)
AS BEGIN
declare @st char(12)
SELECT @st=CASE @SLDat - @SLNhap
WHEN 0 THEN 'Da nhap du'
ELSE 'Chua nhap du'
END
RETURN (@st) /* Trị trả về của hàm */
END
create view vw_DonDH_DaNhapDu as
select SoDH, dbo.DaNhapDu(SLDat, SLNhap) as DaNhapDu  from CTDonDH
inner join CTPNhap
on CTDonDH.MaVT = CTPNhap.MaVT*/

--c--
CREATE VIEW vw_DONDH_DANHAPDU
as
select SoDH, CASE 
When N'Tổng SL đặt'=N'Tổng SL nhập' then N'Đã Nhập Đủ'
else N'Chưa Nhập Đủ'
end as 'TrangThai'
from vw_DonDH_TongSLDatNhap

--hiển thị view--
select * from vw_DonDH_DaNhapDu

--d
create view vw_TongNhap
as
select Ngaynhap, MaVT, Sum(SLNHAP) as TSLNHAP
From PNhap inner join CTPNhap
on PNhap.SoPN=CTPNhap.SoPN
group by NgayNhap, MaVT

--hien thị view--
select * from vw_TongNhap

--e
create view vw_TongXuat
as
select Ngayxuat, MaVT, Sum(SLXUAT) as TSLXuat
From PXuat inner join CTPXuat
on PXuat.SoPX=CTPXuat.SoPX
group by NgayXuat, MaVT

-- hien thị view
select * from vw_TongXuat


--f
create VIEW vw_DonDH_MaVTu_TongSLNhap
as
select DonDH.SoDH, NgayDH, CTDonDH.MaVT, TenVT, SLDat, sum(SLNhap) as TongSLN
from DonDH inner join CTDonDH on DonDH.SoDH=CTDonDH.SoDH
inner join VatTu on CTDonDH.MaVT=VatTu.MaVT
inner join CTPNhap on VatTu.MaVT=CTPNhap.MaVT
group by DonDH.SoDH, CTDonDH.MaVT, NgayDH, TenVT,SLDat

--hiển thị view
select * from vw_DonDH_MaVTu_TongSLNhap


--Cau2
--a
Select *
from DonDH 
where SoDH not in (select SoDH from vw_DonDH_TongSLDatNhap)


--b 
select *
from NHaCC 
where MaNCC not in (select MaNCC from DonDH)


--c
select DonDH.MaNCC, TenNCC, DiaChi, DienThoai
from NhaCC inner join DonDH on NhaCC.MaNCC = DonDH.MaNCC
group by DonDH.MaNCC, TenNCC, DiaChi, DienThoai
having count(SoDH) >= all (select count(SoDH)
                            from DonDH
							group by MaNCC)

--d
select VatTu.MaVT, TenVT, DvTinh, PhanTram
from VatTu inner join vw_TongXuat on VatTu.MaVT = vw_TongXuat.MaVT
where TSLXuat >= all (select TSLXuat
                       from vw_TongXuat)

--e
select DonDH.SoDH, NgayDH, MaNCC
from DonDH inner join CTDonDH on DonDH.SoDH = CTDonDH.SoDH
group by DonDH.SoDH, NgayDH, MaNCC
having count(MaVT) >= all(select count(MaVT) 
					   from CTDonDH
					   Group by SoDH) 
--f
select NamThang, VatTu.MaVT, TenVT, TongSLN, TongSLX
from VatTu inner join TonKho on VatTu.MaVT = TonKho.MaVT

--g
select SoDH, NgayDH, MaVT, SLDat,  TongSLN
from vw_DonDH_MaVTu_TongSLNhap

--h
select NgayDH, VatTu.MaVT, TenVT, sum(SLDat) as TongSLD
from DonDH inner join CTDonDH on DonDH.SoDH = CTDonDH.SoDH
           inner join VatTu on VatTu.MaVT = CTDonDH.MaVT
group by NgayDH, VatTu.MaVT, TenVT

--i
select NgayNhap, VatTu.MaVT, TenVT, sum(SLNhap) as TongSLN
from PNhap inner join CTPNhap on PNhap.SoPN = CTPNhap.SoPN
           inner join VatTu on VatTu.MaVT = CTPNhap.MaVT
group by NgayNhap, VatTu.MaVT, TenVT

--j
select DonDH.SoDH, NgayDH, MaNCC
from vw_DonDH_DaNhapDu inner join DonDH on vw_DonDH_DaNhapDu.SoDH = DonDH.SoDH
where TrangThai = N'Chưa nhập đủ'
