0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Invite sur fonction                               *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 FPGMI01FM  CF   E             WORKSTN
0008.00 F                                     SFILE(SFL01 :WRAN01)
0009.00 F                                     INFDS(DSSFL1)
0010.00 FFIF01L    IF   E           K DISK
0011.00 DPCDACT           S              2
0012.00 DPRET             S              1
0013.00 DPFCT             S              3
0014.00 D* la ds du programme, on pourrait s’en passer dans ce cas
0015.00 DDSPROG          SDS
0016.00 DWNPROG                   1     10
0017.00 DWSTATP                  11     15  0
0018.00 DWSTAPR                  16     20  0
0019.00 DWSQSRC                  21     28
0020.00 DWSBROU                  29     36
0021.00 DWNPARM                  37     39  0
0022.00 DWTYEXC                  40     42
0023.00 DWNMSGM                  40     46
0024.00 DWNMEXC                  43     46
0025.00 DWINSMC                  47     50
0026.00 DWZOMSG                  51     80
0027.00 DWLBPGM                  81     90
0028.00 DWSFDTA                  91    170
0029.00 DWCDERR                 171    174
0030.00 DWLSFIL                 201    208
0031.00 DWLSINF                 209    243
0032.00 DWJOB                   244    253
0034.00 DWNJOB                  264    269  0
0035.00 D* La DS du sous=fichier
0036.00 DDSSFL1           DS
0037.00 DWPOSC                  370    371B 0
0038.00 DWRRNG                  376    377B 0
0039.00 DWRNGP                  378    379B 0
0040.00 DWNBRSF                 380    381B 0
0041.00 C* les paramètres d’entrée
0042.00 C     *ENTRY        PLIST
0043.00 C                   PARM                    PCDACT
0044.00 C                   PARM                    PFCT
0045.00 C* c’est ici que cela commence
0046.00 C     KEYSF1        KLIST
0047.00 C                   KFLD                    MIFON
0048.00 C* la clé sert à trier par code
0049.00 C                   MOVEL     ’*   ’        WPGMQ
0050.00 C                   MOVEL     ’CC01’        WMGKEY
0051.00 C                   MOVEL     WNPROG        ZPGM
0052.00 C* Initialisation des indicateurs
0053.00 C                   SETON                                        0910
0054.00 C                   SETON                                        5013
0055.00 C                   IF        PCDACT = ’GS’
0056.00 C* indicateur pour autoriser la saisie du choix & visu option
0057.00 C                   SETOFF                                       13
0058.00 C                   END
0059.00 C* Initialisation du sous fichier
0060.00 C                   EXSR      INITSF
0061.00 C* Boucle d’attente de sortie
0062.00 C                   DOW       *IN50 = ’1’
0063.00 C                   EXSR      TRTSFL
0064.00 C                   END
0065.00 C* Indicateur de fin de programme
0066.00 C                   SETON                                        LR
0067.00 C* Les procédures
0068.00 C     TRTSFL        BEGSR
0069.00 C* Effacement du sous=fichier de messages
0070.00 C                   MOVEL     ’3’           PTYP
0071.00 C                   MOVEL     *BLANK        PFIM
0072.00 C                   MOVEL     *BLANK        PMID
0073.00 C                   CALL      ’PGM001CL’
0074.00 C                   PARM                    PTYP              1
0075.00 C                   PARM                    PFIM             10
0076.00 C                   PARM                    PMID              7
0077.00 C                   PARM                    PMDT             99
0078.00 C                   WRITE     WSFCTL
0079.00 C* Ecriture de l’écran
0080.00 C                   SETON                                        0405
0081.00 C                   WRITE     FORE1                                  70
0082.00 C                   WRITE     FORB1                                  70
0083.00 C* Attente lecture
0084.00 C                   READ      FORE1                                  70
0085.00 C                   READ      FORB1                                  70
0086.00 C                   IF        *IN02 = ’1’
0087.00 C* pour mémoire, on est en chargement total
0088.00 C* c’est le système qui s’en occupe
0089.00 C                   END
0090.00 C                   IF        *INKC = ’1’ OR
0091.00 C                             *INKL = ’1’
0092.00 C* on quitte sans rien faire
0093.00 C                   SETOFF                                       50
0094.00 C                   END
0095.00 C* en mode GS, si on ne quitte pas, on vérifie le choix
0096.00 C   50              IF        PCDACT = ’GS’
0097.00 C* en mode GS uniquement
0098.00 C                   EXSR      VERIF
0099.00 C* l’utilisateur a fait le bon choix, on quitte le programme
0100.00 C                   IF        *IN85 = ’0’
0101.00 C                   SETOFF                                       50
0102.00 C                   END
0103.00 C                   END
0104.00 C* On recommence la boucle d’attente
0105.00 C                   ENDSR
0106.00 C* vérification si choix ’1’
0107.00 C     VERIF         BEGSR
0108.00 C* indicateur de fin de boucle
0109.00 C                   SETON                                          85
0110.00 C                   Z-ADD     1             WRAN01
0111.00 C  N70              READC     SFL01                                7070
0112.00 C*
0113.00 C                   DOW       *IN70 = ’0’ AND *IN85 = ’1’
0114.00 C                   IF        ZOPT = ’1’
0115.00 C* saisie correcte, on quitte la boucle
0116.00 C                   MOVEL     ZFCT          PFCT
0117.00 C                   SETOFF                                         85
0118.00 C                   END
0119.00 C* en fait c’est un peu inutile, et pour bien faire on devrait
0120.00 C* signaler à l’utilisateur si son choix est différent de ’1’
0121.00 C                   MOVEL     *BLANK        ZOPT
0122.00 C                   UPDATE    SFL01                                90
0123.00 C*
0124.00 C                   READC     SFL01                                7070
0125.00 C                   ENDDO 
0126.00 C                   ENDSR
0127.00 C*********************************
0128.00 C     INITSF        BEGSR
0129.00 C* initialisation de la position de la fenetre ligne6
0130.00 C                   Z-ADD     6             WINLIG
0131.00 C*                                       colonne 32
0132.00 C                   Z-ADD     32            WINCOL
0133.00 C                   Z-ADD     0             WRAN01
0134.00 C* la partie sensible de l’initialisation
0135.00 C                   SETON                                        0607
0136.00 C                   SETOFF                                       0405
0137.00 C                   WRITE     FORE1
0138.00 C                   SETOFF                                       06
0139.00 C                   SETON                                        0405
0140.00 C* lecture de tout le fichier
0141.00 C                   READ      FIFF                                   70
0142.00 C* normalement on devrait tester si WRAN01 est inférieur à 9999
0143.00 C     *IN70         DOWEQ     ’0’
0144.00 C* remplissage des zones
0145.00 C                   MOVEL     MIFON         ZFCT
0146.00 C                   MOVEL     MILIB         ZLIB
0147.00 C                   ADD       1             WRAN01
0148.00 C                   WRITE     SFL01
0149.00 C                   READ      FIFF                                   70
0150.00 C                   ENDDO
0151.00 C                   ENDSR
