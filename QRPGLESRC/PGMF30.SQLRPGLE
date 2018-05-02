0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Liste outq                                        *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 FPGMF30FM  CF   E             WORKSTN
0008.00 F                                     SFILE(SFL01 :WRAN01)
0009.00 F                                     INFDS(DSSFL1)
0010.00 FFIO01L    IF A E           K DISK
0011.00 F                                     INFDS(WDSFIC)
0012.00 FFIO00P    UF   E             DISK
0013.00 F                                     RENAME(FIOF      :FIOFP)
0014.00 DWTXT1            C                   ’DSPOBJD OBJ(’
0015.00 DWTXT2            C                   ’) OBJTYPE(*USRPRF) OUTPUT(*PRINT)’
0016.00 DWTXT3            C                   ’) OBJTYPE(*OUTQ) OUTPUT(*PRINT)’
0017.00      DW14              S             14  0
0018.00      DWDAT             S              8
0019.00      DWHEU             S              6
0020.00      DWCMD             S            256
0021.00      DWLNG             S             15  5
0022.00      DPNREC            S             10
0023.00      DW10              S             10
0024.00      DWSUSR            S             10
0025.00      DWSDOC            S             10
0026.00      DWSPRT            S             10
0027.00      DDSPROG          SDS
0028.00      DWNPROG                   1     10
0029.00      DWSTATP                  11     15  0
0030.00      DWSTAPR                  16     20  0
0031.00      DWSQSRC                  21     28
0032.00      DWSBROU                  29     36
0033.00      DWNPARM                  37     39  0
0034.00      DWTYEXC                  40     42
0035.00      DWNMSGM                  40     46
0036.00      DWNMEXC                  43     46
0037.00      DWINSMC                  47     50
0038.00      DWZOMSG                  51     80
0039.00      DWLBPGM                  81     90
0040.00      DWSFDTA                  91    170
0041.00      DWCDERR                 171    174
0042.00      DWLSFIL                 201    208
0043.00      DWLSINF                 209    243
0044.00      DWJOB                   244    253
0045.00      DWUSER                  254    263
0046.00      DWNJOB                  264    269  0
0047.00      DDSSFL1           DS
0048.00      DWPOSC                  370    371B 0
0049.00      DWRRNG                  376    377B 0
0050.00      DWRNGP                  378    379B 0
0051.00      DWNBRSF                 380    381B 0
0052.00      DWNLIGF                 382    383B 0
0053.00      DWNRCME                 403    404B 0
0054.00      DWDSFIC           DS
0055.00      DWCDFIL                   1      8
0056.00      DWOPENF                   9      9
0057.00      DWSTSFI                  11     15  0
0058.00      DWOPCOD                  16     21
0059.00      DWRPGSQ                  30     37
0060.00      DWRPGNR                  38     45
0061.00      DWERRFI                  46     52
0062.00      DWNFICH                  83     92
0063.00      DWNLIBR                  93    102
0064.00      DWSPNAM                 103    112
0065.00      DWSPLIB                 113    122
0066.00      DWSPNUM                 123    124B 0
0067.00      DWLIMBR                 129    138
0068.00      DWNBPUT                 243    246B 0
0069.00      DWNBGET                 247    250B 0
0070.00      DWNBPG                  251    254B 0
0071.00      DWNBIO                  255    258B 0
0072.00      DWRCDFT                 261    270
0073.00      DWNBRCD                 283    286B 0
0074.00      DWNRCFI                 397    400B 0
0075.00      C     SKEY01        KLIST
0076.00      C                   KFLD                    FOUSR
0077.00      C     KEY001        KLIST
0078.00      C                   KFLD                    ZMUSR
0079.00      C                   KFLD                    ZMDOC
0080.00      C                   KFLD                    ZMPRT
0081.00      C                   Z-ADD     14            NBLIS1            4 0
0082.00      C                   MOVEL     ’*   ’        WPGMQ
0083.00      C                   MOVEL     ’CC01’        WMGKEY
0084.00      C* Programme Liste des Outq
0085.00      C* initialisations générales
0086.00      C                   Z-ADD     256           WLNG
0087.00      C                   MOVEL     WNPROG        ZPGM
0088.00      C                   EXSR      DATHEU
0089.00      C                   MOVE      WDAT          ZDATE
0090.00      C                   MOVE      WHEU          ZHEUR
0091.00      C                   MOVEL     WUSER         ZUSER
0092.00      C                   MOVEL     WJOB          ZJOB
0093.00      C                   SETON                                        091050
0094.00      C* Debut du traitement,
0095.00      C                   EXSR      INITSF
0096.00      C* Boucle d’attente de sortie
0097.00      C                   DOW       *IN50 = ’1’
0098.00      C                   EXSR      TRTSFL
0099.00      C                   END
0100.00      C                   SETON                                        LR
0101.00      C* traitement ecran
0102.00      C     TRTSFL        BEGSR
0103.00      C********************************
0104.00      C                   MOVEL     ’3’           PTYP
0105.00      C                   MOVEL     *BLANK        PFIM
0106.00      C                   MOVEL     *BLANK        PMID
0107.00      C                   CALL      ’PGM001CL’
0108.00      C                   PARM                    PTYP              1
0109.00      C                   PARM                    PFIM             10
0110.00      C                   PARM                    PMID              7
0111.00      C                   PARM                    PMDT             99
0112.00      C* mise à blanc du sous fichier de messages
0113.00      C                   WRITE     WSFCTL
0114.00      C                   SETON                                        0405
0115.00      C* ecriture de l’écran
0116.00      C                   WRITE     FORE1                                  70
0117.00      C                   WRITE     FORB1
0118.00      C* attente lecture
0119.00      C                   READ      FORE1
0120.00      C* chargement de l’heure
0121.00      C                   EXSR      DATHEU
0122.00      C                   MOVE      WDAT          ZDATE
0123.00      C                   MOVE      WHEU          ZHEUR
0124.00      C                   SETON                                          5185
0125.00      C                   IF        WSUSR <> ZSUSR OR
0126.00      C                             WSDOC <> ZSDOC OR
0127.00      C                             WSPRT <> ZSPRT
0128.00      C                   EXSR      INITSF
0129.00      C                   SETOFF                                         51
0130.00      C                   END
0131.00      C* touches F3 et F12
0132.00      C   51              IF        *INKC = ’1’ OR
0133.00      C                             *INKL = ’1’
0134.00      C* on met l’indicateur à Off
0135.00      C                   SETOFF                                       5051
0136.00      C                   END
0137.00      C* la suite n’est exécutée que si indicateur 51 = ’1’
0138.00      C   51              IF        *IN02 = ’1’
0139.00      C* page suivante
0140.00      C                   EXSR      CHGPAG
0141.00      C                   SETOFF
0142.00      C                   END
0143.00      C*
0144.00      C   51              IF        *INKF = ’1’
0145.00      C* fonction création
0146.00      C     LSTLIG        ADD       1             LSTLIG
0147.00      C                   Z-ADD     LSTLIG        WRAN01
0148.00      C                   MOVEL     *BLANK        ZMUSR
0149.00      C                   MOVEL     *BLANK        ZMPRT
0150.00      C                   MOVEL     *BLANK        ZMDOC
0151.00      C* on rajoute une ligne à saisir dans le sous fichier
0152.00      C                   WRITE     SFL01
0153.00      C*                  SETON
0154.00      C                   SETOFF
0155.00      C                   ENDIF
0156.00      C   51              IF        *INKP = ’1’
0157.00      C* ménage profils et outq inconnus
0158.00      C                   Z-ADD     0             HNREC
0159.00      C                   READ      FIOFP                                9070
0160.00      C                   DOW       *IN70 = ’0’
0161.00      C                   EVAL      W10 = FOUSR
0162.00      C                   SETOFF                                         86
0163.00      C                   EXSR      EXECMD
0164.00      C                   IF        *IN90 = ’1’
0165.00      C                   DELETE    FIOFP
0166.00      C                   SETON                                        85
0167.00      C                   ELSE
0168.00      C                   EVAL      W10 = FOOUQ
0169.00      C                   SETON                                          86
0169.00      C                   SETON
0170.00      C                   EXSR      EXECMD
0171.00      C                   IF        *IN90 = ’1’
0172.00      C                   DELETE    FIOFP
0173.00      C                   SETON                                        85
0174.00      C                   END
0175.00      C                   END
0176.00      C                   READ      FIOFP                                9070
0177.00      C                   ENDDO
0178.00      C                   END
0179.00      C* vérification saisie/choix
0180.00      C   51              EXSR      CTLDTA
0181.00      C* en cas de modification on rafraichit l’écran
0182.00      C   85              EXSR      INITSF
0183.00      C* on recommence la boucle d’attente
0184.00      C                   ENDSR
0185.00      C* initialisation du sous fichier
0186.00      C     INITSF        BEGSR
0187.00      C                   eval      WSUSR = ZSUSR
0188.00      C                   eval      WSDOC = ZSDOC
0189.00      C                   eval      WSPRT = ZSPRT
0190.00      C* La dernière ligne écrite
0191.00      C                   Z-ADD     0             LSTLIG            4 0
0192.00      C* Le compteur de ligne par page
0193.00      C                   Z-ADD     0             NBRLIG            4 0
0194.00      C* Le fameux WRAN01
0195.00      C                   Z-ADD     0             WRAN01            4 0
0196.00      C* Effacement du sous=fichier
0197.00      C                   SETON                                        0607
0198.00      C                   SETOFF                                       0405
0199.00      C                   WRITE     FORE1
0200.00      C                   SETOFF                                       06
0201.00      C                   SETON                                        0405
0202.00      C* Positionnement en début de fichier
0203.00      C                   MOVEL     *LOVAL        FOUSR
0204.00      C     SKEY01        SETLL     FIOF
0205.00      C* Chargement de la première page
0206.00      C                   EXSR      CHGPAG
0207.00      C                   ENDSR
0208.00      C* vérification des données
0209.00      C     CTLDTA        BEGSR
0210.00      C********************
0211.00      C* lecture des enregistrements modifiés
0212.00      C                   Z-ADD     1             WRAN01
0213.00      C* Top pour rafraichir l’écran, si besoin
0214.00      C                   SETOFF                                       86
0215.00      C  N70              READC     SFL01
0216.00      C* boucle de lecture
0217.00      C     *IN70         DOWEQ     ’0’
0218.00      C                   MOVEL     ’1’           *IN85
0219.00      C* si les trois champs sont remis à blank = suppression
0220.00      C                   IF        ZMUSR = *BLANK AND
0221.00      C                             ZMPRT = *BLANK AND
0222.00      C                             ZMDOC = *BLANK
0223.00      C     HNREC         CHAIN     FIOFP                              7
0224.00      C                   IF        *IN71  = ’0’
0225.00      C                   DELETE    FIOFP
0226.00      C                   END
0227.00      C                   ELSE
0228.00      C     KEY001        CHAIN     FIOF                               7
0229.00      C                   IF        *IN71 = ’0’
0230.00      C* pas bon du tout
0231.00      C                   MOVEL     ’0’           *IN85
0232.00      C                   ELSE
0233.00      C* le user doit exister
0234.00      C                   EVAL      W10 = ZMUSR
0235.00      C                   EXSR      EXECMD
0236.00      C                   IF        *IN90 = ’1’
0237.00      C                   MOVEL     ’0’           *IN85
0238.00      C                   MOVEL     ’MSG0005’     WMGID            10
0239.00      C                   END
0240.00      C* et la outq aussi
0241.00      C                   IF        *IN85 = ’1’
0242.00      C                   EVAL      W10  =  ZMPRT
0243.00      C                   SETON
0244.00      C                   EXSR      EXECMD
0245.00      C                   IF        *IN90 = ’1’
0246.00      C                   MOVEL     ’0’           *IN85
0247.00      C                   MOVEL     ’MSG0006’     WMGID            10
0248.00      C                   END
0249.00      C                   END
0250.00      C                   END
0251.00      C* si c’est ok
0252.00      C                   IF        *IN85 = ’1’
0253.00      C                   MOVEL     ZMUSR         FOUSR
0254.00      C                   MOVEL     ZMDOC         FODOC
0255.00      C                   MOVEL     ZMPRT         FOOUQ
0256.00      C                   WRITE     FIOF
0257.00      C                   ELSE
0258.00      C* message d’erreur
0259.00      C                   END
0260.00      C                   END
0261.00      C* mise à jour du sous fichier
0262.00      C                   UPDATE    SFL01
0263.00      C* lecture du suivant
0264.00      C                   READC     SFL01
0265.00      C                   END
0266.00      C                   ENDSR
0267.00      C**********************************
0268.00      C     CHGPAG        BEGSR
0269.00      C*  chargement de la page
0270.00      C                   SETOFF                                       08
0271.00      C*                  SETON                                        04
0272.00      C                   Z-ADD     LSTLIG        WRAN01
0273.00      C                   READ      FIOF
0274.00      C                   Z-ADD     0             NBRLIG            4 0
0275.00      C*
0276.00      C     *IN70         DOWEQ     ’0’
0277.00      C     NBRLIG        ANDLT     14
0278.00      C* remplissage des zones écran
0279.00      C                   SETON                                        86 
0280.00      C                   IF        ( FOUSR = ZSUSR OR
0281.00      C                             ZSUSR = *BLANK) AND
0282.00      C                             ( FODOC = ZSDOC OR
0283.00      C                             ZSDOC = *BLANK) AND
0284.00      C                             ( FOOUQ = ZSPRT OR
0285.00      C                             ZSPRT = *BLANK)
0286.00      C* On recherche la stricte égalité
0287.00      C                   MOVEL     FOUSR         ZMUSR
0288.00      C                   MOVEL     FODOC         ZMDOC
0289.00      C                   MOVEL     FOOUQ         ZMPRT
0290.00      C                   Z-ADD     WNRCFI        HNREC
0291.00      C                   ADD       1             NBRLIG
0292.00      C                   ADD       1             WRAN01
0293.00      C                   ADD       1             LSTLIG            4 0
0294.00      C                   WRITE     SFL01
0295.00      C                   END
0296.00      C* lecture du suivant
0297.00      C                   READ      FIOF
0298.00      C                   END
0299.00      C* on quitte la boucle soit en fin de page
0300.00      C*                     soit en fin de fichier
0301.00      C     *IN70         IFEQ      ’1’
0302.00      C* le caractère de suite
0303.00      C                   SETON                                        07
0304.00      C                   END
0305.00      C* si le fichier est vide
0306.00      C     WRAN01        IFEQ      0
0307.00      C                   Z-ADD     1             NBRLIG
0308.00      C                   Z-ADD     1             LSTLIG            4 0
0309.00      C* un petit message
0310.00      C                   Z-ADD     1             WRAN01
0311.00      C* pas de saisie d’option
0312.00      C                   SETON                                        20
0313.00      C                   eval      ZMDOC = ’vide      ’
0314.00      C                   IF        ZMUSR = *BLANK AND ZMDOC = *BLANK AN
0315.00      C                             ZMPRT = *BLANK
0316.00      C                   eval      ZMUSR = ’Fichier   ’
0317.00      C                   ELSE
0318.00      C                   eval      ZMUSR = ’Sélection ’
0319.00      C                   END
0320.00      C                   MOVEL     *BLANK        ZMPRT
0321.00      C                   MOVEL     *BLANK        WDSFIC
0322.00      C                   Z-ADD     0             HNREC
0323.00      C                   WRITE     SFL01
0324.00      C                   END
0325.00      C* le WRAN01 à 1 pour afficher le premier enregistrement
0326.00      C                   Z-ADD     1             WRAN01
0327.00      C                   ENDSR
0328.00      C* execution de commande, puisqu’on le fait plusieurs fois
0329.00      C     EXECMD        BEGSR
0330.00      C* On nettoie la variable
0331.00      C                   MOVEL     *BLANK        WCMD
0332.00      C* cela on le fait dans les deux cas
0333.00      C                   EVAL      WCMD = WTXT1+ W10
0334.00      C* selon le cas on teste user ou outq
0335.00      C                   IF        *IN86 = ’0’
0336.00      C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT2 
0337.00      C                   ELSE
0338.00      C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT3
0339.00      C                   END
0340.00      C* execution commande, WLNG = longueur de WCMD (init au début)
0341.00      C                   CALL      ’QCMDEXC’
0342.00      C                   PARM                    WCMD
0343.00      C                   PARM                    WLNG
0344.00      C                   ENDSR
0345.00      C* procédure pour la date
0346.00      C     DATHEU        BEGSR
0347.00      C                   TIME                    W14
0348.00      C                   MOVE      W14           WDAT
0349.00      C                   MOVEL     W14           WHEU
0350.00      C                   ENDSR
