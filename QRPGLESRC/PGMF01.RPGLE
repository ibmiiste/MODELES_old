000294180518     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000295180518     F*********************************************************************
000296180518     F* CC 01/01/2009
000297180518     F* Liste du personnel
000298180518     F*********************************************************************
000299180518     FPGMF01FM  CF   E             WORKSTN
000300180518     F                                     SFILE(SFL01:WRAN01)
000301180518     F                                     INFDS(DSSFL1)
000302180518     FFIC02L    IF   E           K DISK
000303180518     F                                     INFDS(FIC)
000304180518     F* Déclaration des variables
000305180518     DWDAT             S              8
000306180518     DWHEU             S              6
000307180518     DW14              S             14  0
000308180518     DWSNOM            S             35
000309180518     DWSNOP            S             35
000310180518     DI                S              3  0
000311180518     D* La DS du programme, noter le S indispensable
000312180518     DDSPROG          SDS
000313180518     DWNPROG                   1     10
000314180518     DWSTATP                  11     15  0
000315180518     DWSTAPR                  16     20  0
000316180518     DWSQSRC                  21     28
000317180518     DWSBROU                  29     36
000318180518     DWNPARM                  37     39  0
000319180518     DWTYEXC                  40     42
000320180518     DWNMSGM                  40     46
000321180518     DWNMEXC                  43     46
000322180518     DWINSMC                  47     50
000323180518     DWZOMSG                  51     80
000324180518     DWLBPGM                  81     90
000325180518     DWSFDTA                  91    170
000326180518     DWCDERR                 171    174
000327180518     DWLSFIL                 201    208
000328180518     DWLSINF                 209    243
000329180518     DWJOB                   244    253
000330180518     DWUSER                  254    263
000331180518     DWNJOB                  264    269  0
000332180518     D* La DS du sous=fichier
000333180518     DDSSFL1           DS
000334180518     DWPOSC                  370    371B 0
000335180518     DWRRNG                  376    377B 0
000336180518     DWRNGP                  378    379B 0
000337180518     DWNBRSF                 380    381B 0
000338180518     D* La DS du fichier
000339180518     DFIC              DS
000340180518     DWNRC01                 397    400B 0
000341180518     DWDSFIC           DS
000342180518     DWCDFIL                   1      8
000343180518     DWOPENF                   9      9
000344180518     DWSTSFI                  11     15  0
000345180518     DWOPCOD                  16     21
000346180518     DWRPGSQ                  30     37
000347180518     DWRPGNR                  38     45
000348180518     DWERRFI                  46     52
000349180518     DWNFICH                  83     92
000350180518     DWNLIBR                  93    102
000351180518     DWSPNAM                 103    112
000352180518     DWSPLIB                 113    122
000353180518     DWSPNUM                 123    124B 0
000354180518     DWLIMBR                 129    138
000355180518     DWNBPUT                 243    246B 0
000356180518     DWNBGET                 247    250B 0
000357180518     DWNBPG                  251    254B 0
000358180518     DWNBIO                  255    258B 0
000359180518     DWRCDFT                 261    270
000360180518     DWNBRCD                 283    286B 0
000361180518     DWNRCFI                 397    400B 0
000362180518     C* la clé d'accés au fichier
000363180518     C     KEY001        KLIST
000364180518     C                   KFLD                    FIFON
000365180518     C                   KFLD                    FINOM
000366180518     C* le nombre de lignes affichables, déclaration à la volée
000367180518     C                   Z-ADD     14            NBLIS1            4 0
000368180518     C* initialisation des variables générales
000369180518     C                   MOVEL     WNPROG        ZPGM
000370180518     C                   EXSR      DATHEU
000371180518     C                   MOVE      WDAT          ZDATE
000372180518     C                   MOVE      WHEU          ZHEUR
000373180518     C                   MOVEL     WUSER         ZUSER
000374180518     C                   MOVEL     WJOB          ZJOB
000375180518     C* Initialisation du sous fichier des messages
000376180518     C                   MOVEL     '*  '         WPGMQ
000377180518     C                   MOVEL     'CC01'        WMGKEY
000378180518     C                   SETON                                        0910
000379180518     C* Indicateur fin
000380180518     C                   SETON                                        50
000381180518     C* Début du traitement,
000382180518     C                   EXSR      INITSF
000383180518     C* Boucle d'attente de sortie
000384180518     C                   DOW       *IN50 = '1'
000385180518     C                   EXSR      TRTSFL
000386180518     C                   END
000387180518     C* Indicateur de fin de programme
000388180518     C                   SETON                                        LR
000389180518     C* Les procédures
000390180518     C* Traitement de l'écran
000391180518     C     TRTSFL        BEGSR
000392180518     C* Effacement du sous=fichier de messages
000393180518     C                   MOVEL     '3'           PTYP
000394180518     C                   MOVEL     *BLANK        PFIM
000395180518     C                   MOVEL     *BLANK        PMID
000396180518     C                   CALL      'PGM001CL'
000397180518     C                   PARM                    PTYP              1
000398180518     C                   PARM                    PFIM             10
000399180518     C                   PARM                    PMID              7
000400180518     C                   PARM                    PMDT             99
000401180518     C                   WRITE     WSFCTL
000402180518     C* Ecriture de l'écran
000403180518     C                   SETON                                        0405
000404180518     C                   WRITE     FORE1                                  70
000405180518     C                   WRITE     FORB1
000406180518     C* Attente lecture
000407180518     C                   READ      FORE1                                  70
000408180518     C* Une touche a été actionnée
000409180518     C* Chargement de l'heure
000410180518     C                   TIME                    ZHEUR
000411180518     C* Indicateur pour ne pas tester d'autres actions
000412180518     C                   SETON                                        51
000413180518     C                   IF        *IN02 = '1'
000414180518     C* page suivante
000415180518     C                   EXSR      CHGPAG
000416180518     C                   SETOFF                                       51
000417180518     C                   END
000418180518     C*
000419180518     C   51              IF        WSNOP <> ZSNOM
000420180518     C* Test si selection/ si changé on initialise
000421180518     C                   EXSR      INITSF
000422180518     C                   SETOFF                                       51
000423180518     C                   END
000424180518     C* touches F3 et F12
000425180518     C                   IF        *INKC = '1' OR
000426180518     C                             *INKL = '1'
000427180518     C* on met l'indicateur à Off = fin du programme
000428180518     C                   SETOFF                                       5051
000429180518     C                   END
000430180518     C*
000431180518     C                   IF        *INKE = '1'
000432180518     C* F5 Rafraichissement de l'écran
000433180518     C                   EXSR      INITSF
000434180518     C                   SETOFF                                       51
000435180518     C                   END
000436180518     C*
000437180518     C                   IF        *INKF = '1'
000438180518     C* F6 création d'un nouveau matricule
000439180518     C                   MOVEL     'CR'          PCHX
000440180518     C                   MOVEL     *BLANK        NREC
000441180518     C                   CALL      'PGMF02'
000442180518     C                   PARM                    PCHX              2
000443180518     C                   PARM                    NREC             10
000444180518     C                   EXSR      INITSF
000445180518     C                   SETOFF                                       51
000446180518     C                   END
000447180518     C                   IF        *INKH = '1'
000448180518     C* F8 impression du fichier
000449180518     C                   MOVEL     *BLANK        PMAT
000450180518     C* On appelle le CL de routage sans soumission, sinon PGMF20CL
000451180518     C                   CALL      'PGMF2SCL'
000452180518     C                   PARM                    PMAT             10
000453180518     C                   SETOFF                                       51
000454180518     C                   END
000455180518     C* On ne fait ceci que s'il n'y a eu rien d'autre
000456180518     C                   IF        *IN51 = '1'
000457180518     C                   EXSR      TRTOPT
000458180518     C                   END
000459180518     C* On recommence la boucle d'attente
000460180518     C                   ENDSR
000461180518     C* Initialisation du sous-fichier
000462180518     C     INITSF        BEGSR
000463180518     C*    l'indicateur 20 conditionne la zone OPT (protection)
000464180518     C                   SETOFF                                       20
000465180518     C* Initialisation de la variable de sélection
000466180518     C                   MOVEL     ZSNOM         WSNOP
000467180518     C                   MOVEL     *BLANK        WSNOM
000468180518     C* Initialisation de la clé pour positionnement
000469180518     C                   MOVEL     *BLANK        FIFON
000470180518     C                   MOVEL     *BLANK        FINOM
000471180518     C                   SETOFF                                       8485
000472180518     C                   IF        ZSNOM <> *BLANK
000473180518     C* Si différent de blank il y a sélection
000474180518     C                   SETON                                        84
000475180518     C                   Z-ADD     0             I
000476180518     C     '*'           SCAN      ZSNOM         I                      85
000477180518     C                   IF        I > 0
000478180518     C     I             SUB       1             I
000479180518     C     I             SUBST (P) ZSNOM:1       WSNOM                  90
000480180518     C* On est dans le cas d'une sélection générique
000481180518     C                   SETON                                          85
000482180518     C* On se positionnera juste au bon endroit dans le fichier
000483180518     C                   MOVEL     WSNOM         FINOM
000484180518     C                   END
000485180518     C                   END
000486180518     C* La dernière ligne écrite
000487180518     C                   Z-ADD     0             LSTLIG            4 0
000488180518     C* Le compteur de ligne par page
000489180518     C                   Z-ADD     0             NBRLIG            4 0
000490180518     C* Le fameux WRAN01
000491180518     C                   Z-ADD     0             WRAN01            4 0
000492180518     C* Effacement du sous=fichier
000493180518     C                   SETON                                        0607
000494180518     C                   SETOFF                                       0405
000495180518     C                   WRITE     FORE1
000496180518     C                   SETOFF                                       06
000497180518     C                   SETON                                        0405
000498180518     C* Positionnement en début de fichier
000499180518     C     KEY001        SETLL     FICF                                   70
000500180518     C* Chargement de la première page
000501180518     C                   EXSR      CHGPAG
000502180518     C                   ENDSR
000503180518     C* Traitement des options, on ne lit que les enregistrements modifiés
000504180518     C     TRTOPT        BEGSR
000505180518     C* Lecture des enregistrements modifiés
000506180518     C                   Z-ADD     1             WRAN01
000507180518     C* Top pour rafraîchir l'écran, si besoin
000508180518     C                   SETOFF                                       86
000509180518     C  N70              READC     SFL01                                7071
000510180518     C*
000511180518     C     *IN70         DOWEQ     '0'
000512180518     C                   MOVE      HNREC         NREC
000513180518     C                   IF        HTOUT = '1'
000514180518     C                   IF        ZOPT='2' OR ZOPT='3' OR ZOPT='4' OR ZOPT='99'
000515180518     C* Si l'employé à quitté on ne peut plus rien modifier
000516180518     C                   MOVE      '5 '          ZOPT
000517180518     C                   END
000518180518     C                   END
000519180518     C                   SETON                                        85
000520180518     C* Selection en fonction du choix saisi
000521180518     C                   SELECT
000522180518     C                   WHEN      (ZOPT = '2') OR (ZOPT = ' 2')
000523180518     C                   MOVEL     'MO'          PCHX
000524180518     C                   WHEN      (ZOPT = '3') OR (ZOPT = ' 3')
000525180518     C                   MOVEL     'CO'          PCHX
000526180518     C                   WHEN      (ZOPT = '4') OR (ZOPT = ' 4')
000527180518     C                   MOVEL     'SU'          PCHX
000528180518     C                   WHEN      (ZOPT = '5') OR (ZOPT = ' 5')
000529180518     C                   MOVEL     'AF'          PCHX
000530180518     C                   WHEN      (ZOPT = '6') OR (ZOPT = ' 6')
000531180518     C                   MOVE      HMATR         PMAT
000532180518     C                   CALL      'PGMF2SCL'
000533180518     C                   PARM                    PMAT             10
000534180518     C                   SETOFF                                       85
000535180518     C                   WHEN      (ZOPT = '99')
000536180518     C                   MOVEL     'PE'          PCHX
000537180518     C                   OTHER
000538180518     C* La saisie ne correspond à rien
000539180518     C                   SETOFF                                       85
000540180518     C* Envoyer un message pour dire que l'option n'existe pas
000541180518     C                   MOVEL     '1'           PTYP
000542180518     C                   MOVEL     'FICMSG   '   PFIM
000543180518     C                   MOVEL     'MSG0002'     PMID
000544180518     C                   CALL      'PGM001CL'
000545180518     C                   PARM                    PTYP              1
000546180518     C                   PARM                    PFIM             10
000547180518     C                   PARM                    PMID              7
000548180518     C                   PARM                    PMDT             99
000549180518     C                   ENDSL
000550180518     C                   IF        HTOUT = '0'
000551180518     C* Pour ne pas perdre l'attribut couleur
000552180518     C                   SETOFF                                       30
000553180518     C                   ELSE
000554180518     C                   SETON                                        30
000555180518     C                   END
000556180518     C* Nettoyage
000557180518     C                   MOVEL     *BLANK        ZOPT
000558180518     C                   UPDATE    SFL01                                90
000559180518     C* On aurait pu aussi faire IF..., en tout cas le choix est bon
000560180518     C   85              CALL      'PGMF02'
000561180518     C                   PARM                    PCHX              2
000562180518     C                   PARM                    NREC             10
000563180518     C   85              SETON                                        86
000564180518     C* On continue de boucler si autre option
000565180518     C                   READC     SFL01                                7071
000566180518     C                   END
000567180518     C* Potentiellement il y a eu mise à jour, on pourrait affiner
000568180518     C   86              EXSR      INITSF
000569180518     C                   ENDSR
000570180518     C* Chargement d'une page
000571180518     C     CHGPAG        BEGSR
000572180518     C* Il faut positionner correctement les indicateurs et les variables
000573180518     C                   SETOFF                                       08
000574180518     C*                  SETON                                        04
000575180518     C                   Z-ADD     LSTLIG        WRAN01
000576180518     C* Lexture de l'enregistrement suivant
000577180518     C                   READ      FICF                                   70
000578180518     C* Remise à zéro du compteur de ligne, mais on pourrait faire autremen
000579180518     C                   Z-ADD     0             NBRLIG            4 0
000580180518     C*
000581180518     C     *IN70         DOWEQ     '0'
000582180518     C     NBRLIG        ANDLT     14
000583180518     C* Remplissage des zones écran
000584180518     C                   SETON                                        86
000585180518     C* Test s'il y a sélection
000586180518     C                   IF        *IN84 = '1' OR *IN85 = '1'
000587180518     C                   IF        *IN84 = '1' AND *IN85 = '0'
000588180518     C* On recherche la stricte égalité de nom
000589180518     C                   IF        FINOM <> ZSNOM
000590180518     C                   SETOFF                                       86
000591180518     C                   END
000592180518     C                   ELSE
000593180518     C* On recherche si le nom commence par la valeur avant le '*'
000594180518     C     I             SUBST (P) FINOM:1       WXNOM            35    90
000595180518     C* Petite entorse de flemmard WXNOM est déclarée au fil de l'eau
000596180518     C                   IF        WXNOM <> WSNOM
000597180518     C                   SETOFF                                       86
000598180518     C                   END
000599180518     C                   END
000600180518     C                   END
000601180518     C* L'indicateur est à '1' si sélection OK ou pas de sélection
000602180518     C                   IF        *IN86 = '1'
000603180518     C                   MOVEL     FINOM         ZNOM
000604180518     C                   MOVEL     FIPR1         ZPR1
000605180518     C                   MOVEL     FIFON         ZFONC
000606180518     C                   Z-ADD     FIMAT         ZMATR
000607180518     C                   MOVEL     FICPO         ZCPO
000608180518     C                   MOVEL     FIC           WDSFIC
000609180518     C                   Z-ADD     WNRCFI        HNREC
000610180518     C                   MOVE      FIMAT         HMATR
000611180518     C                   IF        FIDAS = 0
000612180518     C* Top salarié licencié
000613180518     C                   MOVE      '0'           HTOUT
000614180518     C                   SETOFF                                       30
000615180518     C                   ELSE
000616180518     C                   MOVE      '1'           HTOUT
000617180518     C                   SETON                                        30
000618180518     C                   END
000619180518     C* Les compteurs, attention au WRAN01
000620180518     C                   ADD       1             NBRLIG
000621180518     C                   ADD       1             LSTLIG
000622180518     C                   ADD       1             WRAN01
000623180518     C* Ecriture de la ligne
000624180518     C                   WRITE     SFL01
000625180518     C                   END
000626180518     C* Lecture du suivant
000627180518     C                   READ      FICF                                   70
000628180518     C                   END
000629180518     C* On quitte la boucle soit en fin de page
000630180518     C*                     soit en fin de fichier
000631180518     C     *IN70         IFEQ      '1'
000632180518     C* Le caractère de suite, on est en fin de fichier
000633180518     C                   SETON                                        07
000634180518     C                   ELSE
000635180518     C                   SETOFF                                       07
000636180518     C                   END
000637180518     C* Si le fichier est vide
000638180518     C     WRAN01        IFEQ      0
000639180518     C                   Z-ADD     1             NBRLIG
000640180518     C                   Z-ADD     1             LSTLIG            4 0
000641180518     C* Un petit message
000642180518     C                   Z-ADD     1             WRAN01
000643180518     C* Pas de saisie d'option
000644180518     C                   SETON                                        20
000645180518     C                   IF        ZSNOM = *BLANK
000646180518     C* Si on a un vieil AS400 du siècle dernier
000647180518     C                   MOVEL     'Fic. Vide'   ZNOM
000648180518     C                   ELSE
000649180518     C* En RPG ILE
000650180518     C                   eval      ZNOM = 'Sélection Vide'
000651180518     C                   END
000652180518     C* Ne pas oublier de remettre à blanc
000653180518     C                   MOVEL     *BLANK        ZPR1
000654180518     C                   MOVEL     *BLANK        ZFONC
000655180518     C                   Z-ADD     0             ZMATR
000656180518     C                   MOVEL     *BLANK        ZCPO
000657180518     C                   MOVEL     *BLANK        WDSFIC
000658180518     C                   Z-ADD     0             HNREC
000659180518     C* Ecriture du message sur la première ligne
000660180518     C                   WRITE     SFL01
000661180518     C                   END
000662180518     C* le WRAN01 à 1 pour afficher le premier enregistrement
000663180518     C*                  Z-ADD     LSTLIG        WRAN01
000664180518     C                   ENDSR
000665180518     C* Lecture date et heure système
000666180518     C     DATHEU        BEGSR
000667180518     C                   TIME                    W14
000668180518     C                   MOVE      W14           WDAT
000669180518     C                   MOVEL     W14           WHEU
000670180518     C                   ENDSR
