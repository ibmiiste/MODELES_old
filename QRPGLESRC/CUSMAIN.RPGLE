      //****************************************************************
      // PROGRAM NAME: CUSMAIN                                         *
      // RELATED FILES: MAINMENU (DSPF)                                *
      // RELATED PGMS: CUSMNT (ILE RPG PGM)                            *
      // SCHZIP (ILE RPG PGM)                                          *
      // SCHNAM (ILE RPG PGM)                                          *
      // DESCRIPTION: This is a customer main inquiry program.         *
      // It prompts the user to choose from one of the                 *
      // following actions:                                            *
      // 1.Maintain (add, update, delete and display)                  *
      // customer records.                                             *
      // 2.Search customer record by zip code.                         *
      // 3.Search customer record by name.                             *
      //****************************************************************
       dcl-f MAINMENU workstn indds(indicators);
      // Prototype definitions:
       dcl-pr CustMaintain extproc('CUSMNT') end-pr;
       dcl-pr SearchZip extproc('SCHZIP') end-pr;
       dcl-pr SearchName extproc('SCHNAM') end-pr;
      // Field definitions:
       dcl-ds indicators;
        exitKey pos(3);
        maintainKey pos(5);
        srchZipKey pos(6);
        srchCustKey pos(7);
       end-ds;

      // Keep looping until exit key is pressed
       dow '1';
         // Display main menu
         exfmt hdrscn;
         // Perform requested action
         if exitKey;
         // Exit program
           leave;
         elseif maintainKey;
         // Maintain customer data
           CustMaintain();
         elseif srchZipKey;
         // Search customer data on ZIP code
           SearchZip();
         elseif srchCustKey;
         // Search customer data on customer name
           SearchName();
         endif;
       enddo;
       *inlr = *on;
