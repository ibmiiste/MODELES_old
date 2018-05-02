      *------------------------------------------------------------------------*
      * DESCRIPTION:  This program creates a printed output of employee's pay  *
      *               for the week.                                            *
      *------------------------------------------------------------------------*
     H DATEDIT(*DMY/)
      *------------------------------------------------------------------------*
      * File Definitions                                                       *
      *------------------------------------------------------------------------*
     FTRANSACT  IP   E           K DISK
     FEMPLOYEE  IF   E           K DISK
     FQSYSPRT   O    F   80        PRINTER
      *------------------------------------------------------------------------*
      * Variable Declarations                                                  *
      *------------------------------------------------------------------------*
     D Pay             S              8P 2
      *------------------------------------------------------------------------*
      * Constant Declarations                                                  *
      *------------------------------------------------------------------------*
     D Heading1        C                   'NUMBER  NAME              RATE    H-
     D                                     OURS  BONUS    PAY       '
     D Heading2        C                   '______  ________________  ______  _-
     D                                     ____  _______  __________'
      *------------------------------------------------------------------------*
      * Prototype Definition for subprocedure CalcPay                          *
      *------------------------------------------------------------------------*
     D CalcPay         PR             8P 2
     D   Rate                         5P 2 VALUE
     D   Hours                       10U 0 VALUE
     D   Bonus                        5P 2 VALUE
      *------------------------------------------------------------------------*
      * For each record in the transaction file (TRANSACT), if the employee    *
      * is found, compute the employee's pay and print the details.            *
      *------------------------------------------------------------------------*
      /free
         chain trn_number emp_rec;
         if %found(emp_rec);
            pay = CalcPay (emp_rate: trn_hours: trn_bonus);
         endif;
      /end-free
      *------------------------------------------------------------------------*
      * Report Layout                                                          *
      *  -- print the heading lines if 1P is on                                *
      *  -- if the record is found (indicator 99 is off) print the payroll     *
      *     details otherwise print an exception record                        *
      *  -- print 'END OF LISTING' when LR is on                               *
      *------------------------------------------------------------------------*
     OQSYSPRT   H    1P                     2  3
     O                                           35 'PAYROLL REGISTER'
     O                       *DATE         Y     60
     O          H    1P                     2
     O                                           60 Heading1
     O          H    1P                     2
     O                                           60 Heading2
     O          D   N1PN99                  2
     O                       TRN_NUMBER           5
     O                       EMP_NAME            24
     O                       EMP_RATE      L     33
     O                       TRN_HOURS     L     40
     O                       TRN_BONUS     L     49
     O                       Pay                 60 '$     0.  '
     O          D   N1P 99                  2
     O                       TRN_NUMBER           5
     O                                           35 '** NOT ON EMPLOYEE FILE **'
     O          T    LR
     O                                           33 'END OF LISTING'
      *------------------------------------------------------------------------*
      * Subprocedure  -- calculates overtime pay.                              *
      *------------------------------------------------------------------------*
     P CalcPay         B
     D CalcPay         PI             8P 2
     D   Rate                         5P 2 VALUE
     D   Hours                       10U 0 VALUE
     D   Bonus                        5P 2 VALUE
     D Overtime        S              5P 2 INZ(0)

      /free
         // Determine any overtime hours to be paid.
         if Hours > 40;
           Overtime = (Hours - 40) * Rate * 1.5;
           Hours = 40;
         endif;
         // Calculate the total pay and return it to the caller.
         return(H)  Rate * Hours + Bonus + Overtime;
      /end-free
     P CalcPay         E
