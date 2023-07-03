USE [TestSocialDiscusions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
ALTER PROCEDURE [CRUD Testing].[test DeleteDiscusion]
AS
BEGIN
 SET NOCOUNT ON;
  --Assemble
     DECLARE @expected int; SET @expected = 0;
	 DECLARE @actual int;
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

		 INSERT INTO dbo.Discusion
   (
       idDiscusion,
       nombre,
       idUsuario
   )
   VALUES
   (   1,  -- idDiscusion - bigint
       'discusion1', -- nombre - varchar(50)
       1   -- idUsuario - bigint
       )
      
  --Act

  DELETE FROM dbo.Discusion
   WHERE idDiscusion=1 AND idUsuario=1


        SELECT @actual = COUNT(*) FROM dbo.Discusion

  --Assert
 EXEC tSQLt.AssertEquals @expected,
                          @actual, 
                          @Message = 'La eliminación no se realizó'
  
END;



