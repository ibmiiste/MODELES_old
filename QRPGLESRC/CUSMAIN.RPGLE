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
     Fmainmenu  cf e                       workstn indds(indicators)
     // Prototype definitions:
     D CustMaintain    pr                  extproc('CUSMNT')
     D SearchZip       pr                  extproc('SCHZIP')
     D SearchName      pr                  extproc('SCHNAM')
     // Field definitions:
     D indicators      ds
     D exitKey         n                   overlay(indicators:3)
     D maintainKey     n                   overlay(indicators:5)
     D srchZipKey      n                   overlay(indicators:6)
     D srchCustKey     n                   overlay(indicators:7)

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
