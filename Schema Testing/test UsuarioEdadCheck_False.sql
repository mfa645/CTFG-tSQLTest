USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [SchemaTesting].[test UsuarioEdadCheck_False]
AS
BEGIN
SET NOCOUNT ON;
  --Assemble
     DECLARE @expected INT; SET @expected = 0;
	 DECLARE @actual INT;
      
  --Act

   BEGIN TRY
   INSERT INTO dbo.Usuario
(
    idUsuario,
    nombre,
    verificado,
    edad
)
VALUES
(   1,       -- idUsuario - bigint
    'username',      -- nombre - varchar(50)
    DEFAULT, -- verificado - bit
    17        -- edad - int
    )
    END TRY
	BEGIN CATCH
    END CATCH;  

        SELECT @actual = COUNT(*) FROM dbo.Usuario

  --Assert
 EXEC tSQLt.AssertEquals @expected,
                          @actual, 
                          @Message = 'La inserci�n se realiz�'
  
END;



