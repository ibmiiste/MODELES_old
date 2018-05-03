      //****************************************************************
      // PROGRAM NAME:   CUSMNT                                        *
      // RELATED FILES:  CUSMSTL1 (LF)                                 *
      //                 MNTMENU  (DSPF)                               *
      // DESCRIPTION:    This program shows a customer master          *
      //                 maintenance program using a workstn file.     *
      //                 This program allows the user to add, update,  *
      //                 delete and display customer records.          *
      //                 PF3 is used to quit the program.              *
      //****************************************************************

       dcl-f CUSMSTL1 keyed usage(*update: *output);
       dcl-f MNTMENU workstn indds(indicators);

      // Field definitions:

       dcl-ds indicators;
        exitKey ind pos(3);
        disableInput ind pos(4);
        addKey ind pos(5);
        updateKey ind pos(6);
        deleteKey ind pos(7);
        displayKey ind pos(8);
        prevKey ind pos(12);
        custExists ind pos(51);
        custNotFound ind pos(52);
       end-ds;

      // Key list definitions:


      //*****************************************************************
      //       MAINLINE                                                 *
      //*****************************************************************


       mode = 'DISPLAY';
       exfmt hdrscn;

       // Loop until exit key is pressed
       dow not exitKey;
          exsr SetMaintenanceMode;

          if cust <> 0;
             if mode = 'ADD';
                exsr AddSub;
             elseif mode = 'UPDATE';
                exsr UpdateSub;
             elseif mode = 'DELETE';
                exsr DeleteSub;
             elseif mode = 'DISPLAY';
                exsr InquirySub;
             endif;
          endif;

          exfmt hdrscn;
          custExists   = *off;   // turn off error messages
          CustNotFound = *off;
       enddo;

       *inlr = *on;
       //****************************************************************
       //    SUBROUTINE - AddSub                                        *
       //    PURPOSE    - Add new customer to file                      *
       //****************************************************************
       begsr AddSub;

          // Is customer number already in file?
          chain CUST cmlrec1;
          if %found(cusmstl1);
             // Customer number is already being used
             custExists = *on;
             leavesr;
          endif;

          // Initialize new customer data
          custExists   = *off;   // turn off error messages
          CustNotFound = *off;
          name = *blank;
          addr1 = *blank;
          addr2 = *blank;
          city = *blank;
          state = *blank;
          zip = 0;

          // Prompt for updated data for this customer record
          exfmt cstbld;

          // If OK, add customer to the customer file
          if not *in12;
             write cmlrec1;
          endif;
       endsr;  // end of subroutine AddSub



       //****************************************************************
       //    SUBROUTINE - UpdateSub                                     *
       //    PURPOSE    - Update customer master record                 *
       //****************************************************************
       begsr UpdateSub;

          // Lookup customer number
          chain CUST cmlrec1;
          if not %found(cusmstl1);
             // Customer is not found in file
             custNotFound = *on;
             leavesr;
          endif;

          // Display information for this customer
          disableInput = *off;
          exfmt cstinq;
          if not prevKey;
             // Update information in file
             update cmlrec1;
          else;
             // If we don't want to update, at least unlock
             // the record.
             unlock cusmstl1;
          endif;
       endsr;  // end of subroutine UpdateSub;
       //****************************************************************
       //    SUBROUTINE - DeleteSub                                     *
       //    PURPOSE    - Delete customer master record                 *
       //****************************************************************
       begsr DeleteSub;

          // Lookup customer number
          chain CUST cmlrec1;
          if not %found(cusmstl1);
             // Customer is not found in file
             custNotFound = *on;
             leavesr;
          endif;

          // Display information for this customer
          disableInput = *on;
          exfmt cstinq;
          if not prevKey;
             // Delete customer record
             delete cmlrec1;
          else;
             // If we don't want to delete, at least unlock
             // the record.
             unlock cusmstl1;
          endif;
       endsr;  // end of subroutine DeleteSub



       //****************************************************************
       //    SUBROUTINE - InquirySub                                    *
       //    PURPOSE    - Display customer master record                *
       //****************************************************************
       begsr InquirySub;

          // Lookup customer number
          chain(n) CUST cmlrec1;  // don't lock record
          if not %found(cusmstl1);
             // Customer is not found in file
             custNotFound = *on;
             leavesr;
          endif;

          // Display information for this customer
          disableInput = *on;
          exfmt cstinq;
       endsr;  // end of subroutine InquirySub;
       //****************************************************************
       //    SUBROUTINE - SetMaintenanceMode                            *
       //    PURPOSE    - Set maintenance mode                          *
       //****************************************************************
       begsr SetMaintenanceMode;
          if addKey;
             mode = 'ADD';
          elseif updateKey;
             mode = 'UPDATE';
          elseif deleteKey;
             mode = 'DELETE';
          elseif displayKey;
             mode = 'DISPLAY';
          endif;
       endsr;  // end of subroutine SetMaintenanceMode
