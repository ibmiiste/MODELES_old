           CMD        PROMPT('Edition liste du personnel')

             PARM       KWD(MATR) TYPE(*CHAR) LEN(10) +
                          RANGE('0000000001' '9999999999') MIN(0) +
                          ALWUNPRT(*NO) ALWVAR(*NO) +
                          CHOICE('Matricule ou totale') +
                          PROMPT('Edition liste du personnel' 1)
