000100180502      //--------------------------------------------------------------
000200180502      // FmtCust formats CUSTNAME, CUSTNUM, STREETNAME etc into
000300180502      // readable forms
000400180502      //
000500180502      // Parameters:   Name     (output)
000600180502      //               Address  (output)
000700180502      // Globals:      CUSTNAME, CUSTNUM, STREETNUM, STREETNAME, CITY
000800180502      //               STATE, ZIP
000900180502      //--------------------------------------------------------------
001000180502
001100180502
001200180502       dcl-proc FmtCust;
001300180502       dcl-pi FmtCust;
001400180502        Name char(100);
001500180502        Address char(100);
001600180502       end-pi;
001700180502
001800180502
001900180502      //--------------------------------------------------------------
002000180502      // CUSTNAME and CUSTNUM are formatted to look like this:
002100180502      // A&P Electronics     (Customer number 157)
002200180502      //--------------------------------------------------------------
002300180502       Name = CUSTNAME + ' ' + '(Customer number '
002400180502                             + %char(CUSTNUM) + ')';
002500180502      //--------------------------------------------------------------
002600180502      //   Call the FmtAddr procedure to handle the address
002700180502      //--------------------------------------------------------------
002800180502
002900180502       Address = FmtAddress (STREETNUM : STREETNAME :
003000180502                                   CITY : STATE : ZIP);
003100180502
003200180502       end-proc;
