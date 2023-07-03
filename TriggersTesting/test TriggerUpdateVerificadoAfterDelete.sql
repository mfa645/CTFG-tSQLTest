USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [TriggersTesting].[test TriggerUpdateVerificadoAfterDelete]
AS
BEGIN
SET NOCOUNT ON;
  --Assemble--
     DECLARE @expected bit; SET @expected = 0;
	 DECLARE @actual bit;

	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (1,'user1',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (2,'user2',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (3,'user3',DEFAULT,18)
	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (4,'user4',DEFAULT,18)
	 
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (2,1)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (3,1)
	 INSERT INTO dbo.Seguidores(idSeguidor,idSeguido) VALUES (4,1)


   --Check consulta estado BD
	DECLARE @violaciones INT;
	IF OBJECT_ID('tablaV') IS NOT NULL DROP TABLE tablaV;
	SELECT  COUNT(*) AS numero_seguidores
	INTO tablaV
		FROM usuario u
		JOIN seguidores s ON u.idUsuario = s.idSeguido
		WHERE u.verificado = 0
		GROUP BY u.idUsuario
		HAVING COUNT(*) >=3;
	SELECT @violaciones = COUNT(*) FROM tablaV;
	 IF @violaciones > 0  
		EXEC tSQLt.Fail 'Estado de la BD viola la regla de negocio'
	--End consulta estado BD
 --Act

	 DELETE FROM dbo.Seguidores WHERE idSeguido=1 AND idSeguidor=4

        SELECT @actual = verificado FROM dbo.Usuario WHERE	idUsuario=1

  --Assert
 EXEC tSQLt.AssertEquals @expected,
                          @actual, 
                          @Message = 'El usuario no está verificado'
  
END;



