/* LECTURE DTAARA                                           */
             PGM        PARM(&PSOC)
             DCL        VAR(&PSOC) TYPE(*CHAR) LEN(10)
             DCL        VAR(&WSOC) TYPE(*CHAR) LEN(2000)
             DCL        VAR(&WLIB) TYPE(*CHAR) LEN(10)
/* RECUPERATION DU CONTENU                                  */
             RTVDTAARA  DTAARA(&PSOC (1 2000)) RTNVAR(&WSOC)
/* RECUPERATION DE LA BIBLIOTHEQUE                          */
             CHGVAR     VAR(&WLIB) VALUE(%SST(&WSOC 1 10))
/* MISE EN PLACE DE LA BIBLIOTHEQUE                         */
             ADDLIBLE   LIB(&WLIB)
             MONMSG     MSGID(CPF0000)
/* LA ON APPELLERA LE PROGRAMME DE TRAITEMENT               */

/* SUPPRESSION EN FIN DE TRAITEMENT                         */
             RMVLIBLE   LIB(&WLIB)
             MONMSG     MSGID(CPF0000)
             ENDPGM
