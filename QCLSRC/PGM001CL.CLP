/********************************************************************/
/* AFFICHAGE DES MESSAGES CC LE 15/01/2009                          */
/********************************************************************/
             PGM        PARM(&PTYP &PFICM &PMGID &PMGDT)
  /* DECLARATION DES VARIABLES                                      */
             DCL        VAR(&PTYP) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PFICM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PMGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&PMGDT) TYPE(*CHAR) LEN(99)
  /* MESSAGE TYPE 1 = DEF = INFO                                */
             IF         COND(&PTYP = '1') THEN(DO)
             SNDPGMMSG  MSGID(&PMGID) MSGF(*LIBL/&PFICM) MSGDTA(&PMGDT)
             MONMSG     MSGID(CPF0000)
             GOTO       CMDLBL(FINI)
             ENDDO
  /* MESSAGE TYPE 2   *STATUS                                   */
             IF         COND(&PTYP = '2') THEN(DO)
             SNDPGMMSG  MSGID(&PMGID) MSGF(*LIBL/&PFICM) +
                          MSGDTA(&PMGDT) TOPGMQ(*EXT) MSGTYPE(*STATUS)
             MONMSG     MSGID(CPF0000)
             GOTO       CMDLBL(FINI)
             ENDDO
  /* NETTOYAGE VIEUX MESSAGES                                   */
             IF         COND(&PTYP = '3') THEN(DO)
             RMVMSG     PGMQ(*PRV) CLEAR(*OLD)
             MONMSG     MSGID(CPF0000)
             GOTO       CMDLBL(FINI)
             ENDDO
  /* NETTOYAGE TOTAL                                            */
             IF         COND(&PTYP = '4') THEN(DO)
             RMVMSG     PGMQ(*PRV) CLEAR(*ALL)
             MONMSG     MSGID(CPF0000)
             GOTO       CMDLBL(FINI)
             ENDDO
  /* LA FIN */
 FINI:       ENDPGM
