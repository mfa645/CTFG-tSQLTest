USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [SchemaTesting].[test UsuarioPK_True]
AS
BEGIN
 SET NOCOUNT ON;
  --Assemble
     DECLARE @expected INT; SET @expected = 1;
	 DECLARE @actual INT;

  --Act
  INSERT INTO dbo.Usuario
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
      18        -- edad - int
      )

      SELECT @actual = COUNT(*) FROM dbo.Usuario

  --Assert
  EXEC tSQLt.AssertEquals @expected, -- sql_variant
                          @actual,   -- sql_variant
                          @Message = 'Fallo en la insercion'    -- nvarchar(max)
  
END;





