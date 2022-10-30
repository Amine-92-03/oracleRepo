SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
L_FILE UTL_FILE.FILE_TYPE;
L_LOCATION VARCHAR2(100) := 'ORACLE_BASE';
L_FILENAME VARCHAR2(100) := 'test.txt';
L_TEXT VARCHAR2(32672);
BEGIN
    L_FILE := UTL_FILE.FOPEN(L_LOCATION, L_FILENAME, 'r'); 
    LOOP
        UTL_FILE.GET_LINE(L_FILE, L_TEXT);
        --DBMS_OUTPUT.PUT_LINE(' first Line' || L_TEXT);  
        INSERT INTO TESTTABLE(p_nom,nom) VALUES(L_TEXT,L_TEXT);
    END LOOP;
    UTL_FILE.FCLOSE(L_FILE);
EXCEPTION
    WHEN UTL_FILE.READ_ERROR THEN
        DBMS_OUTPUT.PUT_LINE(' Cannot read file'); 
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(' END FILE ');  
        UTL_FILE.FCLOSE(L_FILE);
END;

SET SERVEROUTPUT ON;
DECLARE
L_FILE UTL_FILE.FILE_TYPE;
L_LOCATION VARCHAR2(100) := 'ORACLE_BASE';
L_FILENAME VARCHAR2(100) := 'test.txt';
L_TEXT VARCHAR2(100);
L_TIME VARCHAR2(100);
BEGIN
    L_FILE := UTL_FILE.FOPEN(L_LOCATION, L_FILENAME, 'w'); 
    FOR I IN (select grantor,grantee, table_schema, table_name, privilege from   all_tab_privs ) LOOP
         SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS' ) INTO L_TIME FROM dual;
         UTL_FILE.PUT_LINE(L_FILE, I.grantor ||';'||I.grantee||';'||L_TIME);
    END LOOP;
END;





SELECT 
    TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') 
FROM 
    dual;


SELECT
SUBSTR(  P_nom,0,
                INSTR(P_Nom, ';',1,1)-1) testCol_0 ,
SUBSTR(  P_nom, INSTR(P_Nom, ';',1,1)+1,
                INSTR(P_Nom, ';',1,2) - INSTR(P_Nom, ';',1,1)-1)testCol_1,
SUBSTR(  P_nom, INSTR(P_Nom, ';',1,2)+1,
                INSTR(P_Nom, ';',1,3) - INSTR(P_Nom, ';',1,2)-1)testCol_2,
SUBSTR(  P_nom, INSTR(P_Nom, ';',1,3)+1)testCol_3
 -- LENGTH(P_nom) - INSTR(P_Nom, ';',1,3)
                FROM testtable;






SELECT * FROM dba_directories

CREATE DIRECTORY TESTDIR as 'C:\Users\PC\Documents\www\plSQL';
grant read,write on directory TESTDIR to public


select grantor, 
       grantee, 
       table_schema, 
       table_name, 
       privilege
from   all_tab_privs 