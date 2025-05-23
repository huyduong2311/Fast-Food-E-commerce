USE [master]
GO
/****** Object:  Database [TheHomePizza2]    Script Date: 5/22/2025 8:27:28 PM ******/
CREATE DATABASE [TheHomePizza2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TheHomePizza2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TheHomePizza2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TheHomePizza2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TheHomePizza2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TheHomePizza2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TheHomePizza2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TheHomePizza2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TheHomePizza2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TheHomePizza2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TheHomePizza2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TheHomePizza2] SET ARITHABORT OFF 
GO
ALTER DATABASE [TheHomePizza2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TheHomePizza2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TheHomePizza2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TheHomePizza2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TheHomePizza2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TheHomePizza2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TheHomePizza2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TheHomePizza2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TheHomePizza2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TheHomePizza2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TheHomePizza2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TheHomePizza2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TheHomePizza2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TheHomePizza2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TheHomePizza2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TheHomePizza2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TheHomePizza2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TheHomePizza2] SET RECOVERY FULL 
GO
ALTER DATABASE [TheHomePizza2] SET  MULTI_USER 
GO
ALTER DATABASE [TheHomePizza2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TheHomePizza2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TheHomePizza2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TheHomePizza2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TheHomePizza2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TheHomePizza2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TheHomePizza2', N'ON'
GO
ALTER DATABASE [TheHomePizza2] SET QUERY_STORE = OFF
GO
USE [TheHomePizza2]
GO
/****** Object:  Table [dbo].[CHITIETDONHANG]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETDONHANG](
	[DetailOrderID] [int] IDENTITY(1,1) NOT NULL,
	[IDSP] [int] NULL,
	[OrderID] [int] NULL,
	[IDPizza] [int] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [int] NULL,
	[Note] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DetailOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[IDKH] [int] NULL,
	[VoucherID] [int] NULL,
	[NgayDat] [datetime] NULL,
	[AddressDelivery] [nvarchar](100) NULL,
	[TongTien] [int] NULL,
	[Note] [nvarchar](255) NULL,
	[PayType] [nvarchar](50) NULL,
	[IsPayment] [bit] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[IdFeedBack] [int] IDENTITY(1,1) NOT NULL,
	[IDSP] [int] NOT NULL,
	[IDKH] [int] NULL,
	[Rating] [int] NULL,
	[Comment] [nvarchar](1000) NULL,
	[CreatedAt] [datetime] NULL,
	[IsApproved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFeedBack] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[IDKH] [int] NULL,
	[IDSP] [int] NULL,
	[IDPizza] [int] NULL,
	[SoLuong] [int] NULL,
	[Note] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[IDKH] [int] IDENTITY(1,1) NOT NULL,
	[Password] [varchar](255) NULL,
	[TenKhachHang] [nvarchar](100) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](20) NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[ImageUser] [nvarchar](225) NULL,
	[RoleID] [int] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPizza]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPizza](
	[IDPizza] [int] IDENTITY(1,1) NOT NULL,
	[IDSize] [int] NULL,
	[TenDeBanh] [nvarchar](100) NULL,
	[PhuThuDeBanh] [int] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPizza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSP]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSP](
	[IDLoaiSP] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSP] [nvarchar](255) NULL,
	[IsActive] [bit] NULL,
	[Images] [nvarchar](225) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] NOT NULL,
	[RoleName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[IDSP] [int] IDENTITY(1,1) NOT NULL,
	[IDLoaiSP] [int] NULL,
	[TenSP] [nvarchar](100) NULL,
	[HinhSP] [nvarchar](255) NULL,
	[MoTaSP] [nvarchar](255) NULL,
	[Price] [int] NULL,
	[IsActive] [bit] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SizeSP]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SizeSP](
	[IDSize] [int] IDENTITY(1,1) NOT NULL,
	[TenSize] [nvarchar](100) NULL,
	[PhuThuSize] [int] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDSize] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[VoucherID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[CouponDiscount] [decimal](10, 2) NULL,
	[NgayTao] [datetime] NULL,
	[NgayHetHan] [date] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wishlist]    Script Date: 5/22/2025 8:27:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlist](
	[WishlistID] [int] IDENTITY(1,1) NOT NULL,
	[IDKH] [int] NULL,
	[IDSP] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[WishlistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CHITIETDONHANG] ON 

INSERT [dbo].[CHITIETDONHANG] ([DetailOrderID], [IDSP], [OrderID], [IDPizza], [Quantity], [UnitPrice], [Note]) VALUES (1, 35, 1, 1, 1, 290000, NULL)
INSERT [dbo].[CHITIETDONHANG] ([DetailOrderID], [IDSP], [OrderID], [IDPizza], [Quantity], [UnitPrice], [Note]) VALUES (2, 35, 1, 9, 1, 290000, NULL)
INSERT [dbo].[CHITIETDONHANG] ([DetailOrderID], [IDSP], [OrderID], [IDPizza], [Quantity], [UnitPrice], [Note]) VALUES (3, 35, 1, 9, 1, 290000, NULL)
INSERT [dbo].[CHITIETDONHANG] ([DetailOrderID], [IDSP], [OrderID], [IDPizza], [Quantity], [UnitPrice], [Note]) VALUES (4, 34, 1, NULL, 1, 100000, NULL)
INSERT [dbo].[CHITIETDONHANG] ([DetailOrderID], [IDSP], [OrderID], [IDPizza], [Quantity], [UnitPrice], [Note]) VALUES (5, 22, 2, 9, 2, 978000, NULL)
INSERT [dbo].[CHITIETDONHANG] ([DetailOrderID], [IDSP], [OrderID], [IDPizza], [Quantity], [UnitPrice], [Note]) VALUES (6, 22, 2, 8, 1, 419000, NULL)
SET IDENTITY_INSERT [dbo].[CHITIETDONHANG] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([OrderID], [IDKH], [VoucherID], [NgayDat], [AddressDelivery], [TongTien], [Note], [PayType], [IsPayment], [TrangThai]) VALUES (1, 3, NULL, CAST(N'2025-05-18T10:30:06.403' AS DateTime), N'42914k Lê Văn Sỹ  Xã Đông Cửu Huyện Thanh Sơn Tỉnh Phú Thọ', 1630000, N'', N'Ship COD', 0, N'Hủy đơn')
INSERT [dbo].[DonHang] ([OrderID], [IDKH], [VoucherID], [NgayDat], [AddressDelivery], [TongTien], [Note], [PayType], [IsPayment], [TrangThai]) VALUES (2, 2059, NULL, CAST(N'2025-05-18T10:32:53.713' AS DateTime), N'429/14L Lê Văn Sỹ  Phường Tân Hồng Thành phố Từ Sơn Tỉnh Bắc Ninh', 1397000, N'ngon nha', N'Ship COD', 0, N'Hủy đơn')
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (2, 18, 3, 4, N'salad ngon', CAST(N'2025-03-03T19:08:54.487' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (3, 18, 3, 5, N'salad ngon', CAST(N'2025-03-03T19:09:23.533' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (4, 18, 3, 2, N'tệ', CAST(N'2025-03-03T20:31:08.753' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (5, 16, 3, 5, N'đế bánh dày rất ngon ', CAST(N'2025-03-03T20:32:16.723' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (6, 19, 3, 2, N'món chưa đặt biệt lắm', CAST(N'2025-03-03T20:33:11.697' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (8, 19, 3, 4, N'ngon ', CAST(N'2025-03-03T22:37:57.283' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (9, 23, 3, 1, N'tệ', CAST(N'2025-03-03T22:38:32.003' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (10, 19, 1, 2, N'dở v', CAST(N'2025-03-06T15:37:46.663' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (11, 16, 1, 4, N'ngon

', CAST(N'2025-03-08T10:14:25.247' AS DateTime), 0)
INSERT [dbo].[Feedback] ([IdFeedBack], [IDSP], [IDKH], [Rating], [Comment], [CreatedAt], [IsApproved]) VALUES (12, 16, 1, 3, N'ngon quá', CAST(N'2025-03-09T11:28:09.503' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1, N'1234', N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0562176774', N'42914k Lê Văn Sỹ  Xã Vĩnh Lại Huyện Lâm Thao Tỉnh Phú Thọ', N'user_default.png', 1, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (3, N'1234', N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0903313406', N'123 Xã Trung Kiên Huyện Yên Lạc Tỉnh Vĩnh Phúc', N'user_default.png', 3, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1052, NULL, N'Huy Đoàn', N'quochuyduong7@gmail.com', N'0127837183', N'123 Nguyễn Huệ Thị trấn Đạo Đức Huyện Bình Xuyên Tỉnh Vĩnh Phúc', N'user_default.png', 2, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1053, N'Qc_huy231103', N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0972134151', N'123 Quang trung Phường Ninh Xá Thị xã Thuận Thành Tỉnh Bắc Ninh', N'user_default.png', 3, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1054, NULL, N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0812387123', N'123 Quang Trung Phường Ninh Xá Thị xã Thuận Thành Tỉnh Bắc Ninh', N'user_default.png', 2, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1055, NULL, N'huy', N'quochuyduong7@gmail.com', N'0213897183', N'123 Quang trung  Xã Tề Lễ Huyện Tam Nông Tỉnh Phú Thọ', N'user_default.png', 2, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1056, NULL, N'huy', N'quochuyduong7@gmail.com', N'0312783713', N'123 Quang trung  Xã Tiên Động Huyện Tứ Kỳ Tỉnh Hải Dương', N'user_default.png', 2, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1057, NULL, N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0128391742', N'123 Quang trung  Xã Cao Xá Huyện Lâm Thao Tỉnh Phú Thọ', N'user_default.png', 2, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1058, NULL, N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0872831333', N'123 Nguyễn Huệ Xã Cao Xá Huyện Lâm Thao Tỉnh Phú Thọ', N'user_default.png', 2, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (1059, NULL, N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0128313321', N'123 quang trung Xã Đồng Trung Huyện Thanh Thuỷ Tỉnh Phú Thọ', N'user_default.png', 2, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (2059, N'123', N'Dương Quốc Huy', N'quochuyduong7@gmail.com', N'0239128313', N'429/14L Lê Văn Sỹ  Phường Tân Hồng Thành phố Từ Sơn Tỉnh Bắc Ninh', N'user_default.png', 3, 1)
INSERT [dbo].[KhachHang] ([IDKH], [Password], [TenKhachHang], [Email], [Phone], [DiaChi], [ImageUser], [RoleID], [IsActive]) VALUES (2060, NULL, N'Huy vô tâm', N'quochuyduong7@gmail.com', N'0792030395', N'', N'user_default.png', 2, 1)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiPizza] ON 

INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (1, 1, N'Dày', 0, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (2, 2, N'Dày', 0, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (3, 2, N'Mỏng giòn', 0, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (4, 2, N'Viền phô mai', 50000, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (5, 2, N'Viền phô mai xúc xích', 100000, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (6, 3, N'Dày', 0, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (7, 3, N'Mỏng giòn', 0, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (8, 3, N'Viền phô mai', 70000, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (9, 3, N'Viền phô mai xúc xích', 140000, 1)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (13, 18, N'Dày', 100000, 0)
INSERT [dbo].[LoaiPizza] ([IDPizza], [IDSize], [TenDeBanh], [PhuThuDeBanh], [IsActive]) VALUES (14, 2, N'cực giòn', 100000, 0)
SET IDENTITY_INSERT [dbo].[LoaiPizza] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiSP] ON 

INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (1, N'Pizza', 1, N'loaipizza.jpg')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (2, N'Mỳ Ý', 1, N'loaipasta.png')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (3, N'Salad', 1, N'loaisalad.jpg')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (4, N'Khai Vị', 1, N'loaikhaivi.jpg')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (5, N'Thức uống', 0, N'loaidouong.png')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (43, N'tráng miệng', 0, N'Slide3.png')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (44, N'tráng miệng', 0, N'Slide2.png')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (45, N'Nui Bỏ Lò', 1, N'nui4.png')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (46, N'Gà Chất', 1, N'chicken04.png')
INSERT [dbo].[LoaiSP] ([IDLoaiSP], [TenLoaiSP], [IsActive], [Images]) VALUES (47, N'Thức uống', 1, N'nuoc1.png')
SET IDENTITY_INSERT [dbo].[LoaiSP] OFF
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Khách vãng lai')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Khách hàng thân thiết')
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (16, 1, N'Pizza Hải Sản Pesto Xanh', N'pizza01.png', N'Tôm-thanh cua-mực và bông cải xanh tươi ngon trên nền sốt Pesto Xanh', 169000, 1, N'Best Saler')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (17, 2, N'Mỳ Ý thịt bò bằm', N'pasta01.png', N'Sốt thịt bò bằm đặc trưng kết hợp cùng mỳ Ý', 149000, 0, N'Phổ biến')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (18, 3, N'Salad Đặc Sắc', N'salad3.png', N'Salad rau và trái cây tươi dùng kèm xốt kem đặc biệt của The Hom Pizza', 89000, 1, N'Phổ biến')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (19, 4, N'Sườn Siêu Sao (10 miếng)', N'khaivi05.png', N'Combo Sườn nướng BBQ dùng với khoai tây chiên và Salad', 489000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (20, 47, N'Pepsi Lon', N'nuoc1.png', N'Nước giải khát', 29000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (21, 3, N'Salad Da Cá Hồi', N'salad02.png', N'Salad với da cá hồi giòn với bắp cải đỏ-cà chua bi-ngô với sốt Yuzu', 89000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (22, 1, N'Pizza Hải Sản Nhiệt Đới', N'pizza02.png', N'Tôm-nghêu-mực-thanh cua-dứa với sốt Thousand Island', 159000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (23, 4, N'Gà Nướng BBQ (5 miếng)', N'chicken02.jpeg', N'Thịt gà mềm ngọt-thấm đẫm gia vị-da gà giòn rụm-màu vàng ươm bắt mắt.', 219000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (24, 4, N'Khai Vị Tổng Hợp (Cánh gà chiên giòn)', N'khaivi01.jpeg', N'Cánh gà chiên giòn-bánh mì tỏi nướng và khoai tây chiên', 179000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (25, 4, N'Tôm Bơ tỏi và Bánh Mì Nướng', N'khaivi03.jpeg', N'Tôm tươi đút lò với tỏi-bơ dùng kèm bánh mì nướng bơ tỏi', 129000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (26, 4, N'Bánh Phô Mai Xoắn', N'khaivi02.jpeg', N'Phô mai trắng được nướng với bơ-tỏi và dùng kèm sốt Cocktail', 119000, 1, N'Sale ')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (27, 2, N'Mỳ Ý Nghêu Xốt Cay', N'pasta02.png', N'Mỳ ý với sự kết hợp hoàn hảo giữa vị xốt cay nồng và vị ngọt thanh của nghêu-đảm bảo sẽ làm bạn thích thú.', 139000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (28, 3, N'Cánh gà nướng BBQ (20 miếng)', N'chicken04.png', N'ngon lắm', 120000, 0, N'bán chạy')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (29, 4, N'Mực Chiên Giòn', N'khaivi06.png', N'Mực tẩm bột chiên giòn dùng kèm sốt ngò tây.', 129000, 0, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (30, 1, N'Pizza Thịt Nguội Kiểu Canada', N'pizza03.png', N'ngon', 200000, 0, N'NSale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (31, 2, N'Pizza Thịt Nguội Kiểu', N'pizza04.png', N'ngon2', 149000, 0, N'Phổ biến')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (32, 2, N'pizza aloha 2', N'loaipasta.png', N'ngon lắm pro', 200000, 0, N'Phổ biến')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (34, 2, N'mỳ cay', N'loaipasta.png', N'ngon', 100000, 0, N'bán chạy')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (35, 1, N'Pizza thịt nguội', N'pizza03.png', N'Pizza vừa có thịt vừa nguội', 290000, 0, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1035, 43, N'khoai tây chiên', N'khaivi06.png', N'khoai tươi ngon ', 120000, 0, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1036, 44, N'khoai tây chiên', N'khaivi04.jpeg', N'ngon', 120000, 0, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1037, 1, N'Pizza Thịt Nguội Kiểu Canada', N'pizza03.png', N'Sự kết hợp giữa thịt nguội và bắp ngọt', 149000, 1, N' Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1038, 1, N'Pizza Aloha', N'pizza04.png', N'Thịt nguội-xúc xích và dứa hòa quyện với sốt Thousand Island', 149000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1039, 2, N'Mì Ý Pesto', N'pasta3.png', N'Các loại nguyên liệu hải sản hảo hạng: Tôm-mực hoà quyện trên nền sốt Pesto xanh đậm vị thơm hương đặc trưng từ lá húng tây – mang đậm nét truyền thống ẩm thực Ý.', 149000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1040, 2, N'Mỳ Ý Cay Hải Sản', N'pasta4.png', N'Mỳ Ý rán với các loại hải sản tươi ngon cùng ớt và tỏi', 139000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1041, 2, N'Mỳ Ý Nghêu Xốt Húng Quế', N'pasta2.png', N'Mỳ ý với xốt húng quế thơm lừng đậm đà hương vị đặc trưng kết hợp tinh tế với nghêu mang lại cảm giác tươi mát và sảng khoái.', 139000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1042, 3, N'Salad Gà Giòn Không Xương', N'salad2.png', N'Salad Gà giòn với trứng cút-thịt xông khói-phô mai parmesan và sốt Thousand Island', 89000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1043, 3, N'Salad Trộn Sốt Caesar', N'salad4.png', N'Rau tươi trộn với sốt Caesar', 89000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1044, 47, N'7UP Lon', N'nuoc2.png', N'Nước giải khát', 29000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1045, 47, N'Pepsi không calo vị chanh', N'nuoc4.png', N'Nước giải khát', 29000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1046, 47, N'Mirinda', N'nuoc3.png', N'Nước giải khát', 89000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1047, 45, N'Nui Bỏ Lò Hải Sản Sốt Hương Nhu', N'nui1.png', N'Đánh thức vị giác với sốt hương nhu độc đáo kết hợp cùng hải sản tươi ngon đậm đà', 79000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1048, 45, N'Nui Bỏ Lò Gà BBQ Sốt Hương Nhu', N'nui2.png', N'Sự kết hợp hoàn hảo giữa thịt gà BBQ và sốt hương nhu cùng nhiều nguyên liệu tạo mùi thơm hấp dẫn như rau quế-ớt-hành tây- tỏi…khiến hương vị thêm đậm đà', 79000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1049, 45, N'Nui Bỏ Lò Phô Mai Thịt Nguội & Nấm Sốt Kem', N'nui3.png', N'Thịt nguội và nấm hòa quyện trong sốt kem phủ phô mai', 79000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1050, 45, N'Nui Bỏ Lò Phô Mai Gà Bơ Tỏi & Nấm Sốt Kem', N'nui4.png', N'Gà bơ tỏi và nấm hoà quyện trong sốt kem phủ phô mai cùng với lá mùi tây tạo hương thơm hấp dẫn', 79000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1051, 46, N'Gà Nướng BBQ (2 miếng)', N'ga1.png', N'Thịt gà mềm ngọt thấm đẫm gia vị da gà giòn rụm màu vàng ươm bắt mắt.', 119000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1052, 46, N'Gà Nướng BBQ (5 miếng)', N'ga2.png', N'Thịt gà mềm ngọt thấm đẫm gia vị da gà giòn rụm màu vàng ươm bắt mắt.', 249000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1053, 46, N'Gà Nướng BBQ (9 miếng)', N'ga3.png', N'Thịt gà mềm ngọt thấm đẫm gia vị da gà giòn rụm màu vàng ươm bắt mắt.', 429000, 1, N'Sale')
INSERT [dbo].[SanPham] ([IDSP], [IDLoaiSP], [TenSP], [HinhSP], [MoTaSP], [Price], [IsActive], [TrangThai]) VALUES (1054, 46, N'Gà Giòn Xốt Bơ Tỏi - 5 miếng', N'ga4.png', N'Thịt gà mọng nước với lớp da áo bột mỏng tang giòn rụm phủ xốt bơ tỏi đậm đà và tỏi phi vàng giòn tạo nên hương thơm lừng kích thích vị giác.', 249000, 1, N'Sale')
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[SizeSP] ON 

INSERT [dbo].[SizeSP] ([IDSize], [TenSize], [PhuThuSize], [IsActive]) VALUES (1, N'Nhỏ 6', 0, 1)
INSERT [dbo].[SizeSP] ([IDSize], [TenSize], [PhuThuSize], [IsActive]) VALUES (2, N'Vừa 9', 80000, 1)
INSERT [dbo].[SizeSP] ([IDSize], [TenSize], [PhuThuSize], [IsActive]) VALUES (3, N'Lớn 12', 190000, 1)
INSERT [dbo].[SizeSP] ([IDSize], [TenSize], [PhuThuSize], [IsActive]) VALUES (18, N'XXL', 200000, 0)
SET IDENTITY_INSERT [dbo].[SizeSP] OFF
GO
SET IDENTITY_INSERT [dbo].[Voucher] ON 

INSERT [dbo].[Voucher] ([VoucherID], [Code], [CouponDiscount], [NgayTao], [NgayHetHan], [IsActive]) VALUES (1, N'SALE10', CAST(0.10 AS Decimal(10, 2)), CAST(N'2025-01-16T08:24:52.760' AS DateTime), CAST(N'2025-12-31' AS Date), 1)
INSERT [dbo].[Voucher] ([VoucherID], [Code], [CouponDiscount], [NgayTao], [NgayHetHan], [IsActive]) VALUES (2, N'SALE20', CAST(0.20 AS Decimal(10, 2)), CAST(N'2025-01-16T08:24:52.760' AS DateTime), CAST(N'2025-11-30' AS Date), 1)
INSERT [dbo].[Voucher] ([VoucherID], [Code], [CouponDiscount], [NgayTao], [NgayHetHan], [IsActive]) VALUES (3, N'BLACKFRIDAY', CAST(0.50 AS Decimal(10, 2)), CAST(N'2025-01-16T08:24:52.760' AS DateTime), CAST(N'2025-11-29' AS Date), 1)
INSERT [dbo].[Voucher] ([VoucherID], [Code], [CouponDiscount], [NgayTao], [NgayHetHan], [IsActive]) VALUES (4, N'SUMMER15', CAST(0.15 AS Decimal(10, 2)), CAST(N'2025-01-16T08:24:52.760' AS DateTime), CAST(N'2024-08-31' AS Date), 0)
INSERT [dbo].[Voucher] ([VoucherID], [Code], [CouponDiscount], [NgayTao], [NgayHetHan], [IsActive]) VALUES (5, N'NEWYEAR25', CAST(0.25 AS Decimal(10, 2)), CAST(N'2025-01-16T08:24:52.760' AS DateTime), CAST(N'2025-01-01' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Voucher] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__KhachHan__5C7E359EA83EC572]    Script Date: 5/22/2025 8:27:39 PM ******/
ALTER TABLE [dbo].[KhachHang] ADD UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Voucher__A25C5AA72070D68B]    Script Date: 5/22/2025 8:27:39 PM ******/
ALTER TABLE [dbo].[Voucher] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (getdate()) FOR [NgayDat]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [IsPayment]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (N'Chưa xác nhận') FOR [TrangThai]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[KhachHang] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[LoaiPizza] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[LoaiSP] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SizeSP] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CHITIETDONHANG]  WITH CHECK ADD FOREIGN KEY([IDPizza])
REFERENCES [dbo].[LoaiPizza] ([IDPizza])
GO
ALTER TABLE [dbo].[CHITIETDONHANG]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[DonHang] ([OrderID])
GO
ALTER TABLE [dbo].[CHITIETDONHANG]  WITH CHECK ADD FOREIGN KEY([IDSP])
REFERENCES [dbo].[SanPham] ([IDSP])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([IDKH])
REFERENCES [dbo].[KhachHang] ([IDKH])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([VoucherID])
REFERENCES [dbo].[Voucher] ([VoucherID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Product] FOREIGN KEY([IDSP])
REFERENCES [dbo].[SanPham] ([IDSP])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Product]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_User] FOREIGN KEY([IDKH])
REFERENCES [dbo].[KhachHang] ([IDKH])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_User]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([IDKH])
REFERENCES [dbo].[KhachHang] ([IDKH])
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([IDPizza])
REFERENCES [dbo].[LoaiPizza] ([IDPizza])
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([IDSP])
REFERENCES [dbo].[SanPham] ([IDSP])
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[LoaiPizza]  WITH CHECK ADD FOREIGN KEY([IDSize])
REFERENCES [dbo].[SizeSP] ([IDSize])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([IDLoaiSP])
REFERENCES [dbo].[LoaiSP] ([IDLoaiSP])
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD FOREIGN KEY([IDKH])
REFERENCES [dbo].[KhachHang] ([IDKH])
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD FOREIGN KEY([IDSP])
REFERENCES [dbo].[SanPham] ([IDSP])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [CK_TrangThai] CHECK  (([TrangThai]=N'Hủy đơn' OR [TrangThai]=N'Đã giao' OR [TrangThai]=N'Đang giao' OR [TrangThai]=N'Chưa xác nhận'))
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [CK_TrangThai]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[AddFeedback]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm đánh giá sản phẩm--
CREATE PROCEDURE [dbo].[AddFeedback]
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
GO
/****** Object:  StoredProcedure [dbo].[GetFeedback]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFeedback]
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
GO
/****** Object:  StoredProcedure [dbo].[InsertOrderWithDetails]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Them đơn hàng và chi tiết đơn hàng--
CREATE PROCEDURE [dbo].[InsertOrderWithDetails]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCartItems]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCartItems]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCartItems2]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Hiển thị các sản phẩm trong giỏ hàng Session--
CREATE PROCEDURE [dbo].[sp_GetCartItems2]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCrustByProductAndSize]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCrustByProductAndSize]
    @TenSP NVARCHAR(100),
    @IDSize INT
AS
BEGIN
    SELECT DISTINCT
        cp.IDCrust,
        cp.TenDeBanh,
        cp.PhuThuDeBanh
    FROM SanPham sp
    JOIN CrustPizza cp ON sp.CrustPizza = cp.IDCrust
    WHERE sp.TenSP = @TenSP AND sp.Size = @IDSize
    ORDER BY cp.PhuThuDeBanh;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNewestProductsByCategory]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetNewestProductsByCategory]
    @IDLoaiSP INT
AS
BEGIN
    SELECT TOP 6 IDSP, TenSP, HinhSP, MoTaSP, Price
    FROM SanPham
    WHERE IDLoaiSP = @IDLoaiSP
    ORDER BY IDSP DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOrderDetailsByOrderID]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Xem lại chi tiết đơn hàng--
 CREATE PROCEDURE [dbo].[SP_GetOrderDetailsByOrderID]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductByID]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetProductByID]
    @IDSP INT
AS
BEGIN
    SELECT
        sp.IDSP,
        sp.TenSP,
        sp.HinhSP,
        sp.MoTaSP,
        sp.Price,
        sz.TenSize,
        sz.PhuThuSize,
        cp.TenDeBanh,
        cp.PhuThuDeBanh
    FROM SanPham sp
    LEFT JOIN Size sz ON sp.Size = sz.IDSize
    LEFT JOIN CrustPizza cp ON sp.CrustPizza = cp.IDCrust
    WHERE sp.IDSP = @IDSP AND sp.IsActive = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductSizesByName]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetProductSizesByName]
    @TenSP NVARCHAR(100)
AS
BEGIN
    SELECT DISTINCT
        sz.IDSize,
        sz.TenSize,
        sz.PhuThuSize
    FROM SanPham sp
    JOIN Size sz ON sp.Size = sz.IDSize
    WHERE sp.TenSP = @TenSP 
    ORDER BY sz.PhuThuSize;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemChiTietDonHang]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ThemChiTietDonHang]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemGioHang]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ThemGioHang]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemGioHang2]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ThemGioHang2]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemKH]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ThemKH]
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
GO
/****** Object:  StoredProcedure [dbo].[THEMLOAISP]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[THEMLOAISP]  @TenLoai NVARCHAR(100),
						@HINHMINHHOA NVARCHAR(100)				
AS
BEGIN
	INSERT INTO LOAISP (TenLoaiSP, Images)
    VALUES(@TenLoai,@HINHMINHHOA)
END
GO
/****** Object:  StoredProcedure [dbo].[THEMSP]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[THEMSP]  @IDLOAISP INT,
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
GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sửa sản phẩm--
CREATE PROC [dbo].[UpdateProduct] 
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
GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 5/22/2025 8:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateUser]
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
GO
USE [master]
GO
ALTER DATABASE [TheHomePizza2] SET  READ_WRITE 
GO
