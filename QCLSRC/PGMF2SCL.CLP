/********************************************************************/
/* ROUTAGE D'UN SPOULE VERS UNE OUT Q                               */
/********************************************************************/
             PGM        PARM(&PMAT)
/* DECLARATION DES VARIABLES                                        */
             DCL        VAR(&PMAT) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PUSR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PNREC) TYPE(*DEC) LEN(10)
/* LE FICHIER D'IMPRESSION                                          */
             DCLF       FILE(FIO00P) OPNID(A1)
             DCLF       FILE(QTEMP/FIO00P) OPNID(A2)
/* LE PROFIL UTILISATEUR                                            */
             RTVJOBA    USER(&PUSR)
/* METHODE PAR LECTURE DU FICHIER DES OUTQ                          */
 LECT:       RCVF       OPNID(A1)
 /* TEST SI FIN DE FICHIER DONC PAS DE ROUTAGE                      */
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(APPEL))
             IF         COND((&PUSR = &A1_FOUSR) *AND (&A1_FODOC = +
                          'PGMF20PR')) THEN(DO)
 /* ON A TROUVE L'UTILISATEUR DANS FICHIER                          */
             OVRPRTF    FILE(PGMF20PR) TOFILE(PGMF20PR) +
                          OUTQ(*LIBL/&A1_FOOUQ)
             GOTO       CMDLBL(COPIE)

             ENDDO
 /* PAS TROUVE ON RECOMMENCE                                        */
             GOTO       CMDLBL(LECT)
 /* AUTRE METHODE NON UTILISEE                                      */
 COPIE:      CPYF       FROMFILE(FIO00P) TOFILE(QTEMP/FIO00P) +
                          MBROPT(*REPLACE) CRTFILE(*YES) +
                          INCREL((*IF FOUSR *EQ &PUSR) (*AND FODOC +
                          *EQ 'PGMF20PR'))
             RTVMBRD    FILE(QTEMP/FIO00P) NBRCURRCD(&PNREC)
             IF         COND(&PNREC *NE 0) THEN(DO)
 /* ON A TROUVE L'UTILISATEUR DANS FICHIER                          */
             RCVF       OPNID(A2)

             OVRPRTF    FILE(PGMF20PR) TOFILE(PGMF20PR) +
                          OUTQ(*LIBL/&A2_FOOUQ)
             ENDDO

 APPEL:      CALL       PGM(PGMF20) PARM(&PMAT)
     ENDPGM
