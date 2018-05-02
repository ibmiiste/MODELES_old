      //=================================================================*
      // CvtToHex - convert input string to hex output string
      //=================================================================*
       ctl-opt copyright('(C) Copyright MyCompany 1995');
      /COPY RPGGUIDE/QRPGLE,CVTHEXPR
      //-----------------------------------------------------------------*
      // Main entry parameters
      // 1. Input:   string                   character(n)
      // 2. Output:  hex string               character(2 * n)
      //-----------------------------------------------------------------*
       dcl-pi CvtToHex opdesc;
        InString char(16383) const options(*varsize);
        HexString char(32766) options(*varsize);
       end-pi;

      //-----------------------------------------------------------------*
      // Prototype for CEEDOD (Retrieve operational descriptor)
      //-----------------------------------------------------------------*
       dcl-pr CEEDOD;
        *n int(10) const; // ParmNum
        *n int(10);
        *n int(10);
        *n int(10);
        *n int(10);
        *n int(10);
        *n char(12) options(*omit);
       end-pr;

      // Parameters passed to CEEDOD
       dcl-s DescType int(10);
       dcl-s DataType int(10);
       dcl-s DescInfo1 int(10);
       dcl-s DescInfo2 int(10);
       dcl-s InLen int(10);
       dcl-s HexLen int(10);

      //-----------------------------------------------------------------*
      // Other fields used by the program                                *
      //-----------------------------------------------------------------*
       dcl-c HexDigits const('0123456789ABCDEF');
       dcl-ds IntDs;
        IntNum int(5) inz(0);
        IntChar char(1) overlay(intnum:2);
       end-ds;
       dcl-ds HexDs;
        HexC1 char(1);
        HexC2 char(1);
       end-ds;
       dcl-s InChar char(1);
       dcl-s Pos packed(5);
       dcl-s HexPos packed(5);
      //-----------------------------------------------------------------*
      // Use the operational descriptors to determine the lengths of     *
      // the parameters that were passed.                                *
      //-----------------------------------------------------------------*

       CEEDOD(1         : DescType : DataType :
           DescInfo1 : DescInfo2: Inlen    :
           *OMIT);
       CEEDOD(2         : DescType : DataType :
           DescInfo1 : DescInfo2: HexLen   :
           *OMIT);
       //-----------------------------------------------------------------*
       // Determine the length to handle (minimum of the input length     *
       // and half of the hex length)                                     *
       //-----------------------------------------------------------------*
       IF InLen > HexLen / 2;
         InLen = HexLen / 2;
       ENDIF;

       //-----------------------------------------------------------------*
       // For each character in the input string, convert to a 2-byte     *
       // hexadecimal representation (for example, '5' --> 'F5')          *
       //-----------------------------------------------------------------*
       HexPos = 1;

     C                   DO        InLen         Pos

         InChar = %SUBST(InString : Pos :1);
         EXSR GetHex;
         %SUBST(HexString : HexPos : 2) = HexDs;
         HexPos = HexPos + 2;
       ENDDO;

       //-----------------------------------------------------------------*
       // Done; return to caller.                                         *
       //-----------------------------------------------------------------*
       RETURN;

       //=================================================================*
       // GetHex - subroutine to convert 'InChar' to 'HexDs'              *
       //                                                                 *
       // Use division by 16 to separate the two hexadecimal digits.      *
       // The quotient is the first digit, the remainder is the second.   *
       //=================================================================*
       BEGSR GetHex;
         IntChar = InChar;

     C     IntNum        DIV       16            X1                5 0
     C                   MVR                     X2                5 0
      //-----------------------------------------------------------------*
      // Use the hexadecimal digit (plus 1) to substring the list of     *
      // hexadecimal characters '012...CDEF'.                            *
      //-----------------------------------------------------------------*

         HexC1 = %SUBST(HexDigits:X1+1:1);
         HexC2 = %SUBST(HexDigits:X2+1:1);
       ENDSR;
