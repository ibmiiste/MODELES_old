      *=================================================================*
      * CvtToHex - convert input string to hex output string
      *
      * Parameters
      * 1. Input:   string                   character(n)
      * 2. Output:  hex string               character(2 * n)
      *=================================================================*
     D CvtToHex        PR                    OPDESC
     D   InString                 16383      CONST OPTIONS(*VARSIZE)
     D   HexString                32766      OPTIONS(*VARSIZE)
