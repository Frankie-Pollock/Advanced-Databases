--(a)
SELECT a.obj_name.fullName() Name
    FROM bnk_employeeTable a
    WHERE (UPPER(a.obj_name.surName) LIKE '%ON%') 
    AND (UPPER(a.obj_address.city) = 'GLASGOW')
;

--(b)
SELECT COUNT(c.accNum)  Savings_Accounts_Count, b.obj_bAddress.fullAddress()Address
    FROM bnk_branchTable b
    LEFT JOIN bnk_AccountTable c
    ON b.bID = c.bID_ref.bID
    AND UPPER(c.accType) = 'SAVINGS'
    GROUP BY b.obj_bAddress.fullAddress()
;

--(c)
SELECT d2.bID_ref.bID, e.cID_ref.obj_name.fullName() Name , d2.obj_accFinances.balance MAX_Account_balance
    FROM ( SELECT d.bID_ref.bID, MAX(d.obj_accFinances.balance) mBalance
        FROM bnk_accountTable d
        WHERE UPPER(d.accType) = 'SAVINGS'
        GROUP BY d.bID_ref.bID) d1, bnk_AccountTable d2, cAccount_refTable e
        WHERE d1.mBalance = d2.obj_accFinances.balance
        AND d2.accNum = e.accNum_ref.accNum 
        ORDER BY d2.bID_ref.bID
;

--(d)
SELECT f.bID_ref.obj_bAddress.fullAddress() Workplace,
    h.accNum_ref.bID_ref.obj_bAddress.fullAddress() Customer_Account_Address
    FROM bnk_employeeTable f, bnk_customerTable g, cAccount_refTable h
    WHERE UPPER(f.supervisorID_ref.obj_job.position) = 'MANAGER'
    AND f.obj_name.NiNum = g.obj_name.NiNum
    AND g.custID = h.cID_ref.CustID  
;

--(e)
WITH freeCurrentTable AS(SELECT i.AccNum_ref.bID_ref.bID bID, i.cID_ref.obj_name.fullName() Name, i.AccNum_ref.obj_accFinances.limitOfFreeOD highest_overdraft
    FROM cAccount_refTable i
    WHERE UPPER(i.accNum_ref.accType) = 'CURRENT' AND EXISTS
    (SELECT 1 FROM cAccount_refTable i2
    WHERE i.accNum_ref = i2.accNum_ref
    AND i.cID_ref != i2.cID_ref))
    SELECT freeCurrentTable.* FROM freeCurrentTable,
    (SELECT bID, MAX(highest_overdraft) mOD FROM  freeCurrentTable 
    GROUP BY bID ) mODT
    WHERE freeCurrentTable.bID = mODT.bID
    AND freeCurrentTable.highest_overdraft = mODT.mOD
;

--(f)
SELECT  j.obj_name.fullName() Name , j.CustMobile1, j.CustMobile2
    FROM  bnk_CustomerTable j, table(j.cPhone_numbers) j 
    WHERE j.custMobile2 IS NOT NULL AND j.custMobile1 IS NOT NULL
    AND (j.custMobile2 LIKE '0760%' OR j.custMobile1 LIKE '0760%')
;

--(g)
SELECT COUNT(K.empID)Supervised_By_Mr_John_Supervised_By_Mrs_King
FROM bnk_employeeTable K
WHERE UPPER(K.supervisorID_ref.obj_name.title) = 'MR'
AND UPPER(K.supervisorID_ref.obj_name.surName) = 'JOHN'
AND UPPER(K.supervisorID_ref.supervisorID_ref.obj_name.title) = 'MRS'
AND UPPER(K.supervisorID_ref.supervisorID_ref.obj_name.surName) = 'KING'
;

--(h)
CREATE OR REPLACE TYPE BODY bnk_Employee AS
MEMBER FUNCTION eAwards RETURN STRING IS
SupeCount INTEGER;
EoY_Diff INTEGER;

EoY_DiffS DATE := TO_DATE('12 12 2023', 'DD MM YYYY');
BEGIN
SELECT COUNT(l.empId) 
INTO SupeCount 
FROM bnk_employeeTable l 
WHERE DEREF(l.supervisorID_ref) = self;
EoY_Diff := EoY_DiffS - self.joinDate;

IF EoY_Diff >= 12
AND SupeCount > 8
THEN
RETURN 'Gold Medal';
ELSIF EoY_Diff >= 10
AND SupeCount > 5
THEN
RETURN 'Silver Medal';
ELSIF EoY_Diff >= 4
THEN
RETURN 'Bronze Medal';
ELSE 
RETURN NULL;
END IF;
END eAwards;
END;
/

SELECT k.obj_name.fullName()Name, k.eAwards() Awards
FROM bnk_employeeTable k
WHERE  k.eAwards() IS NOT NULL
;