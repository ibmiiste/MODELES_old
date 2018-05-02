001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Détail personnel                                  *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 FPGMF02FM  CF   E             WORKSTN
0008.00 F                                     INFDS(WDSECR)
0009.00 FFIC00P    UF   E             DISK
0010.00 FFIC01L    UF A E           K DISK
0011.00 F                                     RENAME(FICF      :FICF1)
0012.00 FFIF01L    IF   E           K DISK
0013.00 DWTXT1            C                   ’         Modification         ’
0014.00 DWTXT2            C                   ’             Copie            ’
0015.00 DWTXT3            C                   ’         Suppression          ’
0016.00 DWTXT4            C                   ’           Affichage          ’
0017.00 DWTXT5            C                   ’           Création           ’
0018.00 DWTXT6            C                   ’        Fin de contrat        ’
0019.00 DWDAT             S              8
0020.00 DWHEU             S              6
0021.00 DW14              S             14  0
0022.00 DPCHX             S              2
0023.00 DPNREC            S             10
0024.00 DWNREC            S             10  0
0025.00 DPACT             S              2
0026.00 DPGFCT            S              3
0027.00 DWDI              DS
0028.00 DWSSAI                    1      4  0
0029.00 DWMI                      5      6  0
0030.00 DWJI                      7      8  0
0031.00 DWDATI                    1      8  0
0032.00 DWDE              DS
0033.00 DWJE                      1      2  0
0034.00 DWME                      3      4  0
0035.00 DWSSAE                    5      8  0
0036.00 DWDATE                    1      8  0
0037.00 DWDSPGM          SDS
0038.00 DWNMPGM                   1     10
0039.00 DWSTATU                  11     15  0
0040.00 DWSTPRE                  16     20  0
0041.00 DWSRCSQ                  21     28
0042.00 DWNMROU                  29     36
0043.00 DWNBPAR                  37     39  0
0044.00 DWTYEXC                  40     42
0045.00 DWLICPF                  40     46
0046.00 DWNUEXC                  43     46
0047.00 DWMIODT                  47     50
0048.00 DWZOMES                  51     80
0049.00 DWBIPGM                  81     90
0050.00 DWRTDTA                  91    170
0051.00 DWCOERR                 171    174
0052.00 DWDERFI                 201    208
0053.00 DWFIINF                 209    243
0054.00 DWJOB                   244    253
0055.00 DWUSER                  254    263
0056.00 DWJOBNM                 264    269  0
0057.00 DWDSECR           DS
0058.00 DWNLIG                  370    371B 0
0059.00 DWRANP                  378    379B 0
0060.00 DWNBRS                  380    381B 0
0061.00 DWNULC                  382    383B 0
0062.00 DWRECMI                 403    404B 0
0063.00 C     *ENTRY        PLIST
0064.00 C                   PARM                    PCHX
0065.00 C                   PARM                    PNREC
0066.00 C     KEY001        KLIST
0067.00 C                   KFLD                    ZMATR
0068.00 C     KEY002        KLIST
0069.00 C                   KFLD                    ZFCOD
0070.00 C* début du programme
0071.00 C                   MOVEL     WNMPGM        ZPGM
0072.00 C                   EXSR      DATHEU
0073.00 C                   MOVE      WDAT          ZDATE
0074.00 C                   MOVE      WHEU          ZHEUR
0075.00 C                   MOVEL     WUSER         ZUSER
0076.00 C                   MOVEL     WJOB          ZJOB
0077.00 C                   MOVEL     ’*  ’         WPGMQ
0078.00 C                   MOVEL     ’CC01’        WMGKEY
0079.00 C                   SETON                                        0910
0080.00 C                   SETON                                        141516
0081.00 C                   SETON                                        1718
0082.00 C                   SETOFF                                       8588
0083.00 C* constantes pour ce programme
0084.00 C                   MOVE      ’1’           PTYP
0085.00 C                   MOVEL     ’FICMSG    ’  PFICM
0086.00 C                   SELECT
0087.00 C                   WHEN      (PCHX = ’MO’)
0088.00 C* modification
0089.00 C                   MOVEL     WTXT1         ZMODE
0090.00 C* on ne peut modifier que ces zones
0091.00 C                   SETOFF                                       141516
0092.00 C                   WHEN      (PCHX = ’CO’)
0093.00 C* copie
0094.00 C                   MOVEL     WTXT2         ZMODE
0095.00 C* toutes les zones sont autorisées
0096.00 C                   SETOFF                                       141516
0097.00 C                   SETOFF                                       1718
0098.00 C                   WHEN      (PCHX = ’SU’)
0099.00 C* suppression
0100.00 C                   MOVEL     WTXT3         ZMODE
0101.00 C* aucune zone n’est saisisable
0102.00 C                   WHEN      (PCHX = ’AF’)
0103.00 C* affichage
0104.00 C                   MOVEL     WTXT4         ZMODE
0105.00 C* aucune zone n’est saisisable
0106.00 C                   WHEN      (PCHX = ’CR’)
0107.00 C* création
0108.00 C                   MOVEL     WTXT5         ZMODE
0109.00 C* tout est saisisable sauf date de sortie
0110.00 C                   SETOFF                                       141516
0111.00 C                   SETOFF                                       17
0112.00 C                   WHEN      (PCHX = ’PE’)
0113.00 C* direction Pôle Emploi
0114.00 C                   MOVEL     WTXT6         ZMODE
0115.00 C* on saisit simplement la date de fin
0116.00 C                   SETOFF                                         18
0117.00 C                   ENDSL
0118.00 C* Initialisation de l’écran si on un numéro d’enregistrement
0119.00 C                   IF        PNREC <> *BLANK
0120.00 C                   MOVE      PNREC         WNREC
0121.00 C     WNREC         CHAIN (N) FICF                               7090
0122.00 C                   IF        PCHX = ’CR’ OR PCHX = ’CO’
0123.00 C* en création ou copie zone non renseignée
0124.00 C                   Z-ADD     0             ZMATR
0125.00 C                   ELSE
0126.00 C                   Z-ADD     FIMAT         ZMATR
0127.00 C                   END
0128.00 C                   MOVEL     FIFON         ZFCOD
0129.00 C* fichier des fonctions => libellé
0130.00 C     KEY002        CHAIN     FIFF                               7090
0131.00 C                   MOVEL     MILIB         ZFLIB
0132.00 C                   MOVEL     FINOM         ZNOM
0133.00 C                   MOVEL     FIPR1         ZPR1
0134.00 C                   MOVEL     FIPR2         ZPR2
0135.00 C                   MOVEL     FIAD1         ZAD1
0136.00 C                   MOVEL     FIAD2         ZAD2
0137.00 C                   MOVEL     FIAD3         ZAD3
0138.00 C                   MOVEL     FICPO         ZCPO
0139.00 C                   MOVEL     FIVIL         ZVIL
0140.00 C                   MOVEL     FITEL         ZTEL
0141.00 C                   MOVEL     FIPOR         ZPOR
0142.00 C* traitement des dates
0143.00 C                   Z-ADD     FIDAE         WDATI
0144.00 C                   EXSR      INVDAT
0145.00 C                   Z-ADD     WDATE         ZDAE
0146.00 C                   IF        PCHX = ’PE’
0147.00 C                   Z-ADD     ZDATE         ZDAS
0148.00 C                   ELSE
0149.00 C                   Z-ADD     FIDAS         WDATI
0150.00 C                   EXSR      INVDAT
0151.00 C                   Z-ADD     WDATE         ZDAS
0152.00 C                   END
0153.00 C* zones d’audit
0154.00 C                   Z-ADD     FIDAC         WDATI
0155.00 C                   EXSR      INVDAT
0156.00 C                   Z-ADD     WDATE         ZDAC
0157.00 C                   Z-ADD     FIHEC         ZHEC
0158.00 C                   MOVEL     FIUSC         ZUSC
0159.00 C                   Z-ADD     FIDAM         WDATI
0160.00 C                   EXSR      INVDAT
0161.00 C                   Z-ADD     WDATE         ZDAM
0162.00 C                   Z-ADD     FIHEM         ZHEM
0163.00 C                   MOVEL     FIUSM         ZUSM
0164.00 C                   ELSE
0165.00 C* pas grand chose, la date du jour
0166.00 C                   MOVE      WDAT          ZDAE
0167.00 C                   END
0168.00 C* Boucle d’attente de fin
0169.00 C                   SETON                                        50
0170.00 C                   DOW       *IN50 = ’1’
0171.00 C                   EXSR      TRTSCR
0172.00 C                   ENDDO
0173.00 C*
0174.00 C                   SETON                                        LR
0175.00 C* Les procédures
0176.00 C     TRTSCR        BEGSR
0177.00 C                   WRITE     WMGCTL
0178.00 C* On écrit l’écran
0179.00 C                   WRITE     FORE1
0180.00 C* On attend l’appui sur une touche
0181.00 C                   READ      FORE1                                  70
0182.00 C                   SETON                                          51
0183.00 C* F3 ou F12 on termine
0184.00 C                   IF        *INKC = ’1’ OR
0185.00 C                             *INKL = ’1’
0186.00 C                   SETOFF                                       5051
0187.00 C                   END
0188.00 C* on met à jour l’heure
0189.00 C   51              TIME                    ZHEUR
0190.00 C   51*INKD         IFEQ      ’1’
0191.00 C* appui sur la touche F4
0192.00 C                   IF        WZOCUR = ’ZFCOD’
0193.00 C                   EVAL      PACT = ’GS’
0194.00 C                   CALL      ’PGMI01’
0195.00 C                   PARM                    PACT
0196.00 C                   PARM                    PGFCT
0197.00 C                   IF        PGFCT <> *BLANK
0198.00 C                   MOVEL     PGFCT         ZFCOD
0199.00 C                   END
0200.00 C                   END
0201.00 C                   SETOFF                                         51
0202.00 C                   END
0203.00 C*
0204.00 C                   IF        PCHX = ’SU’
0205.00 C                   SETOFF                                         51
0206.00 C                   IF        *IN85 = ’1’
0207.00 C     *INKP         IFEQ      ’1’
0208.00 C* touche F15 on supprime si indicateur *IN85
0209.00 C     WNREC         CHAIN     FICF                               7090
0210.00 C  N70              DELETE    FICF
0211.00 C                   SETOFF                                       5051
0212.00 C                   END
0213.00 C                   ELSE
0214.00 C                   MOVEL     ’MSG0004’     PMGID
0215.00 C                   MOVEL     *BLANK        PMGDT
0216.00 C                   EXSR      ENVMSG
0217.00 C                   SETON                                          85
0218.00 C                   END
0219.00 C                   END
0220.00 C* contrôle des données saisies
0221.00 C                   IF        *IN51 = ’1’
0222.00 C                   EXSR      CTLDTA
0223.00 C                   IF        *IN88 = ’1’
0224.00 C* anomalie
0225.00 C                   EXSR      ENVMSG 
0226.00 C                   SETOFF                                       88
0227.00 C                   ELSE
0228.00 C* confirmation  pour suppression
0229.00 C                   EXSR      VALID1
0230.00 C                   END
0231.00 C                   END
0232.00 C                   ENDSR
0233.00 C* controle des données/si suppression demande de confirmation
0234.00 C     CTLDTA        BEGSR
0235.00 C                   MOVE      ’0’           *IN88
0236.00 C* on vérifie que tout est bon
0237.00 C                   IF        PCHX = ’SU’
0238.00 C* on demande confirmation
0239.00 C                   ELSE
0240.00 C* vérification du code fonction
0241.00 C     KEY002        CHAIN     FIFF                               7090
0242.00 C                   IF        *IN70 = ’1’
0243.00 C                   MOVE      ’0’           *IN88
0244.00 C                   MOVEL     ’MSG0003’     PMGID
0245.00 C                   EVAL      PMGDT = ’&1’+ ZFCOD
0246.00 C                   MOVE      ’1’           *IN88
0247.00 C                   END
0248.00 C                   END
0249.00 C                   ENDSR
0250.00 C*** Création suppression et MàJ selon le cas
0251.00 C     VALID1        BEGSR
0252.00 C                   IF        PCHX = ’SU’
0253.00 C* La suppression se fait par la touche F15
0254.00 C                   ELSE
0255.00 C     KEY001        CHAIN     FICF1                              7190
0256.00 C                   IF        PCHX = ’CR’ OR PCHX = ’CO’
0257.00 C* On ne crée le matricule qu’en copie ou création
0258.00 C                   MOVE      ’MAT’         PCOD
0259.00 C                   MOVE      ’2’           PCPT
0260.00 C                   CALL      ’PGMC01’
0261.00 C                   PARM                    PCOD              3
0262.00 C                   PARM                    PCPT              1
0263.00 C                   PARM                    PCP1              6
0264.00 C                   PARM                    PMAT             10
0265.00 C                   MOVE      PMAT          FIMAT
0266.00 C                   SETON                                        71
0267.00 C                   END
0268.00 C                   MOVEL     ZFCOD         FIFON
0269.00 C                   MOVEL     ZNOM          FINOM
0270.00 C                   MOVEL     ZPR1          FIPR1
0271.00 C                   MOVEL     ZPR2          FIPR2
0272.00 C                   MOVEL     ZAD1          FIAD1
0273.00 C                   MOVEL     ZAD2          FIAD2
0274.00 C                   MOVEL     ZAD3          FIAD3
0275.00 C                   MOVEL     ZCPO          FICPO
0276.00 C                   MOVEL     ZVIL          FIVIL
0277.00 C                   MOVEL     ZTEL          FITEL
0278.00 C                   MOVEL     ZPOR          FIPOR
0279.00 C* traitement des dates
0280.00 C                   Z-ADD     ZDAE          WDATE
0281.00 C                   EXSR      DATINV
0282.00 C                   Z-ADD     WDATI         FIDAE
0283.00 C                   Z-ADD     ZDAS          WDATE
0284.00 C                   EXSR      DATINV
0285.00 C                   Z-ADD     WDATI         FIDAS
0286.00 C* zones d’audit
0287.00 C                   EXSR      DATHEU
0288.00 C                   MOVE      WDAT          WDATE
0289.00 C                   EXSR      DATINV
0290.00 C                   Z-ADD     WDATI         FIDAM
0291.00 C                   MOVE      WHEU          FIHEM
0292.00 C                   MOVEL     WUSER         FIUSM
0293.00 C                   IF        *IN71 = ’0’
0294.00 C* on met à jour directement
0295.00 C                   UPDATE    FICF1
0296.00 C                   ELSE
0297.00 C* création
0298.00 C                   Z-ADD     WDATI         FIDAC
0299.00 C                   MOVE      WHEU          FIHEC
0300.00 C                   MOVEL     WUSER         FIUSC
0301.00 C                   WRITE     FICF1
0302.00 C                   END
0303.00 C                   END
0304.00 C                   SETOFF                                       50
0305.00 C                   ENDSR
0306.00 C* Traitements de la date
0307.00 C     DATHEU        BEGSR
0308.00 C                   TIME                    W14
0309.00 C                   MOVE      W14           WDAT
0310.00 C                   MOVEL     W14           WHEU
0311.00 C                   ENDSR
0312.00 C     INVDAT        BEGSR
0313.00 C                   Z-ADD     WSSAI         WSSAE
0314.00 C                   Z-ADD     WMI           WME
0315.00 C                   Z-ADD     WJI           WJE
0316.00 C                   ENDSR
0317.00 C     DATINV        BEGSR
0318.00 C                   Z-ADD     WSSAE         WSSAI
0319.00 C                   Z-ADD     WME           WMI
0320.00 C                   Z-ADD     WJE           WJI
0321.00 C                   ENDSR
0322.00 C*****Envoi d’un message programme
0323.00 C     ENVMSG        BEGSR
0324.00 C                   CALL      ’PGM001CL’
0325.00 C                   PARM                    PTYP              1
0326.00 C                   PARM                    PFICM            10
0327.00 C                   PARM                    PMGID             7
0328.00 C                   PARM                    PMGDT            99
0329.00 C                   ENDSR
