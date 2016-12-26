000100160929     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200160929     F*****************************************************
000300160929     F*                                                   *
000400160929     F* Invite sur fonction                               *
000500160929     F*                                                   *
000600160929     F*****************************************************
000700160929     FPGMI01FM  CF   E             WORKSTN
000800160929     F                                     SFILE(SFL01 :WRAN01)
000900160929     F                                     INFDS(DSSFL1)
001000160929     FFIF01L    IF   E           K DISK
001100160929     DPCDACT           S              2
001200160929     DPRET             S              1
001300160929     DPFCT             S              3
001400160929     D* la ds du programme, on pourrait s'en passer dans ce cas
001500160929     DDSPROG          SDS
001600160929     DWNPROG                   1     10
001700160929     DWSTATP                  11     15  0
001800160929     DWSTAPR                  16     20  0
001900160929     DWSQSRC                  21     28
002000160929     DWSBROU                  29     36
002100160929     DWNPARM                  37     39  0
002200160929     DWTYEXC                  40     42
002300160929     DWNMSGM                  40     46
002400160929     DWNMEXC                  43     46
002500160929     DWINSMC                  47     50
002600160929     DWZOMSG                  51     80
002700160929     DWLBPGM                  81     90
002800160929     DWSFDTA                  91    170
002900160929     DWCDERR                 171    174
003000160929     DWLSFIL                 201    208
003100160929     DWLSINF                 209    243
003200160929     DWJOB                   244    253
003300160929     DWNJOB                  264    269  0
003400160929     D* La DS du sous=fichier
003500160929     DDSSFL1           DS
003600160929     DWPOSC                  370    371B 0
003700160929     DWRRNG                  376    377B 0
003800160929     DWRNGP                  378    379B 0
003900160929     DWNBRSF                 380    381B 0
004000160929     C* les paramètres d'entrée
004100160929     C     *ENTRY        PLIST
004200160929     C                   PARM                    PCDACT
004300160929     C                   PARM                    PFCT
004400160929     C* c'est ici que ça commence
004500160929     C     KEYSF1        KLIST
004600160929     C                   KFLD                    MIFON
004700160929     C* la clé sert  trier par code
004800160929     C                   MOVEL     '*   '        WPGMQ
004900160929     C                   MOVEL     'CC01'        WMGKEY
005000160929     C                   MOVEL     WNPROG        ZPGM
005100160929     C* Initialisation des indicateurs
005200160929     C                   SETON                                        0910
005300160929     C                   SETON                                        5013
005400160929     C                   IF        PCDACT = 'GS'
005500160929     C* indicateur pour autoriser la saisie du choix & visu option
005600160929     C                   SETOFF                                       13
005700160929     C                   END
005800160929     C* Initialisation du sous fichier
005900160929     C                   EXSR      INITSF
006000160929     C* Boucle d'attente de sortie
006100160929     C                   DOW       *IN50 = '1'
006200160929     C                   EXSR      TRTSFL
006300160929     C                   END
006400160929     C* Indicateur de fin de programme
006500160929     C                   SETON                                        LR
006600160929     C* Les procédures
006700160929     C     TRTSFL        BEGSR
006800160929     C* Effacement du sous=fichier de messages
006900160929     C                   MOVEL     '3'           PTYP
007000160929     C                   MOVEL     *BLANK        PFIM
007100160929     C                   MOVEL     *BLANK        PMID
007200160929     C                   CALL      'PGM001CL'
007300160929     C                   PARM                    PTYP              1
007400160929     C                   PARM                    PFIM             10
007500160929     C                   PARM                    PMID              7
007600160929     C                   PARM                    PMDT             99
007700160929     C                   WRITE     WSFCTL
007800160929     C* Ecriture de l'écran
007900160929     C                   SETON                                        0405
008000160929     C                   WRITE     FORE1                                  70
008100160929     C                   WRITE     FORB1                                  70
008200160929     C* Attente lecture
008300160929     C                   READ      FORE1                                  70
008400160929     C                   READ      FORB1                                  70
008500160929     C                   IF        *IN02 = '1'
008600160929     C* pour mémoire, on est en chargement total
008700160929     C* c'est le système qui s'en occupe
008800160929     C                   END
008900160929     C                   IF        *INKC = '1' OR
009000160929     C                             *INKL = '1'
009100160929     C* on quitte sans rien faire
009200160929     C                   SETOFF                                       50
009300160929     C                   END
009400160929     C* en mode GS, si on ne quitte pas, on vérifie le choix
009500160929     C   50              IF        PCDACT = 'GS'
009600160929     C* en mode GS uniquement
009700160929     C                   EXSR      VERIF
009800160929     C* l'utilisateur a fait le bon choix, on quitte le programme
009900160929     C                   IF        *IN85 = '0'
010000160929     C                   SETOFF                                       50
010100160929     C                   END
010200160929     C                   END
010300160929     C* On recommence la boucle d'attente
010400160929     C                   ENDSR
010500160929     C* vérification si choix '1'
010600160929     C     VERIF         BEGSR
010700160929     C* indicateur de fin de boucle
010800160929     C                   SETON                                          85
010900160929     C                   Z-ADD     1             WRAN01
011000160929     C  N70              READC     SFL01                                7070
011100160929     C*
011200160929     C                   DOW       *IN70 = '0' AND *IN85 = '1'
011300160929     C                   IF        ZOPT = '1'
011400160929     C* saisie correcte, on quitte la boucle
011500160929     C                   MOVEL     ZFCT          PFCT
011600160929     C                   SETOFF                                         85
011700160929     C                   END
011800160929     C* en fait c'est un peu inutile, et pour bien faire on devrait
011900160929     C* signaler  l'utilisateur si son choix est différent de '1'
012000160929     C                   MOVEL     *BLANK        ZOPT
012100160929     C                   UPDATE    SFL01                                90
012200160929     C*
012300160929     C                   READC     SFL01                                7070
012400160929     C                   ENDDO
012500160929     C                   ENDSR
012600160929     C*********************************
012700160929     C     INITSF        BEGSR
012800160929     C* initialisation de la position de la fenetre ligne6
012900160929     C                   Z-ADD     6             WINLIG
013000160929     C*                                       colonne 32
013100160929     C                   Z-ADD     32            WINCOL
013200160929     C                   Z-ADD     0             WRAN01
013300160929     C* la partie sensible de l'initialisation
013400160929     C                   SETON                                        0607
013500160929     C                   SETOFF                                       0405
013600160929     C                   WRITE     FORE1
013700160929     C                   SETOFF                                       06
013800160929     C                   SETON                                        0405
013900160929     C* lecture de tout le fichier
014000160929     C                   READ      FIFF                                   70
014100160929     C* normalement on devrait tester si WRAN01 est inférieur  9999
014200160929     C     *IN70         DOWEQ     '0'
014300160929     C* remplissage des zones
014400160929     C                   MOVEL     MIFON         ZFCT
014500160929     C                   MOVEL     MILIB         ZLIB
014600160929     C                   ADD       1             WRAN01
014700160929     C                   WRITE     SFL01
014800160929     C                   READ      FIFF                                   70
014900160929     C                   ENDDO
015000160929     C                   ENDSR
