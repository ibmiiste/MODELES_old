      //--------------------------------------------------------------
      // InArrears
      //
      // Parameters: (none)
      // Globals: DUEDATE, AMOUNT, CurDate
      //
      // Returns: ’1’ if the customer is in arrears
      //--------------------------------------------------------------
       Dcl-proc InArrears;
       Dcl-pi InArrears Char(1);
       End-pi;
       // Local declarations
       Dcl-s DaysLate Zoned(10:0);
       Dcl-s DateDue Date;
       // Body of procedure

         DateDue = %date (DUEDATE: *ISO);
         DaysLate = %diff (CurDate: DateDue: *d);
         // The data in the input file comes from another type
         // of computer, and the AMOUNTC field is a character
         // string containing the numeric value. This string
         // must be converted to the numeric AMOUNT field
         // for printing.
         AMOUNT = %dec(AMOUNTC : 31 : 9);
         if DaysLate > 60 AND AMOUNT > 100.00;
           return '1';
         endif;

         return '0';

       End-proc InArrears;
