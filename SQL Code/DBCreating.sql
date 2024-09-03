CREATE TYPE bnk_Name AS OBJECT(
	title VARCHAR2(20),
	firstName VARCHAR2(35),
	surName VARCHAR2(35),
    niNum VARCHAR2(15),
    MEMBER FUNCTION fullName RETURN STRING
)NOT FINAL;
/
CREATE TYPE bnk_Address AS OBJECT(
	street VARCHAR2(50),
	city VARCHAR2(60),
	p_Code VARCHAR2(10),
    MEMBER FUNCTION fullAddress RETURN STRING
)NOT FINAL;
/
CREATE OR REPLACE TYPE BODY bnk_Address AS
MEMBER FUNCTION fullAddress RETURN STRING IS
BEGIN
return self.street || ' ' || self.city || ' ' || self.p_Code;
END fullAddress;
END;
/
CREATE OR REPLACE TYPE BODY bnk_Name AS 
MEMBER FUNCTION fullName RETURN STRING IS
BEGIN
return self.title || ' ' || self.firstname || ' ' || self.surname;
END fullName;
END;
/
CREATE TYPE bnk_Pii AS OBJECT(
	obj_name bnk_name,
	obj_address bnk_address
)NOT FINAL;
/
CREATE TABLE bnk_PersonalTable OF bnk_Pii;
/
CREATE TYPE bnk_CPhoneNumbers AS OBJECT(
	custHomePhone VARCHAR2(45),
    custMobile1 VARCHAR2(45),
    custMobile2 VARCHAR2(45)
);
/
CREATE TYPE bnk_ePhoneNumbers AS OBJECT(
	EmpHomePhone VARCHAR2(45),
	EmpMobile1 VARCHAR2(45),
	EmpMobile2 VARCHAR2(45)
)NOT FINAL;
/
CREATE TYPE bnk_cPhone_nested AS TABLE OF bnk_CPhoneNumbers;
/
CREATE TYPE bnk_Customer UNDER bnk_Pii(
    custID INT,
    cPhone_numbers bnk_cPhone_nested
    );
/ 
CREATE TABLE bnk_CustomerTable OF bnk_Customer(
    custID NOT NULL PRIMARY KEY
    )   
    NESTED TABLE cPhone_numbers STORE AS bnk_cPhone_numbers_nested
;
/
CREATE TYPE bnk_Branch AS OBJECT(
    bID INT,
    obj_bAddress bnk_address,
    bPhoneNum VARCHAR2(45)
);
/
CREATE TABLE bnk_BranchTable OF bnk_Branch(
    bID NOT NULL PRIMARY KEY
);
/
CREATE TYPE bnk_PiiEmployee UNDER bnk_Pii(
    obj_ePhoneNumbers bnk_ePhoneNumbers 
)NOT FINAL;
/
CREATE TYPE bnk_job AS OBJECT(
    position VARCHAR2(15),
    salary NUMBER(20, 2)
)NOT FINAL;
/
CREATE TYPE bnk_Employee UNDER bnk_PiiEmployee(
    empID INT,
    supervisorID_ref REF bnk_Employee,
    joinDate DATE,
    obj_job bnk_job,
    bID_ref REF bnk_Branch,
    MEMBER FUNCTION eAwards RETURN STRING);
/
CREATE TABLE bnk_employeeTable OF bnk_Employee(
    empID NOT NULL PRIMARY KEY,
    CONSTRAINT pConst
    CHECK(obj_job.position IN ('Head', 'Manager', 'Project Leader', 'Accountant', 'Cashier'))
);
/

CREATE TYPE bnk_accFinances AS OBJECT(
    balance NUMBER(20,2),
    inRate NUMBER,
    limitOfFreeOD NUMBER(20, 2)
)NOT FINAL;
/
CREATE TYPE bnk_account AS Object(
    accNum INT,
    accType VARCHAR2(20),
    obj_accFinances bnk_accFinances,
    openDate DATE,
    bID_ref REF bnk_Branch
)NOT FINAL;
/
CREATE TABLE bnk_accountTable OF bnk_account(
    accNum NOT NULL PRIMARY KEY,
    CONSTRAINT accType_constant
    CHECK(accType IN ('Current', 'Savings'))
);
/
CREATE TYPE cAccount_ref AS OBJECT(
    cID_ref  REF bnk_Customer,
    accNum_ref REF bnk_Account
)NOT FINAL;
/
CREATE TABLE cAccount_refTable OF cAccount_ref
;
/