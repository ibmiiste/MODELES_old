000100180502      //----------------------------------------------------------------*
000200180502      // Program to test Service Program CVTTOHEX                       *
000300180502      //                                                                *
000400180502      // 1. Use a 7-character input string                              *
000500180502      // 2. Convert to a 10-character hex string (only the first five   *
000600180502      //    input characters will be used because the result is too     *
000700180502      //    small for the entire input string)                          *
000800180502      // 3. Convert to a 14-character hex string (all seven input       *
000900180502      //    characters will be used because the result is long enough)  *
001000180502      //----------------------------------------------------------------*
001100180502       dcl-f QSYSPRT printer(80);
001200180502      // Prototype for CvtToHex
001300180502      /COPY RPGGUIDE/QRPGLE,CVTHEXPR
001400180502       dcl-ds ResultDS;
001500180502        Result14 char(14) pos(1);
001600180502        Result10 char(10) pos(1);
001700180502       end-ds;
001800180502       dcl-s InString char(7);
001900180502       dcl-s Comment char(25);
002000180502      /FREE
002100180502       InString = 'ABC123*';
002200180502
002300180502       //----------------------------------------------------------------*
002400180502       // Pass character string and the 10-character result field        *
002500180502       // using a prototyped call.  Operational descriptors are          *
002600180502       // passed, as required by the called procedure CvtToHex.          *
002700180502       //----------------------------------------------------------------*
002800180502       Comment = '10 character output';
002900180502       CLEAR ResultDS;
003000180502       CvtToHex(Instring : Result10);
003100180502       EXCEPT;
003200180502
003300180502       //----------------------------------------------------------------*
003400180502       // Pass character string and the 14-character result field        *
003500180502       // using a CALLB(D). The operation extender (D) will create       *
003600180502       // operational descriptors for the passed parameters.  CALLB      *
003700180502       // is used here for comparison with the above CALLP.              *
003800180502       //----------------------------------------------------------------*
003900180502       Comment = '14 character output';
004000180502       CLEAR ResultDS;
004100180502      /END-FREE
004200180502     C                   CALLB(D)  'CVTTOHEX'
004300180502     C                   PARM                    InString
004400180502     C                   PARM                    Result14
004500180502      /FREE
004600180502       EXCEPT;
004700180502       *INLR = *ON;
004800180502
004900180502      /END-FREE
005000180502     OQSYSPRT   H    1P
005100180502     O                                              'Result14++++++'
005200180502     OQSYSPRT   H    1P
005300180502     O                                              'Result10++'
005400180502     OQSYSPRT   E
005500180502     O                       ResultDS
005600180502     O                       Comment             +5
