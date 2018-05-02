0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Le compteur double                                *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 FFCP01L    UF A E           K DISK
0008.00 DPCOD             S              3
0009.00 DPCP1             S              6
0010.00 DPCP2             S             10
0011.00 DPCPT             S              1
0012.00 DW14              S             14  0
0013.00 DWDAT             S              8
0014.00 DWHEU             S              6
0015.00 DWDI              DS
0016.00 DWSSAI                    1      4  0
0017.00 DWMI                      5      6  0
0018.00 DWJI                      7      8  0
0019.00 DWDATI                    1      8  0
0020.00 DWDE              DS
0021.00 DWJE                      1      2  0
0022.00 DWME                      3      4  0
0023.00 DWSSAE                    5      8  0
0024.00 DWDATE                    1      8  0
0025.00 DDSPROG          SDS
0026.00 DWNPROG                   1     10
0027.00 DWSTATP                  11     15  0
0028.00 DWSTAPR                  16     20  0
0029.00 DWSQSRC                  21     28
0030.00 DWSBROU                  29     36
0031.00 DWNPARM                  37     39  0
0032.00 DWTYEXC                  40     42
0033.00 DWNMSGM                  40     46
0034.00 DWNMEXC                  43     46
0035.00 DWINSMC                  47     50
0036.00 DWZOMSG                  51     80
0037.00 DWLBPGM                  81     90
0038.00 DWSFDTA                  91    170
0039.00 DWCDERR                 171    174
0040.00 DWLSFIL                 201    208
0041.00 DWLSINF                 209    243
0042.00 DWJOB                   244    253
0043.00 DWUSER                  254    263
0044.00 DWNJOB                  264    269  0
0045.00 C* le debut du programme toujours
0046.00 C     *ENTRY        PLIST
0047.00 C                   PARM                    PCOD
0048.00 C                   PARM                    PCPT
0049.00 C                   PARM                    PCP1
0050.00 C                   PARM                    PCP2
0051.00 C* déclaration de la clé de lecture
0052.00 C     KKCL01        KLIST
0053.00 C                   KFLD                    PCOD
0054.00 C* Incremente le compteur souhaité
0055.00 C     KKCL01        CHAIN     FCPF                               7090
0056.00 C* le début
0057.00 C* au cas ou il serait utilisé ailleurs
0058.00 C                   DOW       *IN90 = ’1’
0059.00 C     KKCL01        CHAIN     FCPF                               7090
0060.00 C* on boucle 
0061.00 C                   END
0062.00 C                   IF        *IN70 = ’0’
0063.00 C* le compteur existe
0064.00 C                   IF        PCPT = ’1’
0065.00 C* on veut le compteur 1
0066.00 C     CPCP1         ADD       1             CPCP1
0067.00 C                   ELSE
0068.00 C* c’est le compteur 2
0069.00 C     CPCP2         ADD       1             CPCP2
0070.00 C                   END
0071.00 C                   EXSR      DATHEU
0072.00 C                   Z-ADD     WDATI         CPDAM
0073.00 C                   MOVE      WHEU          CPHEM
0074.00 C                   MOVEL     WUSER         CPUSM
0075.00 C                   UPDATE    FCPF
0076.00 C                   ELSE
0077.00 C* il y a un risque, c’est qu’un autre essaie de créer le même !!
0078.00 C                   MOVEL     PCOD          CPCOD
0079.00 C                   IF        PCPT = ’1’
0080.00 C* on veut le compteur 1
0081.00 C                   Z-ADD     1             CPCP1
0082.00 C                   Z-ADD     0             CPCP2
0083.00 C                   ELSE
0084.00 C* c’est le compteur 2
0085.00 C                   Z-ADD     0             CPCP1
0086.00 C                   Z-ADD     1             CPCP2
0087.00 C                   END
0088.00 C                   EXSR      DATHEU
0089.00 C                   Z-ADD     WDATI         CPDAC
0090.00 C                   MOVE      WHEU          CPHEC
0091.00 C                   MOVEL     WUSER         CPUSC
0092.00 C                   Z-ADD     WDATI         CPDAM
0093.00 C                   MOVE      WHEU          CPHEM
0094.00 C                   MOVEL     WUSER         CPUSM
0095.00 C                   WRITE     FCPF
0096.00 C                   END
0097.00 C* et on retourne les valeurs
0098.00 C                   MOVEL     CPCP1         PCP1
0099.00 C                   MOVEL     CPCP2         PCP2
0100.00 C* c’est fini il faut mettre LR à *ON
0101.00 C                   SETON                                        LR
0102.00 C     DATHEU        BEGSR
0103.00 C                   TIME                    W14
0104.00 C                   MOVE      W14           WDAT
0105.00 C                   MOVEL     W14           WHEU
0106.00 C                   MOVE      WDAT          WDATE
0107.00 C                   Z-ADD     WSSAE         WSSAI
0108.00 C                   Z-ADD     WME           WMI
0109.00 C                   Z-ADD     WJE           WJI
0110.00 C                   ENDSR
