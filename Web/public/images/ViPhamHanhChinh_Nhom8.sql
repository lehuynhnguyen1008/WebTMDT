Create database ViPhamHanhChinh
go
use ViPhamHanhChinh
go
--Tạo bảng Quốc tịch
create table quocTich
(
	maQuocTich char(10) not null primary key,
	tenQuocTich nvarchar(50) not null
)
go
--QT001

--Tạo bảng tỉnh thành
create table tinhThanh
(
	maTinhThanh char(10) not null primary key,
	tenTinhThanh nvarchar(50) not null
)
go

--TT001
--Tạo bảng Quận huyện
create table quanHuyen
(
	maQuanHuyen char(10) not null primary key,
	tenQuanHuyen nvarchar(50) not null,
	maTinhThanh char(10) foreign key(maTinhThanh) references tinhThanh(maTinhThanh)
)
go

--QH001

--Tạo bảng Phường xã
create table phuongXa
(
	maPhuongXa char(10) not null primary key,
	tenPhuongXa nvarchar(50) not null,
	maQuanHuyen char(10) foreign key(maQuanHuyen) references quanHuyen(maQuanHuyen)
)
go

--PX001
--Tạo bảng Người vi phạm
create table nguoiViPham
(
	maNguoiViPham char(10) not null primary key,
	matKhau char(50) not null,
	hoTen nvarchar(100) not null,
	soDienThoai char(11) not null unique
		check (soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	email char(50) null unique
		check (email like '[a-z]%@%[a-z]'),
	hinhAnh char(50) null,
	maQuocTich char(10) foreign key (maQuocTich) references quocTich(maQuocTich),
	maPhuongXa char(10) foreign key(maPhuongXa) references phuongXa(maPhuongXa)
)

go
--NVP001
--Tạo bảng Công an
create table congAn
(
	maCongAn char(10) not null primary key,
	matKhau char(50) not null,
	hoTen nvarchar(100) not null,
	ngaySinh datetime not null
		check (ngaySinh - getdate() >= 18),
	soDienThoai char(11) not null unique
		check (soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	email char(50) null unique
		check (email like '[a-z]%@%[a-z]'),
	donVi nvarchar(50) not null,
	chucVu nvarchar(50) not null,
	hinhAnh char(50) null,
	maPhuongXa char(10) foreign key (maPhuongXa) references phuongXa(maPhuongXa)
)
go
insert into congAn
values ('CA001','123456','Nguyễn Trung Kiên','19/06/1994','0983234843',null,'Bộ giao thông vận tải thành phố Đà Nẵng','Thiếu tá', null,'PX001'),
		('CA002','01234567891','Phạm Thanh Tú','20/01/1995','0351123123','thanhtudeptrai@gmail.com','Ủy ban nhân dân Hải Châu','Đại úy','D\images\phamthanhtu.png','PX003'),
		('CA003','landepgai','Nguyễn Thị Ngọc Lan','03/06/1998','0512312123','nguyenthingonlan0306@gmail.com','Sở sát hạch quận Liên Chiểu','Trung úy','D\images\nguyenthingoclan.png','PX009'),
		('CA004','xinchao','Nguyễn Duy Trường','11/11/1986','0386123198',null,'Viện kiểm soát nhân dân thành phố Đà Nẵng','Đại tá','D\images\nguyenduytruong.png','PX004'),
		('CA005','19981996','Bùi Minh Vương','04/09/1996','0952123857','minhvuongbui123@gmail.com','Ủy ban nhân dân phường Thanh Bình','Trung úy',null,'PX001'),
		('CA006','0987654321','Bùi Bích Hương','12/12/1997','0318124976',null,'Trung tâm đào tạo lái xe quận Hòa Vang','Đại úy',null,'PX009'),
		('CA007','oanh123456','Nguyễn Thị Tú Oanh','08/10/1999','0984123123',null,'Ủy ban nhân dân phường Hòa Khánh','Thiếu úy',null,'PX007'),
		('CA008','hoangthu','Trần Công Hoàng','09/11/1995','0975864861',null,'Tòa án tối cao thành phố Đà Nẵng','Trung tá','D\images\tranconghoang.png','PX005'),
		('CA009','vipboy','Mai Tiến Đạt','26/05/1998','0973729523', null,'Bộ giao thông vận tải thành phố Đà Nẵng','Trung úy','D\images\maitiendat.png','PX008'),
		('CA0010','truongphihung0309','Trương Phi Hùng','03/09/1993','0852452235','truongphihung0309@gmail.com','Ủy ban nhân dân quận Cẩm Lệ','Trung tá','D\images\truongphihung,png','PX0010');
go
--CA001
--Tạo bảng Bài đăng
create table baiDang
(
	maBaiDang char(10) not null primary key,
	noiDung ntext not null,
	thoiGianDang datetime not null
		check (thoiGianDang <= getdate()),
	soLuotThich char(10) null,
	maCongAn char(10) foreign key (maCongAn) references congAn(maCongAn)
)
go

--BD001
--Tạo bảng Phản hồi
create table phanHoi
(
	maPhanHoi char(10) not null primary key,
	noiDungPhanHoi ntext not null,
	thoiGianPhanHoi datetime not null default getdate()
		check (thoiGianPhanHoi <= getdate()),
	soLuotThich char(10) null,
	maCongAn char(10) foreign key (maCongAn) references congAn(maCongAn),
	maNguoiViPham char(10) foreign key (maNguoiViPham) references nguoiViPham(maNguoiViPham)
)
go

--PH001
--Tạo bảng Loại xe
create table loaiXe
(
	maLoaiXe char(10) not null primary key,
	tenLoaiXe nvarchar(100) not null
)
go
insert into loaiXe
values	('LX001','Xe máy'),
		('LX002','Ô tô'),
		('LX003','Xe đạp'),
		('LX004','Xe ba gác'),
		('LX005','Xe thi công công trình');
--LX001
--Tạo bảng Xe
create table xe
(
	maXe char(10) not null primary key,
	bienSoXe nvarchar(100) not null
		check (bienSoXe like '[0-9][0-9][A-Z][0-9][0-9][0-9][0-9][0-9]' or bienSoXe like '[0-9][0-9][A-Z][0-9][0-9][0-9][0-9]'),
	tenXe nvarchar(100) not null,
	mauXe nvarchar(50) not null,
	tinhTrangXe nvarchar(100) not null,
	maNguoiViPham char(10) foreign key (maNguoiViPham) references nguoiViPham(maNguoiViPham),
	maLoaiXe char(10) foreign key (maLoaiXe) references loaiXe(maLoaiXe)
)
go

--XE001
--Tạo bảng Kho bạc
create table khoBac
(
	maKhoBac char(10) not null primary key,
	matKhau char(50) not null,
	tenDonViKhoBac nvarchar(100) not null,
	email char(50) null unique
		 check (email like '[a-z]%@%[a-z]'),
	soDienThoai char(11) not null unique
		check (soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	diaChi nvarchar(100) not null
)
go
insert into khoBac
values	('KB001','khobac1','quận Hải Châu','khobachaichau@gmail.com','029441231','Ủy ban nhân dân quận Hải Châu'),
		('KB002','khobac2','quận Cẩm Lệ','khobaccamle@gmail.com','0293787438','Ủy ban nhân dân quận Cẩm Lệ'),
		('KB003','khobac3','quận Sơn Trà','khobacsontra@gmail.com','0298486390','Ủy ban nhân dân quận Sơn Trà'),
		('KB004','khobac4','huyện Tam Kỳ','khobactamky@gmail.com','0297452341','Ủy ban nhân dân huyện Tam Kỳ'),
		('KB005','khobac5','huyện Quế Sơn','khobacqueson@gmail.com','0297362382','Ủy ban nhân dân huyện Quế Sơn'),
		('KB006','khobac6','huyện Phong Điền','khobacphongdien@gmail.com','0297412397','Ủy ban nhân dân Huyện Phong Điền'),
		('KB007','khobac7','quận Liên Chiểu','khobaclienchieu@gmail.com','0293741247','Ủy ban nhân dân quận Liên Chiểu'),
		('KB008','khobac8','huyện Hòa Vang','khobachoavang@gmail.com','0298351259','Ủy ban nhân dân huyện Hòa Vang'),
		('KB009','khobac9','huyện Điện Bàn','khobacdienban@gmail.com','0295612885','Ủy ban nhân dân huyện Điện Bàn'),
		('KB0010','khobac10','huyện Hương Trà','khobachuongtra@gmail.com','0293619732','Ủy ban nhân dân huyện Hương Trà');

--KB001
--Tạo bảng Ngân hàng
create table nganHang
(
	maNganHang char(10) not null primary key,
	tenNganHang nvarchar(100) not null,
	logo image not null
)
go
insert into	nganHang
values	('NH001','Ngân hàng thương mại cổ phần Á Châu','D\images\logo\ACB.ico'),
		('NH002','Ngân hàng thương mại cổ phần quốc tế Việt Nam','D\images\logo\VIB.ico'),
		('NH003','Ngân hàng tiên phong','D\images\logo\TPB.ico'),
		('NH004','Ngân hàng bưu điện Liên Việt','D\images\logo\LienVietPostBank.ico'),
		('NH005','Ngân hàng Quân đội','D\images\logo\MB.ico'),
		('NH006','Ngân hàng Nông nghiệp và phát triển nông thôn Việt Nam','D\images\logo\ARG.ico'),
		('NH007','Ngân hàng Công thương Việt Nam','D\images\logo\VTB.ico'),
		('NH008','Ngân hàng Hàng hải Việt Nam','D\images\logo\MSB.ico'),
		('NH009','Ngân hàng đầu tư và phát triển Việt Nam','D\images\logo\BIDV.ico'),
		('NH0010','Ngân hàng ngoại thương Việt Nam','D\images\logo\VCB.ico');

--NH001
--Tạo bảng Tài khoản ngân hàng
create table taiKhoanNganHang
(
	soTaiKhoan char(50) not null primary key,
	chuTaiKhoan nvarchar(100) not null,
	maNguoiViPham char(10) foreign key (maNguoiViPham) references nguoiViPham(maNguoiViPham),
	maKhoBac char(10) foreign key (maKhoBac) references khoBac(maKhoBac),
	maNganHang char(10) foreign key (maNganHang) references nganHang(maNganHang)
)
go

--TK001
--Tạo bảng Bộ phận công chứng
create table boPhanCongChung
(
	maBoPhanCongChung char(10) not null primary key,
	tenDonViCongChung nvarchar(100) not null, 
	email char(50) null unique
		check (email like '[a-z]%@%[a-z]'),
	soDienThoai char(11) not null unique
		check (soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	matKhau char(50) not null,
	diaChi nvarchar(100) not null
)
go


--CC001
--Tạo bảng Biên bản vi phạm hành chính
create table bienBanViPhamHanhChinh
(
	maBienBanViPhamHanhChinh char(10) not null primary key,
	noiDung ntext not null,
	thoiGianLapBienBan datetime not null default getdate()
		check (thoiGianLapBienBan <= getdate()),
	tienPhat money not null
		check(tienPhat >= 0),
	phuongThucNopTienPhat nvarchar(100) not null,
	maNguoiViPham char(10) foreign key (maNguoiViPham) references nguoiViPham(maNguoiViPham),
	maKhoBac char(10) foreign key (maKhoBac) references khoBac(maKhoBac),
	maXe char(10) foreign key (maXe) references xe(maXe),
	maBoPhanCongChung char(10) foreign key (maBoPhanCongChung) references boPhanCongChung(maBoPhanCongChung),
	maCongAn char(10) foreign key (maCongAn) references congAn(maCongAn),
	soTaiKhoan char(50) foreign key (soTaiKhoan) references taiKhoanNganHang(soTaiKhoan)
)
go

--BB001
--Tạo bảng Bộ phận thu giữ tang vật
create table boPhanGiuTangVat
(
	maBoPhanGiuTangVat char(10) not null primary key,
	matKhau char(50) not null,
	tenDonViGiuTangVat nvarchar(100) not null,
	email char(50) null unique
		check (email like '[a-z]%@%[a-z]'),
	soDienThoai  char(11) not null unique
		check (soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or soDienThoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	diaChi nvarchar(100) not null
)
go

--GTV001
--Tạo bảng Chi tiết biên bản vi phạm
create table chiTietBienBanViPham
(

	maBienBanViPhamHanhChinh char(10) foreign key (maBienBanViPhamHanhChinh) references bienBanViPhamHanhChinh(maBienBanViPhamHanhChinh),
	maBoPhanGiuTangVat char(10) foreign key (maBoPhanGiuTangVat) references boPhanGiuTangVat(maBoPhanGiuTangVat),
	loaiTangVatThuGiu nvarchar(100) not null,
	thoiGianThuGiuTangVat datetime not null default getdate()
		constraint a check (thoiGianThuGiuTangVat <= getdate()),
	thoiGianHoanTraTangVat datetime null,
	noiDungThuGiuTangVat ntext not null,
	primary key (maBienBanViPhamHanhChinh, maBoPhanGiuTangVat)
)
go

--CTBB001
alter table chiTietBienBanViPham
add constraint  b check (thoiGianHoanTraTangVat >= thoiGianThuGiuTangVat)
go

insert into chiTietBienBanViPham
values	('BB001','GTV0010','Xe gắn máy Yamaha Sirius','11/11/2021','14/11/2021','Chạy quá tốc độ cho phép'),
		('BB002','GTV007','Xe gắn máy Honda RSX','19/12/2021',null,'Tự ý thay đổi màu xe'),
		('BB003','GTV004','Ô tô khách 48 chỗ','09/01/2021',null,'Chở quá số người quy định'),
		('BB004','GTV006','Ô tô con Toyota','26/12/2021','29/12/2021','Có nồng độ cồn'),
		('BB005','GTV007','Ô tô chở hàng Huyndai','10/10/2021',null,'Chưa đổi biển số vàng'),
		('BB006','GTV007','Xe gắn máy Honda Air Blade','10/1/2022',null,'không đội mũ bảo hiểm'),
		('BB007','GTV009','Xe gắn máy Yamaha Excited','15/12/2021','05/01/2022','Không xuất trình được giấy tờ xe'),
		('BB008','GTV003','Xe gắn máy Honda Winner X','09/11/2021','09/01/2022','Xe độ chế không đúng quy định'),
		('BB009','GTV006','Ô tô con Honda','05/12/2021','01/01/2022','Đi sai làn đường'),
		('BB0010','GTV005','Ô tô khách 24 chỗ','09/01/2022','10/01/2022','Vận chuyển chất cấm');