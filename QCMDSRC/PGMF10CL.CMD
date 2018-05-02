000100180502           CMD        PROMPT('Edition liste du personnel')
000200180502
000300180502             PARM       KWD(MATR) TYPE(*CHAR) LEN(10) +
000400180502                          RANGE('0000000001' '9999999999') MIN(0) +
000500180502                          ALWUNPRT(*NO) ALWVAR(*NO) +
000600180502                          CHOICE('Matricule ou totale') +
000700180502                          PROMPT('Edition liste du personnel' 1)
