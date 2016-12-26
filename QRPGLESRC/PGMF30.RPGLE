000100160929     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000200160929     F*****************************************************
000300160929     F*                                                   *
000400160929     F* Liste outq                                        *
000500160929     F*                                                   *
000600160929     F*****************************************************
000700160929     FPGMF30FM  CF   E             WORKSTN
000800160929     F                                     SFILE(SFL01 :WRAN01)
000900160929     F                                     INFDS(DSSFL1)
001000160929     FFIO01L    IF A E           K DISK
001100160929     F                                     INFDS(WDSFIC)
001200160929     FFIO00P    UF   E             DISK
001300160929     F                                     RENAME(FIOF      :FIOFP)
001400160929     DWTXT1            C                   'DSPOBJD OBJ('
001500160929     DWTXT2            C                   ') OBJTYPE(*USRPRF) OUTPUT(*PRINT)'
001600160929     DWTXT3            C                   ') OBJTYPE(*OUTQ) OUTPUT(*PRINT)'
001700160929     DW14              S             14  0
001800160929     DWDAT             S              8
001900160929     DWHEU             S              6
002000160929     DWCMD             S            256
002100160929     DWLNG             S             15  5
002200160929     DPNREC            S             10
002300160929     DW10              S             10
002400160929     DWSUSR            S             10
002500160929     DWSDOC            S             10
002600160929     DWSPRT            S             10
002700160929     DDSPROG          SDS
002800160929     DWNPROG                   1     10
002900160929     DWSTATP                  11     15  0
003000160929     DWSTAPR                  16     20  0
003100160929     DWSQSRC                  21     28
003200160929     DWSBROU                  29     36
003300160929     DWNPARM                  37     39  0
003400160929     DWTYEXC                  40     42
003500160929     DWNMSGM                  40     46
003600160929     DWNMEXC                  43     46
003700160929     DWINSMC                  47     50
003800160929     DWZOMSG                  51     80
003900160929     DWLBPGM                  81     90
004000160929     DWSFDTA                  91    170
004100160929     DWCDERR                 171    174
004200160929     DWLSFIL                 201    208
004300160929     DWLSINF                 209    243
004400160929     DWJOB                   244    253
004500160929     DWUSER                  254    263
004600160929     DWNJOB                  264    269  0
004700160929     DDSSFL1           DS
004800160929     DWPOSC                  370    371B 0
004900160929     DWRRNG                  376    377B 0
005000160929     DWRNGP                  378    379B 0
005100160929     DWNBRSF                 380    381B 0
005200160929     DWNLIGF                 382    383B 0
005300160929     DWNRCME                 403    404B 0
005400160929     DWDSFIC           DS
005500160929     DWCDFIL                   1      8
005600160929     DWOPENF                   9      9
005700160929     DWSTSFI                  11     15  0
005800160929     DWOPCOD                  16     21
005900160929     DWRPGSQ                  30     37
006000160929     DWRPGNR                  38     45
006100160929     DWERRFI                  46     52
006200160929     DWNFICH                  83     92
006300160929     DWNLIBR                  93    102
006400160929     DWSPNAM                 103    112
006500160929     DWSPLIB                 113    122
006600160929     DWSPNUM                 123    124B 0
006700160929     DWLIMBR                 129    138
006800160929     DWNBPUT                 243    246B 0
006900160929     DWNBGET                 247    250B 0
007000160929     DWNBPG                  251    254B 0
007100160929     DWNBIO                  255    258B 0
007200160929     DWRCDFT                 261    270
007300160929     DWNBRCD                 283    286B 0
007400160929     DWNRCFI                 397    400B 0
007500160929     C     SKEY01        KLIST
007600160929     C                   KFLD                    FOUSR
007700160929     C     KEY001        KLIST
007800160929     C                   KFLD                    ZMUSR
007900160929     C                   KFLD                    ZMDOC
008000160929     C                   KFLD                    ZMPRT
008100160929     C                   Z-ADD     14            NBLIS1            4 0
008200160929     C                   MOVEL     '*   '        WPGMQ
008300160929     C                   MOVEL     'CC01'        WMGKEY
008400160929     C* Programme Liste des Outq
008500160929     C* initialisations générales
008600160929     C                   Z-ADD     256           WLNG
008700160929     C                   MOVEL     WNPROG        ZPGM
008800160929     C                   EXSR      DATHEU
008900160929     C                   MOVE      WDAT          ZDATE
009000160929     C                   MOVE      WHEU          ZHEUR
009100160929     C                   MOVEL     WUSER         ZUSER
009200160929     C                   MOVEL     WJOB          ZJOB
009300160929     C                   SETON                                        091050
009400160929     C* Debut du traitement,
009500160929     C                   EXSR      INITSF
009600160929     C* Boucle d'attente de sortie
009700160929     C                   DOW       *IN50 = '1'
009800160929     C                   EXSR      TRTSFL
009900160929     C                   END
010000160929     C                   SETON                                        LR
010100160929     C* traitement ecran
010200160929     C     TRTSFL        BEGSR
010300160929     C********************************
010400160929     C                   MOVEL     '3'           PTYP
010500160929     C                   MOVEL     *BLANK        PFIM
010600160929     C                   MOVEL     *BLANK        PMID
010700160929     C                   CALL      'PGM001CL'
010800160929     C                   PARM                    PTYP              1
010900160929     C                   PARM                    PFIM             10
011000160929     C                   PARM                    PMID              7
011100160929     C                   PARM                    PMDT             99
011200160929     C* mise à blanc du sous fichier de messages
011300160929     C                   WRITE     WSFCTL
011400160929     C                   SETON                                        0405
011500160929     C* ecriture de l'écran
011600160929     C                   WRITE     FORE1                                  70
011700160929     C                   WRITE     FORB1
011800160929     C* attente lecture
011900160929     C                   READ      FORE1
012000160929     C* chargement de l'heure
012100160929     C                   EXSR      DATHEU
012200160929     C                   MOVE      WDAT          ZDATE
012300160929     C                   MOVE      WHEU          ZHEUR
012400160929     C                   SETON                                          5185
012500160929     C                   IF        WSUSR <> ZSUSR OR
012600160929     C                             WSDOC <> ZSDOC OR
012700160929     C                             WSPRT <> ZSPRT
012800160929     C                   EXSR      INITSF
012900160929     C                   SETOFF                                         51
013000160929     C                   END
013100160929     C* touches F3 et F12
013200160929     C   51              IF        *INKC = '1' OR
013300160929     C                             *INKL = '1'
013400160929     C* on met l'indicateur à Off
013500160929     C                   SETOFF                                       5051
013600160929     C                   END
013700160929     C* la suite n'est exécutée que si indicateur 51 = '1'
013800160929     C   51              IF        *IN02 = '1'
013900160929     C* page suivante
014000160929     C                   EXSR      CHGPAG
014100160929     C                   SETOFF                                       51
014200160929     C                   END
014300160929     C*
014400160929     C   51              IF        *INKF = '1'
014500160929     C* fonction création
014600160929     C     LSTLIG        ADD       1             LSTLIG
014700160929     C                   Z-ADD     LSTLIG        WRAN01
014800160929     C                   MOVEL     *BLANK        ZMUSR
014900160929     C                   MOVEL     *BLANK        ZMPRT
015000160929     C                   MOVEL     *BLANK        ZMDOC
015100160929     C* on rajoute une ligne à saisir dans le sous fichier
015200160929     C                   WRITE     SFL01
015300160929     C*                  SETON
015400160929     C                   SETOFF                                       51
015500160929     C                   ENDIF
015600160929     C   51              IF        *INKP = '1'
015700160929     C* ménage profils et outq inconnus
015800160929     C                   Z-ADD     0             HNREC
015900160929     C                   READ      FIOFP                                9070
016000160929     C                   DOW       *IN70 = '0'
016100160929     C                   EVAL      W10 = FOUSR
016200160929     C                   SETOFF                                         86
016300160929     C                   EXSR      EXECMD
016400160929     C                   IF        *IN90 = '1'
016500160929     C                   DELETE    FIOFP
016600160929     C                   SETON                                        85
016700160929     C                   ELSE
016800160929     C                   EVAL      W10 = FOOUQ
016900160929     C                   SETON                                          86
017000160929     C                   SETON                                        85
017100160929     C                   EXSR      EXECMD
017200160929     C                   IF        *IN90 = '1'
017300160929     C                   DELETE    FIOFP
017400160929     C                   SETON                                        85
017500160929     C                   END
017600160929     C                   END
017700160929     C                   READ      FIOFP                                9070
017800160929     C                   ENDDO
017900160929     C                   END
018000160929     C* vérification saisie/choix
018100160929     C   51              EXSR      CTLDTA
018200160929     C* en cas de modification on rafraichit l'écran
018300160929     C   85              EXSR      INITSF
018400160929     C* on recommence la boucle d'attente
018500160929     C                   ENDSR
018600160929     C* initialisation du sous fichier
018700160929     C     INITSF        BEGSR
018800160929     C                   eval      WSUSR = ZSUSR
018900160929     C                   eval      WSDOC = ZSDOC
019000160929     C                   eval      WSPRT = ZSPRT
019100160929     C* La dernière ligne écrite
019200160929     C                   Z-ADD     0             LSTLIG            4 0
019300160929     C* Le compteur de ligne par page
019400160929     C                   Z-ADD     0             NBRLIG            4 0
019500160929     C* Le fameux WRAN01
019600160929     C                   Z-ADD     0             WRAN01            4 0
019700160929     C* Effacement du sous=fichier
019800160929     C                   SETON                                        0607
019900160929     C                   SETOFF                                       0405
020000160929     C                   WRITE     FORE1
020100160929     C                   SETOFF                                       06
020200160929     C                   SETON                                        0405
020300160929     C* Positionnement en début de fichier
020400160929     C                   MOVEL     *LOVAL        FOUSR
020500160929     C     SKEY01        SETLL     FIOF
020600160929     C* Chargement de la première page
020700160929     C                   EXSR      CHGPAG
020800160929     C                   ENDSR
020900160929     C* vérification des données
021000160929     C     CTLDTA        BEGSR
021100160929     C********************
021200160929     C* lecture des enregistrements modifiés
021300160929     C                   Z-ADD     1             WRAN01
021400160929     C* Top pour rafraichir l'écran, si besoin
021500160929     C                   SETOFF                                       86
021600160929     C  N70              READC     SFL01
021700160929     C* boucle de lecture
021800160929     C     *IN70         DOWEQ     '0'
021900160929     C                   MOVEL     '1'           *IN85
022000160929     C* si les trois champs sont remis à blank = suppression
022100160929     C                   IF        ZMUSR = *BLANK AND
022200160929     C                             ZMPRT = *BLANK AND
022300160929     C                             ZMDOC = *BLANK
022400160929     C     HNREC         CHAIN     FIOFP                              70
022500160929     C                   IF        *IN71  = '0'
022600160929     C                   DELETE    FIOFP
022700160929     C                   END
022800160929     C                   ELSE
022900160929     C     KEY001        CHAIN     FIOF                               71
023000160929     C                   IF        *IN71 = '0'
023100160929     C* pas bon du tout
023200160929     C                   MOVEL     '0'           *IN85
023300160929     C                   ELSE
023400160929     C* le user doit exister
023500160929     C                   EVAL      W10 = ZMUSR
023600160929     C                   EXSR      EXECMD
023700160929     C                   IF        *IN90 = '1'
023800160929     C                   MOVEL     '0'           *IN85
023900160929     C                   MOVEL     'MSG0005'     WMGID            10
024000160929     C                   END
024100160929     C* et la outq aussi
024200160929     C                   IF        *IN85 = '1'
024300160929     C                   EVAL      W10  =  ZMPRT
024400160929     C                   SETON                                        86
024500160929     C                   EXSR      EXECMD
024600160929     C                   IF        *IN90 = '1'
024700160929     C                   MOVEL     '0'           *IN85
024800160929     C                   MOVEL     'MSG0006'     WMGID            10
024900160929     C                   END
025000160929     C                   END
025100160929     C                   END
025200160929     C* si c'est ok
025300160929     C                   IF        *IN85 = '1'
025400160929     C                   MOVEL     ZMUSR         FOUSR
025500160929     C                   MOVEL     ZMDOC         FODOC
025600160929     C                   MOVEL     ZMPRT         FOOUQ
025700160929     C                   WRITE     FIOF
025800160929     C                   ELSE
025900160929     C* message d'erreur
026000160929     C                   END
026100160929     C                   END
026200160929     C* mise à jour du sous fichier
026300160929     C                   UPDATE    SFL01
026400160929     C* lecture du suivant
026500160929     C                   READC     SFL01
026600160929     C                   END
026700160929     C                   ENDSR
026800160929     C**********************************
026900160929     C     CHGPAG        BEGSR
027000160929     C*  chargement de la page
027100160929     C                   SETOFF                                       08
027200160929     C*                  SETON                                        04
027300160929     C                   Z-ADD     LSTLIG        WRAN01
027400160929     C                   READ      FIOF
027500160929     C                   Z-ADD     0             NBRLIG            4 0
027600160929     C*
027700160929     C     *IN70         DOWEQ     '0'
027800160929     C     NBRLIG        ANDLT     14
027900160929     C* remplissage des zones écran
028000160929     C                   SETON                                        86
028100160929     C                   IF        ( FOUSR = ZSUSR OR
028200160929     C                             ZSUSR = *BLANK) AND
028300160929     C                             ( FODOC = ZSDOC OR
028400160929     C                             ZSDOC = *BLANK) AND
028500160929     C                             ( FOOUQ = ZSPRT OR
028600160929     C                             ZSPRT = *BLANK)
028700160929     C* On recherche la stricte égalité
028800160929     C                   MOVEL     FOUSR         ZMUSR
028900160929     C                   MOVEL     FODOC         ZMDOC
029000160929     C                   MOVEL     FOOUQ         ZMPRT
029100160929     C                   Z-ADD     WNRCFI        HNREC
029200160929     C                   ADD       1             NBRLIG
029300160929     C                   ADD       1             WRAN01
029400160929     C                   ADD       1             LSTLIG            4 0
029500160929     C                   WRITE     SFL01
029600160929     C                   END
029700160929     C* lecture du suivant
029800160929     C                   READ      FIOF
029900160929     C                   END
030000160929     C* on quitte la boucle soit en fin de page
030100160929     C*                     soit en fin de fichier
030200160929     C     *IN70         IFEQ      '1'
030300160929     C* le caractère de suite
030400160929     C                   SETON                                        07
030500160929     C                   END
030600160929     C* si le fichier est vide
030700160929     C     WRAN01        IFEQ      0
030800160929     C                   Z-ADD     1             NBRLIG
030900160929     C                   Z-ADD     1             LSTLIG            4 0
031000160929     C* un petit message
031100160929     C                   Z-ADD     1             WRAN01
031200160929     C* pas de saisie d'option
031300160929     C                   SETON                                        20
031400160929     C                   eval      ZMDOC = 'vide      '
031500160929     C                   IF        ZMUSR = *BLANK AND ZMDOC = *BLANK AND
031600160929     C                             ZMPRT = *BLANK
031700160929     C                   eval      ZMUSR = 'Fichier   '
031800160929     C                   ELSE
031900160929     C                   eval      ZMUSR = 'Sélection '
032000160929     C                   END
032100160929     C                   MOVEL     *BLANK        ZMPRT
032200160929     C                   MOVEL     *BLANK        WDSFIC
032300160929     C                   Z-ADD     0             HNREC
032400160929     C                   WRITE     SFL01
032500160929     C                   END
032600160929     C* le WRAN01 à 1 pour afficher le premier enregistrement
032700160929     C                   Z-ADD     1             WRAN01
032800160929     C                   ENDSR
032900160929     C* execution de commande, puisqu'on le fait plusieurs fois
033000160929     C     EXECMD        BEGSR
033100160929     C* On nettoie la variable
033200160929     C                   MOVEL     *BLANK        WCMD
033300160929     C* ça on le fait dans les deux cas
033400160929     C                   EVAL      WCMD = WTXT1+ W10
033500160929     C* selon le cas on teste user ou outq
033600160929     C                   IF        *IN86 = '0'
033700160929     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT2
033800160929     C                   ELSE
033900160929     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT3
034000160929     C                   END
034100160929     C* execution commande, WLNG = longueur de WCMD (init au début)
034200160929     C                   CALL      'QCMDEXC'
034300160929     C                   PARM                    WCMD
034400160929     C                   PARM                    WLNG
034500160929     C                   ENDSR
034600160929     C* procédure pour la date
034700160929     C     DATHEU        BEGSR
034800160929     C                   TIME                    W14
034900160929     C                   MOVE      W14           WDAT
035000160929     C                   MOVEL     W14           WHEU
035100160929     C                   ENDSR
