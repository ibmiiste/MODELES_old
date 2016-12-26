000100160929     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200160929     F*****************************************************
000300160929     F*                                                   *
000400160929     F* Edition liste du personnel                        *
000500160929     F*                                                   *
000600160929     F*****************************************************
000700160929     FPGMF20PR  O    E             PRINTER OFLIND(*IN99)
000800160929     F                                     INFDS(WPRT)
000900160929     FFIC01L    IF   E           K DISK
001000160929     FFIF01L    IF   E           K DISK
001100160929     DTA1              S              1    DIM(10)
001200160929     DTA2              S              1    DIM(10)
001300160929     DWTXT1            C                   'Détail fiche employé'
001400160929     DWTXT2            C                   'Liste du personnel'
001500160929     DPMATR            S             10
001600160929     DW14              S             14  0
001700160929     DI                S              2  0
001800160929     DJ                S              2  0
001900160929     DD                S              2  0
002000160929     DF                S              2  0
002100160929     DWDI              DS
002200160929     DWSSAI                    1      4  0
002300160929     DWMI                      5      6  0
002400160929     DWJI                      7      8  0
002500160929     DWDATI                    1      8  0
002600160929     DWDE              DS
002700160929     DWJE                      1      2  0
002800160929     DWME                      3      4  0
002900160929     DWSSAE                    5      8  0
003000160929     DWDATE                    1      8  0
003100160929
003200160929     DDSPROG          SDS
003300160929     DWNPROG                   1     10
003400160929     DWSTATP                  11     15  0
003500160929     DWSTAPR                  16     20  0
003600160929     DWSQSRC                  21     28
003700160929     DWSBROU                  29     36
003800160929     DWNPARM                  37     39  0
003900160929     DWTYEXC                  40     42
004000160929     DWNMSGM                  40     46
004100160929     DWNMEXC                  43     46
004200160929     DWINSMC                  47     50
004300160929     DWZOMSG                  51     80
004400160929     DWLBPGM                  81     90
004500160929     DWSFDTA                  91    170
004600160929     DWCDERR                 171    174
004700160929     DWLSFIL                 201    208
004800160929     DWLSINF                 209    243
004900160929     DWJOB                   244    253
005000160929     DWUSER                  254    263
005100160929     DWNJOB                  264    269  0
005200160929     DWPRT             DS
005300160929     DNUMLIG                 367    368I 0
005400160929     DNUMPAG                 369    372I 0
005500160929     C     *ENTRY        PLIST
005600160929     C                   PARM                    PMATR
005700160929     C* début du programme
005800160929     C     KEY001        KLIST
005900160929     C                   KFLD                    FIMAT
006000160929     C     KEY002        KLIST
006100160929     C                   KFLD                    FIFON
006200160929     C                   MOVEL     '1'           *IN85
006300160929     C* pour forcer le premier changement de page
006400160929     C                   MOVEL     '1'           *IN99
006500160929     C* les constantes
006600160929     C                   MOVEL     WNPROG        ZPGM
006700160929     C                   MOVEL     WUSER         ZUSR
006800160929     C                   TIME                    W14
006900160929     C                   MOVE      W14           ZDATE
007000160929     C                   IF        PMATR <> *BLANK
007100160929     C* il faut cadrer si mal saisi
007200160929     C                   MOVEA     PMATR         TA1
007300160929     C                   DOW       I < 10
007400160929     C     I             ADD       1             I
007500160929     C                   IF        D = 0
007600160929     C                   IF        TA1(I) <> ' ' AND TA1(I) <> '0'
007700160929     C                   Z-ADD     I             D
007800160929     C                   END
007900160929     C                   ELSE
008000160929     C                   IF        TA1(I) = ' '
008100160929     C     I             SUB       1             F
008200160929     C                   LEAVE
008300160929     C                   END
008400160929     C                   END
008500160929     C                   END
008600160929     C* on a le debut et la fin
008700160929     C                   Z-ADD     F             I
008800160929     C                   Z-ADD     10            J
008900160929     C                   IF        D > 0 AND F > 0
009000160929     C* on charge le deuxième tableau en commençant par la fin
009100160929     C                   DOW       I >= D
009200160929     C                   MOVEL     TA1(I)        TA2(J)
009300160929     C     J             SUB       1             J
009400160929     C     I             SUB       1             I
009500160929     C                   END
009600160929     C* et tout est cadré à droite
009700160929     C                   MOVEA     TA2           PMATR
009800160929     C                   MOVE      PMATR         FIMAT
009900160929     C                   END
010000160929     C* si n'importe quoi FIMAT = 0, la lecture n'aboutira pas
010100160929     C     KEY001        CHAIN     FICF                               7090
010200160929     C                   IF        *IN70 = '0'
010300160929     C                   MOVEL     '0'           *IN85
010400160929     C* edition 1 page
010500160929     C                   MOVEL     WTXT1         ZTITRE
010600160929     C* le détail
010700160929     C                   Z-ADD     FIMAT         ZMATR
010800160929     C                   MOVEL     FIFON         ZCODF
010900160929     C     KEY002        CHAIN     FIFF                               7090
011000160929     C                   MOVEL     MILIB         ZLIF
011100160929     C                   MOVEL     FINOM         ZNOM
011200160929     C                   MOVEL     FIPR1         ZPRE1
011300160929     C                   MOVEL     FIPR2         ZPRE2
011400160929     C                   MOVEL     FIAD1         ZAD1
011500160929     C                   MOVEL     FIAD2         ZAD2
011600160929     C                   MOVEL     FIAD3         ZAD3
011700160929     C                   MOVEL     FICPO         ZCPO
011800160929     C                   MOVEL     FIVIL         ZVIL
011900160929     C                   MOVEL     FITEL         ZTEL
012000160929     C                   MOVEL     FIPOR         ZPOR
012100160929     C                   Z-ADD     FIDAE         WDATI
012200160929     C                   EXSR      INVDAT
012300160929     C                   Z-ADD     WDATE         ZDAE
012400160929     C                   Z-ADD     FIDAS         WDATI
012500160929     C                   EXSR      INVDAT
012600160929     C                   Z-ADD     WDATE         ZDAS
012700160929     C                   Z-ADD     FIDAC         WDATI
012800160929     C                   EXSR      INVDAT
012900160929     C                   Z-ADD     WDATE         ZDAC
013000160929     C                   Z-ADD     FIHEC         ZHEC
013100160929     C                   MOVEL     FIUSC         ZUSC
013200160929     C                   Z-ADD     FIDAM         WDATI
013300160929     C                   EXSR      INVDAT
013400160929     C                   Z-ADD     WDATE         ZDAM
013500160929     C                   Z-ADD     FIHEM         ZHEM
013600160929     C                   MOVEL     FIUSM         ZUSM
013700160929     C   99              EXSR      CHGPAG
013800160929     C                   WRITE     DETGEN
013900160929     C                   Z-ADD     1             ZLIG
014000160929     C                   ELSE
014100160929     C                   MOVEL     '1'           *IN85
014200160929     C                   END
014300160929     C                   END
014400160929     C                   IF        *IN85 = '1'
014500160929     C                   MOVEL     WTXT2         ZTITRE
014600160929     C* on édite tout
014700160929     C                   READ      FICF                                 9070
014800160929     C                   DOW       *IN70 = '0'
014900160929     C* le détail
015000160929     C                   Z-ADD     FIMAT         ZMATR
015100160929     C                   MOVEL     FINOM         ZNOMC
015200160929     C                   MOVEL     FIPR1         ZPRE1C
015300160929     C                   MOVEL     FIAD1         ZADR1C
015400160929     C                   MOVEL     FICPO         ZCPO
015500160929     C                   MOVEL     FIVIL         ZVILC
015600160929     C   99              EXSR      CHGPAG
015700160929     C                   WRITE     DETLIG
015800160929     C     ZLIG          ADD       1             ZLIG
015900160929     C                   READ      FICF                                 9070
016000160929     C                   END
016100160929     C                   END
016200160929     C   99              EXSR      CHGPAG
016300160929     C                   WRITE     FIN
016400160929     C* fin du programme
016500160929     C                   SETON                                        LR
016600160929     C****** inversion de la date
016700160929     C     INVDAT        BEGSR
016800160929     C                   Z-ADD     WSSAI         WSSAE
016900160929     C                   Z-ADD     WMI           WME
017000160929     C                   Z-ADD     WJI           WJE
017100160929     C                   ENDSR
017200160929     C****** changement de page
017300160929     C     CHGPAG        BEGSR
017400160929     C                   SETOFF                                       99
017500160929     C****** un aurait pu utiliser la variable info splf
017600160929     C*                  Z-ADD     NUMPAG        ZPAG
017700160929     C     ZPAG          ADD       1             ZPAG
017800160929     C                   WRITE     ENTETE
017900160929     C                   IF        *IN85 = '1'
018000160929     C                   WRITE     COLON
018100160929     C                   END
018200160929     C                   ENDSR
