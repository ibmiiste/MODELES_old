      //--------------------------------------------------------------
      // FmtCust formats CUSTNAME, CUSTNUM, STREETNAME etc into
      // readable forms
      //
      // Parameters:   Name     (output)
      //               Address  (output)
      // Globals:      CUSTNAME, CUSTNUM, STREETNUM, STREETNAME, CITY
      //               STATE, ZIP
      //--------------------------------------------------------------


       dcl-proc FmtCust;
       dcl-pi FmtCust;
        Name char(100);
        Address char(100);
       end-pi;


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

       end-proc;
