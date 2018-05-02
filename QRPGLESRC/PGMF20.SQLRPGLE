0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Edition liste du personnel                        *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 FPGMF20PR  O    E             PRINTER OFLIND(*IN99)
0008.00 F                                     INFDS(WPRT)
0009.00 FFIC01L    IF   E           K DISK
0010.00 FFIF01L    IF   E           K DISK
0011.00 DTA1              S              1    DIM(10)
0012.00 DTA2              S              1    DIM(10)
0013.00 DWTXT1            C                   ’Détail fiche employé’
0014.00 DWTXT2            C                   ’Liste du personnel’
0015.00 DPMATR            S             10
0016.00 DW14              S             14  0
0017.00 DI                S              2  0
0018.00 DJ                S              2  0
0019.00 DD                S              2  0
0020.00 DF                S              2  0
0021.00 DWDI              DS
0022.00 DWSSAI                    1      4  0
0023.00 DWMI                      5      6  0
0024.00 DWJI                      7      8  0
0025.00 DWDATI                    1      8  0
0026.00 DWDE              DS
0027.00 DWJE                      1      2  0
0028.00 DWME                      3      4  0
0029.00 DWSSAE                    5      8  0
0030.00 DWDATE                    1      8  0
0031.00 DDSPROG          SDS
0032.00 DWNPROG                   1     10
0033.00 DWSTATP                  11     15  0
0034.00 DWSTAPR                  16     20  0
0035.00 DWSQSRC                  21     28
0036.00 DWSBROU                  29     36
0037.00 DWNPARM                  37     39  0
0038.00 DWTYEXC                  40     42
0039.00 DWNMSGM                  40     46
0040.00 DWNMEXC                  43     46
0041.00 DWINSMC                  47     50
0042.00 DWZOMSG                  51     80
0043.00 DWLBPGM                  81     90
0044.00 DWSFDTA                  91    170
0045.00 DWCDERR                 171    174
0046.00 DWLSFIL                 201    208
0047.00 DWLSINF                 209    243
0048.00 DWJOB                   244    253
0049.00 DWUSER                  254    263
0050.00 DWNJOB                  264    269  0
0051.00 DWPRT             DS 
0052.00 DNUMLIG                 367    368I 0
0053.00 DNUMPAG                 369    372I 0
0054.00 C     *ENTRY        PLIST
0055.00 C                   PARM                    PMATR
0056.00 C* début du programme
0057.00 C     KEY001        KLIST
0058.00 C                   KFLD                    FIMAT
0059.00 C     KEY002        KLIST
0060.00 C                   KFLD                    FIFON
0061.00 C                   MOVEL     ’1’           *IN85
0062.00 C* pour forcer le premier changement de page
0063.00 C                   MOVEL     ’1’           *IN99
0064.00 C* les constantes
0065.00 C                   MOVEL     WNPROG        ZPGM
0066.00 C                   MOVEL     WUSER         ZUSR
0067.00 C                   TIME                    W14
0068.00 C                   MOVE      W14           ZDATE
0069.00 C                   IF        PMATR <> *BLANK
0070.00 C* il faut cadrer si mal saisi
0071.00 C                   MOVEA     PMATR         TA1
0072.00 C                   DOW       I < 10
0073.00 C     I             ADD       1             I
0074.00 C                   IF        D = 0
0075.00 C                   IF        TA1(I) <> ’ ’ AND TA1(I) <> ’0’
0076.00 C                   Z-ADD     I             D
0077.00 C                   END
0078.00 C                   ELSE
0079.00 C                   IF        TA1(I) = ’ ’
0080.00 C     I             SUB       1             F
0081.00 C                   LEAVE
0082.00 C                   END
0083.00 C                   END
0084.00 C                   END
0085.00 C* on a le debut et la fin
0086.00 C                   Z-ADD     F             I
0087.00 C                   Z-ADD     10            J
0088.00 C                   IF        D > 0 AND F > 0
0089.00 C* on charge le deuxième tableau en commençant par la fin
0090.00 C                   DOW       I >= D
0091.00 C                   MOVEL     TA1(I)        TA2(J)
0092.00 C     J             SUB       1             J
0093.00 C     I             SUB       1             I
0094.00 C                   END
0095.00 C* et tout est cadré à droite
0096.00 C                   MOVEA     TA2           PMATR
0097.00 C                   MOVE      PMATR         FIMAT
0098.00 C                   END
0099.00 C* si n’importe quoi FIMAT = 0, la lecture n’aboutira pas
0100.00 C     KEY001        CHAIN     FICF                               7090
0101.00 C                   IF        *IN70 = ’0’
0102.00 C                   MOVEL     ’0’           *IN85
0103.00 C* edition 1 page
0104.00 C                   MOVEL     WTXT1         ZTITRE
0105.00 C* le détail
0106.00 C                   Z-ADD     FIMAT         ZMATR
0107.00 C                   MOVEL     FIFON         ZCODF
0108.00 C     KEY002        CHAIN     FIFF                               7090
0109.00 C                   MOVEL     MILIB         ZLIF
0110.00 C                   MOVEL     FINOM         ZNOM
0111.00 C                   MOVEL     FIPR1         ZPRE1
0112.00 C                   MOVEL     FIPR2         ZPRE2
0113.00 C                   MOVEL     FIAD1         ZAD1
0114.00 C                   MOVEL     FIAD2         ZAD2
0115.00 C                   MOVEL     FIAD3         ZAD3
0116.00 C                   MOVEL     FICPO         ZCPO
0117.00 C                   MOVEL     FIVIL         ZVIL
0118.00 C                   MOVEL     FITEL         ZTEL
0119.00 C                   MOVEL     FIPOR         ZPOR
0120.00 C                   Z-ADD     FIDAE         WDATI
0121.00 C                   EXSR      INVDAT
0122.00 C                   Z-ADD     WDATE         ZDAE
0123.00 C                   Z-ADD     FIDAS         WDATI
0124.00 C                   EXSR      INVDAT
0125.00 C                   Z-ADD     WDATE         ZDAS
0126.00 C                   Z-ADD     FIDAC         WDATI
0127.00 C                   EXSR      INVDAT
0128.00 C                   Z-ADD     WDATE         ZDAC
0129.00 C                   Z-ADD     FIHEC         ZHEC
0130.00 C                   MOVEL     FIUSC         ZUSC
0131.00 C                   Z-ADD     FIDAM         WDATI
0132.00 C                   EXSR      INVDAT
0133.00 C                   Z-ADD     WDATE         ZDAM
0134.00 C                   Z-ADD     FIHEM         ZHEM
0135.00 C                   MOVEL     FIUSM         ZUSM
0136.00 C   99              EXSR      CHGPAG
0137.00 C                   WRITE     DETGEN
0138.00 C                   Z-ADD     1             ZLIG
0139.00 C                   ELSE
0140.00 C                   MOVEL     ’1’           *IN85
0141.00 C                   END
0142.00 C                   END
0143.00 C                   IF        *IN85 = ’1’
0144.00 C                   MOVEL     WTXT2         ZTITRE
0145.00 C* on édite tout 
0146.00 C                   READ      FICF                                 9070
0147.00 C                   DOW       *IN70 = ’0’
0148.00 C* le détail
0149.00 C                   Z-ADD     FIMAT         ZMATR
0150.00 C                   MOVEL     FINOM         ZNOMC
0151.00 C                   MOVEL     FIPR1         ZPRE1C
0152.00 C                   MOVEL     FIAD1         ZADR1C
0153.00 C                   MOVEL     FICPO         ZCPO
0154.00 C                   MOVEL     FIVIL         ZVILC
0155.00 C   99              EXSR      CHGPAG
0156.00 C                   WRITE     DETLIG
0157.00 C     ZLIG          ADD       1             ZLIG
0158.00 C                   READ      FICF                                 9070
0159.00 C                   END
0160.00 C                   END
0161.00 C   99              EXSR      CHGPAG
0162.00 C                   WRITE     FIN
0163.00 C* fin du programme
0164.00 C                   SETON                                        LR
0165.00 C****** inversion de la date
0166.00 C     INVDAT        BEGSR
0167.00 C                   Z-ADD     WSSAI         WSSAE
0168.00 C                   Z-ADD     WMI           WME
0169.00 C                   Z-ADD     WJI           WJE
0170.00 C                   ENDSR
0171.00 C****** changement de page
0172.00 C     CHGPAG        BEGSR
0173.00 C                   SETOFF                                       99
0174.00 C****** un aurait pu utiliser la variable info splf
0175.00 C*                  Z-ADD     NUMPAG        ZPAG
0176.00 C     ZPAG          ADD       1             ZPAG
0177.00 C                   WRITE     ENTETE
0178.00 C                   IF        *IN85 = ’1’
0179.00 C                   WRITE     COLON
0180.00 C                   END
0181.00 C                   ENDSR
