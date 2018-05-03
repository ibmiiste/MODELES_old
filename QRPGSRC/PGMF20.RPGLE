     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Edition liste du personnel                        *
     F*                                                   *
     F*****************************************************
     FPGMF20PR  O    E             PRINTER OFLIND(*IN99)
     F                                     INFDS(WPRT)
     FFIC01L    IF   E           K DISK
     FFIF01L    IF   E           K DISK
     DTA1              S              1    DIM(10)
     DTA2              S              1    DIM(10)
     DWTXT1            C                   'Détail fiche employé'
     DWTXT2            C                   'Liste du personnel'
     DPMATR            S             10
     DW14              S             14  0
     DI                S              2  0
     DJ                S              2  0
     DD                S              2  0
     DF                S              2  0
     DWDI              DS
     DWSSAI                    1      4  0
     DWMI                      5      6  0
     DWJI                      7      8  0
     DWDATI                    1      8  0
     DWDE              DS
     DWJE                      1      2  0
     DWME                      3      4  0
     DWSSAE                    5      8  0
     DWDATE                    1      8  0
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
     DWPRT             DS
     DNUMLIG                 367    368I 0
     DNUMPAG                 369    372I 0
     C     *ENTRY        PLIST
     C                   PARM                    PMATR
     C* début du programme
     C     KEY001        KLIST
     C                   KFLD                    FIMAT
     C     KEY002        KLIST
     C                   KFLD                    FIFON
     C                   MOVEL     '1'           *IN85
     C* pour forcer le premier changement de page
     C                   MOVEL     '1'           *IN99
     C* les constantes
     C                   MOVEL     WNPROG        ZPGM
     C                   MOVEL     WUSER         ZUSR
     C                   TIME                    W14
     C                   MOVE      W14           ZDATE
     C                   IF        PMATR <> *BLANK
     C* il faut cadrer si mal saisi
     C                   MOVEA     PMATR         TA1
     C                   DOW       I < 10
     C     I             ADD       1             I
     C                   IF        D = 0
     C                   IF        TA1(I) <> ' ' AND TA1(I) <> '0'
     C                   Z-ADD     I             D
     C                   END
     C                   ELSE
     C                   IF        TA1(I) = ' '
     C     I             SUB       1             F
     C                   LEAVE
     C                   END
     C                   END
     C                   END
     C* on a le debut et la fin
     C                   Z-ADD     F             I
     C                   Z-ADD     10            J
     C                   IF        D > 0 AND F > 0
     C* on charge le deuxième tableau en commençant par la fin
     C                   DOW       I >= D
     C                   MOVEL     TA1(I)        TA2(J)
     C     J             SUB       1             J
     C     I             SUB       1             I
     C                   END
     C* et tout est cadré à droite
     C                   MOVEA     TA2           PMATR
     C                   END
     C                   MOVE      PMATR         FIMAT
     C* si n'importe quoi FIMAT = 0, la lecture n'aboutira pas
     C     KEY001        CHAIN     FICF                               7090
     C                   IF        *IN70 = '0'
     C                   MOVEL     '0'           *IN85
     C* edition 1 page
     C                   MOVEL     WTXT1         ZTITRE
     C* le détail
     C                   Z-ADD     FIMAT         ZMATR
     C                   MOVEL     FIFON         ZCODF
     C     KEY002        CHAIN     FIFF                               7090
     C                   MOVEL     MILIB         ZLIF
     C                   MOVEL     FINOM         ZNOM
     C                   MOVEL     FIPR1         ZPRE1
     C                   MOVEL     FIPR2         ZPRE2
     C                   MOVEL     FIAD1         ZAD1
     C                   MOVEL     FIAD2         ZAD2
     C                   MOVEL     FIAD3         ZAD3
     C                   MOVEL     FICPO         ZCPO
     C                   MOVEL     FIVIL         ZVIL
     C                   MOVEL     FITEL         ZTEL
     C                   MOVEL     FIPOR         ZPOR
     C                   Z-ADD     FIDAE         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAE
     C                   Z-ADD     FIDAS         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAS
     C                   Z-ADD     FIDAC         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAC
     C                   Z-ADD     FIHEC         ZHEC
     C                   MOVEL     FIUSC         ZUSC
     C                   Z-ADD     FIDAM         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAM
     C                   Z-ADD     FIHEM         ZHEM
     C                   MOVEL     FIUSM         ZUSM
     C   99              EXSR      CHGPAG
     C                   WRITE     DETGEN
     C                   Z-ADD     1             ZLIG
     C                   ELSE
     C                   MOVEL     '1'           *IN85
     C                   END
     C                   END
     C                   IF        *IN85 = '1'
     C                   MOVEL     WTXT2         ZTITRE
     C* on édite tout
     C                   READ      FICF                                 9070
     C                   DOW       *IN70 = '0'
     C* le détail
     C                   Z-ADD     FIMAT         ZMATR
     C                   MOVEL     FINOM         ZNOMC
     C                   MOVEL     FIPR1         ZPRE1C
     C                   MOVEL     FIAD1         ZADR1C
     C                   MOVEL     FICPO         ZCPO
     C                   MOVEL     FIVIL         ZVILC
     C   99              EXSR      CHGPAG
     C                   WRITE     DETLIG
     C     ZLIG          ADD       1             ZLIG
     C                   READ      FICF                                 9070
     C                   END
     C                   END
     C   99              EXSR      CHGPAG
     C                   WRITE     FIN
     C* fin du programme
     C                   SETON                                        LR
     C****** inversion de la date
     C     INVDAT        BEGSR
     C                   Z-ADD     WSSAI         WSSAE
     C                   Z-ADD     WMI           WME
     C                   Z-ADD     WJI           WJE
     C                   ENDSR
     C****** changement de page
     C     CHGPAG        BEGSR
     C                   SETOFF                                       99
     C****** un aurait pu utiliser la variable info splf
     C*                  Z-ADD     NUMPAG        ZPAG
     C     ZPAG          ADD       1             ZPAG
     C                   WRITE     ENTETE
     C                   IF        *IN85 = '1'
     C                   WRITE     COLON
     C                   END
     C                   ENDSR
