      //----------------------------------------------------------------*
      // Program to test Service Program CVTTOHEX                       *
      //                                                                *
      // 1. Use a 7-character input string                              *
      // 2. Convert to a 10-character hex string (only the first five   *
      //    input characters will be used because the result is too     *
      //    small for the entire input string)                          *
      // 3. Convert to a 14-character hex string (all seven input       *
      //    characters will be used because the result is long enough)  *
      //----------------------------------------------------------------*
       dcl-f QSYSPRT printer(80);
      // Prototype for CvtToHex
      /COPY RPGGUIDE/QRPGLE,CVTHEXPR
       dcl-ds ResultDS;
        Result14 char(14) pos(1);
        Result10 char(10) pos(1);
       end-ds;
       dcl-s InString char(7);
       dcl-s Comment char(25);
      /FREE
       InString = 'ABC123*';

       //----------------------------------------------------------------*
       // Pass character string and the 10-character result field        *
       // using a prototyped call.  Operational descriptors are          *
       // passed, as required by the called procedure CvtToHex.          *
       //----------------------------------------------------------------*
       Comment = '10 character output';
       CLEAR ResultDS;
       CvtToHex(Instring : Result10);
       EXCEPT;

       //----------------------------------------------------------------*
       // Pass character string and the 14-character result field        *
       // using a CALLB(D). The operation extender (D) will create       *
       // operational descriptors for the passed parameters.  CALLB      *
       // is used here for comparison with the above CALLP.              *
       //----------------------------------------------------------------*
       Comment = '14 character output';
       CLEAR ResultDS;
      /END-FREE
     C                   CALLB(D)  'CVTTOHEX'
     C                   PARM                    InString
     C                   PARM                    Result14
      /FREE
       EXCEPT;
       *INLR = *ON;

      /END-FREE
     OQSYSPRT   H    1P
     O                                              'Result14++++++'
     OQSYSPRT   H    1P
     O                                              'Result10++'
     OQSYSPRT   E
     O                       ResultDS
     O                       Comment             +5
