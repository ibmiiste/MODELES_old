000100160929     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200160929     F*****************************************************
000300160929     F*                                                   *
000400160929     F* Liste fonction                                    *
000500160929     F*                                                   *
000600160929     F*****************************************************
000700160929     FPGMF10FM  CF   E             WORKSTN
000800160929     F                                     SFILE(SFL01 :WRAN01)
000900160929     F                                     INFDS(WDSFL1)
001000160929     FFIF01L    IF   E           K DISK
001100160929     F                                     INFDS(WDSFIF)
001200160929     FFIC02L    IF   E           K DISK
001300160929     DW14              S             14  0
001400160929     DWDAT             S              8
001500160929     DWHEU             S              6
001600160929     DPOPT             S              2
001700160929     DW8               S              8
001800160929     DWHS              S               Z
001900160929     DPNREC            S             10
002000160929     DWS               DS
002100160929     DWSA                      1      4
002200160929     DWMA                      6      7
002300160929     DWJA                      9     10
002400160929     DWHA                     12     13
002500160929     DWIA                     15     16
002600160929     DWKA                     18     19
002700160929     DWMU                     21     26
002800160929     DWASTA                    1     26
002900160929     DWDSPGM          SDS
003000160929     DWLIPGM                   1     10
003100160929     DWSTATU                  11     15  0
003200160929     DWSTPRE                  16     20  0
003300160929     DWSRCSQ                  21     28
003400160929     DWNMROU                  29     36
003500160929     DWNBPAR                  37     39  0
003600160929     DWTYEXC                  40     42
003700160929     DWLICPF                  40     46
003800160929     DWNUEXC                  43     46
003900160929     DWMIODT                  47     50
004000160929     DWZOMES                  51     80
004100160929     DWBIPGM                  81     90
004200160929     DWRTDTA                  91    170
004300160929     DWCOERR                 171    174
004400160929     DWDERFI                 201    208
004500160929     DWFIINF                 209    243
004600160929     DWJOB                   244    253
004700160929     DWUSER                  254    263
004800160929     DWJBNUM                 264    269  0
004900160929     DWDSFL1           DS
005000160929     DWPOSC                  370    371B 0
005100160929     DWRRNG                  376    377B 0
005200160929     DWRNGP                  378    379B 0
005300160929     DWNBRSF                 380    381B 0
005400160929     DWLIGCF                 382    383B 0
005500160929     DWRCMIE                 403    404B 0
005600160929     DWDSFIF           DS
005700160929     DWNRC01                 397    400B 0
005800160929     DWDSFI1           DS
005900160929     DWCDFIL                   1      8
006000160929     DWOPNF                    9      9
006100160929     DWSTFIL                  11     15  0
006200160929     DWOPCOD                  16     21
006300160929     DWRPGSQ                  30     37
006400160929     DWRPGNR                  38     45
006500160929     DWERRFI                  46     52
006600160929     DWNMFIC                  83     92
006700160929     DWNMBIB                  93    102
006800160929     DWSPNOM                 103    112
006900160929     DWSPLIB                 113    122
007000160929     DWSPNBR                 123    124B 0
007100160929     DWLIMBR                 129    138
007200160929     DWNBPUT                 243    246B 0
007300160929     DWNBGET                 247    250B 0
007400160929     DWNBPG                  251    254B 0
007500160929     DWNBIO                  255    258B 0
007600160929     DWRCDFT                 261    270
007700160929     DWNBRCD                 283    286B 0
007800160929     DWNRCFI                 397    400B 0
007900160929     C     SKKCL1        KLIST
008000160929     C                   KFLD                    MIFON
008100160929     C     KKCL01        KLIST
008200160929     C                   KFLD                    MIFON
008300160929     C* initialisations générales
008400160929     C                   SETON                                        0910
008500160929     C                   EXSR      DATHEU
008600160929     C                   MOVE      WDAT          ZDATE
008700160929     C                   MOVE      WHEU          ZHEUR
008800160929     C                   MOVEL     WUSER         ZUSER
008900160929     C                   MOVEL     WJOB          ZJOB
009000160929     C                   MOVEL     '*  '         WPGMQ
009100160929     C                   MOVEL     'CC01'        WMGKEY
009200160929     C                   SETON                                        0910
009300160929     C* Indicateur fin
009400160929     C                   SETON                                        50
009500160929     C* Debut du traitement,
009600160929     C                   EXSR      INITSF
009700160929     C* Boucle d'attente de sortie
009800160929     C                   DOW       *IN50 = '1'
009900160929     C                   EXSR      TRTSFL
010000160929     C                   END
010100160929     C                   SETON                                        LR
010200160929     C* traitement de l'écran
010300160929     C     TRTSFL        BEGSR
010400160929     C*
010500160929     C                   MOVEL     '3'           PTYP
010600160929     C                   MOVEL     *BLANK        PFIM
010700160929     C                   MOVEL     *BLANK        PMID
010800160929     C                   CALL      'PGM001CL'
010900160929     C                   PARM                    PTYP              1
011000160929     C                   PARM                    PFIM             10
011100160929     C                   PARM                    PMID              7
011200160929     C                   PARM                    PMDT             99
011300160929     C                   WRITE     WSFCTL
011400160929     C                   SETON                                        0405
011500160929     C                   WRITE     FORE1                                  70
011600160929     C                   WRITE     FORB1
011700160929     C* attente lecture
011800160929     C                   READ      FORE1                                  70
011900160929     C* chargement de l'heure
012000160929     C                   TIME                    ZHEUR
012100160929     C*
012200160929     C                   SETON                                        51
012300160929     C                   IF        *IN02 = '1'
012400160929     C* page suivante
012500160929     C                   EXSR      CHGPAG
012600160929     C                   SETOFF                                       51
012700160929     C                   END
012800160929     C*
012900160929     C* touches F3 et F12
013000160929     C                   IF        *INKC = '1' OR
013100160929     C                             *INKL = '1'
013200160929     C* on met l'indicateur à Off
013300160929     C                   SETOFF                                       5051
013400160929     C                   END
013500160929     C*
013600160929     C                   IF        *INKE = '1'
013700160929     C* F5 Rafraichissement de l'écran
013800160929     C                   EXSR      INITSF
013900160929     C                   SETOFF                                       51
014000160929     C                   END
014100160929     C*
014200160929     C                   IF        *INKF = '1'
014300160929     C* F6 création d'une nouvelle fonction
014400160929     C                   MOVEL     'CR'          PCHX
014500160929     C                   MOVEL     *BLANK        NREC
014600160929     C                   CALL      'PGMF11'
014700160929     C                   PARM                    PCHX              2
014800160929     C                   PARM                    NREC             10
014900160929     C                   EXSR      INITSF
015000160929     C                   SETOFF                                       51
015100160929     C                   END
015200160929     C*
015300160929     C                   IF        *IN51 = '1'
015400160929     C                   EXSR      TRTOPT
015500160929     C                   END
015600160929     C* on recommence la boucle d'attente
015700160929     C                   ENDSR
015800160929     C* Les Sub Routines
015900160929     C*****************************************
016000160929     C*  Initialisation du sous-fichier
016100160929     C*****************************************
016200160929     C     INITSF        BEGSR
016300160929     C*    l'indicateur 20 conditionne la zone OPT (protection)
016400160929     C                   SETOFF                                       20
016500160929     C*    dernière ligne écrite
016600160929     C                   Z-ADD     0             LSTLIG            4 0
016700160929     C*    compteur de ligne par page
016800160929     C                   Z-ADD     0             NBRLIG            4 0
016900160929     C*    la fameux WRAN01
017000160929     C                   Z-ADD     0             WRAN01            4 0
017100160929     C                   SETON                                        0607
017200160929     C                   SETOFF                                       0405
017300160929     C                   WRITE     FORE1
017400160929     C                   SETOFF                                       06
017500160929     C                   SETON                                        0405
017600160929     C                   EXSR      CHGPAG
017700160929     C*
017800160929     C                   ENDSR
017900160929     C******************************
018000160929     C     TRTOPT        BEGSR
018100160929     C*  Lecture des enregistrements modifiés
018200160929     C                   Z-ADD     1             WRAN01
018300160929     C* top pour rafraichir l'écran
018400160929     C                   SETOFF                                       86
018500160929     C  N70              READC     SFL01                                7070
018600160929     C*
018700160929     C     *IN70         DOWEQ     '0'
018800160929     C                   MOVE      HNREC         NREC
018900160929     C                   SETON                                        85
019000160929     C                   SELECT
019100160929     C                   WHEN      (ZOPT = ' ')
019200160929     C                   SETOFF                                       85
019300160929     C                   WHEN      (ZOPT = '2')
019400160929     C                   MOVEL     'MO'          PCHX
019500160929     C                   WHEN      (ZOPT = '3')
019600160929     C                   MOVEL     'CO'          PCHX
019700160929     C                   WHEN      (ZOPT = '4')
019800160929     C                   MOVEL     'SU'          PCHX
019900160929     C                   WHEN      (ZOPT = '5')
020000160929     C                   MOVEL     'AF'          PCHX
020100160929     C                   OTHER
020200160929     C                   SETOFF                                       85
020300160929     C* envoyer un message pour dire que l'option n'existe pas
020400160929     C                   MOVEL     '1'           PTYP
020500160929     C                   MOVEL     'FICMSG   '   PFIM
020600160929     C                   MOVEL     'MSG0002'     PMID
020700160929     C                   CALL      'PGM001CL'
020800160929     C                   PARM                    PTYP              1
020900160929     C                   PARM                    PFIM             10
021000160929     C                   PARM                    PMID              7
021100160929     C                   PARM                    PMDT             99
021200160929     C                   ENDSL
021300160929     C                   MOVEL     *BLANK        ZOPT
021400160929     C                   UPDATE    SFL01                                90
021500160929     C* on aurait pu aussi faire IF ....
021600160929     C   85              CALL      'PGMF11'
021700160929     C                   PARM                    PCHX              2
021800160929     C                   PARM                    NREC             10
021900160929     C   85              SETON                                        86
022000160929     C                   READC     SFL01                                7070
022100160929     C                   END
022200160929     C   86              EXSR      INITSF
022300160929     C                   ENDSR
022400160929     C*************************************
022500160929     C     CHGPAG        BEGSR
022600160929     C*  chargement de la page
022700160929     C                   SETOFF                                       08
022800160929     C*                  SETON                                        04
022900160929     C                   Z-ADD     LSTLIG        WRAN01
023000160929     C     *LOVAL        SETLL     FIFF                                   70
023100160929     C                   READ      FIFF                                   70
023200160929     C                   Z-ADD     0             NBRLIG            4 0
023300160929     C*
023400160929     C     *IN70         DOWEQ     '0'
023500160929     C     NBRLIG        ANDLT     15
023600160929     C* remplissage des zones écran
023700160929     C                   MOVEL     MIFON         ZCOD
023800160929     C* on tronque à l'affichage
023900160929     C                   MOVEL     MILIB         ZLIB
024000160929     C* conversion de la date
024100160929     C                   TEST (Z)                MITSC                  90
024200160929     C     *IN90         IFEQ      '1'
024300160929     C                   MOVEL     *LOVAL        WHS
024400160929     C                   ELSE
024500160929     C                   MOVEL     MITSC         WHS
024600160929     C                   END
024700160929     C                   EXSR      CVTDAT
024800160929     C                   MOVE      W8            ZDAC
024900160929     C                   TEST (Z)                MITSM                  90
025000160929     C     *IN90         IFEQ      '1'
025100160929     C                   MOVEL     *LOVAL        WHS
025200160929     C                   ELSE
025300160929     C                   MOVEL     MITSM         WHS
025400160929     C                   END
025500160929     C                   EXSR      CVTDAT
025600160929     C                   MOVE      W8            ZDAM
025700160929     C* la on met une petite complication qui ralentit fortement le traitement
025800160929     C                   Z-ADD     0             ZNBEM
025900160929     C     KKCL01        CHAIN     FICF                               7190
026000160929     C* la clé est la code fonction lu dans le fichier des codes
026100160929     C                   DOW       *IN71 = '0'
026200160929     C* lecture de tous les employés ayant le même code
026300160929     C     ZNBEM         ADD       1             ZNBEM
026400160929     C     KKCL01        READE     FICF                                 9071
026500160929     C                   ENDDO
026600160929     C* pour récupérer le numéro d'enregistrement
026700160929     C                   MOVEL     WDSFIF        WDSFI1
026800160929     C                   Z-ADD     WNRCFI        HNREC
026900160929     C                   ADD       1             NBRLIG
027000160929     C                   ADD       1             WRAN01
027100160929     C                   ADD       1             LSTLIG            4 0
027200160929     C                   WRITE     SFL01
027300160929     C* lecture du suivant
027400160929     C                   READ      FIFF                                   70
027500160929     C                   END
027600160929     C* on quitte la boucle soit en fin de page
027700160929     C*                     soit en fin de fichier
027800160929     C     *IN70         IFEQ      '1'
027900160929     C* le caractère de suite
028000160929     C                   SETON                                        07
028100160929     C                   END
028200160929     C* si le fichier est vide
028300160929     C     WRAN01        IFEQ      0
028400160929     C                   Z-ADD     1             NBRLIG
028500160929     C                   Z-ADD     1             LSTLIG            4 0
028600160929     C* un petit message
028700160929     C                   Z-ADD     1             WRAN01
028800160929     C* pas de saisie d'option
028900160929     C                   SETON                                        20
029000160929     C                   eval      ZLIB = 'Sélection Vide   '
029100160929     C                   MOVEL     *BLANK        ZCOD
029200160929     C                   Z-ADD     0             HNREC
029300160929     C                   WRITE     SFL01
029400160929     C                   END
029500160929     C* le WRAN01 à 1 pour afficher le premier enregistrement
029600160929     C                   Z-ADD     1             WRAN01
029700160929     C                   ENDSR
029800160929     C* chargement de la date et heure système
029900160929     C     DATHEU        BEGSR
030000160929     C                   TIME                    W14
030100160929     C                   MOVE      W14           WDAT
030200160929     C                   MOVEL     W14           WHEU
030300160929     C                   ENDSR
030400160929     C* conversion de la date
030500160929     C     CVTDAT        BEGSR
030600160929     C                   MOVEL     WHS           WASTA
030700160929     C* la DS découpe les valeurs que l'on concatène
030800160929     C                   EVAL      W8 = WJA+ WMA+ WSA
030900160929     C* il ne reste plus qu'a charger dans la zone écran
031000160929     C                   ENDSR
