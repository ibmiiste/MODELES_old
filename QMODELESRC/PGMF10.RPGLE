000100180502     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200180502     F*****************************************************
000300180502     F*                                                   *
000400180502     F* Liste fonction                                    *
000500180502     F*                                                   *
000600180502     F*****************************************************
000700180502     FPGMF10FM  CF   E             WORKSTN
000800180502     F                                     SFILE(SFL01 :WRAN01)
000900180502     F                                     INFDS(WDSFL1)
001000180502     FFIF01L    IF   E           K DISK
001100180502     F                                     INFDS(WDSFIF)
001200180502     FFIC02L    IF   E           K DISK
001300180502     DW14              S             14  0
001400180502     DWDAT             S              8
001500180502     DWHEU             S              6
001600180502     DPOPT             S              2
001700180502     DW8               S              8
001800180502     DWHS              S               Z
001900180502     DPNREC            S             10
002000180502     DWS               DS
002100180502     DWSA                      1      4
002200180502     DWMA                      6      7
002300180502     DWJA                      9     10
002400180502     DWHA                     12     13
002500180502     DWIA                     15     16
002600180502     DWKA                     18     19
002700180502     DWMU                     21     26
002800180502     DWASTA                    1     26
002900180502     DWDSPGM          SDS
003000180502     DWLIPGM                   1     10
003100180502     DWSTATU                  11     15  0
003200180502     DWSTPRE                  16     20  0
003300180502     DWSRCSQ                  21     28
003400180502     DWNMROU                  29     36
003500180502     DWNBPAR                  37     39  0
003600180502     DWTYEXC                  40     42
003700180502     DWLICPF                  40     46
003800180502     DWNUEXC                  43     46
003900180502     DWMIODT                  47     50
004000180502     DWZOMES                  51     80
004100180502     DWBIPGM                  81     90
004200180502     DWRTDTA                  91    170
004300180502     DWCOERR                 171    174
004400180502     DWDERFI                 201    208
004500180502     DWFIINF                 209    243
004600180502     DWJOB                   244    253
004700180502     DWUSER                  254    263
004800180502     DWJBNUM                 264    269  0
004900180502     DWDSFL1           DS
005000180502     DWPOSC                  370    371B 0
005100180502     DWRRNG                  376    377B 0
005200180502     DWRNGP                  378    379B 0
005300180502     DWNBRSF                 380    381B 0
005400180502     DWLIGCF                 382    383B 0
005500180502     DWRCMIE                 403    404B 0
005600180502     DWDSFIF           DS
005700180502     DWNRC01                 397    400B 0
005800180502     DWDSFI1           DS
005900180502     DWCDFIL                   1      8
006000180502     DWOPNF                    9      9
006100180502     DWSTFIL                  11     15  0
006200180502     DWOPCOD                  16     21
006300180502     DWRPGSQ                  30     37
006400180502     DWRPGNR                  38     45
006500180502     DWERRFI                  46     52
006600180502     DWNMFIC                  83     92
006700180502     DWNMBIB                  93    102
006800180502     DWSPNOM                 103    112
006900180502     DWSPLIB                 113    122
007000180502     DWSPNBR                 123    124B 0
007100180502     DWLIMBR                 129    138
007200180502     DWNBPUT                 243    246B 0
007300180502     DWNBGET                 247    250B 0
007400180502     DWNBPG                  251    254B 0
007500180502     DWNBIO                  255    258B 0
007600180502     DWRCDFT                 261    270
007700180502     DWNBRCD                 283    286B 0
007800180502     DWNRCFI                 397    400B 0
007900180502     C     SKKCL1        KLIST
008000180502     C                   KFLD                    MIFON
008100180502     C     KKCL01        KLIST
008200180502     C                   KFLD                    MIFON
008300180502     C* initialisations générales
008400180502     C                   SETON                                        0910
008500180502     C                   EXSR      DATHEU
008600180502     C                   MOVE      WDAT          ZDATE
008700180502     C                   MOVE      WHEU          ZHEUR
008800180502     C                   MOVEL     WUSER         ZUSER
008900180502     C                   MOVEL     WJOB          ZJOB
009000180502     C                   MOVEL     '*  '         WPGMQ
009100180502     C                   MOVEL     'CC01'        WMGKEY
009200180502     C                   SETON                                        0910
009300180502     C* Indicateur fin
009400180502     C                   SETON                                        50
009500180502     C* Debut du traitement,
009600180502     C                   EXSR      INITSF
009700180502     C* Boucle d'attente de sortie
009800180502     C                   DOW       *IN50 = '1'
009900180502     C                   EXSR      TRTSFL
010000180502     C                   END
010100180502     C                   SETON                                        LR
010200180502     C* traitement de l'écran
010300180502     C     TRTSFL        BEGSR
010400180502     C*
010500180502     C                   MOVEL     '3'           PTYP
010600180502     C                   MOVEL     *BLANK        PFIM
010700180502     C                   MOVEL     *BLANK        PMID
010800180502     C                   CALL      'PGM001CL'
010900180502     C                   PARM                    PTYP              1
011000180502     C                   PARM                    PFIM             10
011100180502     C                   PARM                    PMID              7
011200180502     C                   PARM                    PMDT             99
011300180502     C                   WRITE     WSFCTL
011400180502     C                   SETON                                        0405
011500180502     C                   WRITE     FORE1                                  70
011600180502     C                   WRITE     FORB1
011700180502     C* attente lecture
011800180502     C                   READ      FORE1                                  70
011900180502     C* chargement de l'heure
012000180502     C                   TIME                    ZHEUR
012100180502     C*
012200180502     C                   SETON                                        51
012300180502     C                   IF        *IN02 = '1'
012400180502     C* page suivante
012500180502     C                   EXSR      CHGPAG
012600180502     C                   SETOFF                                       51
012700180502     C                   END
012800180502     C*
012900180502     C* touches F3 et F12
013000180502     C                   IF        *INKC = '1' OR
013100180502     C                             *INKL = '1'
013200180502     C* on met l'indicateur à Off
013300180502     C                   SETOFF                                       5051
013400180502     C                   END
013500180502     C*
013600180502     C                   IF        *INKE = '1'
013700180502     C* F5 Rafraichissement de l'écran
013800180502     C                   EXSR      INITSF
013900180502     C                   SETOFF                                       51
014000180502     C                   END
014100180502     C*
014200180502     C                   IF        *INKF = '1'
014300180502     C* F6 création d'une nouvelle fonction
014400180502     C                   MOVEL     'CR'          PCHX
014500180502     C                   MOVEL     *BLANK        NREC
014600180502     C                   CALL      'PGMF11'
014700180502     C                   PARM                    PCHX              2
014800180502     C                   PARM                    NREC             10
014900180502     C                   EXSR      INITSF
015000180502     C                   SETOFF                                       51
015100180502     C                   END
015200180502     C*
015300180502     C                   IF        *IN51 = '1'
015400180502     C                   EXSR      TRTOPT
015500180502     C                   END
015600180502     C* on recommence la boucle d'attente
015700180502     C                   ENDSR
015800180502     C* Les Sub Routines
015900180502     C*****************************************
016000180502     C*  Initialisation du sous-fichier
016100180502     C*****************************************
016200180502     C     INITSF        BEGSR
016300180502     C*    l'indicateur 20 conditionne la zone OPT (protection)
016400180502     C                   SETOFF                                       20
016500180502     C*    dernière ligne écrite
016600180502     C                   Z-ADD     0             LSTLIG            4 0
016700180502     C*    compteur de ligne par page
016800180502     C                   Z-ADD     0             NBRLIG            4 0
016900180502     C*    la fameux WRAN01
017000180502     C                   Z-ADD     0             WRAN01            4 0
017100180502     C                   SETON                                        0607
017200180502     C                   SETOFF                                       0405
017300180502     C                   WRITE     FORE1
017400180502     C                   SETOFF                                       06
017500180502     C                   SETON                                        0405
017600180502     C                   EXSR      CHGPAG
017700180502     C*
017800180502     C                   ENDSR
017900180502     C******************************
018000180502     C     TRTOPT        BEGSR
018100180502     C*  Lecture des enregistrements modifiés
018200180502     C                   Z-ADD     1             WRAN01
018300180502     C* top pour rafraichir l'écran
018400180502     C                   SETOFF                                       86
018500180502     C  N70              READC     SFL01                                7070
018600180502     C*
018700180502     C     *IN70         DOWEQ     '0'
018800180502     C                   MOVE      HNREC         NREC
018900180502     C                   SETON                                        85
019000180502     C                   SELECT
019100180502     C                   WHEN      (ZOPT = ' ')
019200180502     C                   SETOFF                                       85
019300180502     C                   WHEN      (ZOPT = '2')
019400180502     C                   MOVEL     'MO'          PCHX
019500180502     C                   WHEN      (ZOPT = '3')
019600180502     C                   MOVEL     'CO'          PCHX
019700180502     C                   WHEN      (ZOPT = '4')
019800180502     C                   MOVEL     'SU'          PCHX
019900180502     C                   WHEN      (ZOPT = '5')
020000180502     C                   MOVEL     'AF'          PCHX
020100180502     C                   OTHER
020200180502     C                   SETOFF                                       85
020300180502     C* envoyer un message pour dire que l'option n'existe pas
020400180502     C                   MOVEL     '1'           PTYP
020500180502     C                   MOVEL     'FICMSG   '   PFIM
020600180502     C                   MOVEL     'MSG0002'     PMID
020700180502     C                   CALL      'PGM001CL'
020800180502     C                   PARM                    PTYP              1
020900180502     C                   PARM                    PFIM             10
021000180502     C                   PARM                    PMID              7
021100180502     C                   PARM                    PMDT             99
021200180502     C                   ENDSL
021300180502     C                   MOVEL     *BLANK        ZOPT
021400180502     C                   UPDATE    SFL01                                90
021500180502     C* on aurait pu aussi faire IF ....
021600180502     C   85              CALL      'PGMF11'
021700180502     C                   PARM                    PCHX              2
021800180502     C                   PARM                    NREC             10
021900180502     C   85              SETON                                        86
022000180502     C                   READC     SFL01                                7070
022100180502     C                   END
022200180502     C   86              EXSR      INITSF
022300180502     C                   ENDSR
022400180502     C*************************************
022500180502     C     CHGPAG        BEGSR
022600180502     C*  chargement de la page
022700180502     C                   SETOFF                                       08
022800180502     C*                  SETON                                        04
022900180502     C                   Z-ADD     LSTLIG        WRAN01
023000180502     C     *LOVAL        SETLL     FIFF                                   70
023100180502     C                   READ      FIFF                                   70
023200180502     C                   Z-ADD     0             NBRLIG            4 0
023300180502     C*
023400180502     C     *IN70         DOWEQ     '0'
023500180502     C     NBRLIG        ANDLT     15
023600180502     C* remplissage des zones écran
023700180502     C                   MOVEL     MIFON         ZCOD
023800180502     C* on tronque à l'affichage
023900180502     C                   MOVEL     MILIB         ZLIB
024000180502     C* conversion de la date
024100180502     C                   TEST (Z)                MITSC                  90
024200180502     C     *IN90         IFEQ      '1'
024300180502     C                   MOVEL     *LOVAL        WHS
024400180502     C                   ELSE
024500180502     C                   MOVEL     MITSC         WHS
024600180502     C                   END
024700180502     C                   EXSR      CVTDAT
024800180502     C                   MOVE      W8            ZDAC
024900180502     C                   TEST (Z)                MITSM                  90
025000180502     C     *IN90         IFEQ      '1'
025100180502     C                   MOVEL     *LOVAL        WHS
025200180502     C                   ELSE
025300180502     C                   MOVEL     MITSM         WHS
025400180502     C                   END
025500180502     C                   EXSR      CVTDAT
025600180502     C                   MOVE      W8            ZDAM
025700180502     C* la on met une petite complication qui ralentit fortement le traitement
025800180502     C                   Z-ADD     0             ZNBEM
025900180502     C     KKCL01        CHAIN     FICF                               7190
026000180502     C* la clé est la code fonction lu dans le fichier des codes
026100180502     C                   DOW       *IN71 = '0'
026200180502     C* lecture de tous les employés ayant le même code
026300180502     C     ZNBEM         ADD       1             ZNBEM
026400180502     C     KKCL01        READE     FICF                                 9071
026500180502     C                   ENDDO
026600180502     C* pour récupérer le numéro d'enregistrement
026700180502     C                   MOVEL     WDSFIF        WDSFI1
026800180502     C                   Z-ADD     WNRCFI        HNREC
026900180502     C                   ADD       1             NBRLIG
027000180502     C                   ADD       1             WRAN01
027100180502     C                   ADD       1             LSTLIG            4 0
027200180502     C                   WRITE     SFL01
027300180502     C* lecture du suivant
027400180502     C                   READ      FIFF                                   70
027500180502     C                   END
027600180502     C* on quitte la boucle soit en fin de page
027700180502     C*                     soit en fin de fichier
027800180502     C     *IN70         IFEQ      '1'
027900180502     C* le caractère de suite
028000180502     C                   SETON                                        07
028100180502     C                   END
028200180502     C* si le fichier est vide
028300180502     C     WRAN01        IFEQ      0
028400180502     C                   Z-ADD     1             NBRLIG
028500180502     C                   Z-ADD     1             LSTLIG            4 0
028600180502     C* un petit message
028700180502     C                   Z-ADD     1             WRAN01
028800180502     C* pas de saisie d'option
028900180502     C                   SETON                                        20
029000180502     C                   eval      ZLIB = 'Sélection Vide   '
029100180502     C                   MOVEL     *BLANK        ZCOD
029200180502     C                   Z-ADD     0             HNREC
029300180502     C                   WRITE     SFL01
029400180502     C                   END
029500180502     C* le WRAN01 à 1 pour afficher le premier enregistrement
029600180502     C                   Z-ADD     1             WRAN01
029700180502     C                   ENDSR
029800180502     C* chargement de la date et heure système
029900180502     C     DATHEU        BEGSR
030000180502     C                   TIME                    W14
030100180502     C                   MOVE      W14           WDAT
030200180502     C                   MOVEL     W14           WHEU
030300180502     C                   ENDSR
030400180502     C* conversion de la date
030500180502     C     CVTDAT        BEGSR
030600180502     C                   MOVEL     WHS           WASTA
030700180502     C* la DS découpe les valeurs que l'on concatène
030800180502     C                   EVAL      W8 = WJA+ WMA+ WSA
030900180502     C* il ne reste plus qu'a charger dans la zone écran
031000180502     C                   ENDSR
