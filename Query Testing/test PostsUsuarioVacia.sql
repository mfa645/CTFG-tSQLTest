USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test PostsUsuarioVacia]
AS
BEGIN
  SET NOCOUNT ON;
  --Assemble--
     IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
	 IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (1,'user1',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (2,'user1',DEFAULT,18)

	 INSERT INTO dbo.Discusion(idDiscusion,nombre,idUsuario) VALUES (1,'d1',1)
	 INSERT INTO dbo.Discusion(idDiscusion,nombre,idUsuario) VALUES (2,'d2',2)

  	 INSERT INTO dbo.Post(idDiscusion,idPost,idUsuario,descripcion) VALUES (1,1,1,'postU1D1P1')



  --Act
SELECT descripcion INTO actual FROM	dbo.post WHERE idUsuario=2

  --Assert
  EXEC tSQLt.AssertEmptyTable @TableName = 'actual', -- nvarchar(max)
                              @Message = 'Tabla con contenido'    -- nvarchar(max)

END;


