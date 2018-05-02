000100180502      *=================================================================*
000200180502      * CvtToHex - convert input string to hex output string
000300180502      *
000400180502      * Parameters
000500180502      * 1. Input:   string                   character(n)
000600180502      * 2. Output:  hex string               character(2 * n)
000700180502      *=================================================================*
000800180502     D CvtToHex        PR                    OPDESC
000900180502     D   InString                 16383      CONST OPTIONS(*VARSIZE)
001000180502     D   HexString                32766      OPTIONS(*VARSIZE)
