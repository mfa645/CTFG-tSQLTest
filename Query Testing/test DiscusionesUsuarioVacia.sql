USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test DiscusionesUsuarioVacia]
AS
BEGIN
  --Assemble--
     IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
	 IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (1,'user1',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (2,'user2',DEFAULT,18)
	 INSERT INTO dbo.Discusion(idDiscusion,nombre,idUsuario) VALUES (2,'d2',2)
	 INSERT INTO dbo.Discusion(idDiscusion,nombre,idUsuario) VALUES (3,'d3',2)
  
  --Act
SELECT nombre INTO actual FROM	dbo.Discusion WHERE idUsuario=1

  --Assert

  EXEC tSQLt.AssertEmptyTable @TableName = 'actual', -- nvarchar(max)
                              @Message = 'Tabla no vacia'    -- nvarchar(max)
END;




