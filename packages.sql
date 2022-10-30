DECLARE
EMP_FILE UTL_FILE.FILE_TYPE;
BEGIN
    EMP_FILE := UTL_FILE.FOPEN('mydir', 'sampl1e.txt','W');
    FOR I IN (SELECT * FROM testtable) LOOP
        UTL_FILE.PUT_LINE(EMP_FILE, I.P_Nom || ';' || I.Nom);
    END LOOP;
    UTL_FILE.FCLOSE(EMP_FILE);
END;

CREATE DIRECTORY mydir AS 'C:\Users\PC\Documents\www\oracleDataBaseSample\oracleRepo1';