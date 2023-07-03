USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [SchemaTesting].[test PostFK_False]
AS
BEGIN
SET NOCOUNT ON;
  --Assemble
     DECLARE @expected INT; SET @expected = 0;
	 DECLARE @actual INT;

  --Act

   BEGIN TRY
 INSERT INTO	dbo.Post
 (
     idPost,
     descripcion,
     idUsuario,
     idDiscusion
 )
 VALUES
 (   1,  -- idPost - bigint
     'post1', -- descripcion - varchar(50)
     0,  -- idUsuario - bigint
     0   -- idDiscusion - bigint
     )
    END TRY
	BEGIN CATCH
    END CATCH;  

        SELECT @actual = COUNT(*) FROM dbo.Post

  --Assert
 EXEC tSQLt.AssertEquals @expected,
                          @actual, 
                          @Message = 'La inserción se realizó'
  
END;



