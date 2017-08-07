**free
ctl-opt DEBUG DECEDIT('0,') DATEDIT(*DMY.);
//****************************************************
//                                                   *
// Liste fonction                                    *
//                                                   *
//****************************************************
dcl-F PGMF10FM WORKSTN SFILE(SFL01 :WRAN01)INFDS(WDSFL1) ;
Dcl-FFIF01L INFDS(WDSFIF);
Dcl-FFIC02L *keyed;
Dcl-s W14 packed(14:0);
Dcl-S WDAT char(8);
Dcl-S WHEU char(6);
Dcl-S POPT char(2);
Dcl-S W8 char(8);
Dcl-S WHS time;
Dcl-S PNREC char(10);
Dcl-dS WS;
  WS char(4);
  WMA char(2);
  WJA char(2);
  WHA char(2);
  WIA char(2);
  WKA char(2);
  WMU char(6);
  WASTA char(26);
end-ds;

Dcl-ds WDSPGM SDS;
  WLIPGM                   1     10
  WSTATU                  11     15  0
  WSTPRE                  16     20  0
  WSRCSQ                  21     28
  WNMROU                  29     36
  WNBPAR                  37     39  0
  WTYEXC                  40     42
  WLICPF                  40     46
  WNUEXC                  43     46
  WMIODT                  47     50
  WZOMES                  51     80
  WBIPGM                  81     90
  WRTDTA                  91    170
  WCOERR                 171    174
  WDERFI                 201    208
  WFIINF                 209    243
  WJOB                   244    253
  WUSER                  254    263
  WJBNUM                 264    269  0
WDSFL1           DS
  WPOSC                  370    371B 0
  WRRNG                  376    377B 0
  WRNGP                  378    379B 0
  WNBRSF                 380    381B 0
  WLIGCF                 382    383B 0
  WRCMIE                 403    404B 0
  WDSFIF           DS
  WNRC01                 397    400B 0
  WDSFI1           DS
  WCDFIL                   1      8
  WOPNF                    9      9
  WSTFIL                  11     15  0
  WOPCOD                  16     21
  WRPGSQ                  30     37
  WRPGNR                  38     45
  WERRFI                  46     52
  WNMFIC                  83     92
  WNMBIB                  93    102
  WSPNOM                 103    112
  WSPLIB                 113    122
  WSPNBR                 123    124B 0
  WLIMBR                 129    138
  WNBPUT                 243    246B 0
  WNBGET                 247    250B 0
  WNBPG                  251    254B 0
  WNBIO                  255    258B 0
  WRCDFT                 261    270
  WNBRCD                 283    286B 0
  WNRCFI                 397    400B 0
     C     SKKCL1        KLIST
     C                   KFLD                    MIFON
     C     KKCL01        KLIST
     C                   KFLD                    MIFON
      // initialisations générales
      /FREE
       *IN09 = *ON;
       *IN10 = *ON;
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
       // Indicateur fin
       *IN50 = *ON;
       // Debut du traitement,
       EXSR INITSF;
       // Boucle d'attente de sortie
       DOW *IN50 = '1';
         EXSR TRTSFL;
       ENDDO;
       *INLR = *ON;
       // traitement de l'écran
       BEGSR TRTSFL;
         //
      /END-FREE
     C                   MOVEL     '3'           PTYP
     C                   MOVEL     *BLANK        PFIM
     C                   MOVEL     *BLANK        PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
      /FREE
         WRITE WSFCTL;
         *IN04 = *ON;
         *IN05 = *ON;
         WRITE FORE1;
         *IN70 = %EOF;
         WRITE FORB1;
         // attente lecture
         READ FORE1;
         *IN70 = %EOF;
         // chargement de l'heure
      /END-FREE
     C                   TIME                    ZHEUR
      //
      /FREE
         *IN51 = *ON;
         IF *IN02 = '1';
           // page suivante
           EXSR CHGPAG;
           *IN51 = *OFF;
         ENDIF;
         //
         // touches F3 et F12
         IF *INKC = '1' OR
               *INKL = '1';
           // on met l'indicateur à Off
           *IN50 = *OFF;
           *IN51 = *OFF;
         ENDIF;
         //
         IF *INKE = '1';
           // F5 Rafraichissement de l'écran
           EXSR INITSF;
           *IN51 = *OFF;
         ENDIF;
         //
         IF *INKF = '1';
           // F6 création d'une nouvelle fonction
      /END-FREE
     C                   MOVEL     'CR'          PCHX
     C                   MOVEL     *BLANK        NREC
     C                   CALL      'PGMF11'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
      /FREE
           EXSR INITSF;
           *IN51 = *OFF;
         ENDIF;
         //
         IF *IN51 = '1';
           EXSR TRTOPT;
         ENDIF;
         // on recommence la boucle d'attente
       ENDSR;
       // Les Sub Routines
       //****************************************
       //  Initialisation du sous-fichier
       //****************************************
       BEGSR INITSF;
         //    l'indicateur 20 conditionne la zone OPT (protection)
         *IN20 = *OFF;
         //    dernière ligne écrite
      /END-FREE
     C                   Z-ADD     0             LSTLIG            4 0
      //    compteur de ligne par page
     C                   Z-ADD     0             NBRLIG            4 0
      //    la fameux WRAN01
     C                   Z-ADD     0             WRAN01            4 0
      /FREE
         *IN06 = *ON;
         *IN07 = *ON;
         *IN04 = *OFF;
         *IN05 = *OFF;
         WRITE FORE1;
         *IN06 = *OFF;
         *IN04 = *ON;
         *IN05 = *ON;
         EXSR CHGPAG;
         //
       ENDSR;
       //*****************************
       BEGSR TRTOPT;
         //  Lecture des enregistrements modifiés
      /END-FREE
     C                   Z-ADD     1             WRAN01
      // top pour rafraichir l'écran
      /FREE
         *IN86 = *OFF;
      /END-FREE
     C  N70              READC     SFL01                                7070
      //
      /FREE
         DOW *IN70 = '0';
      /END-FREE
     C                   MOVE      HNREC         NREC
      /FREE
           *IN85 = *ON;
           SELECT;
           WHEN (ZOPT = ' ');
             *IN85 = *OFF;
           WHEN (ZOPT = '2');
      /END-FREE
     C                   MOVEL     'MO'          PCHX
      /FREE
           WHEN (ZOPT = '3');
      /END-FREE
     C                   MOVEL     'CO'          PCHX
      /FREE
           WHEN (ZOPT = '4');
      /END-FREE
     C                   MOVEL     'SU'          PCHX
      /FREE
           WHEN (ZOPT = '5');
      /END-FREE
     C                   MOVEL     'AF'          PCHX
      /FREE
           OTHER;
             *IN85 = *OFF;
             // envoyer un message pour dire que l'option n'existe pas
      /END-FREE
     C                   MOVEL     '1'           PTYP
     C                   MOVEL     'FICMSG   '   PFIM
     C                   MOVEL     'MSG0002'     PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
      /FREE
           ENDSL;
      /END-FREE
     C                   MOVEL     *BLANK        ZOPT
      /FREE
           UPDATE(E) SFL01;
           *IN90 = %ERROR;
           // on aurait pu aussi faire IF ....
      /END-FREE
     C   85              CALL      'PGMF11'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
     C   85              SETON                                        86
      /FREE
           READC(E) SFL01;
           *IN70 = %ERROR OR %EOF;
         ENDDO;
      /END-FREE
     C   86              EXSR      INITSF
      /FREE
       ENDSR;
       //************************************
       BEGSR CHGPAG;
         //  chargement de la page
         *IN08 = *OFF;
         //                  SETON                                        04
      /END-FREE
     C                   Z-ADD     LSTLIG        WRAN01
      /FREE
         SETLL *LOVAL FIFF;
         *IN70 = %EQUAL;
         READ FIFF;
         *IN70 = %EOF;
      /END-FREE
     C                   Z-ADD     0             NBRLIG            4 0
      //
      /FREE
         DOW *IN70 = '0'
         AND NBRLIG < 15;
           // remplissage des zones écran
      /END-FREE
     C                   MOVEL     MIFON         ZCOD
      // on tronque à l'affichage
     C                   MOVEL     MILIB         ZLIB
      // conversion de la date
      /FREE
           TEST(ZE) MITSC;
           *IN90 = %ERROR;
           IF *IN90 = '1';
      /END-FREE
     C                   MOVEL     *LOVAL        WHS
      /FREE
           ELSE;
      /END-FREE
     C                   MOVEL     MITSC         WHS
      /FREE
           ENDIF;
           EXSR CVTDAT;
      /END-FREE
     C                   MOVE      W8            ZDAC
      /FREE
           TEST(ZE) MITSM;
           *IN90 = %ERROR;
           IF *IN90 = '1';
      /END-FREE
     C                   MOVEL     *LOVAL        WHS
      /FREE
           ELSE;
      /END-FREE
     C                   MOVEL     MITSM         WHS
      /FREE
           ENDIF;
           EXSR CVTDAT;
      /END-FREE
     C                   MOVE      W8            ZDAM
      // la on met une petite complication qui ralentit fortement le traitement
     C                   Z-ADD     0             ZNBEM
      /FREE
           CHAIN(E) KKCL01 FICF;
           *IN71 = NOT %ERROR AND NOT %FOUND;
           *IN90 = %ERROR;
           // la clé est la code fonction lu dans le fichier des codes
           DOW *IN71 = '0';
             // lecture de tous les employés ayant le même code
      /END-FREE
     C     ZNBEM         ADD       1             ZNBEM
      /FREE
             READE(E) KKCL01 FICF;
             *IN90 = %ERROR;
             *IN71 = %EOF;
           ENDDO;
           // pour récupérer le numéro d'enregistrement
      /END-FREE
     C                   MOVEL     WDSFIF        WDSFI1
     C                   Z-ADD     WNRCFI        HNREC
     C                   ADD       1             NBRLIG
     C                   ADD       1             WRAN01
     C                   ADD       1             LSTLIG            4 0
      /FREE
           WRITE SFL01;
           // lecture du suivant
           READ FIFF;
           *IN70 = %EOF;
         ENDDO;
         // on quitte la boucle soit en fin de page
         //                     soit en fin de fichier
         IF *IN70 = '1';
           // le caractère de suite
           *IN07 = *ON;
         ENDIF;
         // si le fichier est vide
         IF WRAN01 = 0;
      /END-FREE
     C                   Z-ADD     1             NBRLIG
     C                   Z-ADD     1             LSTLIG            4 0
      // un petit message
     C                   Z-ADD     1             WRAN01
      // pas de saisie d'option
      /FREE
           *IN20 = *ON;
           ZLIB = 'Sélection Vide   ';
      /END-FREE
     C                   MOVEL     *BLANK        ZCOD
     C                   Z-ADD     0             HNREC
      /FREE
           WRITE SFL01;
         ENDIF;
         // le WRAN01 à 1 pour afficher le premier enregistrement
      /END-FREE
     C                   Z-ADD     1             WRAN01
      /FREE
       ENDSR;
       // chargement de la date et heure système
       BEGSR DATHEU;
      /END-FREE
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
      /FREE
       ENDSR;
       // conversion de la date
       BEGSR CVTDAT;
      /END-FREE
     C                   MOVEL     WHS           WASTA
      // la DS découpe les valeurs que l'on concatène
      /FREE
         W8 = WJA+ WMA+ WSA;
         // il ne reste plus qu'a charger dans la zone écran
       ENDSR;
      /END-FREE
