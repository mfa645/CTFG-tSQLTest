USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test UsuariosVerificadosMas5SeguidoresVacia]
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

	 --Analisis valor limite, 4 seguidores having>=5 = false. Verificado = 1
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (1,2)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (3,2)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (4,2)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (5,2)

	 --1 seguidor having>=5 = false. Verificado = 0
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (1,3)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (2,3)
  
  --Act
	SELECT u.idUsuario, u.nombre, COUNT(*) AS numero_seguidores
	INTO actual
	FROM usuario u
	JOIN seguidores s ON u.idUsuario = s.idSeguido
	WHERE u.verificado = 1
	GROUP BY u.idUsuario, u.nombre
	HAVING COUNT(*) >=5
  --Assert
  EXEC tSQLt.AssertEmptyTable @TableName = 'actual', -- nvarchar(max)
                              @Message = 'La consulta devolvio valores'    -- nvarchar(max)
  
END;



