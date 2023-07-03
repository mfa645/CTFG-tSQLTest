USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test SeguidoresUsuarioLlena]
AS
BEGIN
  SET NOCOUNT ON;
  --Assemble--
     IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
	 IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (1,'user1',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (2,'user2',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (3,'user3',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (4,'user4',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (5,'user5',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (6,'user6',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (7,'user1',DEFAULT,18)

	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (2,1)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (3,1)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (4,1)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (5,1)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (6,1)
  
  --Act
	SELECT u.nombre
	INTO actual
	FROM seguidores s JOIN dbo.Usuario u ON s.idSeguidor=u.idUsuario
	WHERE s.idSeguido = 1
  --Assert
      CREATE TABLE expected (
	    nombre VARCHAR(50),
    );
	INSERT INTO dbo.expected(nombre)VALUES('user2')
	INSERT INTO dbo.expected(nombre)VALUES('user3')
	INSERT INTO dbo.expected(nombre)VALUES('user4')
	INSERT INTO dbo.expected(nombre)VALUES('user5')
	INSERT INTO dbo.expected(nombre)VALUES('user6')


  EXEC tSQLt.AssertEqualsTable @Expected = 'expected', -- nvarchar(max)
                               @Actual = 'actual',   -- nvarchar(max)
                               @FailMsg = 'Los resultados no son los esperados'   -- nvarchar(max)
END;



