0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F**********************************************************************
0003.00 F* CC 01/01/2009
0004.00 F* Liste du personnel
0005.00 F**********************************************************************
0006.00 F* Déclaration des fichiers
0007.00 FPGMF01FM  CF   E             WORKSTN
0008.00 F                                     SFILE(SFL01 :WRAN01)
0009.00 F                                     INFDS(DSSFL1)
0010.00 FFIC02L    IF   E           K DISK
0011.00 F                                     INFDS(FIC)
0012.00 F* Déclaration des variables
0013.00 DWDAT             S              8
0014.00 DWHEU             S              6
0015.00 DW14              S             14  0
0016.00 DWSNOM            S             35
0017.00 DWSNOP            S             35
0018.00 DI                S              3  0
0019.00 D* La DS du programme, noter le S indispensable
0020.00 DDSPROG          SDS
0021.00 DWNPROG                   1     10
0022.00 DWSTATP                  11     15  0
0023.00 DWSTAPR                  16     20  0
0024.00 DWSQSRC                  21     28
0025.00 DWSBROU                  29     36
0026.00 DWNPARM                  37     39  0
0027.00 DWTYEXC                  40     42
0028.00 DWNMSGM                  40     46
0029.00 DWNMEXC                  43     46
0030.00 DWINSMC                  47     50
0031.00 DWZOMSG                  51     80
0032.00 DWLBPGM                  81     90
0033.00 DWSFDTA                  91    170
0034.00 DWCDERR                 171    174
0035.00 DWLSFIL                 201    208
0036.00 DWLSINF                 209    243
0037.00 DWJOB                   244    253
0038.00 DWUSER                  254    263
0039.00 DWNJOB                  264    269  0
0040.00 D* La DS du sous=fichier
0041.00 DDSSFL1           DS
0042.00 DWPOSC                  370    371B 0
0043.00 DWRRNG                  376    377B 0
0044.00 DWRNGP                  378    379B 0
0045.00 DWNBRSF                 380    381B 0
0046.00 D* La DS du fichier
0047.00 DFIC              DS
0048.00 DWNRC01                 397    400B 0
0049.00 DWDSFIC           DS
0050.00 DWCDFIL                   1      8
0051.00 DWOPENF                   9      9
0052.00 DWSTSFI                  11     15  0
0053.00 DWOPCOD                  16     21
0054.00 DWRPGSQ                  30     37
0055.00 DWRPGNR                  38     45
0056.00 DWERRFI                  46     52
0057.00 DWNFICH                  83     92
0058.00 DWNLIBR                  93    102
0059.00 DWSPNAM                 103    112
0060.00 DWSPLIB                 113    122
0061.00 DWSPNUM                 123    124B 0
0062.00 DWLIMBR                 129    138
0063.00 DWNBPUT                 243    246B 0
0064.00 DWNBGET                 247    250B 0
0065.00 DWNBPG                  251    254B 0
0066.00 DWNBIO                  255    258B 0
0067.00 DWRCDFT                 261    270
0068.00 DWNBRCD                 283    286B 0
0069.00 DWNRCFI                 397    400B 0
0070.00 C* la clé d’accés au fichier
0071.00 C     KEY001        KLIST
0072.00 C                   KFLD                    FIFON
0073.00 C                   KFLD                    FINOM
0074.00 C* le nombre de lignes affichables, déclaration à la volée
0075.00 C                   Z-ADD     14            NBLIS1            4 0
0076.00 C* initialisation des variables générales
0077.00 C                   MOVEL     WNPROG        ZPGM
0078.00 C                   EXSR      DATHEU
0079.00 C                   MOVE      WDAT          ZDATE
0080.00 C                   MOVE      WHEU          ZHEUR
0081.00 C                   MOVEL     WUSER         ZUSER
0082.00 C                   MOVEL     WJOB          ZJOB
0083.00 C* Initialisation du sous fichier des messages
0084.00 C                   MOVEL     ’*  ’         WPGMQ
0085.00 C                   MOVEL     ’CC01’        WMGKEY
0086.00 C                   SETON                                        0910
0087.00 C* Indicateur fin
0088.00 C                   SETON                                        50
0089.00 C* Début du traitement,
0090.00 C                   EXSR      INITSF
0091.00 C* Boucle d’attente de sortie
0092.00 C                   DOW       *IN50 = ’1’
0093.00 C                   EXSR      TRTSFL
0094.00 C                   END
0095.00 C* Indicateur de fin de programme
0096.00 C                   SETON                                        LR
0097.00 C* Les procédures
0098.00 C* Traitement de l’écran
0099.00 C     TRTSFL        BEGSR
0100.00 C* Effacement du sous=fichier de messages
0101.00 C                   MOVEL     ’3’           PTYP
0102.00 C                   MOVEL     *BLANK        PFIM
0103.00 C                   MOVEL     *BLANK        PMID
0104.00 C                   CALL      ’PGM001CL’
0105.00 C                   PARM                    PTYP              1
0106.00 C                   PARM                    PFIM             10
0107.00 C                   PARM                    PMID              7
0108.00 C                   PARM                    PMDT             99
0109.00 C                   WRITE     WSFCTL
0110.00 C* Ecriture de l’écran
0111.00 C                   SETON                                        0405
0112.00 C                   WRITE     FORE1                                  70
0113.00 C                   WRITE     FORB1
0114.00 C* Attente lecture
0115.00 C                   READ      FORE1                                  70
0116.00 C* Une touche a été actionnée
0117.00 C* Chargement de l’heure
0118.00 C                   TIME                    ZHEUR
0119.00 C* Indicateur pour ne pas tester d’autres actions
0120.00 C                   SETON                                        51
0121.00 C                   IF        *IN02 = ’1’
0122.00 C* page suivante
0123.00 C                   EXSR      CHGPAG
0124.00 C                   SETOFF                                       51
0125.00 C                   END
0126.00 C*
0127.00 C   51              IF        WSNOP <> ZSNOM
0128.00 C* Test si selection/ si changé on initialise
0129.00 C                   EXSR      INITSF
0130.00 C                   SETOFF                                       51
0131.00 C                   END
0132.00 C* touches F3 et F12
0133.00 C                   IF        *INKC = ’1’ OR
0134.00 C                             *INKL = ’1’
0135.00 C* on met l’indicateur à Off = fin du programme
0136.00 C                   SETOFF                                       5051
0137.00 C                   END
0138.00 C*
0139.00 C                   IF        *INKE = ’1’
0140.00 C* F5 Rafraichissement de l’écran
0141.00 C                   EXSR      INITSF
0142.00 C                   SETOFF                                       51
0143.00 C                   END
0144.00 C*
0145.00 C                   IF        *INKF = ’1’
0146.00 C* F6 création d’un nouveau matricule
0147.00 C                   MOVEL     ’CR’          PCHX
0148.00 C                   MOVEL     *BLANK        NREC
0149.00 C                   CALL      ’PGMF02’
0150.00 C                   PARM                    PCHX              2
0151.00 C                   PARM                    NREC             10
0152.00 C                   EXSR      INITSF
0153.00 C                   SETOFF                                       51
0154.00 C                   END
0155.00 C                   IF        *INKH = ’1’
0156.00 C* F8 impression du fichier
0157.00 C                   MOVEL     *BLANK        PMAT
0158.00 C* On appelle le CL de routage sans soumission, sinon PGMF20CL
0159.00 C                   CALL      ’PGMF2SCL’
0160.00 C                   PARM                    PMAT             10
0161.00 C                   SETOFF                                       51
0162.00 C                   END
0163.00 C* On ne fait ceci que s’il n’y a eu rien d’autre
0164.00 C                   IF        *IN51 = ’1’
0165.00 C                   EXSR      TRTOPT
0166.00 C                   END
0167.00 C* On recommence la boucle d’attente
0168.00 C                   ENDSR
0169.00 C* Initialisation du sous-fichier
0170.00 C     INITSF        BEGSR
0171.00 C*    l’indicateur 20 conditionne la zone OPT (protection)
0172.00 C                   SETOFF                                       20
0173.00 C* Initialisation de la variable de sélection
0174.00 C                   MOVEL     ZSNOM         WSNOP
0175.00 C                   MOVEL     *BLANK        WSNOM
0176.00 C* Initialisation de la clé pour positionnement
0177.00 C                   MOVEL     *BLANK        FIFON
0178.00 C                   MOVEL     *BLANK        FINOM
0179.00 C                   SETOFF                                       8485
0180.00 C                   IF        ZSNOM <> *BLANK
0181.00 C* Si différent de blank il y a sélection
0182.00 C                   SETON                                        84
0183.00 C                   Z-ADD     0             I
0184.00 C     ’*’           SCAN      ZSNOM         I                      85
0185.00 C                   IF        I > 0
0186.00 C     I             SUB       1             I
0187.00 C     I             SUBST (P) ZSNOM:1       WSNOM                  90
0188.00 C* On est dans le cas d’une sélection générique
0189.00 C                   SETON                                          85
0190.00 C* On se positionnera juste au bon endroit dans le fichier
0191.00 C                   MOVEL     WSNOM         FINOM
0192.00 C                   END
0193.00 C                   END
0194.00 C* La dernière ligne écrite
0195.00 C                   Z-ADD     0             LSTLIG            4 0
0196.00 C* Le compteur de ligne par page
0197.00 C                   Z-ADD     0             NBRLIG            4 0
0198.00 C* Le fameux WRAN01
0199.00 C                   Z-ADD     0             WRAN01            4 0
0200.00 C* Effacement du sous=fichier
0201.00 C                   SETON                                        0607
0202.00 C                   SETOFF                                       0405
0203.00 C                   WRITE     FORE1
0204.00 C                   SETOFF                                       06  
0205.00 C                   SETON                                        0405
0206.00 C* Positionnement en début de fichier
0207.00 C     KEY001        SETLL     FICF                                   70
0208.00 C* Chargement de la première page
0209.00 C                   EXSR      CHGPAG
0210.00 C                   ENDSR
0211.00 C* Traitement des options, on ne lit que les enregistrements modifiés
0212.00 C     TRTOPT        BEGSR
0213.00 C* Lecture des enregistrements modifiés
0214.00 C                   Z-ADD     1             WRAN01
0215.00 C* Top pour rafraîchir l’écran, si besoin
0216.00 C                   SETOFF                                       86
0217.00 C  N70              READC     SFL01                                7070
0218.00 C*
0219.00 C     *IN70         DOWEQ     ’0’
0220.00 C                   MOVE      HNREC         NREC
0221.00 C                   IF        HTOUT = ’1’
0222.00 C                   IF        ZOPT=’2’ OR ZOPT=’3’ OR ZOPT=’4’ OR ZOPT=
0223.00 C* Si l’employé à quitté on ne peut plus rien modifier
0224.00 C                   MOVE      ’5 ’          ZOPT
0225.00 C                   END
0226.00 C                   END
0227.00 C                   SETON                                        85
0228.00 C* Selection en fonction du choix saisi
0229.00 C                   SELECT
0230.00 C                   WHEN      (ZOPT = ’2’) OR (ZOPT = ’ 2’)
0231.00 C                   MOVEL     ’MO’          PCHX
0232.00 C                   WHEN      (ZOPT = ’3’) OR (ZOPT = ’ 3’)
0233.00 C                   MOVEL     ’CO’          PCHX
0234.00 C                   WHEN      (ZOPT = ’4’) OR (ZOPT = ’ 4’)
0235.00 C                   MOVEL     ’SU’          PCHX
0236.00 C                   WHEN      (ZOPT = ’5’) OR (ZOPT = ’ 5’)
0237.00 C                   MOVEL     ’AF’          PCHX
0238.00 C                   WHEN      (ZOPT = ’6’) OR (ZOPT = ’ 6’)
0239.00 C                   MOVE      HMATR         PMAT
0240.00 C                   CALL      ’PGMF2SCL’
0241.00 C                   PARM                    PMAT             10
0242.00 C                   SETOFF                                       85
0243.00 C                   WHEN      (ZOPT = ’99’)
0244.00 C                   MOVEL     ’PE’          PCHX
0245.00 C                   OTHER
0246.00 C* La saisie ne correspond à rien
0247.00 C                   SETOFF                                       85
0248.00 C* Envoyer un message pour dire que l’option n’existe pas
0249.00 C                   MOVEL     ’1’           PTYP
0250.00 C                   MOVEL     ’FICMSG   ’   PFIM
0251.00 C                   MOVEL     ’MSG0002’     PMID
0252.00 C                   CALL      ’PGM001CL’
0253.00 C                   PARM                    PTYP              1
0254.00 C                   PARM                    PFIM             10
0255.00 C                   PARM                    PMID              7
0256.00 C                   PARM                    PMDT             99
0257.00 C                   ENDSL
0258.00 C                   IF        HTOUT = ’0’
0259.00 C* Pour ne pas perdre l’attribut couleur
0260.00 C                   SETOFF                                       30
0261.00 C                   ELSE
0262.00 C                   SETON                                        30
0263.00 C                   END
0264.00 C* Nettoyage
0265.00 C                   MOVEL     *BLANK        ZOPT
0266.00 C                   UPDATE    SFL01                                90
0267.00 C* On aurait pu aussi faire IF..., en tout cas le choix est bon
0268.00 C   85              CALL      ’PGMF02’
0269.00 C                   PARM                    PCHX              2
0270.00 C                   PARM                    NREC             10
0271.00 C   85              SETON                                        86
0272.00 C* On continue de boucler si autre option
0273.00 C                   READC     SFL01                                7070
0274.00 C                   END
0275.00 C* Potentiellement il y a eu mise à jour, on pourrait affiner
0276.00 C   86              EXSR      INITSF
0277.00 C                   ENDSR
0278.00 C* Chargement d’une page
0279.00 C     CHGPAG        BEGSR
0280.00 C* Il faut positionner correctement les indicateurs et les variables
0281.00 C                   SETOFF                                       08
0282.00 C*                  SETON                                        04
0283.00 C                   Z-ADD     LSTLIG        WRAN01
0284.00 C* Lexture de l’enregistrement suivant
0285.00 C                   READ      FICF                                   70
0286.00 C* Remise à zéro du compteur de ligne, mais on pourrait faire autrement
0287.00 C                   Z-ADD     0             NBRLIG            4 0
0288.00 C*
0289.00 C     *IN70         DOWEQ     ’0’
0290.00 C     NBRLIG        ANDLT     14
0291.00 C* Remplissage des zones écran
0292.00 C                   SETON                                        86
0293.00 C* Test s’il y a sélection
0294.00 C                   IF        *IN84 = ’1’ OR *IN85 = ’1’
0295.00 C                   IF        *IN84 = ’1’ AND *IN85 = ’0’
0296.00 C* On recherche la stricte égalité de nom
0297.00 C                   IF        FINOM <> ZSNOM
0298.00 C                   SETOFF                                       86
0299.00 C                   END
0300.00 C                   ELSE
0301.00 C* On recherche si le nom commence par la valeur avant le ’*’
0302.00 C     I             SUBST (P) FINOM:1       WXNOM            35    90
0303.00 C* Petite entorse de flemmard WXNOM est déclarée au fil de l’eau
0304.00 C                   IF        WXNOM <> WSNOM
0305.00 C                   SETOFF                                       86
0306.00 C                   END
0307.00 C                   END
0308.00 C                   END
0309.00 C* L’indicateur est à ’1’ si sélection OK ou pas de sélection
0310.00 C                   IF        *IN86 = ’1’
0311.00 C                   MOVEL     FINOM         ZNOM
0312.00 C                   MOVEL     FIPR1         ZPR1
0313.00 C                   MOVEL     FIFON         ZFONC
0314.00 C                   Z-ADD     FIMAT         ZMATR
0315.00 C                   MOVEL     FICPO         ZCPO
0316.00 C                   MOVEL     FIC           WDSFIC
0317.00 C                   Z-ADD     WNRCFI        HNREC
0318.00 C                   MOVE      FIMAT         HMATR
0319.00 C                   IF        FIDAS = 0
0320.00 C* Top salarié licencié
0321.00 C                   MOVE      ’0’           HTOUT
0322.00 C                   SETOFF                                       30
0323.00 C                   ELSE
0324.00 C                   MOVE      ’1’           HTOUT
0325.00 C                   SETON                                        30
0326.00 C                   END
0327.00 C* Les compteurs, attention au WRAN01
0328.00 C                   ADD       1             NBRLIG
0329.00 C                   ADD       1             LSTLIG
0330.00 C                   ADD       1             WRAN01
0331.00 C* Ecriture de la ligne
0332.00 C                   WRITE     SFL01
0333.00 C                   END
0334.00 C* Lecture du suivant
0335.00 C                   READ      FICF                                   70
0336.00 C                   END
0337.00 C* On quitte la boucle soit en fin de page
0338.00 C*                     soit en fin de fichier
0339.00 C     *IN70         IFEQ      ’1’
0340.00 C* Le caractère de suite, on est en fin de fichier 
0341.00 C                   SETON                                        07
0342.00 C                   ELSE
0343.00 C                   SETOFF                                       07
0344.00 C                   END
0345.00 C* Si le fichier est vide
0346.00 C     WRAN01        IFEQ      0
0347.00 C                   Z-ADD     1             NBRLIG
0348.00 C                   Z-ADD     1             LSTLIG            4 0
0349.00 C* Un petit message
0350.00 C                   Z-ADD     1             WRAN01
0351.00 C* Pas de saisie d’option
0352.00 C                   SETON                                        20
0353.00 C                   IF        ZSNOM = *BLANK
0354.00 C* Si on a un vieil AS/400 du siècle dernier
0355.00 C                   MOVEL     ’Fic. Vide’   ZNOM
0356.00 C                   ELSE
0357.00 C* En RPG ILE
0358.00 C                   eval      ZNOM = ’Sélection Vide’
0359.00 C                   END
0360.00 C* Ne pas oublier de remettre à blanc
0361.00 C                   MOVEL     *BLANK        ZPR1
0362.00 C                   MOVEL     *BLANK        ZFONC
0363.00 C                   Z-ADD     0             ZMATR
0364.00 C                   MOVEL     *BLANK        ZCPO
0365.00 C                   MOVEL     *BLANK        WDSFIC
0366.00 C                   Z-ADD     0             HNREC
0367.00 C* Ecriture du message sur la première ligne
0368.00 C                   WRITE     SFL01
0369.00 C                   END
0370.00 C* le WRAN01 à 1 pour afficher le premier enregistrement
0371.00 C*                  Z-ADD     LSTLIG        WRAN01
0372.00 C                   ENDSR
0373.00 C* Lecture date et heure système
0374.00 C     DATHEU        BEGSR
0375.00 C                   TIME                    W14
0376.00 C                   MOVE      W14           WDAT
0377.00 C                   MOVEL     W14           WHEU
0378.00 C                   ENDSR
