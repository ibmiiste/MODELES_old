             CMD        PROMPT('Appel envoi message')

             PARM       KWD(TYPE) TYPE(*CHAR) LEN(1) RANGE('1' '4') +
                          MIN(1) CHOICE('Type') PROMPT('Type de +
                          message' 1)
             PARM       KWD(FIC_MSG) TYPE(*CHAR) LEN(10) DFT(ERRMSG) +
                          MIN(0) CHOICE('Choisir') PROMPT('Fichier +
                          des messages' 1)
             PARM       KWD(MSGID) TYPE(*CHAR) LEN(7) DFT(CPF0001) +
                          MIN(0) CHOICE('ID message') PROMPT('ID du +
                          message' 1)
             PARM       KWD(TEXT) TYPE(*CHAR) LEN(99) MIN(0) +
                          CHOICE('Message') PROMPT('Valeurs +
                          complémentaires' 1)
