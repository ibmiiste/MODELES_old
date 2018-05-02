000100180502      //****************************************************************
000200180502      // PROGRAM NAME: CUSMAIN                                         *
000300180502      // RELATED FILES: MAINMENU (DSPF)                                *
000400180502      // RELATED PGMS: CUSMNT (ILE RPG PGM)                            *
000500180502      // SCHZIP (ILE RPG PGM)                                          *
000600180502      // SCHNAM (ILE RPG PGM)                                          *
000700180502      // DESCRIPTION: This is a customer main inquiry program.         *
000800180502      // It prompts the user to choose from one of the                 *
000900180502      // following actions:                                            *
001000180502      // 1.Maintain (add, update, delete and display)                  *
001100180502      // customer records.                                             *
001200180502      // 2.Search customer record by zip code.                         *
001300180502      // 3.Search customer record by name.                             *
001400180502      //****************************************************************
001500180502       dcl-f MAINMENU workstn indds(indicators);
001600180502      // Prototype definitions:
001700180502       dcl-pr CustMaintain extproc('CUSMNT') end-pr;
001800180502       dcl-pr SearchZip extproc('SCHZIP') end-pr;
001900180502       dcl-pr SearchName extproc('SCHNAM') end-pr;
002000180502      // Field definitions:
002100180502       dcl-ds indicators;
002200180502        exitKey pos(3);
002300180502        maintainKey pos(5);
002400180502        srchZipKey pos(6);
002500180502        srchCustKey pos(7);
002600180502       end-ds;
002700180502
002800180502      // Keep looping until exit key is pressed
002900180502       dow '1';
003000180502         // Display main menu
003100180502         exfmt hdrscn;
003200180502         // Perform requested action
003300180502         if exitKey;
003400180502         // Exit program
003500180502           leave;
003600180502         elseif maintainKey;
003700180502         // Maintain customer data
003800180502           CustMaintain();
003900180502         elseif srchZipKey;
004000180502         // Search customer data on ZIP code
004100180502           SearchZip();
004200180502         elseif srchCustKey;
004300180502         // Search customer data on customer name
004400180502           SearchName();
004500180502         endif;
004600180502       enddo;
004700180502       *inlr = *on;
