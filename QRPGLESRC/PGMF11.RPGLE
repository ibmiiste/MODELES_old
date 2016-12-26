000100160929     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200160929     F*****************************************************
000300160929     F*                                                   *
000400160929     F* Détail fonction                                   *
000500160929     F*                                                   *
000600160929     F*****************************************************
000700160929     FPGMF11FM  CF   E             WORKSTN
000800160929     F                                     INFDS(WDSECR)
000900160929     FFIF00P    UF A E             DISK
001000160929     FFIF01L    IF   E           K DISK
001100160929     F                                     RENAME(FIFF      :FIFF1   )
001200160929     DWTXT1            C                   '         Modification         '
001300160929     DWTXT2            C                   '             Copie            '
001400160929     DWTXT3            C                   '           Création           '
001500160929     DWTXT4            C                   '         Suppression          '
001600160929     DWTXT5            C                   '           Affichage          '
001700160929     DPOPT             S              2
001800160929     DW14              S             14  0
001900160929     DW8               S              8
002000160929     DWDAT             S              8
002100160929     DWHEU             S              6
002200160929     DWHS              S               Z
002300160929     DPNREC            S             10
002400160929     DWNREC            S             10  0
002500160929     DW6               S              6
002600160929     DWS               DS
002700160929     DWSA                      1      4
002800160929     DWMA                      6      7
002900160929     DWJA                      9     10
003000160929     DWHA                     12     13
003100160929     DWIA                     15     16
003200160929     DWKA                     18     19
003300160929     DWMU                     21     26
003400160929     DWASTA                    1     26
003500160929     DWDSPGM          SDS
003600160929     DWNMPGM                   1     10
003700160929     DWSTATU                  11     15  0
003800160929     DWSTPRE                  16     20  0
003900160929     DWSRCSQ                  21     28
004000160929     DWNMROU                  29     36
004100160929     DWNBPAR                  37     39  0
004200160929     DWTYEXC                  40     42
004300160929     DWLICPF                  40     46
004400160929     DWNUEXC                  43     46
004500160929     DWMIODT                  47     50
004600160929     DWZOMES                  51     80
004700160929     DWBIPGM                  81     90
004800160929     DWRTDTA                  91    170
004900160929     DWCOERR                 171    174
005000160929     DWDERFI                 201    208
005100160929     DWFIINF                 209    243
005200160929     DWJOB                   244    253
005300160929     DWUSER                  254    263
005400160929     DWJOBNM                 264    269  0
005500160929     DWDSECR           DS
005600160929     DWNLIG                  370    371B 0
005700160929     DWRANP                  378    379B 0
005800160929     DWNBRS                  380    381B 0
005900160929     DWNULC                  382    383B 0
006000160929     DWRECMI                 403    404B 0
006100160929     C     *ENTRY        PLIST
006200160929     C                   PARM                    POPT
006300160929     C                   PARM                    PNREC
006400160929     C* Début du programme
006500160929     C     KEY001        KLIST
006600160929     C                   KFLD                    ZFCOD
006700160929     C                   MOVEL     '*   '        WPGMQ
006800160929     C                   MOVEL     'CC01'        WMGKEY
006900160929     C                   SETON                                        0910
007000160929     C                   SETOFF                                       1213
007100160929     C* cette DS découpe automatiquement le time stamp
007200160929     C                   MOVEL     WNMPGM        ZPGM
007300160929     C                   EXSR      DATHEU
007400160929     C                   MOVE      WDAT          ZDATE
007500160929     C                   MOVE      WHEU          ZHEUR
007600160929     C                   MOVEL     WUSER         ZUSER
007700160929     C                   MOVEL     WJOB          ZJOB
007800160929     C* constantes pour ce programme
007900160929     C                   MOVE      '1'           PTYP
008000160929     C                   MOVEL     'FICMSG    '  PFICM
008100160929     C                   SELECT
008200160929     C                   WHEN      (POPT = 'MO')
008300160929     C* modification, forcement du libellé
008400160929     C                   MOVEL     WTXT1         ZMODE
008500160929     C                   SETON                                          13
008600160929     C                   WHEN      (POPT = 'CO')
008700160929     C* tout est saisissable
008800160929     C                   MOVEL     WTXT2         ZMODE
008900160929     C                   SETON                                        1213
009000160929     C                   WHEN      (POPT = 'CR')
009100160929     C* tout est saisissable
009200160929     C                   MOVEL     WTXT3         ZMODE
009300160929     C                   SETON                                        1213
009400160929     C                   WHEN      (POPT = 'SU')
009500160929     C* rien n'est saisissable
009600160929     C                   MOVEL     WTXT4         ZMODE
009700160929     C                   WHEN      (POPT = 'AF')
009800160929     C* rien n'est saisissable
009900160929     C                   MOVEL     WTXT5         ZMODE
010000160929     C                   ENDSL
010100160929     C*
010200160929     C                   MOVE      PNREC         WNREC
010300160929     C                   IF        WNREC <> 0
010400160929     C* sauf si c'est de la création l'enregistrement doit exister
010500160929     C     WNREC         CHAIN (N) FIFF                               7090
010600160929     C                   IF        *IN70 = '0'
010700160929     C* et dans ce cas on renseigne les valeurs, sinon
010800160929     C* les variables sont initialisées à zéro
010900160929     C                   MOVEL     MIFON         ZFCOD
011000160929     C                   MOVEL     MILIB         ZFLIB
011100160929     C* date et heure création
011200160929     C                   TEST (Z)                MITSC                  90
011300160929     C     *IN90         IFEQ      '1'
011400160929     C                   MOVEL     *LOVAL        WHS
011500160929     C                   ELSE
011600160929     C                   MOVEL     MITSC         WHS
011700160929     C                   END
011800160929     C                   EXSR      CVTDAT
011900160929     C* il ne reste plus qu'à charger dans la zone écran
012000160929     C                   MOVE      W8            ZDAC
012100160929     C                   MOVE      W6            ZHEC
012200160929     C                   MOVEL     MIUSC         ZUSC
012300160929     C* date et heure de modif
012400160929     C                   TEST (Z)                MITSM                  90
012500160929     C     *IN90         IFEQ      '1'
012600160929     C                   MOVEL     *LOVAL        WHS
012700160929     C                   ELSE
012800160929     C                   MOVEL     MITSM         WHS
012900160929     C                   END
013000160929     C                   EXSR      CVTDAT
013100160929     C                   MOVE      W8            ZDAM
013200160929     C                   MOVE      W6            ZHEM
013300160929     C                   MOVEL     MIUSM         ZUSM
013400160929     C                   END
013500160929     C                   END
013600160929     C*
013700160929     C                   SETON                                        50
013800160929     C                   DOW       *IN50 = '1'
013900160929     C                   EXSR      TRTSCR
014000160929     C                   ENDDO
014100160929     C*
014200160929     C                   SETON                                        LR
014300160929     C********* les procédures
014400160929     C     TRTSCR        BEGSR
014500160929     C                   WRITE     WMGCTL
014600160929     C* On écrit l'écran
014700160929     C                   WRITE     FORE1
014800160929     C* On attend l'appui sur une touche
014900160929     C                   READ      FORE1                                  70
015000160929     C                   SETON                                          51
015100160929     C*
015200160929     C                   EXSR      DATHEU
015300160929     C                   IF        *INKC = '1' OR
015400160929     C                             *INKL = '1'
015500160929     C                   SETOFF                                       5051
015600160929     C                   END
015700160929     C*                  IF        POPT = 'SU'
015800160929     C*                  SETOFF                                         51
015900160929     C*                  END
016000160929     C                   IF        *IN85 = '1'
016100160929     C     *INKP         IFEQ      '1'
016200160929     C* touche F15 on supprime si indicateur *IN85
016300160929     C     WNREC         CHAIN     FIFF                               7090
016400160929     C  N70              DELETE    FIFF
016500160929     C                   SETOFF                                       5051
016600160929     C                   END
016700160929     C                   END
016800160929     C* contrôle des données saisies
016900160929     C                   IF        *IN51 = '1'
017000160929     C                   EXSR      CTLDTA
017100160929     C                   IF        *IN88 = '1'
017200160929     C* anomalie
017300160929     C                   EXSR      ENVMSG
017400160929     C                   SETOFF                                       88
017500160929     C                   ELSE
017600160929     C* pas d'anomalie, on valide
017700160929     C                   EXSR      VALID
017800160929     C                   SETOFF                                       5051
017900160929     C                   END
018000160929     C                   END
018100160929     C* fin procedure
018200160929     C                   ENDSR
018300160929     C******************
018400160929     C     CTLDTA        BEGSR
018500160929     C                   SETOFF                                       8885
018600160929     C* dans ce cas la seule vérification est en création/copie
018700160929     C                   IF         (POPT = 'CR' OR POPT = 'CO')
018800160929     C     KEY001        CHAIN     FIFF1                              7090
018900160929     C* pour éviter de s'auto verrouiller
019000160929     C                   IF        *IN70 = '0'
019100160929     C* le code fonction existe                           ZFCOD
019200160929     C                   SETON                                        12
019300160929     C                   MOVEL     'MSG0007'     PMGID
019400160929     C                   MOVEL     *BLANK        PMGDT
019500160929     C* top anomalie
019600160929     C                   SETON                                        88
019700160929     C                   END
019800160929     C                   END
019900160929     C* On ne fait la suite que si indicateur 88 à zéro
020000160929     C  N88              IF          POPT = 'SU'
020100160929     C* Suppression on prévient avant de supprimer
020200160929     C                   MOVEL     'MSG0004'     PMGID
020300160929     C                   MOVEL     *BLANK        PMGDT
020400160929     C                   SETON                                        8885
020500160929     C                   END
020600160929     C                   ENDSR
020700160929     C*
020800160929     C     VALID         BEGSR
020900160929     C* il n'y a eu aucune erreur on charge les zones communes
021000160929     C                   TIME                    WHS
021100160929     C     WNREC         CHAIN     FIFF                               7090
021200160929     C* c'est pas joli joli, on ne devrait le faire qu'en cas de modif.
021300160929     C                   MOVEL     ZFLIB         MILIB
021400160929     C                   MOVEL     WHS           MITSM
021500160929     C                   MOVEL     WUSER         MIUSM
021600160929     C                   IF        (POPT = 'MO')
021700160929     C* et on met à jour
021800160929     C                   UPDATE    FIFF
021900160929     C                   END
022000160929     C                   IF        (POPT = 'CO') OR
022100160929     C                             (POPT = 'CR')
022200160929     C* on rajoute le reste pour la création
022300160929     C                   MOVEL     ZFCOD         MIFON
022400160929     C                   MOVEL     MITSM         MITSC
022500160929     C                   MOVEL     WUSER         MIUSC
022600160929     C                   WRITE     FIFF
022700160929     C                   END
022800160929     C                   ENDSR
022900160929     C* mise à jour date et heure système
023000160929     C     DATHEU        BEGSR
023100160929     C                   TIME                    W14
023200160929     C                   MOVE      W14           WDAT
023300160929     C                   MOVEL     W14           WHEU
023400160929     C                   ENDSR
023500160929     C* conversion de la date
023600160929     C     CVTDAT        BEGSR
023700160929     C                   MOVEL     WHS           WASTA
023800160929     C* la DS découpe les valeurs que l'on concatène
023900160929     C                   EVAL      W8 = WJA+ WMA+ WSA
024000160929     C                   EVAL      W6 = WHA+ WIA+ WKA
024100160929     C                   ENDSR
024200160929     C*****Envoi d'un message programme
024300160929     C     ENVMSG        BEGSR
024400160929     C                   CALL      'PGM001CL'
024500160929     C                   PARM                    PTYP              1
024600160929     C                   PARM                    PFICM            10
024700160929     C                   PARM                    PMGID             7
024800160929     C                   PARM                    PMGDT            99
024900160929     C                   ENDSR
