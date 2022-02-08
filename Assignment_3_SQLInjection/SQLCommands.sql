CREATE SCHEMA `unbfcs`;

CREATE TABLE `unbfcs`.`cs4415` (
 `StuID` INT NOT NULL,
 `StuFName` VARCHAR(45) NULL,
 `StuLName` VARCHAR(45) NULL,
 `StuGrade` FLOAT NULL,
 PRIMARY KEY (`StuID`));

INSERT INTO `unbfcs`.`cs4415`
(`StuID`,`StuFName`,`StuLName`,`StuGrade`) VALUES (1000, 'Bob', 'Bobby', 9.6);
INSERT INTO `unbfcs`.`cs4415`
(`StuID`,`StuFName`,`StuLName`,`StuGrade`) VALUES (1011, 'John', 'Johny',
18.82);
INSERT INTO `unbfcs`.`cs4415`
(`StuID`,`StuFName`,`StuLName`,`StuGrade`) VALUES (1023, 'Rose', 'Rosey',
18.82);

SELECT * FROM unbfcs.cs4415;

CREATE TABLE `unbfcs`.`cs4415Hashed` (
 `StuID` INT NOT NULL,
 `StuFName` VARCHAR(45) NULL,
 `StuLName` VARCHAR(45) NULL,
 `StuGrade` FLOAT NULL,
 `StuHashValue` VARCHAR(32) NULL,
 PRIMARY KEY (`StuID`));
 
 INSERT INTO unbfcs.cs4415Hashed (StuID,StuFName,StuLName,StuGrade, StuHashValue) 
 SELECT StuID,StuFName,StuLName,StuGrade, MD5(concat(StuID,StuFName,StuLName,StuGrade)) FROM unbfcs.cs4415;
 
 SELECT * FROM unbfcs.cs4415Hashed;
 
 INSERT INTO unbfcs.cs4415Hashed (StuID,StuFName,StuLName,StuGrade,StuHashValue) 
 VALUES (3720505,'Soheil','Shirvani',20,MD5(concat(3720505,'Soheil','Shirvani',20)) );
 
 SELECT * FROM unbfcs.cs4415Hashed;
 
 SELECT StuHashValue FROM unbfcs.cs4415Hashed WHERE StuID=3720505; # 'd4482d2427630492141432af14fe93d6';
 SELECT MD5(concat(StuID,StuFName,StuLName,10)) FROM unbfcs.cs4415Hashed WHERE StuID=3720505; # '44af4cbea52061baa06841a745a67a3b';

 UPDATE unbfcs.cs4415Hashed SET StuGrade=10, StuHashValue=MD5(concat(StuID,StuFName,StuLName,10)) WHERE StuID=3720505;
 
 SELECT * FROM unbfcs.cs4415Hashed;
 
 CREATE TABLE `unbfcs`.`cs4415enc` (
 `StuID` blob NOT NULL,
 `StuFName` blob,
 `StuLName` blob,
 `StuGrade` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM `unbfcs`.`cs4415enc`;

INSERT INTO unbfcs.cs4415enc (StuID, StuFName, StuLName, StuGrade)
SELECT aes_encrypt(StuID,'qazWSX123!@#'), 
aes_encrypt(StuFName,'qazWSX123!@#'), 
aes_encrypt(StuLName, 'qazWSX123!@#'), 
aes_encrypt(StuGrade,'qazWSX123!@#') FROM unbfcs.cs4415;
 
SELECT * FROM `unbfcs`.`cs4415enc`;

INSERT INTO unbfcs.cs4415enc (StuID, StuFName, StuLName, StuGrade) 
VALUES (3720505,'Soheil','Shirvani',20);

SELECT * FROM `unbfcs`.`cs4415enc`;

UPDATE unbfcs.cs4415enc SET StuGrade=aes_decrypt(18.82,'qazWSX123!@#') WHERE StuID=aes_decrypt(3720505,'qazWSX123!@#');

SELECT * FROM `unbfcs`.`cs4415enc`;

SELECT CAST(aes_decrypt(StuID,'qazWSX123!@#') as CHAR(200)),
CAST(aes_decrypt(StuFName,'qazWSX123!@#') as CHAR(200)),
CAST(aes_decrypt(StuLName,'qazWSX123!@#') as CHAR(200)),
CAST(aes_decrypt(StuGrade,'qazWSX123!@#') as CHAR(200))
FROM unbfcs.cs4415enc;
 
 
 
