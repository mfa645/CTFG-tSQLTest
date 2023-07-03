USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [CRUD Testing].[test DeleteSeguidores]
AS
BEGIN
  --Assemble
     DECLARE @expected INT; SET @expected = 0;
	 DECLARE @actual INT;
	 INSERT INTO	dbo.Usuario
	 (
	     idUsuario,
	     nombre,
	     verificado,
	     edad
	 )
	 VALUES
	 (   1,       -- idUsuario - bigint
	     'user1',      -- nombre - varchar(50)
	     DEFAULT, -- verificado - bit
	     18       -- edad - int
	     )

	INSERT INTO	dbo.Usuario
	 (
	     idUsuario,
	     nombre,
	     verificado,
	     edad
	 )
	 VALUES
	 (   2,       -- idUsuario - bigint
	     'user2',      -- nombre - varchar(50)
	     DEFAULT, -- verificado - bit
	     18       -- edad - int
	     )

		  INSERT INTO	dbo.Seguidores
 (
     idSeguidor,
     idSeguido
 )
 VALUES
 (   1, -- idSeguidor - bigint
     2  -- idSeguido - bigint
     )

  --Act
  DELETE FROM dbo.Seguidores WHERE idSeguidor=1 AND idSeguido=2

        SELECT @actual = COUNT(*) FROM dbo.Seguidores

  --Assert
 EXEC tSQLt.AssertEquals @expected,
                          @actual, 
                          @Message = 'La inserción se realizó'
  
END;



