       ctl-opt debug decedit('0,') datedit(*dmy.);
      //****************************************************
      //                                                   *
      // Détail personnel                                  *
      //                                                   *
      //****************************************************
       dcl-f PGMF02FM workstn infds(wdsecr);
       dcl-f FIC00P usage(*update);
       dcl-f FIC01L keyed usage(*update: *output) rename(ficf      :ficf1);
       dcl-f FIF01L keyed;
       dcl-c WTXT1 '         Modification         ';
       dcl-c WTXT2 '             Copie            ';
       dcl-c WTXT3 '         Suppression          ';
       dcl-c WTXT4 '           Affichage          ';
       dcl-c WTXT5 '           Création           ';
       dcl-c WTXT6 '        Fin de contrat        ';
       dcl-s WDAT char(8);
       dcl-s WHEU char(6);
       dcl-s W14 packed(14);
       dcl-s PCHX char(2);
       dcl-s PNREC char(10);
       dcl-s WNREC packed(10);
       dcl-s PACT char(2);
       dcl-s PGFCT char(3);

       dcl-ds WDI;
        WSSAI zoned(4) pos(1);
        WMI zoned(2) pos(5);
        WJI zoned(2) pos(7);
        WDATI zoned(8) pos(1);
       end-ds;

       dcl-ds WDE;
        WJE zoned(2) pos(1);
        WME zoned(2) pos(3);
        WSSAE zoned(4) pos(5);
        WDATE zoned(8) pos(1);
       end-ds;

       dcl-ds WDSPGM PSDS;
        WNMPGM char(10) pos(1);
        WSTATU zoned(5) pos(11);
        WSTPRE zoned(5) pos(16);
        WSRCSQ char(8) pos(21);
        WNMROU char(8) pos(29);
        WNBPAR zoned(3) pos(37);
        WTYEXC char(3) pos(40);
        WLICPF char(7) pos(40);
        WNUEXC char(4) pos(43);
        WMIODT char(4) pos(47);
        WZOMES char(30) pos(51);
        WBIPGM char(10) pos(81);
        WRTDTA char(80) pos(91);
        WCOERR char(4) pos(171);
        WDERFI char(8) pos(201);
        WFIINF char(35) pos(209);
        WJOB char(10) pos(244);
        WUSER char(10) pos(254);
        WJOBNM zoned(6) pos(264);
       end-ds;

       dcl-ds WDSECR;
        WNLIG int(5) pos(370);
        WRANP int(5) pos(378);
        WNBRS int(5) pos(380);
        WNULC int(5) pos(382);
        WRECMI int(5) pos(403);
       end-ds;

       Dcl-ds
       Dcl-pi Personnal_detail Extpgm('PGMF02');
         Pchx Char(2);
         Pnrec Char(10);
       End-Pi;


     C     KEY002        KLIST
     C                   KFLD                    ZFCOD
      // début du programme
     C                   MOVEL     WNMPGM        ZPGM
      /FREE
       EXSR DATHEU;
      /END-FREE
     C                   MOVE      WDAT          ZDATE
     C                   MOVE      WHEU          ZHEUR
     C                   MOVEL     WUSER         ZUSER
     C                   MOVEL     WJOB          ZJOB
     C                   MOVEL     '*  '         WPGMQ
     C                   MOVEL     'CC01'        WMGKEY
      /FREE
       *IN09 = *ON;
       *IN10 = *ON;
       *IN14 = *ON;
       *IN15 = *ON;
       *IN16 = *ON;
       *IN17 = *ON;
       *IN18 = *ON;
       *IN85 = *OFF;
       *IN88 = *OFF;
       // constantes pour ce programme
      /END-FREE
     C                   MOVE      '1'           PTYP
     C                   MOVEL     'FICMSG    '  PFICM
      /FREE
       SELECT;
       WHEN (PCHX = 'MO');
         // modification
      /END-FREE
     C                   MOVEL     WTXT1         ZMODE
      // on ne peut modifier que ces zones
      /FREE
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
       WHEN (PCHX = 'CO');
         // copie
      /END-FREE
     C                   MOVEL     WTXT2         ZMODE
      // toutes les zones sont autorisées
      /FREE
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
         *IN17 = *OFF;
         *IN18 = *OFF;
       WHEN (PCHX = 'SU');
         // suppression
      /END-FREE
     C                   MOVEL     WTXT3         ZMODE
      // aucune zone n'est saisisable
      /FREE
       WHEN (PCHX = 'AF');
         // affichage
      /END-FREE
     C                   MOVEL     WTXT4         ZMODE
      // aucune zone n'est saisisable
      /FREE
       WHEN (PCHX = 'CR');
         // création
      /END-FREE
     C                   MOVEL     WTXT5         ZMODE
      // tout est saisisable sauf date de sortie
      /FREE
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
         *IN17 = *OFF;
       WHEN (PCHX = 'PE');
         // direction Ple Emploi
      /END-FREE
     C                   MOVEL     WTXT6         ZMODE
      // on saisit simplement la date de fin
      /FREE
         *IN18 = *OFF;
       ENDSL;
       // Initialisation de l'écran si on un numéro d'enregistrement
       IF PNREC <> *BLANK;
      /END-FREE
     C                   MOVE      PNREC         WNREC
      /FREE
         CHAIN(NE) WNREC FICF;
         *IN70 = NOT %ERROR AND NOT %FOUND;
         *IN90 = %ERROR;
         IF PCHX = 'CR' OR PCHX = 'CO';
           // en création ou copie zone non renseignée
      /END-FREE
     C                   Z-ADD     0             ZMATR
      /FREE
         ELSE;
      /END-FREE
     C                   Z-ADD     FIMAT         ZMATR
      /FREE
         ENDIF;
      /END-FREE
     C                   MOVEL     FIFON         ZFCOD
      // fichier des fonctions => libellé
      /FREE
         CHAIN(E) KEY002 FIFF;
         *IN70 = NOT %ERROR AND NOT %FOUND;
         *IN90 = %ERROR;
      /END-FREE
     C                   MOVEL     MILIB         ZFLIB
     C                   MOVEL     FINOM         ZNOM
     C                   MOVEL     FIPR1         ZPR1
     C                   MOVEL     FIPR2         ZPR2
     C                   MOVEL     FIAD1         ZAD1
     C                   MOVEL     FIAD2         ZAD2
     C                   MOVEL     FIAD3         ZAD3
     C                   MOVEL     FICPO         ZCPO
     C                   MOVEL     FIVIL         ZVIL
     C                   MOVEL     FITEL         ZTEL
     C                   MOVEL     FIPOR         ZPOR
      // traitement des dates
     C                   Z-ADD     FIDAE         WDATI
      /FREE
         EXSR INVDAT;
      /END-FREE
     C                   Z-ADD     WDATE         ZDAE
      /FREE
         IF PCHX = 'PE';
      /END-FREE
     C                   Z-ADD     ZDATE         ZDAS
      /FREE
         ELSE;
      /END-FREE
     C                   Z-ADD     FIDAS         WDATI
      /FREE
           EXSR INVDAT;
      /END-FREE
     C                   Z-ADD     WDATE         ZDAS
      /FREE
         ENDIF;
         // zones d'audit
      /END-FREE
     C                   Z-ADD     FIDAC         WDATI
      /FREE
         EXSR INVDAT;
      /END-FREE
     C                   Z-ADD     WDATE         ZDAC
     C                   Z-ADD     FIHEC         ZHEC
     C                   MOVEL     FIUSC         ZUSC
     C                   Z-ADD     FIDAM         WDATI
      /FREE
         EXSR INVDAT;
      /END-FREE
     C                   Z-ADD     WDATE         ZDAM
     C                   Z-ADD     FIHEM         ZHEM
     C                   MOVEL     FIUSM         ZUSM
      /FREE
       ELSE;
         // pas grand chose, la date du jour
      /END-FREE
     C                   MOVE      WDAT          ZDAE
      /FREE
       ENDIF;
       // Boucle d'attente de fin
       *IN50 = *ON;
       DOW *IN50 = '1';
         EXSR TRTSCR;
       ENDDO;
       //
       *INLR = *ON;
       // Les procédures
       BEGSR TRTSCR;
         WRITE WMGCTL;
         // On écrit l'écran
         WRITE FORE1;
         // On attend l'appui sur une touche
         READ FORE1;
         *IN70 = %EOF;
         *IN51 = *ON;
         // F3 ou F12 on termine
         IF *INKC = '1' OR
               *INKL = '1';
           *IN50 = *OFF;
           *IN51 = *OFF;
         ENDIF;
         // on met  jour l'heure
      /END-FREE
     C   51              TIME                    ZHEUR
     C   51*INKD         IFEQ      '1'
      // appui sur la touche F4
      /FREE
           IF WZOCUR = 'ZFCOD';
             PACT = 'GS';
      /END-FREE
     C                   CALL      'PGMI01'
     C                   PARM                    PACT
     C                   PARM                    PGFCT
      /FREE
             IF PGFCT <> *BLANK;
      /END-FREE
     C                   MOVEL     PGFCT         ZFCOD
      /FREE
             ENDIF;
           ENDIF;
           *IN51 = *OFF;
         ENDIF;
         //
         IF PCHX = 'SU';
           *IN51 = *OFF;
           IF *IN85 = '1';
             IF *INKP = '1';
               // touche F15 on supprime si indicateur *IN85
               CHAIN(E) WNREC FICF;
               *IN70 = NOT %ERROR AND NOT %FOUND;
               *IN90 = %ERROR;
      /END-FREE
     C  N70              DELETE    FICF
      /FREE
               *IN50 = *OFF;
               *IN51 = *OFF;
             ENDIF;
           ELSE;
      /END-FREE
     C                   MOVEL     'MSG0004'     PMGID
     C                   MOVEL     *BLANK        PMGDT
      /FREE
             EXSR ENVMSG;
             *IN85 = *ON;
           ENDIF;
         ENDIF;
         // contrle des données saisies
         IF *IN51 = '1';
           EXSR CTLDTA;
           IF *IN88 = '1';
             // anomalie
             EXSR ENVMSG;
             *IN88 = *OFF;
           ELSE;
             // confirmation  pour suppression
             EXSR VALID1;
           ENDIF;
         ENDIF;
       ENDSR;
       // controle des données/si suppression demande de confirmation
       BEGSR CTLDTA;
      /END-FREE
     C                   MOVE      '0'           *IN88
      // on vérifie que tout est bon
      /FREE
         IF PCHX = 'SU';
           // on demande confirmation
         ELSE;
           // vérification du code fonction
           CHAIN(E) KEY002 FIFF;
           *IN70 = NOT %ERROR AND NOT %FOUND;
           *IN90 = %ERROR;
           IF *IN70 = '1';
      /END-FREE
     C                   MOVE      '0'           *IN88
     C                   MOVEL     'MSG0003'     PMGID
      /FREE
             PMGDT = '&1'+ ZFCOD;
      /END-FREE
     C                   MOVE      '1'           *IN88
      /FREE
           ENDIF;
         ENDIF;
       ENDSR;
       //** Création suppression et MJ selon le cas
       BEGSR VALID1;
         IF PCHX = 'SU';
           // La suppression se fait par la touche F15
         ELSE;
           CHAIN(E) ZMATR FICF1;
           *IN71 = NOT %ERROR AND NOT %FOUND;
           *IN90 = %ERROR;
           IF PCHX = 'CR' OR PCHX = 'CO';
             // On ne crée le matricule qu'en copie ou création
      /END-FREE
     C                   MOVE      'MAT'         PCOD
     C                   MOVE      '2'           PCPT
     C                   CALL      'PGMC01'
     C                   PARM                    PCOD              3
     C                   PARM                    PCPT              1
     C                   PARM                    PCP1              6
     C                   PARM                    PMAT             10
     C                   MOVE      PMAT          FIMAT
      /FREE
             *IN71 = *ON;
           ENDIF;
      /END-FREE
     C                   MOVEL     ZFCOD         FIFON
     C                   MOVEL     ZNOM          FINOM
     C                   MOVEL     ZPR1          FIPR1
     C                   MOVEL     ZPR2          FIPR2
     C                   MOVEL     ZAD1          FIAD1
     C                   MOVEL     ZAD2          FIAD2
     C                   MOVEL     ZAD3          FIAD3
     C                   MOVEL     ZCPO          FICPO
     C                   MOVEL     ZVIL          FIVIL
     C                   MOVEL     ZTEL          FITEL
     C                   MOVEL     ZPOR          FIPOR
      // traitement des dates
     C                   Z-ADD     ZDAE          WDATE
      /FREE
           EXSR DATINV;
      /END-FREE
     C                   Z-ADD     WDATI         FIDAE
     C                   Z-ADD     ZDAS          WDATE
      /FREE
           EXSR DATINV;
      /END-FREE
     C                   Z-ADD     WDATI         FIDAS
      // zones d'audit
      /FREE
           EXSR DATHEU;
      /END-FREE
     C                   MOVE      WDAT          WDATE
      /FREE
           EXSR DATINV;
      /END-FREE
     C                   Z-ADD     WDATI         FIDAM
     C                   MOVE      WHEU          FIHEM
     C                   MOVEL     WUSER         FIUSM
      /FREE
           IF *IN71 = '0';
             // on met  jour directement
             UPDATE FICF1;
           ELSE;
             // création
      /END-FREE
     C                   Z-ADD     WDATI         FIDAC
     C                   MOVE      WHEU          FIHEC
     C                   MOVEL     WUSER         FIUSC
      /FREE
             WRITE FICF1;
           ENDIF;
         ENDIF;
         *IN50 = *OFF;
       ENDSR;
       // Traitements de la date
       BEGSR DATHEU;
      /END-FREE
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
      /FREE
       ENDSR;
       BEGSR INVDAT;
      /END-FREE
     C                   Z-ADD     WSSAI         WSSAE
     C                   Z-ADD     WMI           WME
     C                   Z-ADD     WJI           WJE
      /FREE
       ENDSR;
       BEGSR DATINV;
      /END-FREE
     C                   Z-ADD     WSSAE         WSSAI
     C                   Z-ADD     WME           WMI
     C                   Z-ADD     WJE           WJI
      /FREE
       ENDSR;
       //****Envoi d'un message programme
       BEGSR ENVMSG;
      /END-FREE
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFICM            10
     C                   PARM                    PMGID             7
     C                   PARM                    PMGDT            99
      /FREE
       ENDSR;
      /END-FREE
