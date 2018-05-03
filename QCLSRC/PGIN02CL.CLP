             PGM
             DCL &JOB *CHAR 10
             DCL &USER *CHAR 10
             DCL &RPLY *CHAR 1
             RTVJOBA    JOB(&JOB) USER(&USER)
             CLRMSGQ    MSGQ(&JOB)
             MONMSG CPF0000
             CLRMSGQ    MSGQ(&USER)
             MONMSG CPF0000
             CHGMSGQ    MSGQ(&JOB) DLVRY(*BREAK)
             MONMSG CPF0000
 OPT3:       SNDUSRMSG  MSG('''**** VOUS ALLEZ ARRETER LE SYSTEME +
                          G=OUI C=NON. ****''''''') VALUES(C C G G) +
                          TOMSGQ(&JOB) MSGRPY(&RPLY)

             IF         COND((&RPLY *NE 'G') & (&RPLY *NE 'g')) +
                          THEN(GOTO CMDLBL(FIN))

             ELSE DO
/*           QSYS/PWRDWNSYS OPTION(*IMMED) RESTART(*YES)  */
             ENDDO
 FIN:        ENDPGM
