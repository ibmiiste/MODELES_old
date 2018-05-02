000100180502      //=================================================================*
000200180502      // CvtToHex - convert input string to hex output string
000300180502      //=================================================================*
000400180502       ctl-opt copyright('(C) Copyright MyCompany 1995');
000500180502      /COPY RPGGUIDE/QRPGLE,CVTHEXPR
000600180502      //-----------------------------------------------------------------*
000700180502      // Main entry parameters
000800180502      // 1. Input:   string                   character(n)
000900180502      // 2. Output:  hex string               character(2 * n)
001000180502      //-----------------------------------------------------------------*
001100180502       dcl-pi CvtToHex opdesc;
001200180502        InString char(16383) const options(*varsize);
001300180502        HexString char(32766) options(*varsize);
001400180502       end-pi;
001500180502
001600180502      //-----------------------------------------------------------------*
001700180502      // Prototype for CEEDOD (Retrieve operational descriptor)
001800180502      //-----------------------------------------------------------------*
001900180502       dcl-pr CEEDOD;
002000180502        *n int(10) const; // ParmNum
002100180502        *n int(10);
002200180502        *n int(10);
002300180502        *n int(10);
002400180502        *n int(10);
002500180502        *n int(10);
002600180502        *n char(12) options(*omit);
002700180502       end-pr;
002800180502
002900180502      // Parameters passed to CEEDOD
003000180502       dcl-s DescType int(10);
003100180502       dcl-s DataType int(10);
003200180502       dcl-s DescInfo1 int(10);
003300180502       dcl-s DescInfo2 int(10);
003400180502       dcl-s InLen int(10);
003500180502       dcl-s HexLen int(10);
003600180502
003700180502      //-----------------------------------------------------------------*
003800180502      // Other fields used by the program                                *
003900180502      //-----------------------------------------------------------------*
004000180502       dcl-c HexDigits const('0123456789ABCDEF');
004100180502       dcl-ds IntDs;
004200180502        IntNum int(5) inz(0);
004300180502        IntChar char(1) overlay(intnum:2);
004400180502       end-ds;
004500180502       dcl-ds HexDs;
004600180502        HexC1 char(1);
004700180502        HexC2 char(1);
004800180502       end-ds;
004900180502       dcl-s InChar char(1);
005000180502       dcl-s Pos packed(5);
005100180502       dcl-s HexPos packed(5);
005200180502      //-----------------------------------------------------------------*
005300180502      // Use the operational descriptors to determine the lengths of     *
005400180502      // the parameters that were passed.                                *
005500180502      //-----------------------------------------------------------------*
005600180502
005700180502       CEEDOD(1         : DescType : DataType :
005800180502           DescInfo1 : DescInfo2: Inlen    :
005900180502           *OMIT);
006000180502       CEEDOD(2         : DescType : DataType :
006100180502           DescInfo1 : DescInfo2: HexLen   :
006200180502           *OMIT);
006300180502       //-----------------------------------------------------------------*
006400180502       // Determine the length to handle (minimum of the input length     *
006500180502       // and half of the hex length)                                     *
006600180502       //-----------------------------------------------------------------*
006700180502       IF InLen > HexLen / 2;
006800180502         InLen = HexLen / 2;
006900180502       ENDIF;
007000180502
007100180502       //-----------------------------------------------------------------*
007200180502       // For each character in the input string, convert to a 2-byte     *
007300180502       // hexadecimal representation (for example, '5' --> 'F5')          *
007400180502       //-----------------------------------------------------------------*
007500180502       HexPos = 1;
007600180502
007700180502     C                   DO        InLen         Pos
007800180502
007900180502         InChar = %SUBST(InString : Pos :1);
008000180502         EXSR GetHex;
008100180502         %SUBST(HexString : HexPos : 2) = HexDs;
008200180502         HexPos = HexPos + 2;
008300180502       ENDDO;
008400180502
008500180502       //-----------------------------------------------------------------*
008600180502       // Done; return to caller.                                         *
008700180502       //-----------------------------------------------------------------*
008800180502       RETURN;
008900180502
009000180502       //=================================================================*
009100180502       // GetHex - subroutine to convert 'InChar' to 'HexDs'              *
009200180502       //                                                                 *
009300180502       // Use division by 16 to separate the two hexadecimal digits.      *
009400180502       // The quotient is the first digit, the remainder is the second.   *
009500180502       //=================================================================*
009600180502       BEGSR GetHex;
009700180502         IntChar = InChar;
009800180502
009900180502     C     IntNum        DIV       16            X1                5 0
010000180502     C                   MVR                     X2                5 0
010100180502      //-----------------------------------------------------------------*
010200180502      // Use the hexadecimal digit (plus 1) to substring the list of     *
010300180502      // hexadecimal characters '012...CDEF'.                            *
010400180502      //-----------------------------------------------------------------*
010500180502
010600180502         HexC1 = %SUBST(HexDigits:X1+1:1);
010700180502         HexC2 = %SUBST(HexDigits:X2+1:1);
010800180502       ENDSR;
