0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Détail fonction                                   *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 FPGMF11FM  CF   E             WORKSTN
0008.00 F                                     INFDS(WDSECR)
0009.00 FFIF00P    UF A E             DISK
0010.00 FFIF01L    IF   E           K DISK
0011.00 F                                     RENAME(FIFF      :FIFF1   )
0012.00 DWTXT1            C                   ’         Modification         ’
0013.00 DWTXT2            C                   ’             Copie            ’
0014.00 DWTXT3            C                   ’           Création           ’
0015.00 DWTXT4            C                   ’         Suppression          ’
0016.00 DWTXT5            C                   ’           Affichage          ’
0017.00 DPOPT             S              2
0018.00 DW14              S             14  0
0019.00 DW8               S              8
0020.00 DWDAT             S              8
0021.00 DWHEU             S              6
0022.00 DWHS              S               Z
0023.00 DPNREC            S             10
0024.00 DWNREC            S             10  0
0025.00 DW6               S              6
0026.00 DWS               DS
0027.00 DWSA                      1      4
0028.00 DWMA                      6      7
0029.00 DWJA                      9     10
0030.00 DWHA                     12     13
0031.00 DWIA                     15     16
0032.00 DWKA                     18     19
0033.00 DWMU                     21     26
0034.00 DWASTA                    1     26
0035.00 DWDSPGM          SDS
0036.00 DWNMPGM                   1     10
0037.00 DWSTATU                  11     15  0
0038.00 DWSTPRE                  16     20  0
0039.00 DWSRCSQ                  21     28
0040.00 DWNMROU                  29     36
0041.00 DWNBPAR                  37     39  0
0042.00 DWTYEXC                  40     42
0043.00 DWLICPF                  40     46
0044.00 DWNUEXC                  43     46
0045.00 DWMIODT                  47     50
0046.00 DWZOMES                  51     80
0047.00 DWBIPGM                  81     90
0048.00 DWRTDTA                  91    170
0049.00 DWCOERR                 171    174
0050.00 DWDERFI                 201    208
0051.00 DWFIINF                 209    243
0052.00 DWJOB                   244    253
0053.00 DWUSER                  254    263
0054.00 DWJOBNM                 264    269  0
0055.00 DWDSECR           DS
0056.00 DWNLIG                  370    371B 0
0057.00 DWRANP                  378    379B 0
0058.00 DWNBRS                  380    381B 0
0059.00 DWNULC                  382    383B 0
0060.00 DWRECMI                 403    404B 0
0061.00 C     *ENTRY        PLIST
0062.00 C                   PARM                    POPT
0063.00 C                   PARM                    PNREC
0064.00 C* Début du programme
0065.00 C     KEY001        KLIST
0066.00 C                   KFLD                    ZFCOD
0067.00 C                   MOVEL     ’*   ’        WPGMQ
0068.00 C                   MOVEL     ’CC01’        WMGKEY
0069.00 C                   SETON                                        0910
0070.00 C                   SETOFF                                       1213
0071.00 C* cette DS découpe automatiquement le time stamp
0072.00 C                   MOVEL     WNMPGM        ZPGM
0073.00 C                   EXSR      DATHEU
0074.00 C                   MOVE      WDAT          ZDATE
0075.00 C                   MOVE      WHEU          ZHEUR
0076.00 C                   MOVEL     WUSER         ZUSER
0077.00 C                   MOVEL     WJOB          ZJOB
0078.00 C* constantes pour ce programme
0079.00 C                   MOVE      ’1’           PTYP
0080.00 C                   MOVEL     ’FICMSG    ’  PFICM
0081.00 C                   SELECT
0082.00 C                   WHEN      (POPT = ’MO’)
0083.00 C* modification, forcement du libellé
0084.00 C                   MOVEL     WTXT1         ZMODE
0085.00 C                   SETON                                          13
0086.00 C                   WHEN      (POPT = ’CO’)
0087.00 C* tout est saisissable
0088.00 C                   MOVEL     WTXT2         ZMODE
0089.00 C                   SETON                                        1213
0090.00 C                   WHEN      (POPT = ’CR’)
0091.00 C* tout est saisissable
0092.00 C                   MOVEL     WTXT3         ZMODE
0093.00 C                   SETON                                        1213
0094.00 C                   WHEN      (POPT = ’SU’)
0095.00 C* rien n’est saisissable
0096.00 C                   MOVEL     WTXT4         ZMODE
0097.00 C                   WHEN      (POPT = ’AF’)
0098.00 C* rien n’est saisissable
0099.00 C                   MOVEL     WTXT5         ZMODE
0100.00 C                   ENDSL
0101.00 C*
0102.00 C                   MOVE      PNREC         WNREC
0103.00 C                   IF        WNREC <> 0
0104.00 C* sauf si c’est de la création l’enregistrement doit exister
0105.00 C     WNREC         CHAIN (N) FIFF                               7090
0106.00 C                   IF        *IN70 = ’0’
0107.00 C* et dans ce cas on renseigne les valeurs, sinon
0108.00 C* les variables sont initialisées à zéro
0109.00 C                   MOVEL     MIFON         ZFCOD
0110.00 C                   MOVEL     MILIB         ZFLIB
0111.00 C* date et heure création
0112.00 C                   TEST (Z)                MITSC                  90
0113.00 C     *IN90         IFEQ      ’1’
0114.00 C                   MOVEL     *LOVAL        WHS
0115.00 C                   ELSE
0116.00 C                   MOVEL     MITSC         WHS
0117.00 C                   END
0118.00 C                   EXSR      CVTDAT
0119.00 C* il ne reste plus qu’a charger dans la zone écran
0120.00 C                   MOVE      W8            ZDAC
0121.00 C                   MOVE      W6            ZHEC
0122.00 C                   MOVEL     MIUSC         ZUSC
0123.00 C* date et heure de modif
0124.00 C                   TEST (Z)                MITSM                  90
0125.00 C     *IN90         IFEQ      ’1’
0126.00 C                   MOVEL     *LOVAL        WHS
0127.00 C                   ELSE
0128.00 C                   MOVEL     MITSM         WHS
0129.00 C                   END
0130.00 C                   EXSR      CVTDAT
0131.00 C                   MOVE      W8            ZDAM
0132.00 C                   MOVE      W6            ZHEM
0133.00 C                   MOVEL     MIUSM         ZUSM
0134.00 C                   END
0135.00 C                   END
0136.00 C*
0137.00 C                   SETON                                        50
0138.00 C                   DOW       *IN50 = ’1’
0139.00 C                   EXSR      TRTSCR
0140.00 C                   ENDDO
0141.00 C*
0142.00 C                   SETON                                        LR
0143.00 C********* les procédures
0144.00 C     TRTSCR        BEGSR
0145.00 C                   WRITE     WMGCTL
0146.00 C* On écrit l’écran
0147.00 C                   WRITE     FORE1
0148.00 C* On attend l’appui sur une touche 
0149.00 C                   READ      FORE1                                  70
0150.00 C                   SETON                                          51
0151.00 C*
0152.00 C                   EXSR      DATHEU
0153.00 C                   IF        *INKC = ’1’ OR
0154.00 C                             *INKL = ’1’
0155.00 C                   SETOFF                                       5051
0156.00 C                   END
0157.00 C*                  IF        POPT = ’SU’
0158.00 C*                  SETOFF                                         51
0159.00 C*                  END
0160.00 C                   IF        *IN85 = ’1’
0161.00 C     *INKP         IFEQ      ’1’
0162.00 C* touche F15 on supprime si indicateur *IN85
0163.00 C     WNREC         CHAIN     FIFF                               7090
0164.00 C  N70              DELETE    FIFF
0165.00 C                   SETOFF                                       5051
0166.00 C                   END
0167.00 C                   END
0168.00 C* contrôle des données saisies
0169.00 C                   IF        *IN51 = ’1’
0170.00 C                   EXSR      CTLDTA
0171.00 C                   IF        *IN88 = ’1’
0172.00 C* anomalie
0173.00 C                   EXSR      ENVMSG
0174.00 C                   SETOFF                                       88
0175.00 C                   ELSE
0176.00 C* pas d’anomalie, on valide
0177.00 C                   EXSR      VALID
0178.00 C                   SETOFF                                       5051
0179.00 C                   END
0180.00 C                   END
0181.00 C* fin procedure
0182.00 C                   ENDSR
0183.00 C******************
0184.00 C     CTLDTA        BEGSR
0185.00 C                   SETOFF                                       8885
0186.00 C* dans ce cas la seule vérification est en création/copie
0187.00 C                   IF         (POPT = ’CR’ OR POPT = ’CO’)
0188.00 C     KEY001        CHAIN     FIFF1                              7090
0189.00 C* pour éviter de s’auto verrouiller
0190.00 C                   IF        *IN70 = ’0’
0191.00 C* le code fonction existe                           ZFCOD
0192.00 C                   SETON                                        12
0193.00 C                   MOVEL     ’MSG0007’     PMGID
0194.00 C                   MOVEL     *BLANK        PMGDT
0195.00 C* top anomalie
0196.00 C                   SETON                                        88
0197.00 C                   END
0198.00 C                   END
0199.00 C* On ne fait la suite que si indicateur 88 à zéro
0200.00 C  N88              IF          POPT = ’SU’
0201.00 C* Suppression on prévient avant de supprimer
0202.00 C                   MOVEL     ’MSG0004’     PMGID
0203.00 C                   MOVEL     *BLANK        PMGDT
0204.00 C                   SETON                                        8885
0205.00 C                   END
0206.00 C                   ENDSR
0207.00 C*
0208.00 C     VALID         BEGSR
0209.00 C* il n’y a eu aucune erreur on charge les zones communes
0210.00 C                   TIME                    WHS
0211.00 C     WNREC         CHAIN     FIFF                               7090
0212.00 C* c’est pas joli joli, on ne devrait le faire qu’en cas de modif.
0213.00 C                   MOVEL     ZFLIB         MILIB
0214.00 C                   MOVEL     WHS           MITSM
0215.00 C                   MOVEL     WUSER         MIUSM
0216.00 C                   IF        (POPT = ’MO’)
0217.00 C* et on met à jour
0218.00 C                   UPDATE    FIFF
0219.00 C                   END
0220.00 C                   IF        (POPT = ’CO’) OR
0221.00 C                             (POPT = ’CR’)
0222.00 C* on rajoute le reste pour la création
0223.00 C                   MOVEL     ZFCOD         MIFON
0224.00 C                   MOVEL     MITSM         MITSC
0225.00 C                   MOVEL     WUSER         MIUSC
0226.00 C                   WRITE     FIFF 
0227.00 C                   END
0228.00 C                   ENDSR
0229.00 C* mise à jour date et heure système
0230.00 C     DATHEU        BEGSR 
0231.00 C                   TIME                    W14
0232.00 C                   MOVE      W14           WDAT
0233.00 C                   MOVEL     W14           WHEU
0234.00 C                   ENDSR
0235.00 C* conversion de la date 
0236.00 C     CVTDAT        BEGSR
0237.00 C                   MOVEL     WHS           WASTA
0238.00 C* la DS découpe les valeurs que l’on concatène
0239.00 C                   EVAL      W8 = WJA+ WMA+ WSA
0240.00 C                   EVAL      W6 = WHA+ WIA+ WKA
0241.00 C                   ENDSR
0242.00 C*****Envoi d’un message programme
0243.00 C     ENVMSG        BEGSR
0244.00 C                   CALL      ’PGM001CL’
0245.00 C                   PARM                    PTYP              1
0246.00 C                   PARM                    PFICM            10
0247.00 C                   PARM                    PMGID             7
0248.00 C                   PARM                    PMGDT            99
0249.00 C                   ENDSR
