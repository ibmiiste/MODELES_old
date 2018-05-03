     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Liste fonction                                    *
     F*                                                   *
     F*****************************************************
     FPGMF10FM  CF   E             WORKSTN
     F                                     SFILE(SFL01 :WRAN01)
     F                                     INFDS(WDSFL1)
     FFIF01L    IF   E           K DISK
     F                                     INFDS(WDSFIF)
     FFIC02L    IF   E           K DISK
     DW14              S             14  0
     DWDAT             S              8
     DWHEU             S              6
     DPOPT             S              2
     DW8               S              8
     DWHS              S               Z
     DPNREC            S             10
     DWS               DS
     DWSA                      1      4
     DWMA                      6      7
     DWJA                      9     10
     DWHA                     12     13
     DWIA                     15     16
     DWKA                     18     19
     DWMU                     21     26
     DWASTA                    1     26
     DWDSPGM          SDS
     DWLIPGM                   1     10
     DWSTATU                  11     15  0
     DWSTPRE                  16     20  0
     DWSRCSQ                  21     28
     DWNMROU                  29     36
     DWNBPAR                  37     39  0
     DWTYEXC                  40     42
     DWLICPF                  40     46
     DWNUEXC                  43     46
     DWMIODT                  47     50
     DWZOMES                  51     80
     DWBIPGM                  81     90
     DWRTDTA                  91    170
     DWCOERR                 171    174
     DWDERFI                 201    208
     DWFIINF                 209    243
     DWJOB                   244    253
     DWUSER                  254    263
     DWJBNUM                 264    269  0
     DWDSFL1           DS
     DWPOSC                  370    371B 0
     DWRRNG                  376    377B 0
     DWRNGP                  378    379B 0
     DWNBRSF                 380    381B 0
     DWLIGCF                 382    383B 0
     DWRCMIE                 403    404B 0
     DWDSFIF           DS
     DWNRC01                 397    400B 0
     DWDSFI1           DS
     DWCDFIL                   1      8
     DWOPNF                    9      9
     DWSTFIL                  11     15  0
     DWOPCOD                  16     21
     DWRPGSQ                  30     37
     DWRPGNR                  38     45
     DWERRFI                  46     52
     DWNMFIC                  83     92
     DWNMBIB                  93    102
     DWSPNOM                 103    112
     DWSPLIB                 113    122
     DWSPNBR                 123    124B 0
     DWLIMBR                 129    138
     DWNBPUT                 243    246B 0
     DWNBGET                 247    250B 0
     DWNBPG                  251    254B 0
     DWNBIO                  255    258B 0
     DWRCDFT                 261    270
     DWNBRCD                 283    286B 0
     DWNRCFI                 397    400B 0
     C     KEYSF1        KLIST
     C                   KFLD                    MIFON
     C     KEY001        KLIST
     C                   KFLD                    MIFON
     C* initialisations générales
     C                   MOVEL     WLIPGM        ZPGM
     C                   SETON                                        0910
     C                   EXSR      DATHEU
     C                   MOVE      WDAT          ZDATE
     C                   MOVE      WHEU          ZHEUR
     C                   MOVEL     WUSER         ZUSER
     C                   MOVEL     WJOB          ZJOB
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
     C                   SETON                                        LR
     C* traitement de l'écran
     C     TRTSFL        BEGSR
     C*
     C                   MOVEL     '3'           PTYP
     C                   MOVEL     *BLANK        PFIM
     C                   MOVEL     *BLANK        PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
     C                   WRITE     WSFCTL
     C                   SETON                                        0405
     C                   WRITE     FORE1                                  70
     C                   WRITE     FORB1
     C* attente lecture
     C                   READ      FORE1                                  70
     C* chargement de l'heure
     C                   TIME                    ZHEUR
     C*
     C                   SETON                                        51
     C                   IF        *IN02 = '1'
     C* page suivante
     C                   EXSR      CHGPAG
     C                   SETOFF                                       51
     C                   END
     C*
     C* touches F3 et F12
     C                   IF        *INKC = '1' OR
     C                             *INKL = '1'
     C* on met l'indicateur à Off
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
     C* F6 création d'une nouvelle fonction
     C                   MOVEL     'CR'          PCHX
     C                   MOVEL     *BLANK        NREC
     C                   CALL      'PGMF11'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
     C                   EXSR      INITSF
     C                   SETOFF                                       51
     C                   END
     C*
     C                   IF        *IN51 = '1'
     C                   EXSR      TRTOPT
     C                   END
     C* on recommence la boucle d'attente
     C                   ENDSR
     C* Les Sub Routines
     C*****************************************
     C*  Initialisation du sous-fichier
     C*****************************************
     C     INITSF        BEGSR
     C*    l'indicateur 20 conditionne la zone OPT (protection)
     C                   SETOFF                                       20
     C*    dernière ligne écrite
     C                   Z-ADD     0             LSTLIG            4 0
     C*    compteur de ligne par page
     C                   Z-ADD     0             NBRLIG            4 0
     C*    la fameux WRAN01
     C                   Z-ADD     0             WRAN01            4 0
     C                   SETON                                        0607
     C                   SETOFF                                       0405
     C                   WRITE     FORE1
     C                   SETOFF                                       06
     C                   SETON                                        0405
     C                   EXSR      CHGPAG
     C*
     C                   ENDSR
     C******************************
     C     TRTOPT        BEGSR
     C*  Lecture des enregistrements modifiés
     C                   Z-ADD     1             WRAN01
     C* top pour rafraichir l'écran
     C                   SETOFF                                       86
     C  N70              READC     SFL01                                7070
     C*
     C     *IN70         DOWEQ     '0'
     C                   MOVE      HNREC         NREC
     C                   SETON                                        85
     C                   SELECT
     C                   WHEN      (ZOPT = ' ')
     C                   SETOFF                                       85
     C                   WHEN      (ZOPT = '2')
     C                   MOVEL     'MO'          PCHX
     C                   WHEN      (ZOPT = '3')
     C                   MOVEL     'CO'          PCHX
     C                   WHEN      (ZOPT = '4')
     C                   MOVEL     'SU'          PCHX
     C                   WHEN      (ZOPT = '5')
     C                   MOVEL     'AF'          PCHX
     C                   OTHER
     C                   SETOFF                                       85
     C* envoyer un message pour dire que l'option n'existe pas
     C                   MOVEL     '1'           PTYP
     C                   MOVEL     'FICMSG   '   PFIM
     C                   MOVEL     'MSG0002'     PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
     C                   ENDSL
     C                   MOVEL     *BLANK        ZOPT
     C                   UPDATE    SFL01                                90
     C* on aurait pu aussi faire IF ....
     C   85              CALL      'PGMF11'
     C                   PARM                    PCHX              2
     C                   PARM                    NREC             10
     C   85              SETON                                        86
     C                   READC     SFL01                                7070
     C                   END
     C   86              EXSR      INITSF
     C                   ENDSR
     C*************************************
     C     CHGPAG        BEGSR
     C*  chargement de la page
     C                   SETOFF                                       08
     C*                  SETON                                        04
     C                   Z-ADD     LSTLIG        WRAN01
     C     *LOVAL        SETLL     FIFF                                   70
     C                   READ      FIFF                                   70
     C                   Z-ADD     0             NBRLIG            4 0
     C*
     C     *IN70         DOWEQ     '0'
     C     NBRLIG        ANDLT     15
     C* remplissage des zones écran
     C                   MOVEL     MIFON         ZCOD
     C* on tronque à l'affichage
     C                   MOVEL     MILIB         ZLIB
     C* conversion de la date
     C                   TEST (Z)                MITSC                  90
     C     *IN90         IFEQ      '1'
     C                   MOVEL     *LOVAL        WHS
     C                   ELSE
     C                   MOVEL     MITSC         WHS
     C                   END
     C                   EXSR      CVTDAT
     C                   MOVE      W8            ZDAC
     C                   TEST (Z)                MITSM                  90
     C     *IN90         IFEQ      '1'
     C                   MOVEL     *LOVAL        WHS
     C                   ELSE
     C                   MOVEL     MITSM         WHS
     C                   END
     C                   EXSR      CVTDAT
     C                   MOVE      W8            ZDAM
     C* la on met une petite complication qui ralentit fortement le traitement
     C                   Z-ADD     0             ZNBEM
     C     KEY001        CHAIN     FICF                               7190
     C* la clé est la code fonction lu dans le fichier des codes
     C                   DOW       *IN71 = '0'
     C* lecture de tous les employés ayant le même code
     C     ZNBEM         ADD       1             ZNBEM
     C     KEY001        READE     FICF                                 9071
     C                   ENDDO
     C* pour récupérer le numéro d'enregistrement
     C                   MOVEL     WDSFIF        WDSFI1
     C                   Z-ADD     WNRCFI        HNREC
     C                   ADD       1             NBRLIG
     C                   ADD       1             WRAN01
     C                   ADD       1             LSTLIG            4 0
     C                   WRITE     SFL01
     C* lecture du suivant
     C                   READ      FIFF                                   70
     C                   END
     C* on quitte la boucle soit en fin de page
     C*                     soit en fin de fichier
     C     *IN70         IFEQ      '1'
     C* le caractère de suite
     C                   SETON                                        07
     C                   END
     C* si le fichier est vide
     C     WRAN01        IFEQ      0
     C                   Z-ADD     1             NBRLIG
     C                   Z-ADD     1             LSTLIG            4 0
     C* un petit message
     C                   Z-ADD     1             WRAN01
     C* pas de saisie d'option
     C                   SETON                                        20
     C                   eval      ZLIB = 'Sélection Vide                      '
     C                   MOVEL     *BLANK        ZCOD
     C                   Z-ADD     0             HNREC
     C                   WRITE     SFL01
     C                   END
     C* le WRAN01 à 1 pour afficher le premier enregistrement
     C                   Z-ADD     1             WRAN01
     C                   ENDSR
     C* chargement de la date et heure système
     C     DATHEU        BEGSR
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
     C                   ENDSR
     C* conversion de la date
     C     CVTDAT        BEGSR
     C                   MOVEL     WHS           WASTA
     C* la DS découpe les valeurs que l'on concatène
     C                   EVAL      W8 = WJA+ WMA+ WSA
     C* il ne reste plus qu'a charger dans la zone écran
     C                   ENDSR
