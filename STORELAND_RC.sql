CREATE OR REPLACE DIRECTORY MYDIR_IN AS '/opt/ftp/tmp/WMS/INPUT';
CREATE OR REPLACE DIRECTORY MYDIR_OUT AS '/opt/ftp/tmp/WMS/OUTPUT'; 

--DROP DIRECTORY MYDIR
--GRANT READ  DIRECTORY MYDIR to STORELAND; 

--GRANT write on DIRECTORY MYDIR_OUT to PUBLIC;

SELECT * FROM dba_directories

-- lecture 

SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
L_FILE UTL_FILE.FILE_TYPE;
L_LOCATION VARCHAR2(100) := 'MYDIR_IN';
L_FILENAME VARCHAR2(100) := 'in.txt';
L_TEXT VARCHAR2(32672);
BEGIN
    L_FILE := UTL_FILE.FOPEN(L_LOCATION, L_FILENAME, 'r'); 
    LOOP
        UTL_FILE.GET_LINE(L_FILE, L_TEXT);
        --DBMS_OUTPUT.PUT_LINE(L_TEXT);  
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


-- Chargement 

SET SERVEROUTPUT ON;

DECLARE
L_FILE UTL_FILE.FILE_TYPE;
L_LOCATION VARCHAR2(100) := 'MYDIR_OUT';
L_FILENAME VARCHAR2(100) := 'out.txt';
L_TEXT VARCHAR2(100);
L_DAY VARCHAR2(100);
L_HOUR VARCHAR2(100);
L_INDEX NUMBER := 1;
BEGIN
    L_FILE := UTL_FILE.FOPEN(L_LOCATION, L_FILENAME, 'w'); 
    FOR I IN (select grantor,grantee, table_schema, table_name, privilege from   all_tab_privs ) LOOP
            SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY' ) INTO L_DAY FROM dual;
            SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS' ) INTO L_HOUR FROM dual;
         UTL_FILE.PUT_LINE(L_FILE,L_INDEX ||';'||I.grantor ||';'||I.grantee||';'||L_DAY||';'||L_HOUR);
         L_INDEX := L_INDEX + 1;
    END LOOP;
EXCEPTION
    WHEN UTL_FILE.READ_ERROR THEN
        DBMS_OUTPUT.PUT_LINE(' Cannot read file'); 
    WHEN UTL_FILE.WRITE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE(' Ne peux pas ecrire sur le fichier'); 
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(' END FILE ');  
        UTL_FILE.FCLOSE(L_FILE);
END;





/* ------------------ transformation 

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


---------------     PARTIE EMAIL
begin  
UTL_MAIL.send(sender    => 'mohamedelamine.mefti@devred.fr',
                recipients => 'mefti.amine92@gmail.com',               
                subject    => 'Test',               
                message    => 'Please Note this is a test' );
end;
*/


/*
SELECT
  REGEXP_SUBSTR('a;b;c',
                ';[^;]+;') "REGEXPR_SUBSTR"
  FROM DUAL;
*/