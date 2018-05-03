/********************************************************************/
             PGM        PARM(&PDES1 &PFIC &PTOP &PDOC &PDSC1 &PSPE1)

             DCL        VAR(&PDES1) TYPE(*CHAR) LEN(256)
             DCL        VAR(&PDEST) TYPE(*CHAR) LEN(255)
             DCL        VAR(&PFIC)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&PTOP)  TYPE(*CHAR) LEN(01)
             DCL        VAR(&PDOC)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&PDSC1) TYPE(*CHAR) LEN(51)
             DCL        VAR(&PDSCR) TYPE(*CHAR) LEN(50)
             DCL        VAR(&PSPE1) TYPE(*CHAR) LEN(501)
             DCL        VAR(&PSPEC) TYPE(*CHAR) LEN(500)
/* A CAUSE DES VARIABLES LONG > 32                             */
             CHGVAR     VAR(&PDEST) VALUE(&PDES1)
             CHGVAR     VAR(&PDSCR) VALUE(&PDSC1)
             CHGVAR     VAR(&PSPEC) VALUE(&PSPE1)
/* METTRE DES VALEURS PAR DEFAUT SI BESOIN                     */
             IF         COND(&PFIC = '         ') THEN(CHGVAR +
                          VAR(&PTOP) VALUE('0'))
             IF         COND(&PTOP = '1') THEN(DO)
/* IL FAUT AVOIR UN REPERTOIRE EMAIL DANS L'IFS                 */
             CPYTOPCD   FROMFILE(&PFIC) TOFLR(EMAIL) +
                          FROMMBR(*FIRST) TODOC(&PDOC) REPLACE(*YES)
             SNDDST     TYPE(*DOC) TOINTNET((&PDEST)) DSTD(&PDSCR) +
                          PTY(*NORMAL) DOC(&PDOC) FLR(EMAIL)
             ENDDO
             ELSE       CMD(DO)
             SNDDST     TYPE(*LMSG) TOINTNET((&PDEST)) DSTD(&PDSCR) +
                          LONGMSG(&PSPEC) SUBJECT(&PDOC)

             ENDDO
             ENDPGM
