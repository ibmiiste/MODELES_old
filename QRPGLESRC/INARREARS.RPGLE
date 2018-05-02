000100180502      //--------------------------------------------------------------
000200180502      // InArrears
000300180502      //
000400180502      // Parameters: (none)
000500180502      // Globals: DUEDATE, AMOUNT, CurDate
000600180502      //
000700180502      // Returns: ’1’ if the customer is in arrears
000800180502      //--------------------------------------------------------------
000900180502       Dcl-proc InArrears;
001000180502       Dcl-pi InArrears Char(1);
001100180502       End-pi;
001200180502       // Local declarations
001300180502       Dcl-s DaysLate Zoned(10:0);
001400180502       Dcl-s DateDue Date;
001500180502       // Body of procedure
001600180502
001700180502         DateDue = %date (DUEDATE: *ISO);
001800180502         DaysLate = %diff (CurDate: DateDue: *d);
001900180502         // The data in the input file comes from another type
002000180502         // of computer, and the AMOUNTC field is a character
002100180502         // string containing the numeric value. This string
002200180502         // must be converted to the numeric AMOUNT field
002300180502         // for printing.
002400180502         AMOUNT = %dec(AMOUNTC : 31 : 9);
002500180502         if DaysLate > 60 AND AMOUNT > 100.00;
002600180502           return '1';
002700180502         endif;
002800180502
002900180502         return '0';
003000180502
003100180502       End-proc InArrears;
