IF NOT EXISTS(SELECT * FROM sys.databases WHERE name =  '$(DB_NAME)')
    BEGIN
        CREATE DATABASE [$(DB_NAME)]
    END

CREATE LOGIN UmbracoUser   
    WITH PASSWORD = '$(DB_USER_PASSWORD)';  
GO  

-- Creates a database user for the login created above.  
USE [$(DB_NAME)]
    CREATE USER $(DB_USER_LOGIN) FOR LOGIN $(DB_USER_LOGIN);  
GO  

USE [$(DB_NAME)]

    ALTER ROLE db_datareader ADD MEMBER $(DB_USER_LOGIN)
GO  

USE [$(DB_NAME)]
    
    ALTER ROLE db_datawriter ADD MEMBER $(DB_USER_LOGIN)
GO  

USE [$(DB_NAME)]

    ALTER ROLE db_ddladmin ADD MEMBER $(DB_USER_LOGIN)
GO