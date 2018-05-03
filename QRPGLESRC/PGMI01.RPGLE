     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Invite sur fonction                               *
     F*                                                   *
     F*****************************************************
     FPGMI01FM  CF   E             WORKSTN
     F                                     SFILE(SFL01 :WRAN01)
     F                                     INFDS(DSSFL1)
     FFIF01L    IF   E           K DISK
     DPCDACT           S              2
     DPRET             S              1
     DPFCT             S              3
     D* la ds du programme, on pourrait s'en passer dans ce cas
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
     D* La DS du sous=fichier
     DDSSFL1           DS
     DWPOSC                  370    371B 0
     DWRRNG                  376    377B 0
     DWRNGP                  378    379B 0
     DWNBRSF                 380    381B 0
     C* les paramètres d'entrée
     C     *ENTRY        PLIST
     C                   PARM                    PCDACT
     C                   PARM                    PFCT
     C* c'est ici que ça commence
     C     KEYSF1        KLIST
     C                   KFLD                    MIFON
     C* la clé sert à trier par code
     C                   MOVEL     '*   '        WPGMQ
     C                   MOVEL     'CC01'        WMGKEY
     C                   MOVEL     WNPROG        ZPGM
     C* Initialisation des indicateurs
     C                   SETON                                        0910
     C                   SETON                                        5013
     C                   IF        PCDACT = 'GS'
     C* indicateur pour autoriser la saisie du choix & visu option
     C                   SETOFF                                       13
     C                   END
     C* Initialisation du sous fichier
     C                   EXSR      INITSF
     C* Boucle d'attente de sortie
     C                   DOW       *IN50 = '1'
     C                   EXSR      TRTSFL
     C                   END
     C* Indicateur de fin de programme
     C                   SETON                                        LR
     C* Les procédures
     C     TRTSFL        BEGSR
     C* Effacement du sous=fichier de messages
     C                   MOVEL     '3'           PTYP
     C                   MOVEL     *BLANK        PFIM
     C                   MOVEL     *BLANK        PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
     C                   WRITE     WSFCTL
     C* Ecriture de l'écran
     C                   SETON                                        0405
     C                   WRITE     FORE1                                  70
     C                   WRITE     FORB1                                  70
     C* Attente lecture
     C                   READ      FORE1                                  70
     C                   READ      FORB1                                  70
     C                   IF        *IN02 = '1'
     C* pour mémoire, on est en chargement total
     C* c'est le système qui s'en occupe
     C                   END
     C                   IF        *INKC = '1' OR
     C                             *INKL = '1'
     C* on quitte sans rien faire
     C                   SETOFF                                       50
     C                   END
     C* en mode GS, si on ne quitte pas, on vérifie le choix
     C   50              IF        PCDACT = 'GS'
     C* en mode GS uniquement
     C                   EXSR      VERIF
     C* l'utilisateur a fait le bon choix, on quitte le programme
     C                   IF        *IN85 = '0'
     C                   SETOFF                                       50
     C                   END
     C                   END
     C* On recommence la boucle d'attente
     C                   ENDSR
     C* vérification si choix '1'
     C     VERIF         BEGSR
     C* indicateur de fin de boucle
     C                   SETON                                          85
     C                   Z-ADD     1             WRAN01
     C  N70              READC     SFL01                                7070
     C*
     C                   DOW       *IN70 = '0' AND *IN85 = '1'
     C                   IF        ZOPT = '1'
     C* saisie correcte, on quitte la boucle
     C                   MOVEL     ZFCT          PFCT
     C                   SETOFF                                         85
     C                   END
     C* en fait c'est un peu inutile, et pour bien faire on devrait
     C* signaler à l'utilisateur si son choix est différent de '1'
     C                   MOVEL     *BLANK        ZOPT
     C                   UPDATE    SFL01                                90
     C*
     C                   READC     SFL01                                7070
     C                   ENDDO
     C                   ENDSR
     C*********************************
     C     INITSF        BEGSR
     C* initialisation de la position de la fenetre ligne6
     C                   Z-ADD     6             WINLIG
     C*                                       colonne 32
     C                   Z-ADD     32            WINCOL
     C                   Z-ADD     0             WRAN01
     C* la partie sensible de l'initialisation
     C                   SETON                                        0607
     C                   SETOFF                                       0405
     C                   WRITE     FORE1
     C                   SETOFF                                       06
     C                   SETON                                        0405
     C* lecture de tout le fichier
     C                   READ      FIFF                                   70
     C* normalement on devrait tester si WRAN01 est inférieur à 9999
     C     *IN70         DOWEQ     '0'
     C* remplissage des zones
     C                   MOVEL     MIFON         ZFCT
     C                   MOVEL     MILIB         ZLIB
     C                   ADD       1             WRAN01
     C                   WRITE     SFL01
     C                   READ      FIFF                                   70
     C                   ENDDO
     C                   ENDSR
