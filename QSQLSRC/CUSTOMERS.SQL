-- >>PRE-COMPILER<<                                              */
--   >>CRTCMD<<  RUNSQLSTM SRCFILE(&SL/&SF) SRCMBR(&SM);         */
--   >>IMPORTANT<<                                               */
--     >>PARM<<  COMMIT(*NONE);                                  */
--     >>PARM<<  NAMING(*SQL);                                   */
--     >>PARM<<  DFTRDBCOL(&LI);                                 */
--   >>END-IMPORTANT<<                                           */
--   >>EXECUTE<<                                                 */
-- >>END-PRE-COMPILER<<                                          */
BEGIN
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      BEGIN END;
   DROP TABLE CUSTOMERS;
END;

CREATE TABLE CUSTOMERS ( CUSTNO CHAR(9) NOT NULL PRIMARY KEY,
                         CFNAME CHAR(15) DEFAULT,
                         CLNAME CHAR(20) DEFAULT,
                         CADDR CHAR(30) DEFAULT,
                         CZIP CHAR(5) DEFAULT,
                         CPHONE CHAR(10) DEFAULT,
                         CEMAIL CHAR(50) DEFAULT,
                         CDOB DECIMAL( 8, 0) NOT NULL,
                         CGENDER CHAR(1) NOT NULL)
                  RCDFMT CUSTSREC
;

LABEL ON COLUMN CUSTOMERS.CUSTNO
         TEXT IS 'CUSTOMER NUMBER';

LABEL ON COLUMN CUSTOMERS.CFNAME
         TEXT IS 'CUSTOMER FIRST NAME';

LABEL ON COLUMN CUSTOMERS.CLNAME
         TEXT IS 'CUSTOMER LAST NAME';

LABEL ON COLUMN CUSTOMERS.CADDR
         TEXT IS 'CUSTOMER STREET ADDRESS';

LABEL ON COLUMN CUSTOMERS.CZIP
         TEXT IS 'ZIP CODE';

LABEL ON COLUMN CUSTOMERS.CPHONE
         TEXT IS 'CUSTOMER PHONE';

LABEL ON COLUMN CUSTOMERS.CEMAIL
         TEXT IS 'CUSTOMER EMAIL';

LABEL ON COLUMN CUSTOMERS.CDOB
         TEXT IS 'CUSTOMER DATE OF BIRTH';

LABEL ON COLUMN CUSTOMERS.CGENDER
         TEXT IS 'F=FEMALE M=MALE';
