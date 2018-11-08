      *=====================================================================*
      *  Empty Unit Test Case. Prints a protocol of the execution flow.     *
      *=====================================================================*
      *  Command to create the service program:                             *
      *  RUCRTTST TSTPGM(RPGUNIT/TEMPLATE) SRCFILE(RPGUNIT/RPGUNIT1)        *
      *=====================================================================*
      *  Tools/400 STRPREPRC instructions:                                  *
      *   >>PRE-COMPILER<<                                                  *
      *     >>CRTCMD<<  RUCRTTST    TSTPGM(&LI/&OB) +                       *
      *                             SRCFILE(&SL/&SF);                       *
      *     >>COMPILE<<                                                     *
      *       >>PARM<< COPTION(*SRCSTMT);                                   *
      *       >>PARM<< DBGVIEW(*LIST);                                      *
      *       >>PARM<< BNDDIR(&LI/HTTPAPIR4);                               *
      *     >>END-COMPILE<<                                                 *
      *     >>EXECUTE<<                                                     *
      *   >>END-PRE-COMPILER<<                                              *
      *=====================================================================*
       ctl-opt nomain option(*srcstmt);
       dcl-f QSYSPRT printer(80) usropn oflind(*in70);

      /copy RPGUNIT1,TESTCASE

      // ============================================================
      //  Opens the printer.
      // ============================================================
       dcl-proc openPrinter export;
       dcl-pi *n end-pi;

         open QSYSPRT;

       end-proc;

      // ============================================================
      //  Prints a message.
      // ============================================================
       dcl-proc print export;
       dcl-pi *n;
        text varchar(128) value  options(*nopass);
       end-pi;

       dcl-ds lineOutput len(80) inz end-ds;

         if (%parms() >= 1);
            lineOutput = text;
         else;
            lineOutput = '';
         endif;
         write QSYSPRT lineOutput;

       end-proc;

      // ============================================================
      //  Closes the printer.
      // ============================================================
       dcl-proc closePrinter export;
       dcl-pi *n end-pi;

         if (%open(QSYSPRT));
            close QSYSPRT;
         endif;

       end-proc;

      // ============================================================
      //  Set up test suite. Executed once per RUCALLTST.
      // ============================================================
       dcl-proc setUpSuite export;
       dcl-pi *n end-pi;

       dcl-s rc char(1);

         runCmd('OVRPRTF FILE(QSYSPRT) TOFILE(*FILE) +
                 SPLFNAME(PROC_FLOW) OVRSCOPE(*JOB)');
         monitor;
            openPrinter();
            print('Executing:   setUpSuite()');
         on-error;
            // ignore errors ...
         endmon;

         // ... but try to remove the override.
         monitor;
            runCmd('DLTOVR FILE(QSYSPRT) LVL(*JOB)');
         on-error;
            dsply '*** Failed to delete QSYSPRT override! ***' rc;
         endmon;

       end-proc;

      // ============================================================
      //  Tear down test suite.
      // ============================================================
       dcl-proc tearDownSuite export;
       dcl-pi *n end-pi;

         print('Executing:   tearDownSuite()');
         closePrinter();

       end-proc;

      // ============================================================
      //  Set up test case.
      // ============================================================
       dcl-proc setUp export;
       dcl-pi *n end-pi;

         print('Executing:   - setUp()');

       end-proc;

      // ============================================================
      //  Tear down test case.
      // ============================================================
       dcl-proc tearDown export;
       dcl-pi *n end-pi;

         print('Executing:   - tearDown()');

       end-proc;

      // ============================================================
      //  RPGUnit test case.
      // ============================================================
       dcl-proc testWhatever_1 export;
       dcl-pi *n end-pi;

         print('Executing:       * testWhatever_1()');

         // Place your assertions here.

       end-proc;

      // ============================================================
      //  RPGUnit test case.
      // ============================================================
       dcl-proc testWhatever_2 export;
       dcl-pi *n end-pi;

         print('Executing:       * testWhatever_2()');

         // Place your assertions here.

       end-proc;
