CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName NVARCHAR(50) 
);
CREATE TABLE KhachHang (
    IDKH INT PRIMARY KEY IDENTITY(1,1),
    Password VARCHAR(255),
	TenKhachHang NVARCHAR(100),
    Email VARCHAR(50),
    Phone VARCHAR(20) NOT NULL UNIQUE,
	DiaChi NVARCHAR(100), 
	ImageUser NVARCHAR(225),
	RoleID INT,
	IsActive BIT DEFAULT 1,
	FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
CREATE TABLE LoaiSP (
    IDLoaiSP INT PRIMARY KEY IDENTITY(1,1),
    TenLoaiSP NVARCHAR(255),
	IsActive BIT DEFAULT 1,
	Images NVARCHAR(225)
);
CREATE TABLE SanPham (
    IDSP INT PRIMARY KEY IDENTITY(1,1),
    IDLoaiSP INT,
    TenSP NVARCHAR(100),
	HinhSP NVARCHAR(255),
    MoTaSP NVARCHAR(255),
    Price INT,
	IsActive BIT DEFAULT 1,
	TrangThai NVARCHAR(50),
    FOREIGN KEY (IDLoaiSP) REFERENCES LoaiSP(IDLoaiSP),
);

CREATE TABLE SizeSP (
    IDSize INT PRIMARY KEY IDENTITY(1,1),     
    TenSize NVARCHAR(100), 
    PhuThuSize INT,
	IsActive BIT DEFAULT 1
);
CREATE TABLE LoaiPizza (
    IDPizza INT PRIMARY KEY IDENTITY(1,1),     
	IDSize INT,
	TenDeBanh NVARCHAR(100),  
	PhuThuDeBanh INT,
	IsActive BIT DEFAULT 1,
	FOREIGN KEY (IDSize) REFERENCES SizeSP(IDSize)
);
CREATE TABLE Feedback (
    IdFeedBack INT IDENTITY(1,1) PRIMARY KEY,
    IDSP INT NOT NULL,
    IDKH INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(1000),
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsApproved BIT DEFAULT 0,
    CONSTRAINT FK_Feedback_Product FOREIGN KEY (IDSP) REFERENCES SanPham(IDSP),
    CONSTRAINT FK_Feedback_User FOREIGN KEY (IDKH) REFERENCES KhachHang(IDKH)
);

CREATE TABLE Wishlist (
    WishlistID INT PRIMARY KEY IDENTITY(1,1),
    IDKH INT,
    IDSP INT,
    FOREIGN KEY (IDKH) REFERENCES KhachHang(IDKH),
    FOREIGN KEY (IDSP) REFERENCES SanPham(IDSP)
);
CREATE TABLE GioHang (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    IDKH INT,
    IDSP INT,
	IDPizza INT,
    SoLuong INT,
	Note NVARCHAR(50),
    FOREIGN KEY (IDKH) REFERENCES KhachHang(IDKH),
	FOREIGN KEY (IDPizza) REFERENCES LoaiPizza(IDPizza),
    FOREIGN KEY (IDSP) REFERENCES SanPham(IDSP)
);
CREATE TABLE Voucher (
    VoucherID INT PRIMARY KEY IDENTITY(1,1), 
    Code NVARCHAR(50) NOT NULL UNIQUE,       
    CouponDiscount DECIMAL(10, 2),
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayHetHan DATE,                                             
    IsActive BIT DEFAULT 1
);
CREATE TABLE DonHang (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    IDKH INT,
    VoucherID INT,
    NgayDat DATETIME DEFAULT GETDATE(),
    AddressDelivery NVARCHAR(100),
    TongTien INT,								
    Note NVARCHAR(255),
    PayType NVARCHAR(50), --Hình thức thanh toán-- 
    IsPayment BIT DEFAULT 0, --Đã/Chưa thanh toán--
    TrangThai NVARCHAR(50) DEFAULT N'Chưa xác nhận', 
    FOREIGN KEY (IDKH) REFERENCES KhachHang(IDKH),
    FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID),
    CONSTRAINT CK_TrangThai CHECK (TrangThai IN (N'Chưa xác nhận', N'Đang giao', N'Đã giao', N'Hủy đơn'))
);
CREATE TABLE CHITIETDONHANG(
	DetailOrderID INT PRIMARY KEY IDENTITY(1,1),
	IDSP INT,
	OrderID INT,
	IDPizza INT,
	Quantity INT,
	UnitPrice INT,
	Note NVARCHAR(50),
	FOREIGN KEY (IDSP) REFERENCES SanPham(IDSP),
	FOREIGN KEY (OrderID) REFERENCES DonHang(OrderID),
	FOREIGN KEY (IDPizza) REFERENCES LoaiPizza(IDPizza)
);
--Data Role--
INSERT INTO Roles (RoleID, RoleName) VALUES (1,'Admin');
INSERT INTO Roles (RoleID, RoleName) VALUES (2, N'Khách vãng lai');
INSERT INTO Roles (RoleID, RoleName) VALUES (3, N'Khách hàng thân thiết');

--Data LoaiSP--
INSERT INTO LoaiSP (TenLoaiSP, Images) VALUES (N'Pizza');
INSERT INTO LoaiSP (TenLoaiSP, Images) VALUES (N'Mỳ Ý');
INSERT INTO LoaiSP (TenLoaiSP, Images) VALUES (N'Salad');
INSERT INTO LoaiSP (TenLoaiSP, Images) VALUES (N'Khai Vị');
INSERT INTO LoaiSP (TenLoaiSP, Images) VALUES (N'Thức Uống');
--Data Size--
INSERT INTO SizeSP (TenSize, PhuThuSize)
VALUES (N'Nhỏ 6', 0),
       (N'Vừa 9', 80000),
	   (N'Lớn 12', 190000);
--Data CrustPizza--
INSERT INTO LoaiPizza (IDSize, TenDeBanh, PhuThuDeBanh)
VALUES (1,N'Dày', 0),
	   (2,N'Dày', 0),
	   (2,N'Mỏng giòn', 0),
	   (2,N'Viền phô mai', 50000),
	   (2,N'Viền phô mai xúc xích', 100000),
	   (3,N'Dày', 0),
	   (3,N'Mỏng giòn', 0),
	   (3,N'Viền phô mai', 70000),
	   (3,N'Viền phô mai xúc xích', 140000);

--Data SanPham--
INSERT INTO SanPham (IDLoaiSP, TenSP, HinhSP, MoTaSP, Price, TrangThai) 
VALUES (1, N'Pizza Hải Sản Pesto Xanh', 'pizza01.png', N'Tôm-thanh cua-mực và bông cải xanh tươi ngon trên nền sốt Pesto Xanh', 169000, 'Sale'),
	   (2, N'Mỳ Ý thịt bò bằm', 'pasta01.png', N'Sốt thịt bò bằm đặc trưng kết hợp cùng mỳ Ý', 149000, 'Sale'),
       (3, N'Salad Đặc Sắc', 'salad01.png', N'Salad rau và trái cây tươi dùng kèm xốt kem đặc biệt của The Hom Pizza', 89000, 'Sale'),
       (4, N'Sườn Siêu Sao (10 miếng)', 'khaivi05.png', N'Combo Sườn nướng BBQ dùng với khoai tây chiên và Salad', 489000, 'Sale'),
       (5, N'Pepsi Lon', 'nuoc01.jpeg', N'Nước giải khát', 29000, 'Sale'),
       (3, N'Salad Da Cá Hồi', 'salad02.png', N'Salad với da cá hồi giòn với bắp cải đỏ-cà chua bi-ngô với sốt Yuzu', 89000, 'Sale'),
       (1, N'Pizza Hải Sản Nhiệt Đới', 'pizza02.png', N'Tôm-nghêu-mực-thanh cua-dứa với sốt Thousand Island', 159000, 'Sale'),
       (4, N'Gà Nướng BBQ (5 miếng)', 'chicken02.jpeg', N'Thịt gà mềm ngọt-thấm đẫm gia vị-da gà giòn rụm-màu vàng ươm bắt mắt.', 219000, 'Sale'),
       (4, N'Khai Vị Tổng Hợp (Cánh gà chiên giòn)', 'khaivi01.jpeg', N'Cánh gà chiên giòn-bánh mì tỏi nướng và khoai tây chiên', 179000, 'Sale'),
       (4, N'Tôm Bơ tỏi và Bánh Mì Nướng', 'khaivi03.jpeg', N'Tôm tươi đút lò với tỏi-bơ dùng kèm bánh mì nướng bơ tỏi', 129000, 'Sale'),
       (4, N'Bánh Phô Mai Xoắn', 'khaivi02.jpeg', N'Phô mai trắng được nướng với bơ-tỏi và dùng kèm sốt Cocktail', 119000, 'Sale'),
       (2, N'Mỳ Ý Nghêu Xốt Cay', 'pasta02.png', N'Mỳ ý với sự kết hợp hoàn hảo giữa vị xốt cay nồng và vị ngọt thanh của nghêu-đảm bảo sẽ làm bạn thích thú.', 139000, 'Sale'),
       (4, N'Cánh gà nướng BBQ (10 miếng)', 'chicken04.png', N'Cánh gà nướng thấm vị với lớp da mỏng giòn.', 199000, 'Sale'),
       (4, N'Mực Chiên Giòn', 'khaivi06.png', N'Mực tẩm bột chiên giòn dùng kèm sốt ngò tây.', 129000, 'Sale');
--Data KhachHang--
INSERT INTO KhachHang (Password, TenKhachHang, Email, Phone, DiaChi, ImageUser, RoleID)
VALUES ('1234', N'Dương Quốc Huy', 'quochuyduong7@gmail.com', '0562176774', N'429/14k Lê Văn Sỹ phường 12 quận 3 TP.HCM', N'user_default.png', 1), -- RoleID = 1 (Admin)
       (Null, N'Đàm Quang Trung', 'qwe123@example.com', '0987654322', N'123 Quang Trung', N'user_default.png', 2), -- RoleID = 2 (Khách vãng lai), Email và Phone đã được sửa
       ('1234', N'Nguyễn Văn A', 'teo@example.com', '0903313406', N'234 Nguyễn Huệ', N'user_default.png', 3); -- RoleID = 3 (Khách hàng thân thiết), thông tin mới
--Data Voucher--
INSERT INTO Voucher (Code, CouponDiscount, NgayHetHan, IsActive)
VALUES 
('SALE10', 0.10, '2025-12-31', 1),  
('SALE20', 0.20, '2025-11-30', 1),
('BLACKFRIDAY', 0.50, '2025-11-29', 1), 
('SUMMER15', 0.15, '2024-08-31', 0), 
('NEWYEAR25', 0.25, '2025-01-01', 1);  

--Các thủ tục xử lý trong web--
--Thêm loại sản phẩm--
GO
CREATE PROC THEMLOAISP  @TenLoai NVARCHAR(100),
						@HINHMINHHOA NVARCHAR(100)				
AS
BEGIN
	INSERT INTO LOAISP (TenLoaiSP, Images)
    VALUES(@TenLoai,@HINHMINHHOA)
END

--Đăng ký--
CREATE PROCEDURE sp_ThemKH
    @Password VARCHAR(50),
    @TenKhachHang NVARCHAR(100),
    @Email VARCHAR(50),
    @Phone VARCHAR(20),
	@RoleID INT,
	@Hinh VARCHAR(255),
	@DiaChi NVARCHAR(100)
AS
BEGIN
    -- Kiểm tra định dạng số điện thoại
    IF @Phone NOT LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    BEGIN
        -- Nếu không đúng định dạng, trả về thông báo lỗi
        RAISERROR('Số điện thoại không đúng định dạng.', 16, 1);
        RETURN;
    END
	-- Kiểm tra xem Username hoặc Email hoặc Phone đã tồn tại hay chưa
    IF EXISTS (SELECT 1 FROM KhachHang WHERE Phone = @Phone)
    BEGIN
        -- Nếu tồn tại, trả về thông báo lỗi
        RAISERROR('Số điện thoại đã tồn tại.', 16, 1);
        RETURN;
    END

    -- Thêm khách hàng mới
    INSERT INTO KhachHang (Password, TenKhachHang, Email, Phone, RoleID, ImageUser, DiaChi)
    VALUES (@Password, @TenKhachHang, @Email, @Phone, @RoleID, @Hinh, @DiaChi);

    -- Trả về ID của khách hàng vừa thêm
    SELECT SCOPE_IDENTITY() AS NewKhachHangID;
END;
-- Thêm sản phẩm--
GO
CREATE PROC THEMSP  @IDLOAISP INT,
					@TENSP NVARCHAR(100),
					@HINHMINHHOA VARCHAR(50),				
					@MOTA NTEXT,
					@GIA INT,
					@TrangThai NVARCHAR(50)
AS
BEGIN
	INSERT INTO SANPHAM
	VALUES(@IDLOAISP,@TENSP,@HINHMINHHOA,@MOTA,@GIA,1,@TrangThai)
END

--Sửa sản phẩm--
CREATE PROC UpdateProduct 
		@IDLOAISP INT,
		@TENSP NVARCHAR(100),
		@HINHMINHHOA VARCHAR(50),
		@MOTA NTEXT,
		@GIA INT,
		@IDSP INT,
		@TrangThai NVARCHAR(50)
AS
BEGIN
		UPDATE SANPHAM
		SET IDLoaiSP=@IDLOAISP,
			TenSP=@TenSP,
			Price=@GIA,
			MoTaSP=@MOTA,
			HinhSP=@HINHMINHHOA,
			TrangThai=@TrangThai
		WHERE IDSP=@IDSP
END

--Set up password
CREATE TRIGGER trg_SetPasswordNull
ON KhachHang
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE KhachHang
    SET Password = NULL
    FROM KhachHang K
    INNER JOIN inserted I ON K.IDKH = I.IDKH
    WHERE I.RoleID = 2;
END;

--Sửa user
CREATE PROC UpdateUser
		@IDKH INT,
		@IDRole INT,
		@PASSWORD VARCHAR(100),
		@TENKH NVARCHAR(100),
		@EMAIL VARCHAR(50),
		@DIACHI NVARCHAR(100),
		@HINH VARCHAR(255)
AS
BEGIN
		UPDATE KHACHHANG
		SET RoleID=@IDRole,
			Password=@PASSWORD,
			TenKhachHang=@TENKH,
			Email=@EMAIL,
			DiaChi=@DIACHI,
			ImageUser=@HINH
		WHERE IDKH=@IDKH
END


--Thêm đánh giá sản phẩm--
CREATE PROCEDURE AddFeedback
    @ProductId INT,
    @UserId INT,
    @Rating INT,
    @Comment NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu rating hợp lệ
    IF @Rating < 1 OR @Rating > 5
    BEGIN
        RAISERROR('Rating phải từ 1 đến 5.', 16, 1);
        RETURN;
    END

    -- Thêm feedback vào bảng Feedback
    INSERT INTO Feedback (IDSP, IDKH, Rating, Comment, CreatedAt)
    VALUES (@ProductId, @UserId, @Rating, @Comment, GETDATE());

END

--Lấy FeedBack--
CREATE PROCEDURE GetFeedback
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        KH.TenKhachHang, 
		KH.ImageUser,
        FB.IDSP, 
        FB.IDKH, 
        FB.Rating, 
        FB.Comment, 
        FB.CreatedAt, 
        FB.IsApproved
    FROM Feedback FB
    JOIN KhachHang KH ON FB.IDKH = KH.IDKH
    WHERE FB.IDSP = @ProductID
    ORDER BY FB.CreatedAt DESC;
END;
drop proc sp_ThemGioHang2
--Thêm giỏ hàng--
CREATE PROCEDURE sp_ThemGioHang
    @IDKH INT,
    @IDSP INT,
    @SoLuong INT,
    @Note NVARCHAR(50)
AS
BEGIN
    -- Kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng với cùng ghi chú
    IF EXISTS (
        SELECT 1
        FROM GioHang
        WHERE IDKH = @IDKH AND IDSP = @IDSP AND Note = @Note
    )
    BEGIN
        -- Nếu đã tồn tại (cùng sản phẩm và cùng ghi chú), tăng số lượng
        UPDATE GioHang
        SET SoLuong = SoLuong + @SoLuong
        WHERE IDKH = @IDKH AND IDSP = @IDSP AND Note = @Note;
    END
    ELSE
    BEGIN
        -- Nếu chưa có, thêm dòng mới vào giỏ hàng
        INSERT INTO GioHang (IDKH, IDSP, SoLuong, Note)
        VALUES (@IDKH, @IDSP, @SoLuong, @Note);
    END
END;

CREATE PROCEDURE sp_ThemGioHang2
    @IDKH INT,
    @IDSP INT,
    @IDPizza INT,
    @SoLuong INT,
    @Note NVARCHAR(50)
AS
BEGIN
    -- Kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng với cùng ghi chú
    IF EXISTS (
        SELECT 1
        FROM GioHang
        WHERE IDKH = @IDKH AND IDSP = @IDSP AND IDPizza = @IDPizza AND Note = @Note
    )
    BEGIN
        -- Nếu đã tồn tại (cùng sản phẩm, pizza và ghi chú), tăng số lượng
        UPDATE GioHang
        SET SoLuong = SoLuong + @SoLuong
        WHERE IDKH = @IDKH AND IDSP = @IDSP AND IDPizza = @IDPizza AND Note = @Note;
    END
    ELSE
    BEGIN
        -- Nếu chưa có, thêm sản phẩm mới vào giỏ hàng
        INSERT INTO GioHang (IDKH, IDSP, IDPizza, SoLuong, Note)
        VALUES (@IDKH, @IDSP, @IDPizza, @SoLuong, @Note);
    END
END;

drop proc sp_GetCartItems
--Hiển thị các sản phẩm trong giỏ hàng--
CREATE PROCEDURE sp_GetCartItems
    @UserID INT
AS
BEGIN
    SELECT
        sp.IDSP,
        sp.TenSP,
        sp.HinhSP,
        sp.Price,
        gh.SoLuong,
        (sp.Price * gh.SoLuong) AS TotalPrice,
        gh.IDPizza,
        sz.TenSize,
        sz.PhuThuSize,
        lp.TenDeBanh,
        lp.PhuThuDeBanh,
        (ISNULL(sz.PhuThuSize, 0) + ISNULL(lp.PhuThuDeBanh, 0)) AS TotalPhuThu,
        ((sp.Price + ISNULL(sz.PhuThuSize, 0) + ISNULL(lp.PhuThuDeBanh, 0))* gh.SoLuong) AS GrandTotal,
		gh.CartID,
		gh.Note
    FROM
        GioHang gh
    INNER JOIN
        SanPham sp ON gh.IDSP = sp.IDSP
    LEFT JOIN  -- Thay INNER JOIN bằng LEFT JOIN
        LoaiPizza lp ON gh.IDPizza = lp.IDPizza
    LEFT JOIN  -- Thay INNER JOIN bằng LEFT JOIN
        SizeSP sz ON lp.IDSize = sz.IDSize
    WHERE
        gh.IDKH = @UserID;
END;

--Hiển thị các sản phẩm trong giỏ hàng Session--
CREATE PROCEDURE sp_GetCartItems2
    @IDSP INT,
    @IDPizza INT
AS
BEGIN
    SELECT
        sp.TenSP, sp.HinhSP, sp.Price, lp.IDPizza, sz.TenSize, sz.PhuThuSize, lp.TenDeBanh, lp.PhuThuDeBanh
    FROM
        SanPham sp
    INNER JOIN
        LoaiPizza lp ON @IDPizza = lp.IDPizza
    INNER JOIN
        SizeSP sz ON lp.IDSize = sz.IDSize
    WHERE
        sp.IDSP = @IDSP;
END;


--Them đơn hàng và chi tiết đơn hàng--
CREATE PROCEDURE InsertOrderWithDetails
    @IDKH INT,
    @VoucherID INT = NULL,  -- Có thể không có voucher
    @AddressDelivery NVARCHAR(100),
	@TongTien INT,
	@Note NVARCHAR(255) = NULL,
    @PayType NVARCHAR(50)
AS
BEGIN  
    -- Thêm đơn hàng mới vào DonHang
    DECLARE @NewOrderID INT;
    INSERT INTO DonHang (IDKH, VoucherID, AddressDelivery, TongTien, Note, PayType)
    VALUES (@IDKH, @VoucherID, @AddressDelivery, @TongTien, @Note, @PayType);

    -- Lấy ID đơn hàng vừa tạo
    SET @NewOrderID = SCOPE_IDENTITY();

    -- Thêm chi tiết đơn hàng từ giỏ hàng vào CHITIETDONHANG
    INSERT INTO CHITIETDONHANG (IDSP, OrderID, IDPizza, Quantity, UnitPrice)
    SELECT GH.IDSP, @NewOrderID, GH.IDPizza, GH.SoLuong, SP.Price
    FROM GioHang GH
    JOIN SanPham SP ON GH.IDSP = SP.IDSP
    WHERE GH.IDKH = @IDKH;

    -- Xóa giỏ hàng của khách sau khi đặt hàng thành công
    DELETE FROM GioHang WHERE IDKH = @IDKH;
	-- Trả về OrderID
    SELECT @NewOrderID AS OrderID;
END;


--Thêm chi tiết đơn hàng--
 CREATE PROCEDURE sp_ThemChiTietDonHang
    @OrderID INT,
    @IDSP INT,
    @IDPizza INT,
    @Quantity INT,
    @UnitPrice INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO CHITIETDONHANG (OrderID, IDSP, IDPizza, Quantity, UnitPrice)
    VALUES (@OrderID, @IDSP, @IDPizza, @Quantity, @UnitPrice);
END;

 --Xem lại chi tiết đơn hàng--
 CREATE PROCEDURE SP_GetOrderDetailsByOrderID
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        SP.IDSP, 
        SP.TenSP, 
        SP.HinhSP, 
        SP.MoTaSP,
        SP.Price AS ProductPrice,
        CTDH.Quantity, 
        CTDH.UnitPrice,  
        CTDH.IDPizza,
        sz.TenSize, 
        sz.PhuThuSize, 
        LP.TenDeBanh, 
        LP.PhuThuDeBanh,
		((SP.Price + ISNULL(sz.PhuThuSize, 0) + ISNULL(Lp.PhuThuDeBanh, 0))* CTDH.Quantity) AS GrandTotal
    FROM DonHang DH
    JOIN CHITIETDONHANG CTDH ON DH.OrderID = CTDH.OrderID
    LEFT JOIN SanPham SP ON CTDH.IDSP = SP.IDSP
    LEFT JOIN LoaiPizza LP ON CTDH.IDPizza = LP.IDPizza
    LEFT JOIN SizeSP sz ON LP.IDSize = sz.IDSize
    JOIN KhachHang KH ON DH.IDKH = KH.IDKH
    WHERE DH.OrderID = @OrderID;
END;
