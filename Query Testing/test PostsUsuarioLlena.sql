USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test PostsUsuarioLlena]
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
	 INSERT INTO dbo.Post(idDiscusion,idPost,idUsuario,descripcion) VALUES (2,1,2,'postU2D2P1')
  	 INSERT INTO dbo.Post(idDiscusion,idPost,idUsuario,descripcion) VALUES (2,2,2,'postU2D2P2')


  --Act
SELECT descripcion INTO actual FROM	dbo.post WHERE idUsuario=2

  --Assert
      CREATE TABLE expected (
	    descripcion VARCHAR(50),
    );
	INSERT INTO dbo.expected
	(
	    descripcion
	)
	VALUES
	(
	    'postU2D2P1' -- nombre - varchar(50)
	    )
			INSERT INTO dbo.expected
	(
	    descripcion
	)
		VALUES
	(
	    'postU2D2P2' -- nombre - varchar(50)
	    )
  EXEC tSQLt.AssertEqualsTable @Expected = 'expected', -- nvarchar(max)
                               @Actual = 'actual',   -- nvarchar(max)
                               @FailMsg = 'Los resultados no son los esperados'   -- nvarchar(max)
  
END;




