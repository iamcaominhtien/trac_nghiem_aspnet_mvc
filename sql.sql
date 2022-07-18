USE [master]
GO
/****** Object:  Database [trac_nghiem]    Script Date: 7/17/2022 9:44:39 PM ******/
CREATE DATABASE [trac_nghiem]
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [trac_nghiem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [trac_nghiem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [trac_nghiem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [trac_nghiem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [trac_nghiem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [trac_nghiem] SET ARITHABORT OFF 
GO
ALTER DATABASE [trac_nghiem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [trac_nghiem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [trac_nghiem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [trac_nghiem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [trac_nghiem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [trac_nghiem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [trac_nghiem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [trac_nghiem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [trac_nghiem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [trac_nghiem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [trac_nghiem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [trac_nghiem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [trac_nghiem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [trac_nghiem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [trac_nghiem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [trac_nghiem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [trac_nghiem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [trac_nghiem] SET RECOVERY FULL 
GO
ALTER DATABASE [trac_nghiem] SET  MULTI_USER 
GO
ALTER DATABASE [trac_nghiem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [trac_nghiem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [trac_nghiem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [trac_nghiem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [trac_nghiem] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'trac_nghiem', N'ON'
GO
ALTER DATABASE [trac_nghiem] SET QUERY_STORE = OFF
GO
USE [trac_nghiem]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [trac_nghiem]
GO
/****** Object:  Table [dbo].[do_exam]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[do_exam](
	[score] [float] NULL,
	[chose] [nvarchar](100) NULL,
	[note] [text] NULL,
	[statrt_time] [datetime] NULL,
	[finsh_time] [datetime] NULL,
	[id_exam] [bigint] NOT NULL,
	[id_student] [bigint] NOT NULL,
	[id_question] [bigint] NOT NULL,
 CONSTRAINT [PK_do_exam_1] PRIMARY KEY CLUSTERED 
(
	[id_exam] ASC,
	[id_student] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exam_question]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exam_question](
	[id_exam] [bigint] NOT NULL,
	[id_question] [bigint] NOT NULL,
	[note] [nvarchar](500) NULL,
	[date_create] [datetime] NULL,
 CONSTRAINT [PK_exam_question] PRIMARY KEY CLUSTERED 
(
	[id_exam] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exams]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exams](
	[id_exam] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[time_to_do] [int] NULL,
	[date_create] [datetime] NULL,
	[note] [nvarchar](500) NULL,
	[id_subject_grade] [bigint] NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_exams] PRIMARY KEY CLUSTERED 
(
	[id_exam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fields]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fields](
	[id_field] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[date_create] [datetime] NULL,
 CONSTRAINT [PK_fields] PRIMARY KEY CLUSTERED 
(
	[id_field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[grades]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grades](
	[id_grade] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[date_create] [datetime] NULL,
	[id_field] [bigint] NULL,
 CONSTRAINT [PK_grades] PRIMARY KEY CLUSTERED 
(
	[id_grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question_types]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question_types](
	[id_question_type] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[note] [nvarchar](500) NULL,
	[date_create] [datetime] NULL,
 CONSTRAINT [PK_question_types] PRIMARY KEY CLUSTERED 
(
	[id_question_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[questions]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questions](
	[id_question] [bigint] IDENTITY(1,1) NOT NULL,
	[id_question_type] [bigint] NULL,
	[avatar] [nvarchar](200) NULL,
	[question] [nvarchar](200) NULL,
	[answer_1] [nvarchar](100) NULL,
	[answer_2] [nvarchar](100) NULL,
	[answer_3] [nvarchar](100) NULL,
	[answer_4] [nvarchar](100) NULL,
	[correct] [nvarchar](100) NULL,
	[note] [nvarchar](500) NULL,
	[date_create] [datetime] NULL,
 CONSTRAINT [PK_questions] PRIMARY KEY CLUSTERED 
(
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rights]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rights](
	[id_right] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nchar](10) NULL,
	[note] [text] NULL,
	[date_create] [datetime] NULL,
 CONSTRAINT [PK_rights] PRIMARY KEY CLUSTERED 
(
	[id_right] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[score_of_exam]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[score_of_exam](
	[id_exam] [bigint] NOT NULL,
	[id_student] [bigint] NOT NULL,
	[score] [float] NULL,
	[note] [nvarchar](500) NULL,
	[start_time] [datetime] NULL,
	[finish_time] [datetime] NULL,
 CONSTRAINT [PK_score_of_exam] PRIMARY KEY CLUSTERED 
(
	[id_exam] ASC,
	[id_student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject_grade]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject_grade](
	[id_subject_grade] [bigint] IDENTITY(1,1) NOT NULL,
	[id_subject] [bigint] NOT NULL,
	[id_grade] [bigint] NOT NULL,
	[id_teacher] [bigint] NULL,
	[note] [nvarchar](500) NULL,
 CONSTRAINT [PK_subject_grade_1] PRIMARY KEY CLUSTERED 
(
	[id_subject_grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject_student]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject_student](
	[id_subject_grade] [bigint] NOT NULL,
	[id_student] [bigint] NOT NULL,
	[note] [nvarchar](500) NULL,
 CONSTRAINT [PK_subject_student] PRIMARY KEY CLUSTERED 
(
	[id_subject_grade] ASC,
	[id_student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subjects]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subjects](
	[id_subject] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[date_create] [datetime] NULL,
 CONSTRAINT [PK_subjects] PRIMARY KEY CLUSTERED 
(
	[id_subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id_user] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [nchar](20) NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [nchar](100) NOT NULL,
	[email] [nchar](50) NULL,
	[avatar] [nchar](200) NULL,
	[gender] [bit] NULL,
	[birthday] [date] NULL,
	[date_create] [datetime] NULL,
	[id_right] [bigint] NULL,
	[id_grade] [bigint] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, NULL, CAST(N'2022-07-17T19:51:19.050' AS DateTime), 9, 10018, 91)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, NULL, CAST(N'2022-07-17T19:51:51.683' AS DateTime), 9, 10018, 93)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, NULL, CAST(N'2022-07-17T19:51:46.603' AS DateTime), 9, 10018, 94)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, NULL, CAST(N'2022-07-17T19:51:39.593' AS DateTime), 9, 10018, 95)
GO
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (7, 71, NULL, CAST(N'2022-07-17T02:40:40.660' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (7, 72, NULL, CAST(N'2022-07-17T02:41:43.200' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (7, 73, NULL, CAST(N'2022-07-17T02:42:22.093' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (7, 74, NULL, CAST(N'2022-07-17T02:43:41.627' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (7, 75, NULL, CAST(N'2022-07-17T02:44:05.787' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (7, 76, NULL, CAST(N'2022-07-17T02:44:23.077' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (8, 79, NULL, CAST(N'2022-07-17T13:20:41.253' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (8, 80, NULL, CAST(N'2022-07-17T13:20:52.783' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (8, 81, NULL, CAST(N'2022-07-17T13:21:05.347' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (8, 82, NULL, CAST(N'2022-07-17T13:21:19.087' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (8, 85, NULL, CAST(N'2022-07-17T16:37:35.503' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 86, NULL, CAST(N'2022-07-17T19:40:54.320' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 87, NULL, CAST(N'2022-07-17T19:41:09.827' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 88, NULL, CAST(N'2022-07-17T19:41:22.537' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 89, NULL, CAST(N'2022-07-17T19:41:34.627' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 90, NULL, CAST(N'2022-07-17T19:41:45.967' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 91, NULL, CAST(N'2022-07-17T19:42:34.960' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 92, NULL, CAST(N'2022-07-17T19:43:03.657' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 93, NULL, CAST(N'2022-07-17T19:43:42.753' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 94, NULL, CAST(N'2022-07-17T19:44:12.603' AS DateTime))
INSERT [dbo].[exam_question] ([id_exam], [id_question], [note], [date_create]) VALUES (9, 95, NULL, CAST(N'2022-07-17T19:44:43.633' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[exams] ON 

INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status]) VALUES (7, N' Củng cố Linux 2', CAST(N'2022-07-02T05:03:00.000' AS DateTime), CAST(N'2022-07-05T05:03:00.000' AS DateTime), 120, CAST(N'2022-07-16T17:04:00.000' AS DateTime), N'tạo lần 1', 3, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status]) VALUES (8, N'Củng cố Linux 3', CAST(N'2022-07-16T05:34:00.000' AS DateTime), CAST(N'2022-07-21T05:34:00.000' AS DateTime), 1, CAST(N'2022-07-16T17:34:14.000' AS DateTime), NULL, 2, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status]) VALUES (9, N'Củng cố linux 4', CAST(N'2022-07-04T07:37:00.000' AS DateTime), CAST(N'2022-07-20T07:37:00.000' AS DateTime), 45, CAST(N'2022-07-17T19:37:30.000' AS DateTime), NULL, 2, 1)
SET IDENTITY_INSERT [dbo].[exams] OFF
GO
SET IDENTITY_INSERT [dbo].[fields] ON 

INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (1, N'Công nghệ thông tin', CAST(N'2022-07-13T11:45:07.667' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (2, N'Thông tin quản lí', CAST(N'2022-07-13T11:45:18.160' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (3, N'Khoa học máy tính', CAST(N'2022-07-13T11:45:30.310' AS DateTime))
SET IDENTITY_INSERT [dbo].[fields] OFF
GO
SET IDENTITY_INSERT [dbo].[grades] ON 

INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (2, N'61.cntt3', CAST(N'2022-07-13T22:55:01.053' AS DateTime), 1)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (3, N'63.cntt3', CAST(N'2022-07-13T23:01:06.070' AS DateTime), 1)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (5, N'60.ttql3', CAST(N'2022-07-16T13:10:48.410' AS DateTime), 1)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (6, N'62.cntt1', CAST(N'2022-07-16T13:11:16.810' AS DateTime), 1)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (7, N'62.cntt2', CAST(N'2022-07-16T13:11:22.653' AS DateTime), 1)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (8, N'62.cntt3', CAST(N'2022-07-16T13:11:30.520' AS DateTime), 1)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (9, N'62.cntt4', CAST(N'2022-07-16T13:11:35.647' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[grades] OFF
GO
SET IDENTITY_INSERT [dbo].[question_types] ON 

INSERT [dbo].[question_types] ([id_question_type], [name], [note], [date_create]) VALUES (1, N'1 đáp án', N'chỉ duy nhất 1 đáp án được chấp nhận', CAST(N'2022-07-14T10:53:20.300' AS DateTime))
INSERT [dbo].[question_types] ([id_question_type], [name], [note], [date_create]) VALUES (3, N'Điền đáp án', N'người làm cần phải điền đáp án', CAST(N'2022-07-14T10:53:57.750' AS DateTime))
SET IDENTITY_INSERT [dbo].[question_types] OFF
GO
SET IDENTITY_INSERT [dbo].[questions] ON 

INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (5, 1, N'', N'Đưa kết quả của lệnh $ls -l /home vào file kq.txt, sử dụng lệnh nào?', N'1', N'2', N'3', N'4', N'5', N'6', CAST(N'2022-07-14T23:54:12.753' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (6, 1, N'', N'Để tìm kiếm file theo quyền hạn tham số nào sau đây được dùng?', N'1', N'2', N'3', N'4', N'1', N'hello', CAST(N'2022-07-14T23:58:22.483' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (7, 3, N'', N'Distro của Linux khác nhau ở đặc điểm gì?', NULL, NULL, NULL, NULL, N'1', N'1', CAST(N'2022-07-15T00:16:28.777' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (8, 3, N'', N'Hãy cho biết để xem nội dung file text câu lệnh nào sau đây đúng?', NULL, NULL, NULL, NULL, N'Ai đã đặt tên cho dòng sông', N'', CAST(N'2022-07-15T01:06:31.063' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (10, 3, N'', N'Khi tìm kiếm file ta có lệnh sau $find /home -type f -iname  a\*, phát biểu nào sau đây đúng?', NULL, NULL, NULL, NULL, N'ko', N'', CAST(N'2022-07-15T11:28:49.320' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (45, 3, N'', N'Nếu đang ở thư mục /cntt/k60/linux/btHỏi lệnh nào tạo thư mục mới có tên k61 trong thư mục /cntt. (Sử dụng đương dẫn tương đối)', N'null', N'null', N'null', N'null', N'mkdir ../../../k64', N'', CAST(N'2022-07-15T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (46, 3, N'', N'Cho biết tại dấu nhắc lệnh như sau:

user1@vp01:~$

Thư mục hiện hành (nêu đường dẫn đầy đủ) là gì?', NULL, NULL, NULL, NULL, N'/home/user1', N'', CAST(N'2022-07-15T21:08:46.813' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (47, 3, N'', N'Phím nào sử dụng để thoát khỏi cửa sổ mở file khi dùng less?

', NULL, NULL, NULL, NULL, N'q', N'', CAST(N'2022-07-15T21:09:15.677' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (48, 3, N'', N'Để xóa cây thư mục rỗng /cntt/k60/linux

Lệnh như thế nào?', NULL, NULL, NULL, NULL, N'rmdir /cntt/k60/linux', N'', CAST(N'2022-07-15T21:09:34.463' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (49, 3, N'', N'Nếu đường dẫn hiện hành là /home/user1/linux/bt

Dùng đường dẫn tương đối là lệnh nào để trở về /', NULL, NULL, NULL, NULL, N'cd ../../../../', N'', CAST(N'2022-07-15T21:09:47.433' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (50, 3, N'', N'Lỗi báo không có quyền thực hiện câu lệnh là gì? (Viết tiếng anh (chỉ có 2 hoặc 3 từ)', NULL, NULL, NULL, NULL, N'Permission denied', N'', CAST(N'2022-07-15T21:09:59.720' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (51, 3, N'', N'Đưa kết quả của lệnh $ls -l /home vào file kq.txt, sử dụng lệnh nào?

', NULL, NULL, NULL, NULL, N'ls -l /home > kq.txt', N'', CAST(N'2022-07-15T21:10:09.933' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (53, 1, N'', N'Hãy cho biết để xem nội dung file text câu lệnh nào sau đây đúng?', N'cd', N'ls ', N'less', N'su', N'less', N'', CAST(N'2022-07-15T21:21:18.437' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (54, 1, N'', N'Hãy cho biết câu lệnh nào sau đây dùng tạo thư mục?

', N'chown', N'mkdir', N'', N'', N'mkdir', N'', CAST(N'2022-07-15T21:21:46.880' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (55, 1, N'', N'Cho biết lệnh $mv file1.txt /home/user1, user1 là tài khoản của người dùng có trong hệ thống, phát biểu nào sau đây chính xác nhất?', N'file1.txt phải chưa tồn tại', N'file1.txt tại thư mục hiện hành được di chuyển vào thư mục /home/user1', N'
file1.txt được đổi tên thành user1 trong thư mục /home', N'file1.txt đang ở trong thư mục người dùng hiện hành', N'file1.txt đang ở trong thư mục người dùng hiện hành', N'', CAST(N'2022-07-15T21:22:56.417' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (71, 1, N'', N'Hãy cho biết câu lệnh nào sau đây dùng tạo thư mục?', N'chown', N'head', N'mkdir', NULL, N'3', N'', CAST(N'2022-07-17T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (72, 1, N'', N'Cho biết lệnh $mv file1.txt /home/user1, user1 là tài khoản của người dùng có trong hệ thống, phát biểu nào sau đây chính xác nhất?', N'file1.txt phải chưa tồn tại', N'file1.txt phải chưa tồn tại', N'file1.txt đang ở trong thư mục người dùng hiện hành', NULL, N'3', N'', CAST(N'2022-07-17T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (73, 1, N'', N'Khi tìm kiếm file ta có lệnh sau $find /home -type f -iname  a\*, phát biểu nào sau đây đúng?', N'Khi tìm kiếm file ta có lệnh sau $find /home -type f -iname  a\*, phát biểu nào sau đây đúng?', N'Khi tìm kiếm file ta có lệnh sau $find /home -type f -iname  a\*, phát biểu nào sau đây đúng?', N'Lệnh này cho phép tìm kiếm file trong thư mục /home có tên bắt đầu bằng chữ A hoặc a.', NULL, N'3', N'', CAST(N'2022-07-17T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (74, 3, N'', N'Tìm kiếm các file trong thư mục /etc', NULL, NULL, NULL, N'Lệnh này cho phép tìm kiếm file trong thư mục /home có tên bắt đầu bằng chữ A hoặc a.', N'find /etc -type f', N'', CAST(N'2022-07-17T02:43:41.560' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (75, 3, N'', N'Trong kết quả tìm kiếm các file trong thư mục làm việc của người dùng hiện hành, hiện thị các dòng có tên là baocao', NULL, NULL, NULL, N'Lệnh này cho phép tìm kiếm file trong thư mục /home có tên bắt đầu bằng chữ A hoặc a.', N'find -type f | grep baocao', N'', CAST(N'2022-07-17T02:44:05.777' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (76, 3, N'', N'Hiện thị số thứ tự dòng và dòng chứa từ auto nhưng không chứa từ eth0 trong file /etc/network/interfaces', NULL, NULL, NULL, N'Lệnh này cho phép tìm kiếm file trong thư mục /home có tên bắt đầu bằng chữ A hoặc a.', N'grep auto /etc/network/interfaces | grep -v eth0', N'', CAST(N'2022-07-17T02:44:23.043' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (79, 3, N'', N'Hãy liệt kê các dòng chứa từ uk hoặc từ au trong file xuatkhau trong thư mục /home.

', NULL, NULL, NULL, NULL, N'grep -e uk -e au /home/xuatkhau', N'', CAST(N'2022-07-17T13:20:41.220' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (80, 3, N'', N'Hiển thị các dòng trong file /etc/network/interfaces chứa số 27 nhiều hơn 1 lần dùng lệnh gì?', NULL, NULL, NULL, NULL, N'egrep ''27\{1,\}''', N'', CAST(N'2022-07-17T13:20:52.713' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (81, 3, N'', N'Tìm các dòng có từ drive trong file thietbi của thư mục người dùng hiện hành?', NULL, NULL, NULL, NULL, N'grep drive thietbi', N'', CAST(N'2022-07-17T13:21:05.333' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (82, 3, N'', N'Đếm các dòng là liên kết trong kết quả xem thư mục /boot, hãy cho biết lệnh nào?

', NULL, NULL, NULL, NULL, N'ls -l /boot | grep -c ^l', N'', CAST(N'2022-07-17T13:21:19.053' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (85, 1, N'', N'con mèo to như nào?', N'10', N'20', N'30', N'40', N'2', N'', CAST(N'2022-07-17T16:37:35.337' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (86, 3, N'', N'Nếu đang ở thư mục /cntt/k60/linux/bt. Hỏi lệnh nào tạo thư mục mới có tên k61 trong thư mục /cntt. (Sử dụng đương dẫn tương đối)', NULL, NULL, NULL, NULL, N'mkdir ../../../k61', N'', CAST(N'2022-07-17T19:40:54.103' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (87, 3, N'', N'Cho biết tại dấu nhắc lệnh như sau:

user1@vp01:~$

Thư mục hiện hành (nêu đường dẫn đầy đủ) là gì?', NULL, NULL, NULL, NULL, N'/home/user1', N'', CAST(N'2022-07-17T19:41:09.803' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (88, 3, N'', N'Để xóa cây thư mục rỗng /cntt/k60/linux

Lệnh như thế nào?', NULL, NULL, NULL, NULL, N'rmdir /cntt/k60/linux', N'', CAST(N'2022-07-17T19:41:22.450' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (89, 3, N'', N'Lỗi báo không có quyền thực hiện câu lệnh là gì? (Viết tiếng anh (chỉ có 2 hoặc 3 từ)', NULL, NULL, NULL, NULL, N'Permission denied', N'', CAST(N'2022-07-17T19:41:34.550' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (90, 3, N'', N'Đưa kết quả của lệnh $ls -l /home vào file kq.txt, sử dụng lệnh nào?', NULL, NULL, NULL, NULL, N'ls -l /home > kq.txt', N'', CAST(N'2022-07-17T19:41:45.890' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (91, 1, N'', N'Để tìm kiếm file theo quyền hạn tham số nào sau đây được dùng?', N'-type', N'-d', N'-perm', N'-uid', N'-perm', N'', CAST(N'2022-07-17T19:42:34.937' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (92, 1, N'', N'Hãy cho biết để xem nội dung file text câu lệnh nào sau đây đúng?

', N'cd', N'ls', N'less', N'su', N'less', N'', CAST(N'2022-07-17T19:43:03.613' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (93, 1, N'', N'Cho biết lệnh $mv file1.txt /home/user1, user1 là tài khoản của người dùng có trong hệ thống, phát biểu nào sau đây chính xác nhất?', N'file1.txt phải chưa tồn tại', N'
file1.txt tại thư mục hiện hành được di chuyển vào thư mục /home/user1', N'file1.txt được đổi tên thành user1 trong thư mục /home', N'file1.txt đang ở trong thư mục người dùng hiện hành', N'
file1.txt tại thư mục hiện hành được di chuyển vào thư mục /home/user1', N'', CAST(N'2022-07-17T19:43:42.740' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (94, 1, N'', N'Khi tìm kiếm file ta có lệnh sau $find /home -type f -iname  a\*, phát biểu nào sau đây đúng?', N'Lệnh này cho phép tìm kiếm thư mục trong thư mục hiện hành có tên bắt đầu bằng chữ A hoặc a.', N'Lệnh này cho phép tìm kiếm file trong thư mục /home có tên bắt đầu bằng chữ a.', N'Lệnh này cho phép tìm kiếm thư mục trong thư mục /home có tên bắt đầu bằng chữ A hoặc a.', N'Lệnh này cho phép tìm kiếm file trong thư mục /home có tên bắt đầu bằng chữ A hoặc a.', N'Lệnh này cho phép tìm kiếm file trong thư mục /home có tên bắt đầu bằng chữ A hoặc a.', N'', CAST(N'2022-07-17T19:44:12.587' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (95, 1, N'', N'Để tìm kiếm nội dung trong file sử dụng lệnh nào?', N'
$find', N'$locate', N'$less', N'$grep', N'$grep', N'', CAST(N'2022-07-17T19:44:43.620' AS DateTime))
SET IDENTITY_INSERT [dbo].[questions] OFF
GO
SET IDENTITY_INSERT [dbo].[rights] ON 

INSERT [dbo].[rights] ([id_right], [name], [note], [date_create]) VALUES (1, N'admin     ', NULL, CAST(N'2022-07-13T11:44:09.943' AS DateTime))
INSERT [dbo].[rights] ([id_right], [name], [note], [date_create]) VALUES (2, N'teacher   ', NULL, CAST(N'2022-07-13T11:44:17.137' AS DateTime))
INSERT [dbo].[rights] ([id_right], [name], [note], [date_create]) VALUES (3, N'student   ', NULL, CAST(N'2022-07-13T11:44:21.007' AS DateTime))
SET IDENTITY_INSERT [dbo].[rights] OFF
GO
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [score], [note], [start_time], [finish_time]) VALUES (7, 10018, 1.6666666666666665, NULL, NULL, CAST(N'2022-07-17T11:16:07.967' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [score], [note], [start_time], [finish_time]) VALUES (8, 10018, 2, NULL, NULL, CAST(N'2022-07-17T16:32:40.407' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [score], [note], [start_time], [finish_time]) VALUES (9, 10018, 0, NULL, NULL, CAST(N'2022-07-17T19:53:55.643' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[subject_grade] ON 

INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (2, 1, 2, 10014, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (3, 1, 3, 10014, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (4, 1, 5, 10015, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (5, 1, 7, 10015, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (6, 1, 9, 10015, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (7, 2, 5, 10016, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (8, 2, 6, 10016, NULL)
SET IDENTITY_INSERT [dbo].[subject_grade] OFF
GO
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (2, 10018, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (3, 10018, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (4, 10018, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (5, 10018, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (6, 10018, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (7, 10018, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (7, 10019, NULL)
GO
SET IDENTITY_INSERT [dbo].[subjects] ON 

INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (1, N'Linux', CAST(N'2022-07-14T09:51:50.000' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (2, N'Lí thuyết xác suất thống kê', CAST(N'2022-07-16T13:08:57.790' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (3, N'Toán rời rạc', CAST(N'2022-07-16T13:09:02.120' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (4, N'Tiếng Anh', CAST(N'2022-07-16T13:09:07.150' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (6, N'Cấu trúc dữ liệu', CAST(N'2022-07-16T13:09:18.983' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (7, N'Nhập môn lập trình', CAST(N'2022-07-16T13:09:26.263' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (8, N'Kĩ thuật điện', CAST(N'2022-07-16T13:09:36.053' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (9, N'Kinh tế học đại cương', CAST(N'2022-07-16T13:09:42.393' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (10, N'Cơ sở dữ liệu', CAST(N'2022-07-16T13:09:56.073' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (11, N'Lập trình python', CAST(N'2022-07-16T13:10:04.580' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (12, N'Nhập môn di động', CAST(N'2022-07-16T13:10:10.170' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (13, N'Phát triển web', CAST(N'2022-07-16T13:10:14.297' AS DateTime))
INSERT [dbo].[subjects] ([id_subject], [name], [date_create]) VALUES (14, N'IELTS', CAST(N'2022-07-17T16:38:51.707' AS DateTime))
SET IDENTITY_INSERT [dbo].[subjects] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (2, N'viet                ', N'Đặng Nhật Việt', N'1234                                                                                                ', N'viet@email.com                                    ', NULL, 1, CAST(N'2022-07-20' AS Date), CAST(N'2022-07-13T11:48:29.000' AS DateTime), 1, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (3, N'nhu                 ', N'Lâm Tâm Như', N'1234                                                                                                ', N'nhu@email.com                                     ', NULL, 0, NULL, NULL, 1, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10008, N'tuyett              ', N'Ánh Tuyết', N'1234                                                                                                ', N'tuyet@email.com                                   ', NULL, 0, CAST(N'2022-07-20' AS Date), CAST(N'2022-07-13T21:52:49.000' AS DateTime), 2, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10011, N'dat                 ', N'Lại Quốc Đạt', N'1234                                                                                                ', N'laiquocdat@email.com                              ', NULL, 1, NULL, CAST(N'2022-07-13T23:10:26.330' AS DateTime), 3, 3)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10012, N'an                  ', N'Nguyễn An', N'1234                                                                                                ', N'an@email.com                                      ', NULL, 1, NULL, CAST(N'2022-07-14T09:24:29.380' AS DateTime), 3, 2)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10013, N'hoang               ', N'Hoàng', N'1234                                                                                                ', N'hoang@email.com                                   ', NULL, 1, NULL, CAST(N'2022-07-16T09:41:09.857' AS DateTime), 2, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10014, N'nhung               ', N'Nguyễn Nhung', N'1234                                                                                                ', N'nhung@email.com                                   ', NULL, 0, NULL, CAST(N'2022-07-16T13:12:12.943' AS DateTime), 2, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10015, N'luc                 ', N'Dương Tuấn Lực', N'1234                                                                                                ', N'luc@email.com                                     ', NULL, 1, NULL, CAST(N'2022-07-16T13:12:33.913' AS DateTime), 2, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10016, N'vuong               ', N'Vương Nhất Bác', N'1234                                                                                                ', N'vuong@email.com                                   ', NULL, NULL, NULL, CAST(N'2022-07-16T13:12:50.750' AS DateTime), 2, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10017, N'khoi                ', N'Lê Như Khôi', N'1234                                                                                                ', N'khoi@email.com                                    ', NULL, NULL, NULL, CAST(N'2022-07-16T13:13:04.083' AS DateTime), 2, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10018, N'thien               ', N'Hồ Nhất Thiên', N'1234                                                                                                ', N'honhatthien@email.com                             ', NULL, NULL, CAST(N'2022-07-25' AS Date), CAST(N'2022-07-16T21:32:36.107' AS DateTime), 3, 2)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10019, N'quyen               ', N'Đặng Quyên', N'1234                                                                                                ', N'quyen@email.com                                   ', NULL, NULL, CAST(N'2022-07-27' AS Date), CAST(N'2022-07-16T21:36:45.637' AS DateTime), 3, 3)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10020, N'loan                ', N'Mai Quý Loan', N'1234                                                                                                ', N'loan@email.com                                    ', NULL, 0, NULL, CAST(N'2022-07-17T16:16:45.940' AS DateTime), 1, NULL)
INSERT [dbo].[users] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10021, N'nga                 ', N'Nguyễn Thị Nga', N'1234                                                                                                ', N'nga@email.com                                     ', NULL, NULL, NULL, CAST(N'2022-07-17T16:17:40.740' AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[do_exam] ADD  CONSTRAINT [DF_do_exam_finsh_time]  DEFAULT (getdate()) FOR [finsh_time]
GO
ALTER TABLE [dbo].[exam_question] ADD  CONSTRAINT [DF_exam_question_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[exams] ADD  CONSTRAINT [DF_exams_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[fields] ADD  CONSTRAINT [DF_fields_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[grades] ADD  CONSTRAINT [DF_grades_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[question_types] ADD  CONSTRAINT [DF_question_types_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[questions] ADD  CONSTRAINT [DF_questions_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[rights] ADD  CONSTRAINT [DF_rights_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[subjects] ADD  CONSTRAINT [DF_subjects_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_id_right]  DEFAULT ((3)) FOR [id_right]
GO
ALTER TABLE [dbo].[do_exam]  WITH CHECK ADD  CONSTRAINT [FK_do_exam_exams] FOREIGN KEY([id_exam])
REFERENCES [dbo].[exams] ([id_exam])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[do_exam] CHECK CONSTRAINT [FK_do_exam_exams]
GO
ALTER TABLE [dbo].[do_exam]  WITH CHECK ADD  CONSTRAINT [FK_do_exam_questions] FOREIGN KEY([id_question])
REFERENCES [dbo].[questions] ([id_question])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[do_exam] CHECK CONSTRAINT [FK_do_exam_questions]
GO
ALTER TABLE [dbo].[do_exam]  WITH CHECK ADD  CONSTRAINT [FK_do_exam_users] FOREIGN KEY([id_student])
REFERENCES [dbo].[users] ([id_user])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[do_exam] CHECK CONSTRAINT [FK_do_exam_users]
GO
ALTER TABLE [dbo].[exam_question]  WITH CHECK ADD  CONSTRAINT [FK_exam_question_exams] FOREIGN KEY([id_exam])
REFERENCES [dbo].[exams] ([id_exam])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exam_question] CHECK CONSTRAINT [FK_exam_question_exams]
GO
ALTER TABLE [dbo].[exam_question]  WITH CHECK ADD  CONSTRAINT [FK_exam_question_questions] FOREIGN KEY([id_question])
REFERENCES [dbo].[questions] ([id_question])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exam_question] CHECK CONSTRAINT [FK_exam_question_questions]
GO
ALTER TABLE [dbo].[exams]  WITH CHECK ADD  CONSTRAINT [FK_exams_subject_grade2] FOREIGN KEY([id_subject_grade])
REFERENCES [dbo].[subject_grade] ([id_subject_grade])
GO
ALTER TABLE [dbo].[exams] CHECK CONSTRAINT [FK_exams_subject_grade2]
GO
ALTER TABLE [dbo].[grades]  WITH CHECK ADD  CONSTRAINT [FK_grades_fields] FOREIGN KEY([id_field])
REFERENCES [dbo].[fields] ([id_field])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[grades] CHECK CONSTRAINT [FK_grades_fields]
GO
ALTER TABLE [dbo].[questions]  WITH CHECK ADD  CONSTRAINT [FK_questions_question_types] FOREIGN KEY([id_question_type])
REFERENCES [dbo].[question_types] ([id_question_type])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[questions] CHECK CONSTRAINT [FK_questions_question_types]
GO
ALTER TABLE [dbo].[score_of_exam]  WITH CHECK ADD  CONSTRAINT [FK_score_of_exam_exams] FOREIGN KEY([id_exam])
REFERENCES [dbo].[exams] ([id_exam])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[score_of_exam] CHECK CONSTRAINT [FK_score_of_exam_exams]
GO
ALTER TABLE [dbo].[score_of_exam]  WITH CHECK ADD  CONSTRAINT [FK_score_of_exam_users] FOREIGN KEY([id_student])
REFERENCES [dbo].[users] ([id_user])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[score_of_exam] CHECK CONSTRAINT [FK_score_of_exam_users]
GO
ALTER TABLE [dbo].[subject_grade]  WITH CHECK ADD  CONSTRAINT [FK_subject_grade_grades] FOREIGN KEY([id_grade])
REFERENCES [dbo].[grades] ([id_grade])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[subject_grade] CHECK CONSTRAINT [FK_subject_grade_grades]
GO
ALTER TABLE [dbo].[subject_grade]  WITH CHECK ADD  CONSTRAINT [FK_subject_grade_subjects] FOREIGN KEY([id_subject])
REFERENCES [dbo].[subjects] ([id_subject])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[subject_grade] CHECK CONSTRAINT [FK_subject_grade_subjects]
GO
ALTER TABLE [dbo].[subject_grade]  WITH CHECK ADD  CONSTRAINT [FK_subject_grade_users] FOREIGN KEY([id_teacher])
REFERENCES [dbo].[users] ([id_user])
GO
ALTER TABLE [dbo].[subject_grade] CHECK CONSTRAINT [FK_subject_grade_users]
GO
ALTER TABLE [dbo].[subject_student]  WITH CHECK ADD  CONSTRAINT [FK_subject_student_subject_grade] FOREIGN KEY([id_subject_grade])
REFERENCES [dbo].[subject_grade] ([id_subject_grade])
GO
ALTER TABLE [dbo].[subject_student] CHECK CONSTRAINT [FK_subject_student_subject_grade]
GO
ALTER TABLE [dbo].[subject_student]  WITH CHECK ADD  CONSTRAINT [FK_subject_student_users] FOREIGN KEY([id_student])
REFERENCES [dbo].[users] ([id_user])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[subject_student] CHECK CONSTRAINT [FK_subject_student_users]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_grades] FOREIGN KEY([id_grade])
REFERENCES [dbo].[grades] ([id_grade])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_grades]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_rights] FOREIGN KEY([id_right])
REFERENCES [dbo].[rights] ([id_right])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_rights]
GO
/****** Object:  StoredProcedure [dbo].[CheckDoExam]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[CheckDoExam] 
	@id_exam bigint,
	@id_question bigint,
	@id_student bigint
AS
BEGIN
	select *
	from do_exam
	where id_exam=@id_exam and id_question=@id_question and id_student=@id_student
end
GO
/****** Object:  StoredProcedure [dbo].[getDetailDoExam]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getDetailDoExam] 
	@id_exam bigint,
	@id_user bigint
AS
BEGIN
	select d.chose, q.correct, (case when (d.chose = q.correct) then 1 else 0 end) as status
	from do_exam as d
	join questions as q on d.id_question = q.id_question
	where d.id_exam = @id_exam and d.id_student = @id_user
end
GO
/****** Object:  StoredProcedure [dbo].[SelectAllQuestionFrom]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectAllQuestionFrom] 
	@id_exam bigint
AS
BEGIN
	select id_exam,q.id_question_type,q.id_question,question,answer_1,answer_2,answer_3,answer_4,correct,q.note,q.date_create, qt.name as 'question_type'
	from exam_question as ex
	join questions as q
	on ex.id_question = q.id_question
	join question_types as qt
	on q.id_question_type = qt.id_question_type
	where ex.id_exam = @id_exam
end
GO
/****** Object:  StoredProcedure [dbo].[SelectOneQuestionFrom]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectOneQuestionFrom] 
	@id_exam bigint,
	@stt bigint
AS
BEGIN
	select id_exam,q.id_question_type,q.id_question,question,answer_1,answer_2,answer_3,answer_4,q.note,q.date_create, qt.name as 'question_type'
	from exam_question as ex
	join questions as q
	on ex.id_question = q.id_question
	join question_types as qt
	on q.id_question_type = qt.id_question_type
	where ex.id_exam = @id_exam
	ORDER BY q.id_question
	OFFSET     (@stt-1) ROWS  
	FETCH NEXT 1 ROWS ONLY
end
GO
/****** Object:  StoredProcedure [dbo].[subject_grade_filter]    Script Date: 7/17/2022 9:44:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[subject_grade_filter]
	@id_subject varchar(15)='',
	@id_teacher varchar(15)='',
	@id_grade varchar(15)=''
AS
BEGIN
DECLARE @SqlStr NVARCHAR(4000),
		@ParamList nvarchar(2000)
SELECT @SqlStr = '
		SELECT s_g.id_subject_grade, s_g.id_grade, s_g.id_subject, s_g.id_teacher, g.name as name_grade, s.name as name_subject, u.name as name_teacher, (s.name+'' - ''+g.name+'' - ''+ u.name) as name_subject_grade
		FROM subject_grade as s_g
		join grades as g on s_g.id_grade = g.id_grade
		join subjects as s on s.id_subject = s_g.id_subject
		join users as u on s_g.id_teacher = u.id_user
		WHERE  (1=1)
       '
IF @id_subject !=''
       SELECT @SqlStr = @SqlStr + '
              AND (s_g.id_subject = '+@id_subject+')
              '
IF @id_teacher !=''
       SELECT @SqlStr = @SqlStr + '
              AND (s_g.id_teacher = '+@id_teacher+')
              '
IF @id_grade !=''
       SELECT @SqlStr = @SqlStr + '
              AND (s_g.id_grade = '+@id_grade+')
              '
SELECT @SqlStr = @SqlStr + '
			  order by s.name
              '
	EXEC SP_EXECUTESQL @SqlStr
END
GO
USE [master]
GO
ALTER DATABASE [trac_nghiem] SET  READ_WRITE 
GO
