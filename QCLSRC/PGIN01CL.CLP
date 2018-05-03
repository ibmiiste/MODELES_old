             PGM        PARM(&SBS &MSG)
 /*DECLARATION VARIABLES                                       */
             DCL        VAR(&MSG) TYPE(*CHAR) LEN(500)
             DCL        VAR(&JOB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&TYPE) TYPE(*CHAR) LEN(3)
             DCL        VAR(&SBS) TYPE(*CHAR) LEN(10)
 /*DECLARATION FICHIER                                         */
             DCLF       FILE(QTEMP/ACTJ)
 /*CREATION D'UN FICHIER DE TRAVAIL TEMPORAIRE                 */
             DLTF QTEMP/ACTJ
             MONMSG CPF0000
             CRTPF      FILE(QTEMP/ACTJ) RCDLEN(130)
             MONMSG CPF0000
 /*PRINT DE L'ETAT D'UN SOUS SYSTEME                           */
             WRKACTJOB  OUTPUT(*PRINT) SBS(&SBS)
 /*COPIE DU SPOULE DANS LE FICHIER DE TRAVAIL                  */
             CPYSPLF    FILE(QPDSPAJB) TOFILE(QTEMP/ACTJ) SPLNBR(*LAST)
 /*SUPPRESSION DU SPOULE                                       */
             DLTSPLF    FILE(QPDSPAJB) SPLNBR(*LAST)
 /*SUBSTITUTION ET LECTURE A PARTIR DE 11                      */
             OVRDBF     FILE(ACTJ) POSITION(*RRN 11)
 LECT:       RCVF       RCDFMT(ACTJ)
 /*MESSAGE DE FIN DE FICHIER                                   */
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
 /*RECHERCHE DE LA VALEUR A TRAITER                            */
             CHGVAR     VAR(&TYPE) VALUE(%SST(&ACTJ 38 3))
             IF         COND(&TYPE *NE 'INT') THEN(GOTO CMDLBL(LECT))
             ELSE       CMD(DO)
 /*SI ON A TROUVE ON ENVOIE UN MESSAGE                         */
             CHGVAR     VAR(&JOB) VALUE(%SST(&ACTJ 4 10))
             SNDBRKMSG  MSG(&MSG) TOMSGQ(&JOB)
             GOTO LECT
             ENDDO

FIN:         ENDPGM
