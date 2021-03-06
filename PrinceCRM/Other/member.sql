USE [PrinceCRM]
GO
/****** Object:  Table [dbo].[member]    Script Date: 2017/8/27 下午 09:49:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Token] [nvarchar](50) NULL,
	[LastModify] [datetime] NOT NULL,
 CONSTRAINT [PK_member] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[member] ON 

INSERT [dbo].[member] ([id], [Username], [Password], [Token], [LastModify]) VALUES (1, N'mike', N'1234', N'B44C3C1D-ED54-444D-B1D3-188FCA31EEBD', CAST(N'2017-08-27T21:42:32.677' AS DateTime))
INSERT [dbo].[member] ([id], [Username], [Password], [Token], [LastModify]) VALUES (2, N'bonnie', N'1234', N'59D0318F-2001-4C26-8969-4F57842DA8FB', CAST(N'2017-08-25T16:25:04.987' AS DateTime))
INSERT [dbo].[member] ([id], [Username], [Password], [Token], [LastModify]) VALUES (3, N'peterpan', N'1234', N'D32CAF28-0901-41A0-9E2B-D88BC734B8CD', CAST(N'2017-08-25T16:25:14.903' AS DateTime))
SET IDENTITY_INSERT [dbo].[member] OFF
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [DF_member_LastModify]  DEFAULT (dateadd(hour,(8),getutcdate())) FOR [LastModify]
GO
