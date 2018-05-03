     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Le compteur double                                *
     F*                                                   *
     F*****************************************************
     FFCP01L    UF A E           K DISK
     DPCOD             S              3
     DPCP1             S              6
     DPCP2             S             10
     DPCPT             S              1
     DW14              S             14  0
     DWDAT             S              8
     DWHEU             S              6
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
     C* le debut du programme toujours
     C     *ENTRY        PLIST
     C                   PARM                    PCOD
     C                   PARM                    PCPT
     C                   PARM                    PCP1
     C                   PARM                    PCP2
     C* déclaration de la clé de lecture
     C     KKCL01        KLIST
     C                   KFLD                    PCOD
     C* Incremente le compteur souhaité
     C     KKCL01        CHAIN     FCPF                               7090
     C* le début
     C* au cas ou il serait utilisé ailleurs
     C                   DOW       *IN90 = '1'
     C     KKCL01        CHAIN     FCPF                               7090
     C* on boucle
     C                   END
     C                   IF        *IN70 = '0'
     C* le compteur existe
     C                   IF        PCPT = '1'
     C* on veut le compteur 1
     C     CPCP1         ADD       1             CPCP1
     C                   ELSE
     C* c'est le compteur 2
     C     CPCP2         ADD       1             CPCP2
     C                   END
     C                   EXSR      DATHEU
     C                   Z-ADD     WDATI         CPDAM
     C                   MOVE      WHEU          CPHEM
     C                   MOVEL     WUSER         CPUSM
     C                   UPDATE    FCPF
     C                   ELSE
     C* il y a un risque, c'est qu'un autre essaie de créer le même !!
     C                   MOVEL     PCOD          CPCOD
     C                   IF        PCPT = '1'
     C* on veut le compteur 1
     C                   Z-ADD     1             CPCP1
     C                   Z-ADD     0             CPCP2
     C                   ELSE
     C* c'est le compteur 2
     C                   Z-ADD     0             CPCP1
     C                   Z-ADD     1             CPCP2
     C                   END
     C                   EXSR      DATHEU
     C                   Z-ADD     WDATI         CPDAC
     C                   MOVE      WHEU          CPHEC
     C                   MOVEL     WUSER         CPUSC
     C                   Z-ADD     WDATI         CPDAM
     C                   MOVE      WHEU          CPHEM
     C                   MOVEL     WUSER         CPUSM
     C                   WRITE     FCPF
     C                   END
     C* et on retourne les valeurs
     C                   MOVEL     CPCP1         PCP1
     C                   MOVEL     CPCP2         PCP2
     C* c'est fini il faut mettre LR à *ON
     C                   SETON                                        LR
     C     DATHEU        BEGSR
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
     C                   MOVE      WDAT          WDATE
     C                   Z-ADD     WSSAE         WSSAI
     C                   Z-ADD     WME           WMI
     C                   Z-ADD     WJE           WJI
     C                   ENDSR
