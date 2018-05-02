0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Liste fonction                                    *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 FPGMF10FM  CF   E             WORKSTN
0008.00 F                                     SFILE(SFL01 :WRAN01)
0009.00 F                                     INFDS(WDSFL1)
0010.00 FFIF01L    IF   E           K DISK
0011.00 F                                     INFDS(WDSFIF)
0012.00 FFIC02L    IF   E           K DISK
0013.00 DW14              S             14  0
0014.00 DWDAT             S              8
0015.00 DWHEU             S              6
0016.00 DPOPT             S              2
0017.00 DW8               S              8
0018.00 DWHS              S               Z
0019.00 DPNREC            S             10
0020.00 DWS               DS
0021.00 DWSA                      1      4
0022.00 DWMA                      6      7
0023.00 DWJA                      9     10
0024.00 DWHA                     12     13
0025.00 DWIA                     15     16
0026.00 DWKA                     18     19
0027.00 DWMU                     21     26
0028.00 DWASTA                    1     26
0029.00 DWDSPGM          SDS
0030.00 DWLIPGM                   1     10
0031.00 DWSTATU                  11     15  0
0032.00 DWSTPRE                  16     20  0
0033.00 DWSRCSQ                  21     28
0034.00 DWNMROU                  29     36
0035.00 DWNBPAR                  37     39  0
0036.00 DWTYEXC                  40     42
0037.00 DWLICPF                  40     46
0038.00 DWNUEXC                  43     46
0039.00 DWMIODT                  47     50
0040.00 DWZOMES                  51     80
0041.00 DWBIPGM                  81     90
0042.00 DWRTDTA                  91    170
0043.00 DWCOERR                 171    174
0044.00 DWDERFI                 201    208
0045.00 DWFIINF                 209    243
0046.00 DWJOB                   244    253
0047.00 DWUSER                  254    263
0048.00 DWJBNUM                 264    269  0
0049.00 DWDSFL1           DS
0050.00 DWPOSC                  370    371B 0
0051.00 DWRRNG                  376    377B 0
0052.00 DWRNGP                  378    379B 0
0053.00 DWNBRSF                 380    381B 0
0054.00 DWLIGCF                 382    383B 0
0055.00 DWRCMIE                 403    404B 0
0056.00 DWDSFIF           DS
0057.00 DWNRC01                 397    400B 0
0058.00 DWDSFI1           DS
0059.00 DWCDFIL                   1      8
0060.00 DWOPNF                    9      9
0061.00 DWSTFIL                  11     15  0
0062.00 DWOPCOD                  16     21
0063.00 DWRPGSQ                  30     37
0064.00 DWRPGNR                  38     45
0065.00 DWERRFI                  46     52
0066.00 DWNMFIC                  83     92
0067.00 DWNMBIB                  93    102
0068.00 DWSPNOM                 103    112
0069.00 DWSPLIB                 113    122
0070.00 DWSPNBR                 123    124B 0
0071.00 DWLIMBR                 129    138
0072.00 DWNBPUT                 243    246B 0
0073.00 DWNBGET                 247    250B 0
0074.00 DWNBPG                  251    254B 0
0075.00 DWNBIO                  255    258B 0
0076.00 DWRCDFT                 261    270
0077.00 DWNBRCD                 283    286B 0
0078.00 DWNRCFI                 397    400B 0
0079.00 C     SKKCL1        KLIST
0080.00 C                   KFLD                    MIFON
0081.00 C     KKCL01        KLIST
0082.00 C                   KFLD                    MIFON
0083.00 C* initialisations générales
0085.00 C                   SETON                                        0910
0086.00 C                   EXSR      DATHEU
0087.00 C                   MOVE      WDAT          ZDATE
0088.00 C                   MOVE      WHEU          ZHEUR
0089.00 C                   MOVEL     WUSER         ZUSER
0090.00 C                   MOVEL     WJOB          ZJOB
0091.00 C                   MOVEL     ’*  ’         WPGMQ
0092.00 C                   MOVEL     ’CC01’        WMGKEY
0093.00 C                   SETON                                        0910
0094.00 C* Indicateur fin
0095.00 C                   SETON                                        50
0096.00 C* Debut du traitement,
0097.00 C                   EXSR      INITSF
0098.00 C* Boucle d’attente de sortie
0099.00 C                   DOW       *IN50 = ’1’
0100.00 C                   EXSR      TRTSFL
0101.00 C                   END
0102.00 C                   SETON                                        LR
0103.00 C* traitement de l’écran
0104.00 C     TRTSFL        BEGSR
0105.00 C*
0106.00 C                   MOVEL     ’3’           PTYP
0107.00 C                   MOVEL     *BLANK        PFIM
0108.00 C                   MOVEL     *BLANK        PMID
0109.00 C                   CALL      ’PGM001CL’
0110.00 C                   PARM                    PTYP              1
0111.00 C                   PARM                    PFIM             10
0112.00 C                   PARM                    PMID              7
0113.00 C                   PARM                    PMDT             99
0114.00 C                   WRITE     WSFCTL
0115.00 C                   SETON                                        0405
0116.00 C                   WRITE     FORE1                                  70
0117.00 C                   WRITE     FORB1
0118.00 C* attente lecture
0119.00 C                   READ      FORE1                                  70
0120.00 C* chargement de l’heure
0121.00 C                   TIME                    ZHEUR
0122.00 C*
0123.00 C                   SETON                                        51
0124.00 C                   IF        *IN02 = ’1’
0125.00 C* page suivante
0126.00 C                   EXSR      CHGPAG
0127.00 C                   SETOFF                                       51
0128.00 C                   END
0129.00 C*
0130.00 C* touches F3 et F12
0131.00 C                   IF        *INKC = ’1’ OR
0132.00 C                             *INKL = ’1’
0133.00 C* on met l’indicateur à Off
0134.00 C                   SETOFF                                       5051
0135.00 C                   END
0136.00 C*
0137.00 C                   IF        *INKE = ’1’
0138.00 C* F5 Rafraichissement de l’écran
0139.00 C                   EXSR      INITSF
0140.00 C                   SETOFF                                       51
0141.00 C                   END
0142.00 C*
0143.00 C                   IF        *INKF = ’1’
0144.00 C* F6 création d’une nouvelle fonction
0145.00 C                   MOVEL     ’CR’          PCHX
0146.00 C                   MOVEL     *BLANK        NREC
0147.00 C                   CALL      ’PGMF11’
0148.00 C                   PARM                    PCHX              2
0149.00 C                   PARM                    NREC             10
0150.00 C                   EXSR      INITSF
0151.00 C                   SETOFF                                       51
0152.00 C                   END
0153.00 C*
0154.00 C                   IF        *IN51 = ’1’
0155.00 C                   EXSR      TRTOPT
0156.00 C                   END
0157.00 C* on recommence la boucle d’attente
0158.00 C                   ENDSR
0159.00 C* Les Sub Routines
0160.00 C*****************************************
0161.00 C*  Initialisation du sous-fichier
0162.00 C*****************************************
0163.00 C     INITSF        BEGSR
0164.00 C*    l’indicateur 20 conditionne la zone OPT (protection)
0165.00 C                   SETOFF                                       20
0166.00 C*    dernière ligne écrite
0167.00 C                   Z-ADD     0             LSTLIG            4 0
0168.00 C*    compteur de ligne par page
0169.00 C                   Z-ADD     0             NBRLIG            4 0
0170.00 C*    la fameux WRAN01
0171.00 C                   Z-ADD     0             WRAN01            4 0
0172.00 C                   SETON                                        0607
0173.00 C                   SETOFF                                       0405
0174.00 C                   WRITE     FORE1
0175.00 C                   SETOFF                                       06
0176.00 C                   SETON                                        0405
0177.00 C                   EXSR      CHGPAG
0178.00 C*
0179.00 C                   ENDSR
0180.00 C******************************
0181.00 C     TRTOPT        BEGSR
0182.00 C*  Lecture des enregistrements modifiés
0183.00 C                   Z-ADD     1             WRAN01
0184.00 C* top pour rafraichir l’écran
0185.00 C                   SETOFF                                       86
0186.00 C  N70              READC     SFL01                                7070
0187.00 C*
0188.00 C     *IN70         DOWEQ     ’0’
0189.00 C                   MOVE      HNREC         NREC
0190.00 C                   SETON                                        85
0191.00 C                   SELECT
0192.00 C                   WHEN      (ZOPT = ’ ’)
0193.00 C                   SETOFF                                       85
0194.00 C                   WHEN      (ZOPT = ’2’)
0195.00 C                   MOVEL     ’MO’          PCHX
0196.00 C                   WHEN      (ZOPT = ’3’)
0197.00 C                   MOVEL     ’CO’          PCHX
0198.00 C                   WHEN      (ZOPT = ’4’)
0199.00 C                   MOVEL     ’SU’          PCHX
0200.00 C                   WHEN      (ZOPT = ’5’)
0201.00 C                   MOVEL     ’AF’          PCHX
0202.00 C                   OTHER
0203.00 C                   SETOFF                                       85
0204.00 C* envoyer un message pour dire que l’option n’existe pas
0205.00 C                   MOVEL     ’1’           PTYP
0206.00 C                   MOVEL     ’FICMSG   ’   PFIM
0207.00 C                   MOVEL     ’MSG0002’     PMID
0208.00 C                   CALL      ’PGM001CL’
0209.00 C                   PARM                    PTYP              1
0210.00 C                   PARM                    PFIM             10
0211.00 C                   PARM                    PMID              7
0212.00 C                   PARM                    PMDT             99
0213.00 C                   ENDSL
0214.00 C                   MOVEL     *BLANK        ZOPT
0215.00 C                   UPDATE    SFL01                                90
0216.00 C* on aurait pu aussi faire IF ....
0217.00 C   85              CALL      ’PGMF11’
0218.00 C                   PARM                    PCHX              2
0219.00 C                   PARM                    NREC             10
0220.00 C   85              SETON                                        86
0221.00 C                   READC     SFL01                                7070
0222.00 C                   END
0223.00 C   86              EXSR      INITSF
0224.00 C                   ENDSR
0225.00 C*************************************
0226.00 C     CHGPAG        BEGSR
0227.00 C*  chargement de la page
0228.00 C                   SETOFF                                       08
0229.00 C*                  SETON                                        04
0230.00 C                   Z-ADD     LSTLIG        WRAN01
0231.00 C     *LOVAL        SETLL     FIFF                                   70
0232.00 C                   READ      FIFF                                   70
0233.00 C                   Z-ADD     0             NBRLIG            4 0
0234.00 C*
0235.00 C     *IN70         DOWEQ     ’0’
0236.00 C     NBRLIG        ANDLT     15
0237.00 C* remplissage des zones écran
0238.00 C                   MOVEL     MIFON         ZCOD
0239.00 C* on tronque à l’affichage
0240.00 C                   MOVEL     MILIB         ZLIB
0241.00 C* conversion de la date
0242.00 C                   TEST (Z)                MITSC                  90
0243.00 C     *IN90         IFEQ      ’1’
0244.00 C                   MOVEL     *LOVAL        WHS
0245.00 C                   ELSE
0246.00 C                   MOVEL     MITSC         WHS
0247.00 C                   END
0248.00 C                   EXSR      CVTDAT
0249.00 C                   MOVE      W8            ZDAC
0250.00 C                   TEST (Z)                MITSM                  90
0251.00 C     *IN90         IFEQ      ’1’
0252.00 C                   MOVEL     *LOVAL        WHS
0253.00 C                   ELSE
0254.00 C                   MOVEL     MITSM         WHS
0255.00 C                   END
0256.00 C                   EXSR      CVTDAT
0257.00 C                   MOVE      W8            ZDAM
0258.00 C* la on met une petite complication qui ralentit fortement le traitement
0259.00 C                   Z-ADD     0             ZNBEM
0260.00 C     KKCL01        CHAIN     FICF                               7190
0261.00 C* la clé est la code fonction lu dans le fichier des codes
0262.00 C                   DOW       *IN71 = ’0’
0263.00 C* lecture de tous les employés ayant le même code
0264.00 C     ZNBEM         ADD       1             ZNBEM
0265.00 C     KKCL01        READE     FICF                                 9071
0266.00 C                   ENDDO
0267.00 C* pour récupérer le numéro d’enregistrement
0268.00 C                   MOVEL     WDSFIF        WDSFI1
0269.00 C                   Z-ADD     WNRCFI        HNREC
0270.00 C                   ADD       1             NBRLIG
0271.00 C                   ADD       1             WRAN01
0272.00 C                   ADD       1             LSTLIG            4 0
0273.00 C                   WRITE     SFL01
0274.00 C* lecture du suivant
0275.00 C                   READ      FIFF                                   70
0276.00 C                   END
0277.00 C* on quitte la boucle soit en fin de page
0278.00 C*                     soit en fin de fichier
0279.00 C     *IN70         IFEQ      ’1’
0280.00 C* le caractère de suite
0281.00 C                   SETON                                        07
0282.00 C                   END
0283.00 C* si le fichier est vide
0284.00 C     WRAN01        IFEQ      0
0285.00 C                   Z-ADD     1             NBRLIG
0286.00 C                   Z-ADD     1             LSTLIG            4 0
0287.00 C* un petit message
0288.00 C                   Z-ADD     1             WRAN01
0289.00 C* pas de saisie d’option
0290.00 C                   SETON                                        20
0291.00 C                   eval      ZLIB = ’Sélection Vide   ‘
0292.00 C                   MOVEL     *BLANK        ZCOD
0293.00 C                   Z-ADD     0             HNREC
0294.00 C                   WRITE     SFL01
0295.00 C                   END
0296.00 C* le WRAN01 à 1 pour afficher le premier enregistrement
0297.00 C                   Z-ADD     1             WRAN01
0298.00 C                   ENDSR
0299.00 C* chargement de la date et heure système
0300.00 C     DATHEU        BEGSR
0301.00 C                   TIME                    W14
0302.00 C                   MOVE      W14           WDAT
0303.00 C                   MOVEL     W14           WHEU
0304.00 C                   ENDSR
0305.00 C* conversion de la date
0306.00 C     CVTDAT        BEGSR
0307.00 C                   MOVEL     WHS           WASTA
0308.00 C* la DS découpe les valeurs que l’on concatène
0309.00 C                   EVAL      W8 = WJA+ WMA+ WSA
0310.00 C* il ne reste plus qu’a charger dans la zone écran
0311.00 C                   ENDSR
