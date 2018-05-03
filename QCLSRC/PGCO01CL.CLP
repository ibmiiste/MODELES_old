/******************************************************************************/
/*  COPIE D'UNE BIBLIOTHEQUE DANS UNE AUTRE (FICHIERS)                        */
/******************************************************************************/
             PGM        PARM(&BSRC &BDST)

             DCL        VAR(&BSRC) TYPE(*CHAR) LEN(10)
             DCL        VAR(&BDST) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CDRT) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PCRT) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PDLT) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PLCK) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PENV) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PLEP) TYPE(*CHAR) LEN(10)
             DCL        VAR(&XEPU) TYPE(*CHAR) LEN(1)
             DCL        VAR(&NMPGM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&NRCD) TYPE(*DEC) LEN(10 0)
  /* DECLARATION DU FICHIER                                 */
             DCLF       FILE(QSYS/QADSPOBJ) RCDFMT(QLIDOBJD)
  /* CHARGEMENT DU FICHIER                                  */
             DSPOBJD    OBJ(&BSRC/*ALL) OBJTYPE(*FILE) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/FTEMP)
  /* SUBSTITUTION                                          */
             OVRDBF     FILE(QADSPOBJ) TOFILE(QTEMP/FTEMP)
  /* LECTURE DU FICHIER                                    */
 LECT:       RCVF       RCDFMT(QLIDOBJD)
  /* EN FIN DE FICHIER ON TERMINE                           */
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(CLOSE))
  /* ON NE TRAITE QUE LES FICHIERS PHYSIQUES                */
             IF         COND(&ODOBAT *NE 'PF') THEN(GOTO CMDLBL(LECT))
  /* ON VIDE LE FICHIER DESTINATION S'IL EXISTE             */
             CLRPFM     FILE(&BDST/&ODOBNM)
             MONMSG     MSGID(CPF0000)
  /* COPIE DU FICHIER SOURCE ET CREATION EVENTUELLE          */
             CPYF       FROMFILE(&BSRC/&ODOBNM) +
                          TOFILE(&BDST/&ODOBNM) MBROPT(*ADD) +
                          CRTFILE(*YES)
             MONMSG     MSGID(CPF0000)
  /* ON BOUCLE                                                */
             GOTO       CMDLBL(LECT)
CLOSE:       CLOF       OPNID(QADSPFFD)
             MONMSG CPF0000
  /* NETTOYAGE                                                */
             DLTF       FILE(QTEMP/FTEMP)
             ENDPGM
