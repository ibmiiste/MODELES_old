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

       //External procedure Prototypes
       Dcl-pr compteur_double Extpgm('PGMC01');
         PCOD Char(3);
         PCPT Char(1);
         PCP1 Char(6);
         PMAT Char(10);
       End-Pr;

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

      // début du programme
       ZPGM=WNMPGM;
       ZDATE=%DATE();
       ZHEUR=%TIME();
       ZUSER=WUSER;
       ZJOB=WJOB;
       WPGMQ='*  ';
       WMGKEY='CC01';

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
       PTYP='1';
       PFICM='FICMSG    ';

       SELECT;
       WHEN (PCHX = 'MO');
         // modification
         ZMODE=WTXT1;
      // on ne peut modifier que ces zones
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
       WHEN (PCHX = 'CO');
         // copie
         ZMODE=WTXT2;
       // toutes les zones sont autorisées
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
         *IN17 = *OFF;
         *IN18 = *OFF;
       WHEN (PCHX = 'SU');
         // suppression
         ZMODE=WTXT3;
       // aucune zone n'est saisisable
       WHEN (PCHX = 'AF');
         // affichage
         ZMODE=WTXT4;
      // aucune zone n'est saisisable
       WHEN (PCHX = 'CR');
         // création
         ZMODE=WTXT5;
      // tout est saisisable sauf date de sortie
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
         *IN17 = *OFF;
       WHEN (PCHX = 'PE');
         // direction Ple Emploi
         ZMODE=WTXT6;
         // on saisit simplement la date de fin
         *IN18 = *OFF;
       ENDSL;
       // Initialisation de l'écran si on un numéro d'enregistrement
       IF PNREC <> *BLANK;
         WNREC=%Dec(PNREC);
         CHAIN(NE) WNREC FICF;
         *IN70 = NOT %ERROR AND NOT %FOUND;
         *IN90 = %ERROR;
         IF PCHX = 'CR' OR PCHX = 'CO';
           // en création ou copie zone non renseignée
           ZMATR=0;
         ELSE;
           ZMATR=FIMAT;
         ENDIF;

         ZFCOD=FIFON;
      // fichier des fonctions => libellé
         CHAIN(E) ZFCOD FIFF;
         *IN70 = NOT %ERROR AND NOT %FOUND;
         *IN90 = %ERROR;
         ZFLIB=MILIB;
         ZNOM=FINOM ;
         ZPR1=FIPR1;
         ZPR2=FIPR2;
         ZAD1=FIAD1;
         ZAD2=FIAD2;
         ZAD3=FIAD3;
         ZCPO=FICPO;
         ZVIL=FIVIL;
         ZTEL=FITEL;
         ZPOR=FIPOR;
         ZDAE=FIDAE;

        IF PCHX = 'PE';
          ZDATE=ZDAS;
        ELSE;
          ZDAS=FIDAS;
        ENDIF;
        // zones d'audit
        ZDAC=FIDAC;
        ZHEC=FIHEC;
        ZUSC=FIUSC;
        ZDAM=FIDAM;
        ZHEM=FIHEM;
        ZUSM=FIUSM;
       ELSE;
         // pas grand chose, la date du jour
         ZDAE=%Date();
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
         If *In51;
           ZHEUR=%Time();
           If *Inkd;
             IF WZOCUR = 'ZFCOD';
               PACT = 'GS';
             Endif;
             Invite_fonction( PACT
                             :PGFCT);
             IF PGFCT <> *BLANK;

               ZFCOD =PGFCT;

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
               If Not *IN70;
                 DELETE FICF;
               Endif;
               *IN50 = *OFF;
               *IN51 = *OFF;
             ENDIF;
           ELSE;
             PMGID='MSG0004';
             PMGDT=*BLANK;
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
         *IN88=*Off;
         // on vérifie que tout est bon
         IF PCHX = 'SU';
           // on demande confirmation
         ELSE;
           // vérification du code fonction
           CHAIN(E) ZFCOD FIFF;
           *IN70 = NOT %ERROR AND NOT %FOUND;
           *IN90 = %ERROR;
           IF *IN70 = '1';
             *IN88=*Off;
             PMGID='MSG0003' ;
             PMGDT = '&1'+ ZFCOD;
             *IN88=*Off;
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
             PCOD='MAT';
             PCPT='2';
             compteur_double( PCOD
                             :PCPT
                             :PCP1
                             :PMAT);
             FIMAT=%Int(PMAT);
             *IN71 = *ON;
           ENDIF;

           FIFON=ZFCOD;
           FINOM=ZNOM;
           FIPR1=ZPR1;
           FIPR2=ZPR2;
           FIAD1=ZAD1;
           FIAD2=ZAD2;
           FIAD3=ZAD3;
           FICPO=ZCPO;
           FIVIL=ZVIL;
           FITEL=ZTEL;
           FIPOR=ZPOR;
           // traitement des dates
           FIDAE=ZDAE;

           FIDAS=ZDAS;

          // zones d'audit
          FIDAM=%Date();
          FIHEM=%Time();
          FIUSM=WUSER;
          IF *IN71 = '0';
            // on met  jour directement
            UPDATE FICF1;
          ELSE;
             // création
            FIDAC=%Date();
            FIHEC=%Time();
            FIUSC=WUSER;
            WRITE FICF1;
           ENDIF;
         ENDIF;
         *IN50 = *OFF;
       ENDSR;

       //****Envoi d'un message programme
       BEGSR ENVMSG;
         Gestion_message( PTYP
                         :PFICM
                         :PMGID
                         :PMGDT);
       ENDSR;
