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

CREATE TABLE CUSTOMERS (CUSTNO CHAR(9) NON NULL PRIMARY KEY,
                        CFNAME CHAR(15) DEFAULT,
                        CLNAME CHAR(20) DEFAULT,
                        CADDR CHAR(30) DEFAULT,
                        CZIP CHAR(5) DEFAULT,
                        CPHONE CHAR(10) NOT NULL,
                        CEMAIL CHAR(50) NOT NULL,
                        CDOB DECIMAL( 8, 0) NOT NULL,
                        CGENDER CHAR(1) NOT NULL )
      RCDFMT CUSTSREC;     
      
                                