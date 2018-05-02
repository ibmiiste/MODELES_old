000100180502      //****************************************************************
000200180502      // PROGRAM NAME:   CUSMNT                                        *
000300180502      // RELATED FILES:  CUSMSTL1 (LF)                                 *
000400180502      //                 MNTMENU  (DSPF)                               *
000500180502      // DESCRIPTION:    This program shows a customer master          *
000600180502      //                 maintenance program using a workstn file.     *
000700180502      //                 This program allows the user to add, update,  *
000800180502      //                 delete and display customer records.          *
000900180502      //                 PF3 is used to quit the program.              *
001000180502      //****************************************************************
001100180502
001200180502       dcl-f CUSMSTL1 keyed usage(*update: *output);
001300180502       dcl-f MNTMENU workstn indds(indicators);
001400180502
001500180502      // Field definitions:
001600180502
001700180502       dcl-ds indicators;
001800180502        exitKey ind pos(3);
001900180502        disableInput ind pos(4);
002000180502        addKey ind pos(5);
002100180502        updateKey ind pos(6);
002200180502        deleteKey ind pos(7);
002300180502        displayKey ind pos(8);
002400180502        prevKey ind pos(12);
002500180502        custExists ind pos(51);
002600180502        custNotFound ind pos(52);
002700180502       end-ds;
002800180502
002900180502      // Key list definitions:
003000180502
003100180502
003200180502      //*****************************************************************
003300180502      //       MAINLINE                                                 *
003400180502      //*****************************************************************
003500180502
003600180502
003700180502       mode = 'DISPLAY';
003800180502       exfmt hdrscn;
003900180502
004000180502       // Loop until exit key is pressed
004100180502       dow not exitKey;
004200180502          exsr SetMaintenanceMode;
004300180502
004400180502          if cust <> 0;
004500180502             if mode = 'ADD';
004600180502                exsr AddSub;
004700180502             elseif mode = 'UPDATE';
004800180502                exsr UpdateSub;
004900180502             elseif mode = 'DELETE';
005000180502                exsr DeleteSub;
005100180502             elseif mode = 'DISPLAY';
005200180502                exsr InquirySub;
005300180502             endif;
005400180502          endif;
005500180502
005600180502          exfmt hdrscn;
005700180502          custExists   = *off;   // turn off error messages
005800180502          CustNotFound = *off;
005900180502       enddo;
006000180502
006100180502       *inlr = *on;
006200180502       //****************************************************************
006300180502       //    SUBROUTINE - AddSub                                        *
006400180502       //    PURPOSE    - Add new customer to file                      *
006500180502       //****************************************************************
006600180502       begsr AddSub;
006700180502
006800180502          // Is customer number already in file?
006900180502          chain CUST cmlrec1;
007000180502          if %found(cusmstl1);
007100180502             // Customer number is already being used
007200180502             custExists = *on;
007300180502             leavesr;
007400180502          endif;
007500180502
007600180502          // Initialize new customer data
007700180502          custExists   = *off;   // turn off error messages
007800180502          CustNotFound = *off;
007900180502          name = *blank;
008000180502          addr1 = *blank;
008100180502          addr2 = *blank;
008200180502          city = *blank;
008300180502          state = *blank;
008400180502          zip = 0;
008500180502
008600180502          // Prompt for updated data for this customer record
008700180502          exfmt cstbld;
008800180502
008900180502          // If OK, add customer to the customer file
009000180502          if not *in12;
009100180502             write cmlrec1;
009200180502          endif;
009300180502       endsr;  // end of subroutine AddSub
009400180502
009500180502
009600180502
009700180502       //****************************************************************
009800180502       //    SUBROUTINE - UpdateSub                                     *
009900180502       //    PURPOSE    - Update customer master record                 *
010000180502       //****************************************************************
010100180502       begsr UpdateSub;
010200180502
010300180502          // Lookup customer number
010400180502          chain CUST cmlrec1;
010500180502          if not %found(cusmstl1);
010600180502             // Customer is not found in file
010700180502             custNotFound = *on;
010800180502             leavesr;
010900180502          endif;
011000180502
011100180502          // Display information for this customer
011200180502          disableInput = *off;
011300180502          exfmt cstinq;
011400180502          if not prevKey;
011500180502             // Update information in file
011600180502             update cmlrec1;
011700180502          else;
011800180502             // If we don't want to update, at least unlock
011900180502             // the record.
012000180502             unlock cusmstl1;
012100180502          endif;
012200180502       endsr;  // end of subroutine UpdateSub;
012300180502       //****************************************************************
012400180502       //    SUBROUTINE - DeleteSub                                     *
012500180502       //    PURPOSE    - Delete customer master record                 *
012600180502       //****************************************************************
012700180502       begsr DeleteSub;
012800180502
012900180502          // Lookup customer number
013000180502          chain CUST cmlrec1;
013100180502          if not %found(cusmstl1);
013200180502             // Customer is not found in file
013300180502             custNotFound = *on;
013400180502             leavesr;
013500180502          endif;
013600180502
013700180502          // Display information for this customer
013800180502          disableInput = *on;
013900180502          exfmt cstinq;
014000180502          if not prevKey;
014100180502             // Delete customer record
014200180502             delete cmlrec1;
014300180502          else;
014400180502             // If we don't want to delete, at least unlock
014500180502             // the record.
014600180502             unlock cusmstl1;
014700180502          endif;
014800180502       endsr;  // end of subroutine DeleteSub
014900180502
015000180502
015100180502
015200180502       //****************************************************************
015300180502       //    SUBROUTINE - InquirySub                                    *
015400180502       //    PURPOSE    - Display customer master record                *
015500180502       //****************************************************************
015600180502       begsr InquirySub;
015700180502
015800180502          // Lookup customer number
015900180502          chain(n) CUST cmlrec1;  // don't lock record
016000180502          if not %found(cusmstl1);
016100180502             // Customer is not found in file
016200180502             custNotFound = *on;
016300180502             leavesr;
016400180502          endif;
016500180502
016600180502          // Display information for this customer
016700180502          disableInput = *on;
016800180502          exfmt cstinq;
016900180502       endsr;  // end of subroutine InquirySub;
017000180502       //****************************************************************
017100180502       //    SUBROUTINE - SetMaintenanceMode                            *
017200180502       //    PURPOSE    - Set maintenance mode                          *
017300180502       //****************************************************************
017400180502       begsr SetMaintenanceMode;
017500180502          if addKey;
017600180502             mode = 'ADD';
017700180502          elseif updateKey;
017800180502             mode = 'UPDATE';
017900180502          elseif deleteKey;
018000180502             mode = 'DELETE';
018100180502          elseif displayKey;
018200180502             mode = 'DISPLAY';
018300180502          endif;
018400180502       endsr;  // end of subroutine SetMaintenanceMode
