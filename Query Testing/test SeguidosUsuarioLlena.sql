USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test SeguidosUsuarioLlena]
AS
BEGIN
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

	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (1,3)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (1,4)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (1,5)
  
  --Act
	SELECT u.nombre
	INTO actual
	FROM seguidores s JOIN dbo.Usuario u ON s.idSeguido=u.idUsuario
	WHERE s.idSeguidor = 1
  --Assert
      CREATE TABLE expected (
	    nombre VARCHAR(50),
    );
	INSERT INTO dbo.expected(nombre)VALUES('user3')
	INSERT INTO dbo.expected(nombre)VALUES('user4')
	INSERT INTO dbo.expected(nombre)VALUES('user5')


  EXEC tSQLt.AssertEqualsTable @Expected = 'expected', -- nvarchar(max)
                               @Actual = 'actual',   -- nvarchar(max)
                               @FailMsg = 'Los resultados no son los esperados'   -- nvarchar(max)
  
END;




