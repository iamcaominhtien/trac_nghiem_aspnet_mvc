USE [master]
GO
/****** Object:  Database [SqlServerTracNghiem]    Script Date: 12/30/2022 11:51:21 PM ******/
CREATE DATABASE [SqlServerTracNghiem]
GO
USE [SqlServerTracNghiem]
GO

CREATE TABLE [dbo].[do_exam](
	[score] [float] NULL,
	[chose] [nvarchar](100) NULL,
	[note] [text] NULL,
	[statrt_time] [datetime] NULL,
	[finsh_time] [datetime] NULL,
	[id_redo] [int] NOT NULL,
	[id_exam] [bigint] NOT NULL,
	[id_student] [bigint] NOT NULL,
	[id_question] [bigint] NOT NULL,
 CONSTRAINT [PK_do_exam_1] PRIMARY KEY CLUSTERED 
(
	[id_redo] ASC,
	[id_exam] ASC,
	[id_student] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exam_question]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[exams]    Script Date: 12/30/2022 11:51:27 PM ******/
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
	[score] [float] NULL,
	[number_of_questions] [int] NULL,
	[number_of_redo] [int] NULL,
 CONSTRAINT [PK_exams] PRIMARY KEY CLUSTERED 
(
	[id_exam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fields]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[grades]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[managers]    Script Date: 12/30/2022 11:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[managers](
	[id_manager] [bigint] IDENTITY(1,1) NOT NULL,
	[email] [nchar](50) NULL,
	[username] [nvarchar](100) NULL,
	[name] [nvarchar](100) NULL,
	[id_right] [bigint] NULL,
	[password] [nchar](100) NULL,
	[note] [nchar](10) NULL,
 CONSTRAINT [PK_managers] PRIMARY KEY CLUSTERED 
(
	[id_manager] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question_bank]    Script Date: 12/30/2022 11:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question_bank](
	[id_question_bank] [bigint] IDENTITY(1,1) NOT NULL,
	[id_subject_grade] [bigint] NOT NULL,
	[note] [nvarchar](500) NULL,
	[date_create] [datetime] NULL,
 CONSTRAINT [PK_question_bank] PRIMARY KEY CLUSTERED 
(
	[id_question_bank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question_bank_questions]    Script Date: 12/30/2022 11:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question_bank_questions](
	[id_question_bank] [bigint] NOT NULL,
	[id_question] [bigint] NOT NULL,
	[note] [nvarchar](500) NULL,
 CONSTRAINT [PK_question_bank_questions] PRIMARY KEY CLUSTERED 
(
	[id_question_bank] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question_types]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[questions]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[rights]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[score_of_exam]    Script Date: 12/30/2022 11:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[score_of_exam](
	[id_exam] [bigint] NOT NULL,
	[id_student] [bigint] NOT NULL,
	[id_redo] [int] NOT NULL,
	[score] [float] NULL,
	[note] [nvarchar](500) NULL,
	[start_time] [datetime] NULL,
	[finish_time] [datetime] NULL,
 CONSTRAINT [PK_score_of_exam] PRIMARY KEY CLUSTERED 
(
	[id_exam] ASC,
	[id_student] ASC,
	[id_redo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[students_user]    Script Date: 12/30/2022 11:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students_user](
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
/****** Object:  Table [dbo].[subject_grade]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[subject_student]    Script Date: 12/30/2022 11:51:27 PM ******/
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
/****** Object:  Table [dbo].[subjects]    Script Date: 12/30/2022 11:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subjects](
	[id_subject] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[date_create] [datetime] NULL,
	[id_field] [bigint] NULL,
 CONSTRAINT [PK_subjects] PRIMARY KEY CLUSTERED 
(
	[id_subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teachers_user]    Script Date: 12/30/2022 11:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teachers_user](
	[id_teacher] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [nchar](20) NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [nchar](100) NOT NULL,
	[email] [nchar](50) NULL,
	[phone] [nchar](15) NULL,
	[avatar] [nchar](200) NULL,
	[gender] [bit] NULL,
	[birthday] [date] NULL,
	[date_create] [datetime] NULL,
	[id_right] [bigint] NULL,
 CONSTRAINT [PK_teachers] PRIMARY KEY CLUSTERED 
(
	[id_teacher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-24T02:49:32.413' AS DateTime), NULL, 1, 12, 10023, 104)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 12, 10023, 106)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'', NULL, CAST(N'2022-07-24T02:50:21.133' AS DateTime), NULL, 1, 12, 10023, 108)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'Permission denied', NULL, CAST(N'2022-07-24T02:48:31.150' AS DateTime), NULL, 1, 12, 10023, 109)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'ls -l /home > kq.txt', NULL, CAST(N'2022-07-24T02:49:36.110' AS DateTime), NULL, 1, 12, 10023, 110)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 12, 10023, 111)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, CAST(N'2022-07-24T02:50:30.673' AS DateTime), NULL, 1, 12, 10023, 112)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:50:17.227' AS DateTime), NULL, 1, 12, 10023, 114)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 12, 10023, 115)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'deluser', NULL, CAST(N'2022-07-24T02:49:46.067' AS DateTime), NULL, 1, 12, 10023, 147)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'dfgdfg', NULL, CAST(N'2022-12-30T19:35:41.450' AS DateTime), NULL, 1, 12, 30029, 108)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-12-30T19:35:05.643' AS DateTime), NULL, 1, 12, 30029, 113)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-12-30T19:35:15.930' AS DateTime), NULL, 1, 12, 30029, 114)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'dfgfgdfg', NULL, CAST(N'2022-12-30T19:35:28.910' AS DateTime), NULL, 1, 12, 30029, 147)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-12-30T19:35:34.527' AS DateTime), NULL, 1, 12, 30029, 20119)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 103)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 104)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'', NULL, CAST(N'2022-07-24T03:22:17.127' AS DateTime), NULL, 1, 14, 10023, 105)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 106)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 107)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 108)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 109)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'', NULL, CAST(N'2022-07-24T03:22:12.223' AS DateTime), NULL, 1, 14, 10023, 110)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-24T03:22:08.867' AS DateTime), NULL, 1, 14, 10023, 111)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 112)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, CAST(N'2022-07-24T03:22:05.493' AS DateTime), NULL, 1, 14, 10023, 113)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 114)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 115)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 147)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'24', NULL, CAST(N'2022-07-24T03:21:49.500' AS DateTime), NULL, 1, 14, 10023, 10115)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 10116)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 10117)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 1, 14, 10023, 10118)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:57:18.923' AS DateTime), NULL, 1, 20, 10027, 119)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-24T02:56:14.837' AS DateTime), NULL, 1, 20, 10027, 120)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:57:08.230' AS DateTime), NULL, 1, 20, 10027, 121)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:56:31.860' AS DateTime), NULL, 1, 20, 10027, 122)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:55:53.087' AS DateTime), NULL, 1, 20, 10027, 124)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:56:07.497' AS DateTime), NULL, 1, 20, 10027, 126)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, CAST(N'2022-07-24T02:57:37.190' AS DateTime), NULL, 1, 20, 10027, 127)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-24T02:56:39.667' AS DateTime), NULL, 1, 20, 10027, 132)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:57:26.707' AS DateTime), NULL, 1, 20, 10027, 135)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, CAST(N'2022-07-24T02:57:03.867' AS DateTime), NULL, 1, 20, 10027, 136)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, CAST(N'2022-07-25T08:35:18.973' AS DateTime), NULL, 1, 22, 10025, 139)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, CAST(N'2022-07-25T08:35:47.477' AS DateTime), NULL, 1, 22, 10025, 142)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-25T08:35:30.950' AS DateTime), NULL, 1, 22, 10025, 143)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, CAST(N'2022-07-25T08:35:04.060' AS DateTime), NULL, 1, 22, 10025, 144)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-25T08:34:51.577' AS DateTime), NULL, 1, 22, 10025, 146)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-25T11:14:43.243' AS DateTime), NULL, 1, 10017, 10025, 139)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-25T11:14:38.850' AS DateTime), NULL, 1, 10017, 10025, 140)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-25T11:14:59.077' AS DateTime), NULL, 1, 10017, 10025, 141)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-25T11:14:45.993' AS DateTime), NULL, 1, 10017, 10025, 144)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-25T11:14:49.960' AS DateTime), NULL, 1, 10017, 10025, 10119)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-26T02:57:08.780' AS DateTime), NULL, 1, 20017, 10025, 140)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-26T02:57:13.390' AS DateTime), NULL, 1, 20017, 10025, 143)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-26T02:57:25.347' AS DateTime), NULL, 1, 20017, 10025, 144)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-26T02:57:15.623' AS DateTime), NULL, 1, 20017, 10025, 146)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-26T02:57:18.330' AS DateTime), NULL, 1, 20017, 10025, 10119)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-26T02:59:48.747' AS DateTime), NULL, 1, 20018, 10025, 138)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-26T02:59:54.183' AS DateTime), NULL, 1, 20018, 10025, 139)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-26T03:00:05.633' AS DateTime), NULL, 1, 20018, 10025, 142)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-26T02:59:56.327' AS DateTime), NULL, 1, 20018, 10025, 144)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-26T02:59:58.630' AS DateTime), NULL, 1, 20018, 10025, 10119)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'mkdir ../../../k61', NULL, CAST(N'2022-07-24T02:50:51.633' AS DateTime), NULL, 2, 12, 10023, 103)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-24T02:51:16.233' AS DateTime), NULL, 2, 12, 10023, 104)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'', NULL, CAST(N'2022-07-24T02:51:24.103' AS DateTime), NULL, 2, 12, 10023, 105)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 12, 10023, 106)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 12, 10023, 109)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 12, 10023, 110)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-24T02:51:12.060' AS DateTime), NULL, 2, 12, 10023, 111)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 12, 10023, 113)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, CAST(N'2022-07-24T02:51:27.753' AS DateTime), NULL, 2, 12, 10023, 114)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 12, 10023, 147)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 103)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-25T11:59:59.117' AS DateTime), NULL, 2, 14, 10023, 104)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 105)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'', NULL, CAST(N'2022-07-25T12:00:09.393' AS DateTime), NULL, 2, 14, 10023, 106)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'', NULL, CAST(N'2022-07-25T12:00:26.440' AS DateTime), NULL, 2, 14, 10023, 107)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 108)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 109)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 110)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-25T12:00:12.307' AS DateTime), NULL, 2, 14, 10023, 111)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, CAST(N'2022-07-25T12:00:16.163' AS DateTime), NULL, 2, 14, 10023, 112)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 113)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'1', NULL, CAST(N'2022-07-25T12:00:06.567' AS DateTime), NULL, 2, 14, 10023, 114)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 115)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 147)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-25T12:00:04.257' AS DateTime), NULL, 2, 14, 10023, 10115)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 10116)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 10117)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, NULL, NULL, NULL, NULL, 2, 14, 10023, 10118)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'mkdir ../../../k61', NULL, CAST(N'2022-07-24T02:52:43.580' AS DateTime), NULL, 3, 12, 10023, 103)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-24T02:52:21.610' AS DateTime), NULL, 3, 12, 10023, 104)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'/home/user1', NULL, CAST(N'2022-07-24T02:51:46.570' AS DateTime), NULL, 3, 12, 10023, 105)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'q', NULL, CAST(N'2022-07-24T02:52:17.597' AS DateTime), NULL, 3, 12, 10023, 106)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'cd ../../../../', NULL, CAST(N'2022-07-24T02:52:34.790' AS DateTime), NULL, 3, 12, 10023, 108)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'Permission denied', NULL, CAST(N'2022-07-24T02:52:03.560' AS DateTime), NULL, 3, 12, 10023, 109)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'3', NULL, CAST(N'2022-07-24T02:52:10.890' AS DateTime), NULL, 3, 12, 10023, 111)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'4', NULL, CAST(N'2022-07-24T02:52:14.123' AS DateTime), NULL, 3, 12, 10023, 113)
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'2', NULL, CAST(N'2022-07-24T02:53:01.447' AS DateTime), NULL, 3, 12, 10023, 115)
GO
INSERT [dbo].[do_exam] ([score], [chose], [note], [statrt_time], [finsh_time], [id_redo], [id_exam], [id_student], [id_question]) VALUES (NULL, N'deluser', NULL, CAST(N'2022-07-24T02:52:24.797' AS DateTime), NULL, 3, 12, 10023, 147)
GO
SET IDENTITY_INSERT [dbo].[exams] ON 

INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (12, N'Củng cố Linux', CAST(N'2022-12-30T19:35:00.000' AS DateTime), CAST(N'2022-12-30T20:20:00.000' AS DateTime), 45, CAST(N'2022-07-21T00:26:32.000' AS DateTime), NULL, 12, 1, 10, 5, 3)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (14, N'Củng cố linux 3', CAST(N'2022-07-08T07:11:00.000' AS DateTime), CAST(N'2022-07-26T07:11:00.000' AS DateTime), 45, CAST(N'2022-07-21T19:11:34.000' AS DateTime), NULL, 12, 1, 100, 30, 2)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (16, N' Củng cố Linux 1', CAST(N'2022-07-03T19:22:00.000' AS DateTime), CAST(N'2022-07-23T19:22:00.000' AS DateTime), 120, CAST(N'2022-07-21T19:23:05.657' AS DateTime), NULL, 14, 0, 20, 10, 3)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (17, N'Thi cuối kì', CAST(N'2022-07-21T18:32:00.000' AS DateTime), CAST(N'2022-07-29T18:32:00.000' AS DateTime), 120, CAST(N'2022-07-22T06:33:03.433' AS DateTime), N'Bạn nào quên làm thì 0 điểm nhé', 12, 1, 10, 20, 3)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (20, N'Thi giữa kì', CAST(N'2022-07-22T10:36:00.000' AS DateTime), CAST(N'2022-07-30T10:36:00.000' AS DateTime), 45, CAST(N'2022-07-22T10:36:16.000' AS DateTime), NULL, 15, 1, 10, 10, 3)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (21, N'Bài luyện tập trắc nghiệm 02 - LTTN02', CAST(N'2022-07-23T11:11:00.000' AS DateTime), CAST(N'2022-07-29T11:11:00.000' AS DateTime), 15, CAST(N'2022-07-22T11:12:28.000' AS DateTime), NULL, 17, 1, 100, 5, 3)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (22, N'Bài luyện tập trắc nghiệm 01 - LTTN01', CAST(N'2022-07-21T11:13:00.000' AS DateTime), CAST(N'2022-07-30T11:13:00.000' AS DateTime), 15, CAST(N'2022-07-22T11:14:10.000' AS DateTime), NULL, 17, 1, 100, 5, 2)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (23, N'Bài luyện tập trắc nghiệm 03 - LTTN03', CAST(N'2022-07-21T11:27:00.000' AS DateTime), CAST(N'2022-07-23T11:27:00.000' AS DateTime), 15, CAST(N'2022-07-22T11:27:58.000' AS DateTime), NULL, 17, 1, 100, 5, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (24, N'Bài kiểm tra quá trình lần 1', CAST(N'2022-07-23T01:24:00.000' AS DateTime), CAST(N'2022-07-29T01:24:00.000' AS DateTime), 30, CAST(N'2022-07-22T13:25:08.827' AS DateTime), NULL, 15, 1, 10, 10, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (25, N'Kiểm tra lần 2', CAST(N'2022-07-21T01:42:00.000' AS DateTime), CAST(N'2022-07-30T01:42:00.000' AS DateTime), 45, CAST(N'2022-07-23T01:42:30.957' AS DateTime), NULL, 19, 1, 10, 10, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (10017, N'LTTN04', CAST(N'2022-07-24T23:12:00.000' AS DateTime), CAST(N'2022-08-01T23:13:00.000' AS DateTime), 15, CAST(N'2022-07-25T11:13:47.350' AS DateTime), NULL, 17, 1, 10, 5, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (20017, N'LTTN05', CAST(N'2022-07-25T14:56:00.000' AS DateTime), CAST(N'2022-07-27T14:56:00.000' AS DateTime), 15, CAST(N'2022-07-26T02:56:46.903' AS DateTime), NULL, 17, 1, 10, 5, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (20018, N'LTTN06', CAST(N'2022-07-25T14:58:00.000' AS DateTime), CAST(N'2022-07-27T14:58:00.000' AS DateTime), 15, CAST(N'2022-07-26T02:59:07.583' AS DateTime), NULL, 17, 1, 10, 5, 1)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (20019, N'lái online', CAST(N'2022-07-30T00:49:00.000' AS DateTime), CAST(N'2022-08-30T00:49:00.000' AS DateTime), 60, CAST(N'2022-07-30T00:49:17.670' AS DateTime), N'ab', 10015, 1, 30, 20, 3)
INSERT [dbo].[exams] ([id_exam], [name], [start_time], [end_time], [time_to_do], [date_create], [note], [id_subject_grade], [status], [score], [number_of_questions], [number_of_redo]) VALUES (20020, N'Test demo', CAST(N'2022-12-30T19:20:00.000' AS DateTime), CAST(N'2022-12-30T19:35:00.000' AS DateTime), 15, CAST(N'2022-12-30T19:15:33.027' AS DateTime), NULL, 19, 1, 100, 10, 1)
SET IDENTITY_INSERT [dbo].[exams] OFF
GO
SET IDENTITY_INSERT [dbo].[fields] ON 

INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (4, N'Công nghệ thông tin', CAST(N'2022-07-20T22:37:42.630' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (5, N'Ngôn ngữ Anh', CAST(N'2022-07-20T22:39:33.517' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (6, N'Quốc tế học', CAST(N'2022-07-20T22:39:55.190' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (8, N'Quản trị dịch vụ du lịch và lữ hành', CAST(N'2022-07-20T22:40:34.753' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (13, N'Kinh tế ứng dụng', CAST(N'2022-07-22T10:02:05.113' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (14, N'Văn hóa Việt Nam', CAST(N'2022-07-22T10:02:14.847' AS DateTime))
INSERT [dbo].[fields] ([id_field], [name], [date_create]) VALUES (10012, N'Phi Công', CAST(N'2022-07-30T00:46:55.777' AS DateTime))
SET IDENTITY_INSERT [dbo].[fields] OFF
GO
SET IDENTITY_INSERT [dbo].[grades] ON 

INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (10, N'C514C', CAST(N'2022-07-20T22:41:13.307' AS DateTime), 4)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (11, N'C414C', CAST(N'2022-07-20T22:42:11.737' AS DateTime), 4)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (12, N'CNTT3', CAST(N'2022-07-20T22:42:22.670' AS DateTime), 4)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (13, N'NNA1', CAST(N'2022-07-20T22:42:33.870' AS DateTime), 5)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (14, N'NNA2', CAST(N'2022-07-20T22:42:43.370' AS DateTime), 5)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (15, N'QTH1', CAST(N'2022-07-20T22:42:53.703' AS DateTime), 6)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (16, N'QTH2', CAST(N'2022-07-20T22:42:59.533' AS DateTime), 6)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (17, N'KTUD1', CAST(N'2022-07-20T22:43:09.877' AS DateTime), 13)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (19, N'NNA3', CAST(N'2022-07-22T13:29:05.423' AS DateTime), 5)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (10019, N'C513C', CAST(N'2022-07-25T10:57:42.917' AS DateTime), 4)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (10020, N'C214B', CAST(N'2022-07-25T11:49:00.367' AS DateTime), 4)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (20019, N'CNTT5', CAST(N'2022-07-30T00:46:23.767' AS DateTime), 4)
INSERT [dbo].[grades] ([id_grade], [name], [date_create], [id_field]) VALUES (20020, N'60.CNTT-1', CAST(N'2022-12-30T19:48:59.873' AS DateTime), 4)
SET IDENTITY_INSERT [dbo].[grades] OFF
GO
SET IDENTITY_INSERT [dbo].[managers] ON 

INSERT [dbo].[managers] ([id_manager], [email], [username], [name], [id_right], [password], [note]) VALUES (1, N'nhu@email.com                                     ', N'nhu', N'Võ Nhu', 1, N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', NULL)
INSERT [dbo].[managers] ([id_manager], [email], [username], [name], [id_right], [password], [note]) VALUES (3, N'quangnd@email.com                                 ', N'Giang', N'Nguyễn Trường Giang', 1, N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', NULL)
INSERT [dbo].[managers] ([id_manager], [email], [username], [name], [id_right], [password], [note]) VALUES (4, N'le@email.com                                      ', N'hai', N'Lê Trí Hải', 1, N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', NULL)
INSERT [dbo].[managers] ([id_manager], [email], [username], [name], [id_right], [password], [note]) VALUES (10004, N'haint@gmail.com                                   ', N'anhduy          ', N'Nguyễn Anh Duy', 1, N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', NULL)
INSERT [dbo].[managers] ([id_manager], [email], [username], [name], [id_right], [password], [note]) VALUES (20004, N'abc@gmail.com                                     ', N'admin1', N'le tri hai', 1, N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', NULL)
SET IDENTITY_INSERT [dbo].[managers] OFF
GO
SET IDENTITY_INSERT [dbo].[question_bank] ON 

INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (5, 12, N'', CAST(N'2022-07-21T17:52:36.337' AS DateTime))
INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (6, 14, N'', CAST(N'2022-07-21T17:52:40.007' AS DateTime))
INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (7, 15, N'', CAST(N'2022-07-22T06:21:49.400' AS DateTime))
INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (8, 17, N'', CAST(N'2022-07-22T10:58:13.897' AS DateTime))
INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (9, 16, NULL, CAST(N'2022-07-23T01:37:46.530' AS DateTime))
INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (10, 18, NULL, CAST(N'2022-07-23T01:38:37.927' AS DateTime))
INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (10007, 20015, N'a', CAST(N'2022-07-30T00:50:20.330' AS DateTime))
INSERT [dbo].[question_bank] ([id_question_bank], [id_subject_grade], [note], [date_create]) VALUES (10008, 20016, N'', CAST(N'2022-12-30T19:51:58.503' AS DateTime))
SET IDENTITY_INSERT [dbo].[question_bank] OFF
GO
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 103, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 104, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 105, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 106, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 107, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 108, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 109, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 110, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 111, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 112, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 113, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 114, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 115, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 147, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 10115, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 10116, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 10117, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 10118, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (5, 20119, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (6, 20120, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (6, 20122, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 116, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 117, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 118, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 119, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 120, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 121, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 122, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 123, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 124, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 125, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 126, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 127, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 128, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 129, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 130, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 131, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 132, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 133, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 134, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 135, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (7, 136, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 137, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 138, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 139, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 140, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 141, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 142, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 143, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 144, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 145, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 146, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (8, 10119, NULL)
INSERT [dbo].[question_bank_questions] ([id_question_bank], [id_question], [note]) VALUES (10, 10120, NULL)
GO
SET IDENTITY_INSERT [dbo].[question_types] ON 

INSERT [dbo].[question_types] ([id_question_type], [name], [note], [date_create]) VALUES (1, N'1 đáp án', N'chỉ duy nhất 1 đáp án được chấp nhận', CAST(N'2022-07-14T10:53:20.300' AS DateTime))
INSERT [dbo].[question_types] ([id_question_type], [name], [note], [date_create]) VALUES (3, N'Điền đáp án', N'người làm cần phải điền đáp án', CAST(N'2022-07-14T10:53:57.750' AS DateTime))
INSERT [dbo].[question_types] ([id_question_type], [name], [note], [date_create]) VALUES (4, N'Nhiều đáp án', N'Có thể chọn nhiều đáp án', CAST(N'2022-07-20T19:00:14.763' AS DateTime))
SET IDENTITY_INSERT [dbo].[question_types] OFF
GO
SET IDENTITY_INSERT [dbo].[questions] ON 

INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (98, 1, N'', N'Hôm nay trời thế nào?', N'Đẹp', N'Không đẹp', N'Tạm', N'Tệ', N'Tạm', N'', CAST(N'2022-07-21T17:31:45.070' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (99, 3, N'', N'b', NULL, NULL, NULL, NULL, N'b', N'', CAST(N'2022-07-21T17:36:41.813' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (100, 3, N'', N'c', NULL, NULL, NULL, NULL, N'c', N'', CAST(N'2022-07-21T17:36:46.130' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (103, 3, N'', N'Nếu đang ở thư mục /cntt/k60/linux/bt

.Hỏi lệnh nào tạo thư mục mới có tên k61 trong thư mục /cntt. (Sử dụng đương dẫn tương đối)', NULL, NULL, NULL, NULL, N'mkdir ../../../k61', N'', CAST(N'2022-07-21T19:59:11.030' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (104, 1, N'', N'Để tìm kiếm file theo quyền hạn tham số nào sau đây được dùng?', N'
-type', N'-d', N'-perm

', N'
-uid', N'3', N'', CAST(N'2022-07-21T20:26:05.600' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (105, 3, N'', N'Cho biết tại dấu nhắc lệnh như sau:

user1@vp01:~$

Thư mục hiện hành (nêu đường dẫn đầy đủ) là gì?', NULL, NULL, NULL, NULL, N'/home/user1', N'', CAST(N'2022-07-21T20:27:03.443' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (106, 3, N'', N'Phím nào sử dụng để thoát khỏi cửa sổ mở file khi dùng less?', NULL, NULL, NULL, NULL, N'q', N'', CAST(N'2022-07-21T20:27:19.677' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (107, 3, N'', N'Để xóa cây thư mục rỗng /cntt/k60/linux

Lệnh như thế nào?', NULL, NULL, NULL, NULL, N'rmdir /cntt/k60/linux', N'', CAST(N'2022-07-21T20:27:29.363' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (108, 3, N'', N'Nếu đường dẫn hiện hành là /home/user1/linux/bt

Dùng đường dẫn tương đối là lệnh nào để trở về /', NULL, NULL, NULL, NULL, N'cd ../../../../', N'', CAST(N'2022-07-21T20:27:41.027' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (109, 3, N'', N'Lỗi báo không có quyền thực hiện câu lệnh là gì? (Viết tiếng anh (chỉ có 2 hoặc 3 từ)', N'null', N'null', N'null', N'null', N'Permission denied', N'', CAST(N'2022-07-21T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (110, 3, N'', N'Đưa kết quả của lệnh $ls -l /home vào file kq.txt, sử dụng lệnh nào?', NULL, NULL, NULL, NULL, N'ls -l /home > kq.txt', N'', CAST(N'2022-07-21T20:28:02.890' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (111, 1, N'', N'Để tìm kiếm file theo quyền hạn tham số nào sau đây được dùng?', N'-type', N'-d', N'-perm', N'-uid', N'3', N'', CAST(N'2022-07-21T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (112, 1, N'', N'Hãy cho biết để xem nội dung file text câu lệnh nào sau đây đúng?', N'cd', N'ls', N'su', N'less', N'4', N'', CAST(N'2022-07-21T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (113, 1, N'', N'Hãy cho biết câu lệnh nào sau đây dùng tạo thư mục?

', N'chown', N'head', N'ls', N'mkdir', N'1', N'', CAST(N'2022-07-21T20:30:09.693' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (114, 1, N'', N'Cho biết lệnh $mv file1.txt /home/user1, user1 là tài khoản của người dùng có trong hệ thống, phát biểu nào sau đây chính xác nhất?', N'file1.txt phải chưa tồn tại', N'file1.txt tại thư mục hiện hành được di chuyển vào thư mục /home/user1

', N'file1.txt tại thư mục hiện hành được di chuyển vào thư mục /home/user1

', N'
file1.txt đang ở trong thư mục người dùng hiện hành

', N'2', N'', CAST(N'2022-07-21T21:10:44.237' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (115, 1, N'', N'Để chuyển sang một thư mục khác ta dùng lệnh', N'Lệnh cdir', N'Lệnh cd', N'Lệnh mkdir', N'Lệnh dir', N'2', N'', CAST(N'2022-07-22T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (116, 1, N'', N'He ...................... on business yesterday', N'went ', N'goes           ', N'go', N'going', N'1', N'', CAST(N'2022-07-22T10:07:50.447' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (117, 1, N'', N'Listen! Somebody......................for help.', N'are screaming   ', N'scream                   ', N'is screaming    ', N'has screamed', N'3', N'', CAST(N'2022-07-22T10:08:35.047' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (118, 1, N'', N'Waiter! There......................forks on this table', N'are not some ', N'isn’t any ', N'are not any', N'are not any', N'3', N'', CAST(N'2022-07-22T10:09:16.593' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (119, 1, N'', N'Using Facebook, you can post update sayings about your life every day', N'locate     ', N'displace    ', N'establish     ', N'put up', N'2', N'Tìm từ trái nghĩa của post:', CAST(N'2022-07-22T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (120, 1, N'', N'Developing new technologies are time-consuming and expensive.', N'developing      ', N'technologies      ', N'technologies      ', N'technologies      ', N'3', N'Tìm lỗi sai', CAST(N'2022-07-22T10:17:07.687' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (121, 1, N'', N'When we went back to the bookstore, the bookseller _______ the book we wanted.', N'sold    ', N'had sold ', N'sells     ', N'has sold', N'2', N'', CAST(N'2022-07-22T10:18:32.343' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (122, 1, N'', N'By the end of last summer, the farmers _______ all the crop.', N'harvested    ', N'harvested    ', N'harvest     ', N'are harvested', N'2', N'', CAST(N'2022-07-22T10:18:58.783' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (123, 1, N'', N'The director _______ for the meeting by the time I got to his office.', N'left    ', N'had left  ', N'leaves     ', N'will leave', N'2', N'', CAST(N'2022-07-22T10:19:20.893' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (124, 1, N'', N'My mother told me she _______ very tired since she came back from a visit to our grandparents.', N'was    ', N'had been', N'is     ', N'is     ', N'2', N'', CAST(N'2022-07-22T10:19:46.863' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (125, 1, N'', N'Susan _______ her family after she had taken the university entrance examination.', N'phoned   ', N'phoned   ', N'phones    ', N'is phoning', N'1', N'', CAST(N'2022-07-22T10:20:10.863' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (126, 1, N'', N'How many cities you and your uncle _______ by July last summer?', N'visited     ', N'had visited', N'did you visit', N'had you visited', N'2', N'', CAST(N'2022-07-22T10:20:36.590' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (127, 1, N'', N'Miss Jane _______ typing the report when her boss came in.', N'didn’t finish', N'hadn’t finished', N'doesn’t finish  ', N'can’t finish', N'2', N'', CAST(N'2022-07-22T10:21:05.687' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (128, 1, N'', N'Peter was in New York last week; he _______ in Washington D.C. three days earlier.', N'was    ', N'had been', N'is    ', N'was being', N'2', N'', CAST(N'2022-07-22T10:21:31.890' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (129, 1, N'', N'Three women, none of whom we _______ before, _______ out of the hall', N'saw-had come ', N'had seen-came', N'saw-came ', N'had seen-had come', N'2', N'', CAST(N'2022-07-22T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (130, 1, N'', N'They _______ through horrible times during the war years.', N'lived    ', N' had lived ', N'live    ', N'are living', N'1', N'', CAST(N'2022-07-22T10:22:31.690' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (131, 1, N'', N'Sam didn''t get much formal _______.', N'school    ', N'schooling    ', N'schooldays    ', N'schoolgirl', N'2', N'', CAST(N'2022-07-22T00:00:00.000' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (132, 1, N'', N'Space travel is one of the marvels wonders of modern _______.', N'science    ', N'scientific    ', N'scientifically     ', N'scientist', N'1', N'', CAST(N'2022-07-22T10:25:02.887' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (133, 1, N'', N'scientist', N'continue    ', N'continued    ', N'continuing     ', N'continuous', N'4', N'', CAST(N'2022-07-22T10:25:26.043' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (134, 1, N'', N'All her life she had a _______ trust in other people.', N'child    ', N'childlike    ', N'childish    ', N'childless', N'2', N'', CAST(N'2022-07-22T10:25:52.950' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (135, 1, N'', N'After he had spoken, a _______ silence fell on the room.', N'die    ', N'death    ', N'deathly    ', N'deathless', N'3', N'', CAST(N'2022-07-22T10:26:15.543' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (136, 1, N'', N'In 1778, he ……………… to London to study with Benjamin West for four years.', N'has gone  ', N'had gone', N'would go ', N'went', N'4', N'', CAST(N'2022-07-22T10:26:49.937' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (137, 1, N'', N'Thuộc tính nào sau đây là của đối tượng Session?', N'CodePage', N'QueryString', N'Form', N'CacheControl', N'1', N'', CAST(N'2022-07-22T11:01:04.853' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (138, 1, N'', N'Đối tượng Server là thể hiện của lớp nào?', N'System.Web.HttpContext.Current', N'System.Web.HttpServerUtility', N'System.Web.UI', N'System.Web', N'2', N'', CAST(N'2022-07-22T11:02:14.220' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (139, 1, N'', N'Sự kiện nào xảy ra khi Application được khởi tạo?', N' End', N'Start ', N'BeginRequest', N' AuthenticateRequest', N'2', N'', CAST(N'2022-07-22T11:04:29.410' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (140, 1, N'', N'Dữ liệu lưu trong đối tượng nào là chung cho các trang trong 1 website?', N' Server', N'Application', N'Request', N'Session', N'2', N'', CAST(N'2022-07-22T11:05:40.707' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (141, 1, N'', N'Mặc định, mỗi Session tồn tại trong bao lâu sau lần truy cập cuối cùng của người dùng?', N' 20 phút ', N' 10 phút ', N' 15 phút ', N' 25 phút ', N'1', N'', CAST(N'2022-07-22T11:06:28.287' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (142, 1, N'', N'Thuộc tính nào thiết lập thời gian tối đa để thực thi các yêu cầu web?', N'Server.TimeOut', N'Response.ScriptTimeOut', N'Server.ScriptTimeOut ', N'Request.TimeOut', N'3', N'', CAST(N'2022-07-22T11:07:25.600' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (143, 1, N'', N'Để tránh xung đột khi yêu cầu từ nhiều người dùng cùng truy xuất đến Application thì ta cần làm gì?', N' Tạo mới Application', N'HủyApplication', N'Khóa Application', N'', N'3', N'', CAST(N'2022-07-22T11:08:15.877' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (144, 1, N'', N'Dùng phương thức nào để đăng ký một đoạn ClientSide Script chạy khởi động khi trình duyệt nạp trang?', N'RegisterClientScriptBlock(...)', N'IsStartupScriptRegistered(....)', N'IsClientScriptBlockRegistered(....)', N'RegisterStartupScript(...) ', N'4', N'', CAST(N'2022-07-22T11:09:28.677' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (145, 1, N'', N'Khi sử dụng các đối tượng nội tại của ASP.NET, ta có cần khai báo chúng không?', N' Không ', N'Có', N'', N'', N'1', N'', CAST(N'2022-07-22T11:10:11.723' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (146, 1, N'', N'Phương thức nào sau đây dùng để hủy Session?', N'RemoveAll', N' Abandon', N'Clear', N'', N'2', N'', CAST(N'2022-07-22T11:11:03.087' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (147, 3, N'', N'Để xóa user ra khỏi group dùng lệnh nào? Chỉ viết tên lệnh', NULL, NULL, NULL, NULL, N'deluser', N'', CAST(N'2022-07-22T19:47:20.083' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (10115, 4, N'', N'Lệnh nào sau đây cho phép tạo nhóm?', N'adduser', N'useradd', N'groupadd', N'addgroup', N'34', N'', CAST(N'2022-07-24T03:11:56.997' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (10116, 4, N'', N'Thư mục mặc định của người dùng khi được tạo ra sẽ được đặt ở đầu?

', N'/bin', N'
/home

', N'
/etc', N'
/usr', N'2', N'', CAST(N'2022-07-24T03:12:36.153' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (10117, 4, N'', N'Câu lệnh nào sau đây là câu lệnh tạo tài khoản người dùng/', N'
addgroup', N'adduser', N'useradd', N'groupadd', N'23', N'', CAST(N'2022-07-24T03:13:12.103' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (10118, 4, N'', N'Giá trị nào sau đây của UID cho biết là người dùng thông thường

', N'999', N'0', N'1000', N'500', N'3', N'', CAST(N'2022-07-24T03:13:32.370' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (10119, 1, N'', N'Một người dùng có thể đặt mua bao nhiêu mặt hàng trong một đơn hàng?', N'Không', N'Nhiều', N'Một', N'', N'2', N'', CAST(N'2022-07-25T11:12:01.270' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (10120, 1, N'', N'Thẻ bài (Token) được sử dụng như thế nào trong thuật toán đồng bộ tiến trình', N'a. Để ngăn chặn các tiến trình khác truy nhập dữ liệu', N'b. Để tiến trình giữ thẻ bài có thể chuyển sang trạng thái truy nhập tài nguyên (CS)', N'c. Để báo cho các tiến trình khác truy nhập dữ liệu', N'd. Để chia sẻ dữ liệu giữa các tiến trình đang hoạt động', N'2', N'', CAST(N'2022-07-25T11:57:44.307' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (20119, 1, N'', N'Câu hỏi 1', N'2', N'3', N'4', N'', N'1', N'', CAST(N'2022-11-06T22:45:33.777' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (20120, 3, N'', N'Sự khác nhau giữa kiểm thử hộp đen và kiểm thử hộp trắng là gì?', NULL, NULL, NULL, NULL, N'Black box is functional; white box is structural (Hộp đen là chức năng; hộp trắng là cấu trúc)', N'', CAST(N'2022-12-30T19:45:29.867' AS DateTime))
INSERT [dbo].[questions] ([id_question], [id_question_type], [avatar], [question], [answer_1], [answer_2], [answer_3], [answer_4], [correct], [note], [date_create]) VALUES (20122, 1, N'', N'test demo', N'1', N'2', N'3', N'4', N'2', N'', CAST(N'2022-12-30T19:46:29.687' AS DateTime))
SET IDENTITY_INSERT [dbo].[questions] OFF
GO
SET IDENTITY_INSERT [dbo].[rights] ON 

INSERT [dbo].[rights] ([id_right], [name], [note], [date_create]) VALUES (1, N'admin     ', NULL, CAST(N'2022-07-13T11:44:09.943' AS DateTime))
INSERT [dbo].[rights] ([id_right], [name], [note], [date_create]) VALUES (2, N'teacher   ', NULL, CAST(N'2022-07-13T11:44:17.137' AS DateTime))
INSERT [dbo].[rights] ([id_right], [name], [note], [date_create]) VALUES (3, N'student   ', NULL, CAST(N'2022-07-13T11:44:21.007' AS DateTime))
SET IDENTITY_INSERT [dbo].[rights] OFF
GO
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (12, 10023, 1, 6, NULL, CAST(N'2022-07-24T02:48:26.270' AS DateTime), CAST(N'2022-07-24T02:50:40.003' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (12, 10023, 2, 3, NULL, CAST(N'2022-07-24T02:50:51.113' AS DateTime), CAST(N'2022-07-24T02:51:37.070' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (12, 10023, 3, 9, NULL, CAST(N'2022-07-24T02:51:45.563' AS DateTime), CAST(N'2022-07-24T02:53:10.600' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (12, 30029, 1, 4, NULL, CAST(N'2022-12-30T19:35:05.117' AS DateTime), CAST(N'2022-12-30T19:35:46.293' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (14, 10023, 1, 5.5555555555555554, NULL, CAST(N'2022-07-24T03:21:48.923' AS DateTime), CAST(N'2022-07-24T03:22:33.547' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (14, 10023, 2, 0, NULL, CAST(N'2022-07-25T11:59:59.100' AS DateTime), CAST(N'2022-07-25T12:00:26.830' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (20, 10027, 1, 8, NULL, CAST(N'2022-07-24T02:55:52.530' AS DateTime), CAST(N'2022-07-24T02:57:46.457' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (22, 10025, 1, 60, NULL, CAST(N'2022-07-25T08:35:30.933' AS DateTime), CAST(N'2022-07-25T08:35:47.977' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (10017, 10025, 1, 4, NULL, CAST(N'2022-07-25T11:14:38.837' AS DateTime), CAST(N'2022-07-25T11:14:59.373' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (20017, 10025, 1, 2, NULL, CAST(N'2022-07-26T02:57:08.763' AS DateTime), CAST(N'2022-07-26T02:57:25.643' AS DateTime))
INSERT [dbo].[score_of_exam] ([id_exam], [id_student], [id_redo], [score], [note], [start_time], [finish_time]) VALUES (20018, 10025, 1, 4, NULL, CAST(N'2022-07-26T02:59:48.747' AS DateTime), CAST(N'2022-07-26T03:00:05.913' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[students_user] ON 

INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10023, N'tien                ', N'Nguyễn Nhật Tiến', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'tien@email.com                                    ', NULL, 1, CAST(N'2022-07-15' AS Date), CAST(N'2022-07-20T22:46:38.000' AS DateTime), 3, 10)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10024, N'Giang               ', N'Nguyễn Trường Giang', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'votram@email.com                                  ', NULL, 0, NULL, CAST(N'2022-07-20T23:03:17.000' AS DateTime), 3, 15)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10025, N'duy                 ', N'Vũ Đức Duy', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'datlq@email.com                                   ', NULL, 1, CAST(N'2001-12-22' AS Date), CAST(N'2022-07-22T07:34:28.000' AS DateTime), 3, 11)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10026, N'anhduy              ', N'Nguyễn Anh Duy', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'an@email.com                                      ', NULL, 0, NULL, CAST(N'2022-07-22T10:04:11.000' AS DateTime), 3, 13)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (10027, N'thienan             ', N'Nguyễn Thiên An', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'an@email.com                                      ', NULL, 0, NULL, CAST(N'2022-07-22T10:53:44.310' AS DateTime), 3, 13)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (20025, N'minh                ', N'Đặng Nhật Minh', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'minh@email.com                                    ', NULL, NULL, NULL, CAST(N'2022-07-23T20:17:23.230' AS DateTime), 3, 10)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (20026, N'hai                 ', N'Đới Ngọc Hải', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'haint@gmail.com                                   ', NULL, 1, NULL, CAST(N'2022-07-25T10:11:16.163' AS DateTime), 3, 11)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (20027, N'lehai               ', N'Lê Trí Hải', N'c4ca4238a0b923820dcc509a6f75849b                                                                    ', N'haile@gmail.com                                   ', NULL, 1, CAST(N'2022-01-06' AS Date), CAST(N'2022-07-25T11:47:53.073' AS DateTime), 3, 10)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (30026, N'haile               ', N'hai le tri ', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'sad@gmail.com                                     ', NULL, 1, CAST(N'2007-01-01' AS Date), CAST(N'2022-07-30T00:44:51.643' AS DateTime), 3, 10)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (30027, N'duyna               ', N'Nguyễn Anh Duy', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'duyna@gmail.com                                   ', NULL, 1, CAST(N'2022-01-03' AS Date), CAST(N'2022-07-30T03:21:03.500' AS DateTime), 3, 11)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (30028, N'duyna003            ', N'NGUYỄN ANH DUY', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'duyna003@gmail.com                                ', NULL, NULL, CAST(N'1987-06-10' AS Date), CAST(N'2022-07-30T03:40:19.437' AS DateTime), 3, 11)
INSERT [dbo].[students_user] ([id_user], [username], [name], [password], [email], [avatar], [gender], [birthday], [date_create], [id_right], [id_grade]) VALUES (30029, N'thoai               ', N'thoai', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'thoai@gmail.com                                   ', NULL, NULL, CAST(N'2000-06-19' AS Date), CAST(N'2022-12-30T19:08:16.220' AS DateTime), 3, 12)
SET IDENTITY_INSERT [dbo].[students_user] OFF
GO
SET IDENTITY_INSERT [dbo].[subject_grade] ON 

INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (12, 1, 12, 2, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (14, 1, 11, 2, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (15, 4, 13, 3, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (16, 4, 14, 3, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (17, 16, 10, 4, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (18, 4, 19, 3, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (19, 1, 10, 4, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (10015, 10016, 10019, 4, NULL)
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (20015, 20016, 20019, 10005, N'a')
INSERT [dbo].[subject_grade] ([id_subject_grade], [id_subject], [id_grade], [id_teacher], [note]) VALUES (20016, 20017, 20020, 5, NULL)
SET IDENTITY_INSERT [dbo].[subject_grade] OFF
GO
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (12, 10025, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (12, 30029, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (14, 10023, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (15, 10023, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (15, 10025, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (15, 10026, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (15, 10027, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (17, 10025, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (17, 30026, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (18, 30029, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (19, 10023, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (19, 30029, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (20015, 10023, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (20015, 10025, NULL)
INSERT [dbo].[subject_student] ([id_subject_grade], [id_student], [note]) VALUES (20015, 30029, NULL)
GO
SET IDENTITY_INSERT [dbo].[subjects] ON 

INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (1, N'Linux', CAST(N'2022-07-14T09:51:50.000' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (2, N'Lí thuyết xác suất thống kê', CAST(N'2022-07-16T13:08:57.000' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (4, N'Tiếng Anh', CAST(N'2022-07-16T13:09:07.150' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (6, N'Cấu trúc dữ liệu', CAST(N'2022-07-16T13:09:18.983' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (7, N'Nhập môn lập trình', CAST(N'2022-07-16T13:09:26.263' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (9, N'Kinh tế học đại cương', CAST(N'2022-07-16T13:09:42.393' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (10, N'Cơ sở dữ liệu', CAST(N'2022-07-16T13:09:56.073' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (12, N'Nhập môn di động', CAST(N'2022-07-16T13:10:10.170' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (13, N'Phát triển web', CAST(N'2022-07-16T13:10:14.297' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (14, N'IELTS', CAST(N'2022-07-17T16:38:51.000' AS DateTime), 5)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (16, N'Lập trình Web IT15.025', CAST(N'2022-07-22T10:55:18.000' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (10016, N'Môn Thực tập chuyên nghành', CAST(N'2022-07-25T10:58:50.263' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (10017, N'Các Hệ Thống Phân Tán IT45.001', CAST(N'2022-07-25T11:49:53.693' AS DateTime), 4)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (20016, N'Lái Trực Thăng', CAST(N'2022-07-30T00:47:21.900' AS DateTime), 10012)
INSERT [dbo].[subjects] ([id_subject], [name], [date_create], [id_field]) VALUES (20017, N'Kiểm thử phần mềm', CAST(N'2022-12-30T19:50:30.150' AS DateTime), 4)
SET IDENTITY_INSERT [dbo].[subjects] OFF
GO
SET IDENTITY_INSERT [dbo].[teachers_user] ON 

INSERT [dbo].[teachers_user] ([id_teacher], [username], [name], [password], [email], [phone], [avatar], [gender], [birthday], [date_create], [id_right]) VALUES (2, N'nhung               ', N'Nguyễn Nhung', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'nhung@email.com                                   ', NULL, NULL, 0, CAST(N'2022-07-22' AS Date), CAST(N'2022-07-20T22:25:47.457' AS DateTime), 2)
INSERT [dbo].[teachers_user] ([id_teacher], [username], [name], [password], [email], [phone], [avatar], [gender], [birthday], [date_create], [id_right]) VALUES (3, N'tam                 ', N'Nguyễn Mỹ Tâm', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'mtam@email.com                                    ', NULL, NULL, 0, CAST(N'2022-07-21' AS Date), CAST(N'2022-07-20T23:50:07.030' AS DateTime), 2)
INSERT [dbo].[teachers_user] ([id_teacher], [username], [name], [password], [email], [phone], [avatar], [gender], [birthday], [date_create], [id_right]) VALUES (4, N'dung                ', N'Lê Hữu Dũng', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'cuong@email.com                                   ', NULL, NULL, 1, NULL, CAST(N'2022-07-20T23:50:51.000' AS DateTime), 2)
INSERT [dbo].[teachers_user] ([id_teacher], [username], [name], [password], [email], [phone], [avatar], [gender], [birthday], [date_create], [id_right]) VALUES (5, N'ledung              ', N'Nguyễn Văn Dũng', N'c4ca4238a0b923820dcc509a6f75849b                                                                    ', N'abc@gmail.com                                     ', N'0123456789     ', NULL, 1, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-25T11:48:38.323' AS DateTime), 2)
INSERT [dbo].[teachers_user] ([id_teacher], [username], [name], [password], [email], [phone], [avatar], [gender], [birthday], [date_create], [id_right]) VALUES (10005, N'letrihai            ', N'le tri hai', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'nguyenvana@gmail.com                              ', N'0934447444     ', NULL, 1, CAST(N'2002-05-05' AS Date), CAST(N'2022-07-30T00:43:48.413' AS DateTime), 2)
INSERT [dbo].[teachers_user] ([id_teacher], [username], [name], [password], [email], [phone], [avatar], [gender], [birthday], [date_create], [id_right]) VALUES (10006, N'letrihai            ', N'le tri hai', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'abc@gmail.com                                     ', N'0741258222     ', NULL, 1, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-30T16:53:38.183' AS DateTime), 2)
INSERT [dbo].[teachers_user] ([id_teacher], [username], [name], [password], [email], [phone], [avatar], [gender], [birthday], [date_create], [id_right]) VALUES (10007, N'minh                ', N'1111', N'81dc9bdb52d04dc20036dbd8313ed055                                                                    ', N'giang@gmail.com                                   ', NULL, NULL, 1, CAST(N'2020-08-21' AS Date), CAST(N'2022-07-30T05:47:04.467' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[teachers_user] OFF
GO
ALTER TABLE [dbo].[do_exam] ADD  CONSTRAINT [DF_do_exam_finsh_time]  DEFAULT (getdate()) FOR [finsh_time]
GO
ALTER TABLE [dbo].[exam_question] ADD  CONSTRAINT [DF_exam_question_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[exams] ADD  CONSTRAINT [DF_exams_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[exams] ADD  CONSTRAINT [DF_exams_score]  DEFAULT ((10.0)) FOR [score]
GO
ALTER TABLE [dbo].[fields] ADD  CONSTRAINT [DF_fields_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[grades] ADD  CONSTRAINT [DF_grades_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[managers] ADD  CONSTRAINT [DF_managers_id_right]  DEFAULT ((1)) FOR [id_right]
GO
ALTER TABLE [dbo].[question_bank] ADD  CONSTRAINT [DF_question_bank_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[question_types] ADD  CONSTRAINT [DF_question_types_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[questions] ADD  CONSTRAINT [DF_questions_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[rights] ADD  CONSTRAINT [DF_rights_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[students_user] ADD  CONSTRAINT [DF_users_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[students_user] ADD  CONSTRAINT [DF_users_id_right]  DEFAULT ((3)) FOR [id_right]
GO
ALTER TABLE [dbo].[subjects] ADD  CONSTRAINT [DF_subjects_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[teachers_user] ADD  CONSTRAINT [DF_teachers_date_create]  DEFAULT (getdate()) FOR [date_create]
GO
ALTER TABLE [dbo].[teachers_user] ADD  CONSTRAINT [DF_teachers_id_right]  DEFAULT ((2)) FOR [id_right]
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
REFERENCES [dbo].[students_user] ([id_user])
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
ALTER TABLE [dbo].[exams]  WITH CHECK ADD  CONSTRAINT [FK_exams_subject_grade] FOREIGN KEY([id_subject_grade])
REFERENCES [dbo].[subject_grade] ([id_subject_grade])
GO
ALTER TABLE [dbo].[exams] CHECK CONSTRAINT [FK_exams_subject_grade]
GO
ALTER TABLE [dbo].[grades]  WITH CHECK ADD  CONSTRAINT [FK_grades_fields] FOREIGN KEY([id_field])
REFERENCES [dbo].[fields] ([id_field])
GO
ALTER TABLE [dbo].[grades] CHECK CONSTRAINT [FK_grades_fields]
GO
ALTER TABLE [dbo].[managers]  WITH CHECK ADD  CONSTRAINT [FK_managers_rights] FOREIGN KEY([id_right])
REFERENCES [dbo].[rights] ([id_right])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[managers] CHECK CONSTRAINT [FK_managers_rights]
GO
ALTER TABLE [dbo].[question_bank]  WITH CHECK ADD  CONSTRAINT [FK_question_bank_subject_grade] FOREIGN KEY([id_subject_grade])
REFERENCES [dbo].[subject_grade] ([id_subject_grade])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[question_bank] CHECK CONSTRAINT [FK_question_bank_subject_grade]
GO
ALTER TABLE [dbo].[question_bank_questions]  WITH CHECK ADD  CONSTRAINT [FK_question_bank_questions_question_bank] FOREIGN KEY([id_question_bank])
REFERENCES [dbo].[question_bank] ([id_question_bank])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[question_bank_questions] CHECK CONSTRAINT [FK_question_bank_questions_question_bank]
GO
ALTER TABLE [dbo].[question_bank_questions]  WITH CHECK ADD  CONSTRAINT [FK_question_bank_questions_questions] FOREIGN KEY([id_question])
REFERENCES [dbo].[questions] ([id_question])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[question_bank_questions] CHECK CONSTRAINT [FK_question_bank_questions_questions]
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
REFERENCES [dbo].[students_user] ([id_user])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[score_of_exam] CHECK CONSTRAINT [FK_score_of_exam_users]
GO
ALTER TABLE [dbo].[students_user]  WITH CHECK ADD  CONSTRAINT [FK_users_grades] FOREIGN KEY([id_grade])
REFERENCES [dbo].[grades] ([id_grade])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[students_user] CHECK CONSTRAINT [FK_users_grades]
GO
ALTER TABLE [dbo].[students_user]  WITH CHECK ADD  CONSTRAINT [FK_users_rights] FOREIGN KEY([id_right])
REFERENCES [dbo].[rights] ([id_right])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[students_user] CHECK CONSTRAINT [FK_users_rights]
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
ALTER TABLE [dbo].[subject_grade]  WITH CHECK ADD  CONSTRAINT [FK_subject_grade_teachers] FOREIGN KEY([id_teacher])
REFERENCES [dbo].[teachers_user] ([id_teacher])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[subject_grade] CHECK CONSTRAINT [FK_subject_grade_teachers]
GO
ALTER TABLE [dbo].[subject_student]  WITH CHECK ADD  CONSTRAINT [FK_subject_student_subject_grade] FOREIGN KEY([id_subject_grade])
REFERENCES [dbo].[subject_grade] ([id_subject_grade])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[subject_student] CHECK CONSTRAINT [FK_subject_student_subject_grade]
GO
ALTER TABLE [dbo].[subject_student]  WITH CHECK ADD  CONSTRAINT [FK_subject_student_users] FOREIGN KEY([id_student])
REFERENCES [dbo].[students_user] ([id_user])
GO
ALTER TABLE [dbo].[subject_student] CHECK CONSTRAINT [FK_subject_student_users]
GO
ALTER TABLE [dbo].[subjects]  WITH CHECK ADD  CONSTRAINT [FK_subjects_fields] FOREIGN KEY([id_field])
REFERENCES [dbo].[fields] ([id_field])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[subjects] CHECK CONSTRAINT [FK_subjects_fields]
GO
ALTER TABLE [dbo].[teachers_user]  WITH CHECK ADD  CONSTRAINT [FK_teachers_rights] FOREIGN KEY([id_right])
REFERENCES [dbo].[rights] ([id_right])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[teachers_user] CHECK CONSTRAINT [FK_teachers_rights]
GO
/****** Object:  StoredProcedure [dbo].[CheckDoExam]    Script Date: 12/30/2022 11:51:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckDoExam] 
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
/****** Object:  StoredProcedure [dbo].[getDetailDoExam]    Script Date: 12/30/2022 11:51:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getDetailDoExam] 
	@id_exam bigint,
	@id_user bigint,
	@id_redo int
AS
BEGIN
	select d.chose, q.correct, (case when (d.chose = q.correct) then 1 else 0 end) as status
	from do_exam as d
	join questions as q on d.id_question = q.id_question
	where d.id_exam = @id_exam and d.id_student = @id_user and d.id_redo = @id_redo
end
GO
/****** Object:  StoredProcedure [dbo].[ReviewDoExam]    Script Date: 12/30/2022 11:51:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[ReviewDoExam] 
	@id_exam bigint,
	@id_user bigint,
	@id_redo int
AS
BEGIN
	select d.chose, q.correct, (case when (d.chose = q.correct) then 1 else 0 end) as isCorrect, q.question, q.answer_1,q.answer_2,q.answer_3,q.answer_4,q.id_question_type,q.note
	from do_exam as d
	join questions as q on d.id_question = q.id_question
	where d.id_exam = @id_exam and d.id_student = @id_user and d.id_redo = @id_redo
end
GO
/****** Object:  StoredProcedure [dbo].[SelectAllQuestionFrom]    Script Date: 12/30/2022 11:51:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectAllQuestionFrom] 
	@id_question_bank bigint
AS
BEGIN
	select id_question_bank,q.id_question_type,q.id_question,question,answer_1,answer_2,answer_3,answer_4,correct,q.note,q.date_create, qt.name as 'question_type'
	from question_bank_questions as ex
	join questions as q
	on ex.id_question = q.id_question
	join question_types as qt
	on q.id_question_type = qt.id_question_type
	where ex.id_question_bank = @id_question_bank
end
GO
/****** Object:  StoredProcedure [dbo].[SelectOneQuestionFrom]    Script Date: 12/30/2022 11:51:51 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SelectRandomQuestionFrom]    Script Date: 12/30/2022 11:51:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectRandomQuestionFrom] 
	@id_question_bank bigint,
	@number_of_question int
AS
BEGIN
select distinct *
from (
	select id_question_bank,q.id_question_type,q.id_question,question,answer_1,answer_2,answer_3,answer_4,q.note,q.date_create, qt.name as 'question_type'
	from question_bank_questions as ex
	join questions as q
	on ex.id_question = q.id_question
	join question_types as qt
	on q.id_question_type = qt.id_question_type
	where ex.id_question_bank = @id_question_bank
	order by NEWID()
	OFFSET     0 ROWS
	FETCH NEXT @number_of_question ROWS ONLY
) as t
end
GO
/****** Object:  StoredProcedure [dbo].[subject_grade_filter]    Script Date: 12/30/2022 11:51:51 PM ******/
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
		join teachers_user as u on s_g.id_teacher = u.id_teacher
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
ALTER DATABASE [SqlServerTracNghiem] SET  READ_WRITE 
GO
