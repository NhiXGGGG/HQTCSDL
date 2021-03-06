CREATE DATABASE QLNV
GO
USE QLNV
GO

CREATE TABLE NHANVIEN
(
	MaNV nvarchar(15) PRIMARY KEY,
	TenNV nvarchar(30),
	HeSoLuong int,
	MaPB nvarchar(15) CONSTRAINT chk_MaPB CHECK (MaPB LIKE 'PB%') 
)

CREATE TABLE DUAN
(
	MaDA nvarchar(15) PRIMARY KEY,
	TenDA nvarchar(30),
	NganSach float DEFAULT 100000
)

CREATE TABLE PHANCONG
(	
	MaNV nvarchar(15) FOREIGN KEY (MaNV) REFERENCES  NHANVIEN(MaNV) ON UPDATE CASCADE ON DELETE CASCADE,
	MaDA nvarchar(15) FOREIGN KEY (MaDA) REFERENCES  DUAN(MaDA) ON UPDATE CASCADE ON DELETE CASCADE,
	NhiemVu nvarchar(30),
	PRIMARY KEY(MaNV, MaDA)
)

INSERT INTO NHANVIEN VALUES
	('001','Nguyen A',5,'PB1'),
	('002','Nguyen B',6,'PB2'),
	('003','Nguyen C',7,'PB3')

SELECT * FROM NHANVIEN

INSERT INTO DUAN(MaDA,TenDA) VALUES
	('DA1', 'Du An 1'),
	('DA2', 'Du An 2'),
	('DA3', 'Du An 3')

SELECT * FROM DUAN

INSERT INTO PHANCONG VALUES
	('001', 'DA1', N'Kế toán'),
	('002', 'DA2', N'Kiểm toán'),
	('001', 'DA3', N'Quản Lý'),
	('003', 'DA1', N'Kiểm toán'),
	('002', 'DA3', N'Kế toán'),
	('003', 'DA2', N'Quản Lý')

SELECT * FROM PHANCONG

--Câu2
SELECT TenNV FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV=PHANCONG.MaNV
	INNER JOIN DUAN ON PHANCONG.MaDA=DUAN.MaDA
	WHERE TenDA=N'Hồng Hải' AND NhiemVu=N'Kế Toán'

--Câu3
CREATE VIEW vw_cau3
AS
SELECT MaNV, COUNT(MaDA) AS 'SLDA' FROM PHANCONG GROUP BY MaNV

SELECT * FROM vw_cau3

--Câu4
SELECT TenNV FROM NHANVIEN INNER JOIN vw_cau3 ON NHANVIEN.MaNV=vw_cau3.MaNV  
WHERE SLDA = (SELECT COUNT(MaDA) FROM DUAN)

--Câu5
CREATE FUNCTION fn_cau5(@manv nvarchar(10))
RETURNS @bang TABLE (
    MaNV nvarchar(15),
    TenNV nvarchar(30),
    MaDA nvarchar(15),
    TenDA nvarchar(30),
    NhiemVu nvarchar(30)
)
AS 
BEGIN
    INSERT INTO @bang
                select NHANVIEN.MaNV,TenNV, PHANCONG.MaDA,TenDA,NhiemVu FROM NHANVIEN
                inner join PHANCONG ON PHANCONG.MaNV = NHANVIEN.MaNV
                inner join DUAN ON PHANCONG.MaDA = DUAN.MaDA
                where NHANVIEN.MaNV = @manv
        RETURN
END
SELECT * FROM dbo.fn_cau5(N'001')