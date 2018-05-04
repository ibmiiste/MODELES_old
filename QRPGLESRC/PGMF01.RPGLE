       ctl-opt debug decedit('0,') datedit(*dmy.);
      //*********************************************************************
      // CC 01/01/2009
      // Liste du personnel
      //*********************************************************************
      // Déclaration des fichiers
       dcl-f PGMF01FM workstn sfile(sfl01 :wran01) infds(dssfl1) indds(IndDs);
       dcl-f FIC02L keyed infds(fic);


      // Déclaration des variables
       dcl-s WDAT char(8);
       dcl-s WHEU char(6);
       dcl-s W14 packed(14);
       dcl-s WSNOM char(35);
       dcl-s WSNOP char(35);
       dcl-s I packed(3);
       Dcl-s g_Nblis1 Packed(4:0);

       // Gestion des messages
       Dcl-s PTYP Char(1);
       Dcl-s PFIM Char(10);
       Dcl-s PMID Char(7);
       Dcl-s PMDT Char(99);

      // La DS du programme, noter le S indispensable
       /copy qcpysrc,Psds

      // La DS du sous=fichier
       Dcl-ds DSSFL1;
        WPOSC int(5) pos(370);
        WRRNG int(5) pos(376);
        WRNGP int(5) pos(378);
        WNBRSF int(5) pos(380);
       end-ds;

      // Le DS des indicateurs de l'écran
       dcl-ds IndDs;
        Rollup Ind Pos(2);
        Sflnxtchg Ind Pos(8);
        Zoptpr Ind Pos(20);
        Znomred Ind Pos(30);
        Sflend Ind Pos(7);
        Sfldsp Ind Pos(4);
        Sfldspctl Ind Pos(5);
        Sflclr Ind Pos(6);
        Sflend_no_rollup Ind Pos(7);
        Sflinz_Msgf Ind Pos(10);
        Sflend_Msgf Ind Pos(09);
       End-ds;

      // La DS du fichier
       dcl-ds FIC;
        WNRC01 int(10) pos(397);
       end-ds;


       dcl-ds WDSFIC;
        WCDFIL char(8) pos(1);
        WOPENF char(1) pos(9);
        WSTSFI zoned(5) pos(11);
        WOPCOD char(6) pos(16);
        WRPGSQ char(8) pos(30);
        WRPGNR char(8) pos(38);
        WERRFI char(7) pos(46);
        WNFICH char(10) pos(83);
        WNLIBR char(10) pos(93);
        WSPNAM char(10) pos(103);
        WSPLIB char(10) pos(113);
        WSPNUM int(5) pos(123);
        WLIMBR char(10) pos(129);
        WNBPUT int(10) pos(243);
        WNBGET int(10) pos(247);
        WNBPG int(10) pos(251);
        WNBIO int(10) pos(255);
        WRCDFT char(10) pos(261);
        WNBRCD int(10) pos(283);
        WNRCFI int(10) pos(397);
       end-ds;
      // la clé d'accés au fichier

       Dcl-ds Key likerec(FICF : *key);

       // le nombre de lignes afichables, déclaration a la volée
       g_Nblis1 = 14;
       // initialisation des variables système affichées à l'écran
       Zpgm = Procedure;
       Zdate=%char(%Date());
       Zheur=%char(%Time());
       Zjob=Job_name;

       // Initialisation du sous=fichier des messages
       WPGMQ='*  ';
       WMGKEY='CC01';

       Sflend_Msgf = *ON;
       Sflinz_Msgf = *ON;
       // Indicateur fin
       g_Sortie = *ON;
       // Debut du traitement,
       EXSR INITSF;
       // Boucle d'attente de sortie
       DOW g_Sortie = '1';
         EXSR TRTSFL;
       ENDDO;
       // Indicateur de fin de programme
       *INLR = *ON;
       // Les procédures
       // Traitement de l'écran
       BEGSR TRTSFL;
         // Effacement du sous=fichier de messages
         PTYP = '3';
         PFIM = *Blank;
         PMID = *Blank;
         Gestion_message( PTYP
                         :PFIM
                         :PMID
                         :PMDT);

         WRITE WSFCTL;
         // Ecriture de l'écran
         Sfldsp = *ON;
         Sfldspctl = *ON;
         WRITE FORE1;

         WRITE FORB1;
         // Attente lecture
         READ FORE1;

         // Une touche a été actionnée
         // Chargement de l'heure
         ZHEUR=%TIME();

      // Indicateur pour ne pas tester d'autres actions
         g_Fin_actions = *ON;
         IF Rollup = '1';
           // page suivante
           EXSR CHGPAG;
           g_Fin_actions = *OFF;
         ENDIF;
         //
         IF WSNOP <> ZSNOM And g_Fin_actions;
      // Test si selection/ si changé on initialise
           EXSR INITSF;
           g_Fin_actions = *OFF;
         ENDIF;
         // touches F3 et F12
         IF *INKC = '1' OR
               *INKL = '1';
           // on met l'indicateur à Off = fin du programme
           g_Sortie = *OFF;
           g_Fin_actions = *OFF;
         ENDIF;
         //
         IF *INKE = '1';
           // F5 Rafraichissement de l'écran
           EXSR INITSF;
           g_Fin_actions = *OFF;
         ENDIF;
         //
         IF *INKF = '1';
           // F6 création d'un nouveau matricule
     C                   MOVEL     'CR'          PCHX
     C                   MOVEL     *BLANK        NREC
     C                   CALL      'PGMF02'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
           EXSR INITSF;
           g_Fin_actions = *OFF;
         ENDIF;
         IF *INKH = '1';
           // F8 impression du fichier
     C                   MOVEL     *BLANK        PMAT
      // On appelle le CL de routage sans soumission, sinon PGMF20CL
     C                   CALL      'PGMF2SCL'
     C                   PARM                    PMAT             10
           g_Fin_actions = *OFF;
         ENDIF;
         // On ne fait ceci que s'il n'y a eu rien d'autre
         IF g_Fin_actions = '1';
           EXSR TRTOPT;
         ENDIF;
         // On recommence la boucle d'attente
       ENDSR;
       // Initialisation du sous-fichier
       BEGSR INITSF;
         //    l'indicateur 20 conditionne la zone OPT (protection)
         Zoptpr = *OFF;
         // Initialisation de la variable de sélection
     C                   MOVEL     ZSNOM         WSNOP
     C                   MOVEL     *BLANK        WSNOM
      // Initialisation de la clé pour positionnement
     C                   MOVEL     *BLANK        FIFON
     C                   MOVEL     *BLANK        FINOM
         g_Selection = *OFF;
         g_Selection_generique = *OFF;
         IF ZSNOM <> *BLANK;
           // Si différent de blank il y a selection
           g_Selection = *ON;
     C                   Z-ADD     0             I
     C     '*'           SCAN      ZSNOM         I                      85
           IF I > 0;
     C     I             SUB       1             I
     C     I             SUBST (P) ZSNOM:1       WSNOM                  90
      // On est dans le cas d'une sélection générique
             g_Selection_generique = *ON;
             // On se positionnera juste au bon endroit dans le fichier
     C                   MOVEL     WSNOM         FINOM
           ENDIF;
         ENDIF;
         // La dernière ligne écrite
     C                   Z-ADD     0             LSTLIG            4 0
      // Le compteur de ligne par page
     C                   Z-ADD     0             NBRLIG            4 0
      // Le fameux WRAN01
     C                   Z-ADD     0             WRAN01            4 0
      // Effacement du sous=fichier
         Sflclr = *ON;
         Sflend_no_rollup = *ON;
         Sfldsp = *OFF;
         Sfldspctl = *OFF;
         WRITE FORE1;
         Sflclr = *OFF;
         Sfldsp = *ON;
         Sfldspctl = *ON;
         // Positionnement en début de fichier
         SETLL KEY001 FICF;
         *IN70 = %EQUAL;
         // Chargement de la première page
         EXSR CHGPAG;
       ENDSR;
       // Traitement des options, on ne lit que les enregistrements modifiés
       BEGSR TRTOPT;
         // Lecture des enregistrements modifiés
     C                   Z-ADD     1             WRAN01
      // Top pour rafraichir l'écran, si besoin
         g_Selection_OK = *OFF;

         If %Found;
           READC SFL01;
         EndIf;
      //
         DOW not %Eof;
     C                   MOVE      HNREC         NREC
           IF HTOUT = '1';
             IF ZOPT='2' OR ZOPT='3' OR ZOPT='4' OR ZOPT='99';
               // Si l'employé à quitté on ne peut plus rien modifier
     C                   MOVE      '5 '          ZOPT
             ENDIF;
           ENDIF;
           g_Selection_generique = *ON;
           // Selection en fonction du choix saisi
           SELECT;
           WHEN (ZOPT = '2') OR (ZOPT = ' 2');
     C                   MOVEL     'MO'          PCHX
           WHEN (ZOPT = '3') OR (ZOPT = ' 3');
     C                   MOVEL     'CO'          PCHX
           WHEN (ZOPT = '4') OR (ZOPT = ' 4');
     C                   MOVEL     'SU'          PCHX
           WHEN (ZOPT = '5') OR (ZOPT = ' 5');
     C                   MOVEL     'AF'          PCHX
           WHEN (ZOPT = '6') OR (ZOPT = ' 6');
     C                   MOVE      HMATR         PMAT
     C                   CALL      'PGMF2SCL'
     C                   PARM                    PMAT             10
             g_Selection_generique = *OFF;
           WHEN (ZOPT = '99');
     C                   MOVEL     'PE'          PCHX
           OTHER;
             // La saisie ne correspond à rien
             g_Selection_generique = *OFF;
             // Envoyer un message pour dire que l'option n'existe pas
     C                   MOVEL     '1'           PTYP
     C                   MOVEL     'FICMSG   '   PFIM
     C                   MOVEL     'MSG0002'     PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
           ENDSL;
           IF HTOUT = '0';
             // Pour ne pas perdre l'attribut couleur
             Znomred = *OFF;
           ELSE;
             Znomred = *ON;
           ENDIF;
           // Nettoyage
     C                   MOVEL     *BLANK        ZOPT
           UPDATE(E) SFL01;
           *IN90 = %ERROR;
           // On aurait pu aussi faire IF..., en tout cas le choix est bon
     C   85              CALL      'PGMF02'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
     C   85              SETON                                        86
      // On continue de boucler si autre option
           READC(E) SFL01;
           *IN70 = %ERROR OR %EOF;
         ENDDO;
         // Potentiellement il y a eu mise à jour, on pourrait affiner
     C   86              EXSR      INITSF
       ENDSR;
       // Chargement d'une page
       BEGSR CHGPAG;
         // Il faut positionner correctement les indicateurs et les variables
         Sflnxtchg = *OFF;
         //                  SETON                                        04
     C                   Z-ADD     LSTLIG        WRAN01
      // Lexture de l'enregistrement suivant
         READ FICF;
         *IN70 = %EOF;
         // Remise à zéro du compteur de ligne, mais on pourrait faire autrement
     C                   Z-ADD     0             NBRLIG            4 0
      //
         DOW *IN70 = '0'
         AND NBRLIG < 14;
           // Remplissage des zones écran
           g_Selection_OK = *ON;
           // Test s'il y a selection
           IF g_Selection = '1' OR g_Selection_generique = '1';
             IF g_Selection = '1' AND g_Selection_generique = '0';
               // On recherche la stricte égalité de nom
               IF FINOM <> ZSNOM;
                 g_Selection_OK = *OFF;
               ENDIF;
             ELSE;
               // On recherche si le nom commence par la valeur avant le '*'
     C     I             SUBST (P) FINOM:1       WXNOM            35    90
      // Petite entorse de flemmard WXNOM est déclarée au fil de l'eau
               IF WXNOM <> WSNOM;
                 g_Selection_OK = *OFF;
               ENDIF;
             ENDIF;
           ENDIF;
           // L'indicateur est à '1' si sélection OK ou pas de sélection
           IF g_Selection_OK;
     C                   MOVEL     FINOM         ZNOM
     C                   MOVEL     FIPR1         ZPR1
     C                   MOVEL     FIFON         ZFONC
     C                   Z-ADD     FIMAT         ZMATR
     C                   MOVEL     FICPO         ZCPO
     C                   MOVEL     FIC           WDSFIC
     C                   Z-ADD     WNRCFI        HNREC
     C                   MOVE      FIMAT         HMATR
             IF FIDAS = 0;
               // Top salarié licencié
     C                   MOVE      '0'           HTOUT
               Znomred = *OFF;
             ELSE;
     C                   MOVE      '1'           HTOUT
               Znomred = *ON;
             ENDIF;
             // Les compteurs, attention au WRAN01
     C                   ADD       1             NBRLIG
     C                   ADD       1             LSTLIG
     C                   ADD       1             WRAN01
      // Ecriture de la ligne
             WRITE SFL01;
           ENDIF;
           // Lecture du suivant
           READ FICF;
           *IN70 = %EOF;
         ENDDO;
         // On quitte la boucle soit en fin de page
         //                     soit en fin de fichier
         IF *IN70 = '1';
           // Le caractère de suite, on est en fin de fichier
           Sflend_no_rollup = *ON;
         ELSE;
           Sflend_no_rollup = *OFF;
         ENDIF;
         // Si le fichier est vide
         IF WRAN01 = 0;
     C                   Z-ADD     1             NBRLIG
     C                   Z-ADD     1             LSTLIG            4 0
      // Un petit message
     C                   Z-ADD     1             WRAN01
      // Pas de saisie d'option
           Zoptpr = *ON;
           IF ZSNOM = *BLANK;
             // Si on a un vieil AS400 du siècle dernier
     C                   MOVEL     'Fic. Vide'   ZNOM
           ELSE;
             // En RPG ILE
             ZNOM = 'Sélection Vide';
           ENDIF;
           // Ne pas oublier de remettre à blanc
     C                   MOVEL     *BLANK        ZPR1
     C                   MOVEL     *BLANK        ZFONC
     C                   Z-ADD     0             ZMATR
     C                   MOVEL     *BLANK        ZCPO
     C                   MOVEL     *BLANK        WDSFIC
     C                   Z-ADD     0             HNREC
      // Ecriture du message sur la première ligne
           WRITE SFL01;
         ENDIF;
         // le WRAN01 à 1 pour afficher le premier enregistrement
         //                  Z-ADD     LSTLIG        WRAN01
       ENDSR;
