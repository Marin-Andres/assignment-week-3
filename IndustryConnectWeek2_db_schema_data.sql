USE [master]
GO
/****** Object:  Database [IndustryConnectWeek2]    Script Date: 24/08/2024 11:04:20 PM ******/
CREATE DATABASE [IndustryConnectWeek2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IndustryConnectWeek2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\IndustryConnectWeek2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IndustryConnectWeek2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\IndustryConnectWeek2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [IndustryConnectWeek2] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IndustryConnectWeek2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ARITHABORT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IndustryConnectWeek2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IndustryConnectWeek2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IndustryConnectWeek2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET RECOVERY FULL 
GO
ALTER DATABASE [IndustryConnectWeek2] SET  MULTI_USER 
GO
ALTER DATABASE [IndustryConnectWeek2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IndustryConnectWeek2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IndustryConnectWeek2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [IndustryConnectWeek2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'IndustryConnectWeek2', N'ON'
GO
ALTER DATABASE [IndustryConnectWeek2] SET QUERY_STORE = ON
GO
ALTER DATABASE [IndustryConnectWeek2] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [IndustryConnectWeek2]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCustomerAmount]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetCustomerAmount] (@CustomerId int)
returns money
as
begin
--declare @amount money;

return (select sum(price) from CustomerSales where [Customer Id] = @CustomerId);

--return @amount
end

GO
/****** Object:  UserDefinedFunction [dbo].[GetPersonAge]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[GetPersonAge] (@DateOfBirth datetime)
returns int
as
begin

return( select DATEDIFF(year,@DateOfBirth,GETDATE()))
/**** GETDATE() gets the current date when the function is executed ****/
/**** DATEDIFF provides the difference between two dates, first argument "year" returns only that DATEPART ****/
end 
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](30) NULL,
	[LastName] [nvarchar](40) NULL,
	[DateOfBirth] [datetime] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Active] [bit] NULL,
	[Price] [money] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[ProductId] [int] NULL,
	[DateSold] [datetime] NULL,
	[StoreId] [int] NULL,
 CONSTRAINT [PK_Sale] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerSales]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[CustomerSales]
as
select c.Id as 'Customer Id', c.FirstName, c.LastName, (c.FirstName + ' ' + c.LastName) as 'Full Name', s.DateSold, p.[Name], p.Price
, [dbo].[GetCustomerAmount](c.Id) as 'Total Purchases'
	from Customer c
		left join 
			Sale s on 
				c.Id = s.CustomerId
					left join 
						Product p on
							s.ProductId = p.Id 
GO
/****** Object:  Table [dbo].[Store]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Location] [nvarchar](100) NULL,
	[Continent] [nvarchar](50) NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (1, N'Andrew', N'Mckelvey', CAST(N'2000-12-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (2, N'Callum', N'Jones', CAST(N'2000-12-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (3, N'Abigail', N'Smith', CAST(N'1978-12-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (4, N'Jenny', N'Jones', CAST(N'2004-08-23T22:07:19.420' AS DateTime))
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (5, N'Fred', N'Jones', CAST(N'2004-08-23T22:07:37.377' AS DateTime))
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (7, N'Michael', N'Caine', CAST(N'1933-03-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (8, N'Nicolas', N'Cage', CAST(N'1964-01-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (9, N'Susan', N'Sarandon', CAST(N'1946-10-04T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (1, N'Washing Machine', N'Washing Machine', 1, 200.0000)
INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (2, N'Television', N'Television', 1, 450.0000)
INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (3, N'Toaster', N'Toaster', 1, 45.5000)
INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (4, N'Kettle', NULL, 1, 15.0000)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Sale] ON 

INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (1, 1, 2, CAST(N'2024-06-03T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (2, 2, 1, CAST(N'2024-06-03T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (3, 1, 3, CAST(N'2024-06-03T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (4, 1, 1, CAST(N'2024-08-23T21:52:46.710' AS DateTime), 1)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (5, 7, 4, CAST(N'2024-08-24T12:14:37.457' AS DateTime), 4)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (6, 8, 3, CAST(N'1945-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (7, 9, 2, CAST(N'2024-08-24T19:52:52.787' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Sale] OFF
GO
SET IDENTITY_INSERT [dbo].[Store] ON 

INSERT [dbo].[Store] ([Id], [Name], [Location], [Continent]) VALUES (1, N'San Jose District', N'Costa Rica', N'America')
INSERT [dbo].[Store] ([Id], [Name], [Location], [Continent]) VALUES (2, N'Batmania', N'Melbourne', N'Oceania')
INSERT [dbo].[Store] ([Id], [Name], [Location], [Continent]) VALUES (3, N'Le petit Paris', N'France', N'Europe')
INSERT [dbo].[Store] ([Id], [Name], [Location], [Continent]) VALUES (4, N'Verda Domo', N'Japan', N'Asia')
INSERT [dbo].[Store] ([Id], [Name], [Location], [Continent]) VALUES (1004, N'Cord Yuroy', N'Helsinki', N'Europe')
SET IDENTITY_INSERT [dbo].[Store] OFF
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Sale_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_Sale_Customer]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Sale_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_Sale_Product]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Sale_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_Sale_Store]
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 24/08/2024 11:04:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertProduct] @Name nvarchar(100), @Price money
as
begin
insert into [dbo].[Product]([Name], Price, Active)
values
(@Name,@Price,1)

end

GO
USE [master]
GO
ALTER DATABASE [IndustryConnectWeek2] SET  READ_WRITE 
GO
