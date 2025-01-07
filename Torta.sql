--Membuat dan menggunakan Database
Create Database Torta;
Use Torta;

--Membuat tabel untuk torta
Create Table MsUser
(
	IDUser INT IDENTITY(1,1) Primary Key NOT NULL, --Buat AUTO INCREMENT (IDENTITY)
	NamaUser Varchar(60) NOT NULL,
	NomorTelp Varchar(14) NOT NULL,
	PasswordUser Varchar(20) NOT NULL,
	TypeUser Varchar(9) NOT NULL
);

Create Table MsKue
(
	IDKue INT Primary Key NOT NULL,
	NamaKue Varchar(100) NOT NULL,
	Harga INT NOT NULL,
	Stok INT NOT NULL
);

Create Table MsTransaksi
(
	IDTransaksi INT IDENTITY(1,1) Primary Key NOT NULL,
	IDUser INT constraint MsUser_IDUser References MsUser(IDUser),
	AlamatUser Varchar(255) NOT NULL
);

Create Table MsKurir
(
	IDKurir INT Primary Key NOT NULL,
	NamaKurir Varchar(60) NOT NULL,
	NoTelp Varchar(14) NOT NULL
);

Create Table Pengirim
(
	IDKurir INT constraint MsKurir_IDKurir References MsKurir(IDKurir),
	IDTransaksi INT constraint MsTransaksi_IDTransaksi References MsTransaksi(IDTransaksi)
);

Create Table Pembelian
(
	IDTransaksi INT constraint MsTransaksi_IDTransaksi1 References MsTransaksi(IDTransaksi),
	IDKue INT constraint MsKue_IDKue References MsKue(IDKue),
	Qty INT NOT NULL
);

Insert Into MsKurir VALUES ('1', 'Situardjo Kimin', '08136662221');
Insert Into MsKurir VALUES ('2', 'Wahyuni Liliana', '08136679212');
Insert Into MsKurir VALUES ('3', 'Prismo Agus', '081265322121');

Insert Into MsKue VALUES ('1', 'Kue Nastar - 500gr', '50000', '10');
Insert Into MsKue VALUES ('2', 'Kue Lidah Kucing - 100gr', '20000', '15');
Insert Into MsKue VALUES ('3', 'Kue Putri Salju - 250gr', '11000', '32');

Insert Into MsUser VALUES ('Admin', '081347106867', '1234', 'Admin');
Insert Into MsUser VALUES ('Angel', '081347722167', '3456', 'Pelanggan');

Select * From MsKue;
Select * From MsKurir;
Select * From MsUser;
Select * From MsTransaksi;
Select * From Pembelian;
Select * From Pengirim;

CREATE VIEW TransaksiView AS
SELECT t.IDTransaksi, u.NamaUser AS 'Pembeli', k.NamaKurir AS 'Kurir', ku.NamaKue AS 'Item Dibeli'
FROM MsTransaksi t
JOIN MsUser u ON t.IDUser = u.IDUser
JOIN Pengirim p ON t.IDTransaksi = p.IDTransaksi
JOIN MsKurir k ON p.IDKurir = k.IDKurir
JOIN Pembelian pb ON t.IDTransaksi = pb.IDTransaksi
JOIN MsKue ku ON pb.IDKue = ku.IDKue;
Select * From TransaksiView;

DROP Database Torta;