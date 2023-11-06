USE [master]
GO
/****** Object:  Database [HMSDB]    Script Date: 2023-11-05 7:15:21 PM ******/
CREATE DATABASE [HMSDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HMSDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019EXPRESS\MSSQL\DATA\HMSDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HMSDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019EXPRESS\MSSQL\DATA\HMSDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HMSDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HMSDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HMSDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HMSDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HMSDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HMSDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HMSDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HMSDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HMSDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HMSDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HMSDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HMSDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HMSDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HMSDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HMSDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HMSDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HMSDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HMSDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HMSDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HMSDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HMSDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HMSDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HMSDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HMSDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HMSDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HMSDB] SET  MULTI_USER 
GO
ALTER DATABASE [HMSDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HMSDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HMSDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HMSDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HMSDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HMSDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HMSDB] SET QUERY_STORE = OFF
GO
USE [HMSDB]
GO
/****** Object:  Table [dbo].[tbl_booking]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_booking](
	[booking_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_name] [varchar](250) NOT NULL,
	[customer_address] [nvarchar](550) NOT NULL,
	[customer_email] [nvarchar](550) NOT NULL,
	[customer_phone_no] [nvarchar](50) NOT NULL,
	[booking_from] [date] NOT NULL,
	[booking_to] [date] NOT NULL,
	[payment_type] [int] NOT NULL,
	[assigned_room] [int] NOT NULL,
	[no_of_members] [tinyint] NULL,
	[total_amount] [decimal](18, 2) NULL,
 CONSTRAINT [pk_booking_id] PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_booking_status]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_booking_status](
	[booking_status_id] [int] IDENTITY(1,1) NOT NULL,
	[booking_status] [varchar](250) NOT NULL,
 CONSTRAINT [pk_booking_status_id] PRIMARY KEY CLUSTERED 
(
	[booking_status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_client]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_client](
	[clientID] [int] IDENTITY(1,1) NOT NULL,
	[clientName] [nvarchar](100) NULL,
	[clientEmail] [nvarchar](250) NULL,
	[clientPassword] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_client] PRIMARY KEY CLUSTERED 
(
	[clientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_payment]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_payment](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[booking_id] [tinyint] NOT NULL,
	[payment_type_id] [int] NOT NULL,
	[payment_amount] [decimal](18, 2) NOT NULL,
	[Is_Active] [bit] NULL,
 CONSTRAINT [pk_payment_id] PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_payment_type]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_payment_type](
	[payment_type_id] [int] IDENTITY(1,1) NOT NULL,
	[payment_type] [varchar](50) NOT NULL,
 CONSTRAINT [pk_payment_type_id] PRIMARY KEY CLUSTERED 
(
	[payment_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_room]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_room](
	[room_id] [int] IDENTITY(1,1) NOT NULL,
	[room_number] [varchar](50) NOT NULL,
	[room_type_id] [int] NOT NULL,
	[booking_status_id] [int] NOT NULL,
	[is_Active] [bit] NULL,
 CONSTRAINT [pk_room_id] PRIMARY KEY CLUSTERED 
(
	[room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_room_type]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_room_type](
	[room_type_id] [int] IDENTITY(1,1) NOT NULL,
	[room_name] [varchar](50) NOT NULL,
	[description] [nvarchar](255) NOT NULL,
	[room_price] [decimal](18, 2) NULL,
	[room_capacity] [tinyint] NOT NULL,
 CONSTRAINT [pk_room_type_id] PRIMARY KEY CLUSTERED 
(
	[room_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_user]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user](
	[userid] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[user_password] [nvarchar](255) NOT NULL,
	[user_level] [int] NOT NULL,
 CONSTRAINT [pk_user_id] PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_user_level]    Script Date: 2023-11-05 7:15:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user_level](
	[user_level_id] [int] IDENTITY(1,1) NOT NULL,
	[user_type] [varchar](255) NOT NULL,
 CONSTRAINT [pk_user_level_id] PRIMARY KEY CLUSTERED 
(
	[user_level_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_booking] ADD  DEFAULT ((2)) FOR [no_of_members]
GO
ALTER TABLE [dbo].[tbl_booking] ADD  DEFAULT ((2000)) FOR [total_amount]
GO
ALTER TABLE [dbo].[tbl_payment] ADD  DEFAULT ((0)) FOR [Is_Active]
GO
ALTER TABLE [dbo].[tbl_room] ADD  DEFAULT ((0)) FOR [is_Active]
GO
ALTER TABLE [dbo].[tbl_room_type] ADD  CONSTRAINT [df_room_price]  DEFAULT ((3000)) FOR [room_price]
GO
ALTER TABLE [dbo].[tbl_booking]  WITH CHECK ADD  CONSTRAINT [FK_ass_room_Id] FOREIGN KEY([assigned_room])
REFERENCES [dbo].[tbl_room] ([room_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_booking] CHECK CONSTRAINT [FK_ass_room_Id]
GO
ALTER TABLE [dbo].[tbl_booking]  WITH CHECK ADD  CONSTRAINT [FK_paytyp_pay_Id] FOREIGN KEY([payment_type])
REFERENCES [dbo].[tbl_payment_type] ([payment_type_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_booking] CHECK CONSTRAINT [FK_paytyp_pay_Id]
GO
ALTER TABLE [dbo].[tbl_payment]  WITH CHECK ADD  CONSTRAINT [fk_payment_type] FOREIGN KEY([payment_type_id])
REFERENCES [dbo].[tbl_payment_type] ([payment_type_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_payment] CHECK CONSTRAINT [fk_payment_type]
GO
ALTER TABLE [dbo].[tbl_room]  WITH CHECK ADD  CONSTRAINT [FK_booking_status] FOREIGN KEY([booking_status_id])
REFERENCES [dbo].[tbl_booking_status] ([booking_status_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_room] CHECK CONSTRAINT [FK_booking_status]
GO
ALTER TABLE [dbo].[tbl_room]  WITH CHECK ADD  CONSTRAINT [fk_room_type] FOREIGN KEY([room_type_id])
REFERENCES [dbo].[tbl_room_type] ([room_type_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_room] CHECK CONSTRAINT [fk_room_type]
GO
ALTER TABLE [dbo].[tbl_user]  WITH CHECK ADD  CONSTRAINT [FK_usr_level_no] FOREIGN KEY([user_level])
REFERENCES [dbo].[tbl_user_level] ([user_level_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_user] CHECK CONSTRAINT [FK_usr_level_no]
GO
USE [master]
GO
ALTER DATABASE [HMSDB] SET  READ_WRITE 
GO
