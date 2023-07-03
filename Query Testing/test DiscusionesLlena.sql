USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [Query Testing].[test DiscusionesLlena]
AS
BEGIN
  SET NOCOUNT ON;
  --Assemble--
     IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
	 IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

	 INSERT INTO dbo.Usuario(idUsuario,nombre,verificado,edad) VALUES (1,'user1',DEFAULT,18)


	 --Analisis valor limite, 5 seguidores having>=5 = true. Verificado = 1
	 INSERT INTO dbo.Discusion(idDiscusion,nombre,idUsuario) VALUES (1,'d1',1)
	 INSERT INTO dbo.Discusion(idDiscusion,nombre,idUsuario) VALUES (2,'d2',1)
	 INSERT INTO dbo.Discusion(idDiscusion,nombre,idUsuario) VALUES (3,'d3',1)
  
  --Act
SELECT nombre INTO actual FROM	dbo.Discusion

  --Assert
      CREATE TABLE expected (
	    nombre VARCHAR(50),
    );
	INSERT INTO dbo.expected
	(
	    nombre
	)
	VALUES
	(
	    'd1' -- nombre - varchar(50)
	    )
			INSERT INTO dbo.expected
	(
	    nombre
	)
	VALUES
	(
	    'd2' -- nombre - varchar(50)
	    )
			INSERT INTO dbo.expected
	(
	    nombre
	)
	VALUES
	(
	    'd3' -- nombre - varchar(50)
	    )
  EXEC tSQLt.AssertEqualsTable @Expected = 'expected', -- nvarchar(max)
                               @Actual = 'actual',   -- nvarchar(max)
                               @FailMsg = 'Los resultados no son los esperados'   -- nvarchar(max)
END;




