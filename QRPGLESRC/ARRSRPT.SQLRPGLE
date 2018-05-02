000100180502      //=================================================================
000200180502      // Source for module ARRSRPT.  Contains a cycle-main procedure and
000300180502      // two subprocedures: InArrears and FmtCust.
000400180502      //
000500180502      // Related Module:  CVTPROCS  (CharToNum called by InArrears)
000600180502      //=================================================================
000700180502      //--------------------------------------------------------------
000800180502      // F I L E S
000900180502      //
001000180502      // CUSTFILE - contains customer information
001100180502      // CUSTRPT  - printer file (using format ARREARS)
001200180502      //--------------------------------------------------------------
001300180502     FCUSTFILE  IP   E             DISK
001400180502     FCUSTRPT   O    E             PRINTER
001500180502      *--------------------------------------------------------------*
001600180502      * P R O T O T Y P E S
001700180502      *--------------------------------------------------------------*
001800180502      /COPY QRPGLESRC,FMTPROC_P
001900180502      *--------------------------------------------------------------*
002000180502      * InArrears returns '1' if the customer is in arrears
002100180502      *--------------------------------------------------------------*
002200180502     D InArrears       PR             1A
002300180502      *--------------------------------------------------------------*
002400180502      * FmtCust formats CUSTNAME, CUSTNUM, STREETNAME etc into
002500180502      * readable forms
002600180502      *--------------------------------------------------------------*
002700180502     D FmtCust         PR
002800180502     D  Name                        100A
002900180502     D  Address                     100A
003000180502      *--------------------------------------------------------------*
003100180502      * G L O B A L   D E F I N I T I O N S
003200180502      *--------------------------------------------------------------*
003300180502     D CurDate         S               D
003400180502     ICUSTREC       01
003500180502      *--------------------------------------------------------------*
003600180502      * M A I N   P R O C E D U R E
003700180502      *--------------------------------------------------------------*
003800180502     C                   IF        InArrears() = '1'
003900180502     C                   CALLP     FmtCust(RPTNAME : RPTADDR)
004000180502     C                   EVAL      RPTNUM = CUSTNUM
004100180502     C                   WRITE     ARREARS
004200180502     C                   ENDIF
004300180502     C     *INZSR        BEGSR
004400180502     C                   MOVEL     UDATE         CurDate
004500180502     C                   ENDSR
004600180502      *--------------------------------------------------------------*
004700180502      * S U B P R O C E D U R E S
004800180502      *--------------------------------------------------------------*
004900180502       //--------------------------------------------------------------
005000180502       // InArrears
005100180502       //
005200180502       // Parameters: (none)
005300180502       // Globals:    DUEDATE, AMOUNT, CurDate
005400180502       //
005500180502       // Returns:   '1' if the customer is in arrears
005600180502       //--------------------------------------------------------------
005700180502     P InArrears       B
005800180502     D InArrears       PI             1A
005900180502       // Local declarations
006000180502     D DaysLate        S             10I 0
006100180502     D DateDue         S               D
006200180502       // Body of procedure
006300180502      /free
006400180502          DateDue = %date (DUEDATE: *ISO);
006500180502          DaysLate = %diff (CurDate: DateDue: *d);
006600180502           // The data in the input file comes from another type
006700180502            // of computer, and the AMOUNTC field is a character
006800180502            // string containing the numeric value.  This string
006900180502            // must be converted to the numeric AMOUNT field
007000180502            // for printing.
007100180502           AMOUNT = %dec(AMOUNTC : 31 : 9);
007200180502          if DaysLate > 60 AND AMOUNT > 100.00;
007300180502             return '1';
007400180502          endif;
007500180502          return '0';
007600180502      /end-free
007700180502     P InArrears       E
007800180502      //--------------------------------------------------------------
007900180502      // FmtCust formats CUSTNAME, CUSTNUM, STREETNAME etc into
008000180502      // readable forms
008100180502      //
008200180502      // Parameters:   Name     (output)
008300180502      //               Address  (output)
008400180502      // Globals:      CUSTNAME, CUSTNUM, STREETNUM, STREETNAME, CITY
008500180502      //               STATE, ZIP
008600180502      //--------------------------------------------------------------
008700180502
008800180502
008900180502     P FmtCust         B
009000180502     D FmtCust         PI
009100180502     D  Name                        100A
009200180502     D  Address                     100A
009300180502
009400180502
009500180502      //--------------------------------------------------------------
009600180502      // CUSTNAME and CUSTNUM are formatted to look like this:
009700180502      // A&P Electronics     (Customer number 157)
009800180502      //--------------------------------------------------------------
009900180502       Name = CUSTNAME + ' ' + '(Customer number '
010000180502                             + %char(CUSTNUM) + ')';
010100180502      //--------------------------------------------------------------
010200180502      //   Call the FmtAddr procedure to handle the address
010300180502      //--------------------------------------------------------------
010400180502
010500180502       Address = FmtAddress (STREETNUM : STREETNAME :
010600180502                                   CITY : STATE : ZIP);
010700180502
010800180502     P FmtCust         E
