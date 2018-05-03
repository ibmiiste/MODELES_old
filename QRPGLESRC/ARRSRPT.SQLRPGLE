      //=================================================================
      // Source for module ARRSRPT.  Contains a cycle-main procedure and
      // two subprocedures: InArrears and FmtCust.
      //
      // Related Module:  CVTPROCS  (CharToNum called by InArrears)
      //=================================================================
      //--------------------------------------------------------------
      // F I L E S
      //
      // CUSTFILE - contains customer information
      // CUSTRPT  - printer file (using format ARREARS)
      //--------------------------------------------------------------
     FCUSTFILE  IP   E             DISK
     FCUSTRPT   O    E             PRINTER
      *--------------------------------------------------------------*
      * P R O T O T Y P E S
      *--------------------------------------------------------------*
      /COPY QRPGLESRC,FMTPROC_P
      *--------------------------------------------------------------*
      * InArrears returns '1' if the customer is in arrears
      *--------------------------------------------------------------*
     D InArrears       PR             1A
      *--------------------------------------------------------------*
      * FmtCust formats CUSTNAME, CUSTNUM, STREETNAME etc into
      * readable forms
      *--------------------------------------------------------------*
     D FmtCust         PR
     D  Name                        100A
     D  Address                     100A
      *--------------------------------------------------------------*
      * G L O B A L   D E F I N I T I O N S
      *--------------------------------------------------------------*
     D CurDate         S               D
     ICUSTREC       01
      *--------------------------------------------------------------*
      * M A I N   P R O C E D U R E
      *--------------------------------------------------------------*
     C                   IF        InArrears() = '1'
     C                   CALLP     FmtCust(RPTNAME : RPTADDR)
     C                   EVAL      RPTNUM = CUSTNUM
     C                   WRITE     ARREARS
     C                   ENDIF
     C     *INZSR        BEGSR
     C                   MOVEL     UDATE         CurDate
     C                   ENDSR
      *--------------------------------------------------------------*
      * S U B P R O C E D U R E S
      *--------------------------------------------------------------*
       //--------------------------------------------------------------
       // InArrears
       //
       // Parameters: (none)
       // Globals:    DUEDATE, AMOUNT, CurDate
       //
       // Returns:   '1' if the customer is in arrears
       //--------------------------------------------------------------
     P InArrears       B
     D InArrears       PI             1A
       // Local declarations
     D DaysLate        S             10I 0
     D DateDue         S               D
       // Body of procedure
      /free
          DateDue = %date (DUEDATE: *ISO);
          DaysLate = %diff (CurDate: DateDue: *d);
           // The data in the input file comes from another type
            // of computer, and the AMOUNTC field is a character
            // string containing the numeric value.  This string
            // must be converted to the numeric AMOUNT field
            // for printing.
           AMOUNT = %dec(AMOUNTC : 31 : 9);
          if DaysLate > 60 AND AMOUNT > 100.00;
             return '1';
          endif;
          return '0';
      /end-free
     P InArrears       E
      //--------------------------------------------------------------
      // FmtCust formats CUSTNAME, CUSTNUM, STREETNAME etc into
      // readable forms
      //
      // Parameters:   Name     (output)
      //               Address  (output)
      // Globals:      CUSTNAME, CUSTNUM, STREETNUM, STREETNAME, CITY
      //               STATE, ZIP
      //--------------------------------------------------------------


     P FmtCust         B
     D FmtCust         PI
     D  Name                        100A
     D  Address                     100A


      //--------------------------------------------------------------
      // CUSTNAME and CUSTNUM are formatted to look like this:
      // A&P Electronics     (Customer number 157)
      //--------------------------------------------------------------
       Name = CUSTNAME + ' ' + '(Customer number '
                             + %char(CUSTNUM) + ')';
      //--------------------------------------------------------------
      //   Call the FmtAddr procedure to handle the address
      //--------------------------------------------------------------

       Address = FmtAddress (STREETNUM : STREETNAME :
                                   CITY : STATE : ZIP);

     P FmtCust         E
