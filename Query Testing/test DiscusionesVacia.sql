USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test DiscusionesVacia]
AS
BEGIN
  --Assemble--
     IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
	 IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (1,'user1',DEFAULT,18)

  
  --Act
SELECT nombre INTO actual FROM	dbo.Discusion

  --Assert

  EXEC tSQLt.AssertEmptyTable @TableName = 'actual', -- nvarchar(max)
                              @Message = 'Tabla no vacia'    -- nvarchar(max)
END;



