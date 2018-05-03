     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F**********************************************************************
     F* CC 01/01/2009
     F* Liste du personnel
     F**********************************************************************
     F* Déclaration des fichiers
     FPGMF01FM  CF   E             WORKSTN
     F                                     SFILE(SFL01 :WRAN01)
     F                                     INFDS(DSSFL1)
     FFIC02L    IF   E           K DISK
     F                                     INFDS(FIC)
     F* Déclaration des variables
     DWDAT             S              8
     DWHEU             S              6
     DW14              S             14  0
     DWSNOM            S             35
     DWSNOP            S             35
     DI                S              3  0
     D* La DS du programme, noter le S indispensable
     DDSPROG          SDS
     DWNPROG                   1     10
     DWSTATP                  11     15  0
     DWSTAPR                  16     20  0
     DWSQSRC                  21     28
     DWSBROU                  29     36
     DWNPARM                  37     39  0
     DWTYEXC                  40     42
     DWNMSGM                  40     46
     DWNMEXC                  43     46
     DWINSMC                  47     50
     DWZOMSG                  51     80
     DWLBPGM                  81     90
     DWSFDTA                  91    170
     DWCDERR                 171    174
     DWLSFIL                 201    208
     DWLSINF                 209    243
     DWJOB                   244    253
     DWUSER                  254    263
     DWNJOB                  264    269  0
     D* La DS du sous=fichier
     DDSSFL1           DS
     DWPOSC                  370    371B 0
     DWRRNG                  376    377B 0
     DWRNGP                  378    379B 0
     DWNBRSF                 380    381B 0
     D* La DS du fichier
     DFIC              DS
     DWNRC01                 397    400B 0
     DWDSFIC           DS
     DWCDFIL                   1      8
     DWOPENF                   9      9
     DWSTSFI                  11     15  0
     DWOPCOD                  16     21
     DWRPGSQ                  30     37
     DWRPGNR                  38     45
     DWERRFI                  46     52
     DWNFICH                  83     92
     DWNLIBR                  93    102
     DWSPNAM                 103    112
     DWSPLIB                 113    122
     DWSPNUM                 123    124B 0
     DWLIMBR                 129    138
     DWNBPUT                 243    246B 0
     DWNBGET                 247    250B 0
     DWNBPG                  251    254B 0
     DWNBIO                  255    258B 0
     DWRCDFT                 261    270
     DWNBRCD                 283    286B 0
     DWNRCFI                 397    400B 0
     C* la clé d'accés au fichier
     C     KEY001        KLIST
     C                   KFLD                    FIFON
     C                   KFLD                    FINOM
     C* le nombre de lignes afichables, déclaration a la volée
     C                   Z-ADD     14            NBLIS1            4 0
     C* initialisation des variables générales
     C                   MOVEL     WNPROG        ZPGM
     C                   EXSR      DATHEU
     C                   MOVE      WDAT          ZDATE
     C                   MOVE      WHEU          ZHEUR
     C                   MOVEL     WUSER         ZUSER
     C                   MOVEL     WJOB          ZJOB
     C* Initialisation du sous=fichier des messages
     C                   MOVEL     '*  '         WPGMQ
     C                   MOVEL     'CC01'        WMGKEY
     C                   SETON                                        0910
     C* Indicateur fin
     C                   SETON                                        50
     C* Debut du traitement,
     C                   EXSR      INITSF
     C* Boucle d'attente de sortie
     C                   DOW       *IN50 = '1'
     C                   EXSR      TRTSFL
     C                   END
     C* Indicateur de fin de programme
     C                   SETON                                        LR
     C* Les procédures
     C* Traitement de l'écran
     C     TRTSFL        BEGSR
     C* Effacement du sous=fichier de messages
     C                   MOVEL     '3'           PTYP
     C                   MOVEL     *BLANK        PFIM
     C                   MOVEL     *BLANK        PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
     C                   WRITE     WSFCTL
     C* Ecriture de l'écran
     C                   SETON                                        0405
     C                   WRITE     FORE1                                  70
     C                   WRITE     FORB1
     C* Attente lecture
     C                   READ      FORE1                                  70
     C* Une touche a été actionnée
     C* Chargement de l'heure
     C                   TIME                    ZHEUR
     C* Indicateur pour ne pas tester d'autres actions
     C                   SETON                                        51
     C                   IF        *IN02 = '1'
     C* page suivante
     C                   EXSR      CHGPAG
     C                   SETOFF                                       51
     C                   END
     C*
     C   51              IF        WSNOP <> ZSNOM
     C* Test si selection/ si changé on initialise
     C                   EXSR      INITSF
     C                   SETOFF                                       51
     C                   END
     C* touches F3 et F12
     C                   IF        *INKC = '1' OR
     C                             *INKL = '1'
     C* on met l'indicateur à Off = fin du programme
     C                   SETOFF                                       5051
     C                   END
     C*
     C                   IF        *INKE = '1'
     C* F5 Rafraichissement de l'écran
     C                   EXSR      INITSF
     C                   SETOFF                                       51
     C                   END
     C*
     C                   IF        *INKF = '1'
     C* F6 création d'un nouveau matricule
     C                   MOVEL     'CR'          PCHX
     C                   MOVEL     *BLANK        NREC
     C                   CALL      'PGMF02'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
     C                   EXSR      INITSF
     C                   SETOFF                                       51
     C                   END
     C                   IF        *INKH = '1'
     C* F8 impression du fichier
     C                   MOVEL     *BLANK        PMAT
     C* On appelle le CL de routage sans soumission, sinon PGMF20CL
     C                   CALL      'PGMF2SCL'
     C                   PARM                    PMAT             10
     C                   SETOFF                                       51
     C                   END
     C* On ne fait ceci que s'il n'y a eu rien d'autre
     C                   IF        *IN51 = '1'
     C                   EXSR      TRTOPT
     C                   END
     C* On recommence la boucle d'attente
     C                   ENDSR
     C* Initialisation du sous-fichier
     C     INITSF        BEGSR
     C*    l'indicateur 20 conditionne la zone OPT (protection)
     C                   SETOFF                                       20
     C* Initialisation de la variable de sélection
     C                   MOVEL     ZSNOM         WSNOP
     C                   MOVEL     *BLANK        WSNOM
     C* Initialisation de la clé pour positionnement
     C                   MOVEL     *BLANK        FIFON
     C                   MOVEL     *BLANK        FINOM
     C                   SETOFF                                       8485
     C                   IF        ZSNOM <> *BLANK
     C* Si différent de blank il y a selection
     C                   SETON                                        84
     C                   Z-ADD     0             I
     C     '*'           SCAN      ZSNOM         I                      85
     C                   IF        I > 0
     C     I             SUB       1             I
     C     I             SUBST (P) ZSNOM:1       WSNOM                  90
     C* On est dans le cas d'une sélection générique
     C                   SETON                                          85
     C* On se positionnera juste au bon endroit dans le fichier
     C                   MOVEL     WSNOM         FINOM
     C                   END
     C                   END
     C* La dernière ligne écrite
     C                   Z-ADD     0             LSTLIG            4 0
     C* Le compteur de ligne par page
     C                   Z-ADD     0             NBRLIG            4 0
     C* Le fameux WRAN01
     C                   Z-ADD     0             WRAN01            4 0
     C* Effacement du sous=fichier
     C                   SETON                                        0607
     C                   SETOFF                                       0405
     C                   WRITE     FORE1
     C                   SETOFF                                       06
     C                   SETON                                        0405
     C* Positionnement en début de fichier
     C     KEY001        SETLL     FICF                                   70
     C* Chargement de la première page
     C                   EXSR      CHGPAG
     C                   ENDSR
     C* Traitement des options, on ne lit que les enregistrements modifiés
     C     TRTOPT        BEGSR
     C* Lecture des enregistrements modifiés
     C                   Z-ADD     1             WRAN01
     C* Top pour rafraichir l'écran, si besoin
     C                   SETOFF                                       86
     C  N70              READC     SFL01                                7070
     C*
     C     *IN70         DOWEQ     '0'
     C                   MOVE      HNREC         NREC
     C                   IF        HTOUT = '1'
     C                   IF        ZOPT='2' OR ZOPT='3' OR ZOPT='4' OR ZOPT='99'
     C* Si l'employé à quitté on ne peut plus rien modifier
     C                   MOVE      '5 '          ZOPT
     C                   END
     C                   END
     C                   SETON                                        85
     C* Selection en fonction du choix saisi
     C                   SELECT
     C                   WHEN      (ZOPT = '2') OR (ZOPT = ' 2')
     C                   MOVEL     'MO'          PCHX
     C                   WHEN      (ZOPT = '3') OR (ZOPT = ' 3')
     C                   MOVEL     'CO'          PCHX
     C                   WHEN      (ZOPT = '4') OR (ZOPT = ' 4')
     C                   MOVEL     'SU'          PCHX
     C                   WHEN      (ZOPT = '5') OR (ZOPT = ' 5')
     C                   MOVEL     'AF'          PCHX
     C                   WHEN      (ZOPT = '6') OR (ZOPT = ' 6')
     C                   MOVE      HMATR         PMAT
     C                   CALL      'PGMF2SCL'
     C                   PARM                    PMAT             10
     C                   SETOFF                                       85
     C                   WHEN      (ZOPT = '99')
     C                   MOVEL     'PE'          PCHX
     C                   OTHER
     C* La saisie ne correspond à rien
     C                   SETOFF                                       85
     C* Envoyer un message pour dire que l'option n'existe pas
     C                   MOVEL     '1'           PTYP
     C                   MOVEL     'FICMSG   '   PFIM
     C                   MOVEL     'MSG0002'     PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
     C                   ENDSL
     C                   IF        HTOUT = '0'
     C* Pour ne pas perdre l'attribut couleur
     C                   SETOFF                                       30
     C                   ELSE
     C                   SETON                                        30
     C                   END
     C* Nettoyage
     C                   MOVEL     *BLANK        ZOPT
     C                   UPDATE    SFL01                                90
     C* On aurait pu aussi faire IF..., en tout cas le choix est bon
     C   85              CALL      'PGMF02'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
     C   85              SETON                                        86
     C* On continue de boucler si autre option
     C                   READC     SFL01                                7070
     C                   END
     C* Potentiellement il y a eu mise à jour, on pourrait affiner
     C   86              EXSR      INITSF
     C                   ENDSR
     C* Chargement d'une page
     C     CHGPAG        BEGSR
     C* Il faut positionner correctement les indicateurs et les variables
     C                   SETOFF                                       08
     C*                  SETON                                        04
     C                   Z-ADD     LSTLIG        WRAN01
     C* Lexture de l'enregistrement suivant
     C                   READ      FICF                                   70
     C* Remise à zéro du compteur de ligne, mais on pourrait faire autrement
     C                   Z-ADD     0             NBRLIG            4 0
     C*
     C     *IN70         DOWEQ     '0'
     C     NBRLIG        ANDLT     14
     C* Remplissage des zones écran
     C                   SETON                                        86
     C* Test s'il y a selection
     C                   IF        *IN84 = '1' OR *IN85 = '1'
     C                   IF        *IN84 = '1' AND *IN85 = '0'
     C* On recherche la stricte égalité de nom
     C                   IF        FINOM <> ZSNOM
     C                   SETOFF                                       86
     C                   END
     C                   ELSE
     C* On recherche si le nom commence par la valeur avant le '*'
     C     I             SUBST (P) FINOM:1       WXNOM            35    90
     C* Petite entorse de flemmard WXNOM est déclarée au fil de l'eau
     C                   IF        WXNOM <> WSNOM
     C                   SETOFF                                       86
     C                   END
     C                   END
     C                   END
     C* L'indicateur est à '1' si sélection OK ou pas de sélection
     C                   IF        *IN86 = '1'
     C                   MOVEL     FINOM         ZNOM
     C                   MOVEL     FIPR1         ZPR1
     C                   MOVEL     FIFON         ZFONC
     C                   Z-ADD     FIMAT         ZMATR
     C                   MOVEL     FICPO         ZCPO
     C                   MOVEL     FIC           WDSFIC
     C                   Z-ADD     WNRCFI        HNREC
     C                   MOVE      FIMAT         HMATR
     C                   IF        FIDAS = 0
     C* Top salarié licencié
     C                   MOVE      '0'           HTOUT
     C                   SETOFF                                       30
     C                   ELSE
     C                   MOVE      '1'           HTOUT
     C                   SETON                                        30
     C                   END
     C* Les compteurs, attention au WRAN01
     C                   ADD       1             NBRLIG
     C                   ADD       1             LSTLIG
     C                   ADD       1             WRAN01
     C* Ecriture de la ligne
     C                   WRITE     SFL01
     C                   END
     C* Lecture du suivant
     C                   READ      FICF                                   70
     C                   END
     C* On quitte la boucle soit en fin de page
     C*                     soit en fin de fichier
     C     *IN70         IFEQ      '1'
     C* Le caractère de suite, on est en fin de fichier
     C                   SETON                                        07
     C                   ELSE
     C                   SETOFF                                       07
     C                   END
     C* Si le fichier est vide
     C     WRAN01        IFEQ      0
     C                   Z-ADD     1             NBRLIG
     C                   Z-ADD     1             LSTLIG            4 0
     C* Un petit message
     C                   Z-ADD     1             WRAN01
     C* Pas de saisie d'option
     C                   SETON                                        20
     C                   IF        ZSNOM = *BLANK
     C* Si on a un vieil AS400 du siècle dernier
     C                   MOVEL     'Fic. Vide'   ZNOM
     C                   ELSE
     C* En RPG ILE
     C                   eval      ZNOM = 'Sélection Vide'
     C                   END
     C* Ne pas oublier de remettre à blanc
     C                   MOVEL     *BLANK        ZPR1
     C                   MOVEL     *BLANK        ZFONC
     C                   Z-ADD     0             ZMATR
     C                   MOVEL     *BLANK        ZCPO
     C                   MOVEL     *BLANK        WDSFIC
     C                   Z-ADD     0             HNREC
     C* Ecriture du message sur la première ligne
     C                   WRITE     SFL01
     C                   END
     C* le WRAN01 à 1 pour afficher le premier enregistrement
     C*                  Z-ADD     LSTLIG        WRAN01
     C                   ENDSR
     C* Lecture date et heure systeme
     C     DATHEU        BEGSR
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
     C                   ENDSR
