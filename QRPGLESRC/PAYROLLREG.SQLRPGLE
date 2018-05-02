000100180502      *------------------------------------------------------------------------*
000200180502      * DESCRIPTION:  This program creates a printed output of employee's pay  *
000300180502      *               for the week.                                            *
000400180502      *------------------------------------------------------------------------*
000500180502     H DATEDIT(*DMY/)
000600180502      *------------------------------------------------------------------------*
000700180502      * File Definitions                                                       *
000800180502      *------------------------------------------------------------------------*
000900180502     FTRANSACT  IP   E           K DISK
001000180502     FEMPLOYEE  IF   E           K DISK
001100180502     FQSYSPRT   O    F   80        PRINTER
001200180502      *------------------------------------------------------------------------*
001300180502      * Variable Declarations                                                  *
001400180502      *------------------------------------------------------------------------*
001500180502     D Pay             S              8P 2
001600180502      *------------------------------------------------------------------------*
001700180502      * Constant Declarations                                                  *
001800180502      *------------------------------------------------------------------------*
001900180502     D Heading1        C                   'NUMBER  NAME              RATE    H-
002000180502     D                                     OURS  BONUS    PAY       '
002100180502     D Heading2        C                   '______  ________________  ______  _-
002200180502     D                                     ____  _______  __________'
002300180502      *------------------------------------------------------------------------*
002400180502      * Prototype Definition for subprocedure CalcPay                          *
002500180502      *------------------------------------------------------------------------*
002600180502     D CalcPay         PR             8P 2
002700180502     D   Rate                         5P 2 VALUE
002800180502     D   Hours                       10U 0 VALUE
002900180502     D   Bonus                        5P 2 VALUE
003000180502      *------------------------------------------------------------------------*
003100180502      * For each record in the transaction file (TRANSACT), if the employee    *
003200180502      * is found, compute the employee's pay and print the details.            *
003300180502      *------------------------------------------------------------------------*
003400180502      /free
003500180502         chain trn_number emp_rec;
003600180502         if %found(emp_rec);
003700180502            pay = CalcPay (emp_rate: trn_hours: trn_bonus);
003800180502         endif;
003900180502      /end-free
004000180502      *------------------------------------------------------------------------*
004100180502      * Report Layout                                                          *
004200180502      *  -- print the heading lines if 1P is on                                *
004300180502      *  -- if the record is found (indicator 99 is off) print the payroll     *
004400180502      *     details otherwise print an exception record                        *
004500180502      *  -- print 'END OF LISTING' when LR is on                               *
004600180502      *------------------------------------------------------------------------*
004700180502     OQSYSPRT   H    1P                     2  3
004800180502     O                                           35 'PAYROLL REGISTER'
004900180502     O                       *DATE         Y     60
005000180502     O          H    1P                     2
005100180502     O                                           60 Heading1
005200180502     O          H    1P                     2
005300180502     O                                           60 Heading2
005400180502     O          D   N1PN99                  2
005500180502     O                       TRN_NUMBER           5
005600180502     O                       EMP_NAME            24
005700180502     O                       EMP_RATE      L     33
005800180502     O                       TRN_HOURS     L     40
005900180502     O                       TRN_BONUS     L     49
006000180502     O                       Pay                 60 '$     0.  '
006100180502     O          D   N1P 99                  2
006200180502     O                       TRN_NUMBER           5
006300180502     O                                           35 '** NOT ON EMPLOYEE FILE **'
006400180502     O          T    LR
006500180502     O                                           33 'END OF LISTING'
006600180502      *------------------------------------------------------------------------*
006700180502      * Subprocedure  -- calculates overtime pay.                              *
006800180502      *------------------------------------------------------------------------*
006900180502     P CalcPay         B
007000180502     D CalcPay         PI             8P 2
007100180502     D   Rate                         5P 2 VALUE
007200180502     D   Hours                       10U 0 VALUE
007300180502     D   Bonus                        5P 2 VALUE
007400180502     D Overtime        S              5P 2 INZ(0)
007500180502
007600180502      /free
007700180502         // Determine any overtime hours to be paid.
007800180502         if Hours > 40;
007900180502           Overtime = (Hours - 40) * Rate * 1.5;
008000180502           Hours = 40;
008100180502         endif;
008200180502         // Calculate the total pay and return it to the caller.
008300180502         return(H)  Rate * Hours + Bonus + Overtime;
008400180502      /end-free
008500180502     P CalcPay         E
