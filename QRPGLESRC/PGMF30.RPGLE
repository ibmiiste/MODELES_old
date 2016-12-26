     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Liste outq                                        *
     F*                                                   *
     F*****************************************************
     FPGMF30FM  CF   E             WORKSTN
     F                                     SFILE(SFL01 :WRAN01)
     F                                     INFDS(DSSFL1)
     FFIO01L    IF A E           K DISK
     F                                     INFDS(WDSFIC)
     FFIO00P    UF   E             DISK
     F                                     RENAME(FIOF      :FIOFP)
     DWTXT1            C                   'DSPOBJD OBJ('
     DWTXT2            C                   ') OBJTYPE(*USRPRF) OUTPUT(*PRINT)'
     DWTXT3            C                   ') OBJTYPE(*OUTQ) OUTPUT(*PRINT)'
     DW14              S             14  0
     DWDAT             S              8
     DWHEU             S              6
     DWCMD             S            256
     DWLNG             S             15  5
     DPNREC            S             10
     DW10              S             10
     DWSUSR            S             10
     DWSDOC            S             10
     DWSPRT            S             10
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
     DDSSFL1           DS
     DWPOSC                  370    371B 0
     DWRRNG                  376    377B 0
     DWRNGP                  378    379B 0
     DWNBRSF                 380    381B 0
     DWNLIGF                 382    383B 0
     DWNRCME                 403    404B 0
     DWDSFIC           DS
     DWCDFIL                   1      8
     DWOPENF                   9      9
     DWSTSFI                  11     15  0
     DWOPCOD                  16     21
     DWRPGSQ                  30     37
     DWRPGNR                  38     45
     DWERRFI                  46     52
     DWNFICH                  83     92
     DWNLIBR                  93    102
     DWSPNAM                 103    112
     DWSPLIB                 113    122
     DWSPNUM                 123    124B 0
     DWLIMBR                 129    138
     DWNBPUT                 243    246B 0
     DWNBGET                 247    250B 0
     DWNBPG                  251    254B 0
     DWNBIO                  255    258B 0
     DWRCDFT                 261    270
     DWNBRCD                 283    286B 0
     DWNRCFI                 397    400B 0
     C     SKEY01        KLIST
     C                   KFLD                    FOUSR
     C     KEY001        KLIST
     C                   KFLD                    ZMUSR
     C                   KFLD                    ZMDOC
     C                   KFLD                    ZMPRT
     C                   Z-ADD     14            NBLIS1            4 0
     C                   MOVEL     '*   '        WPGMQ
     C                   MOVEL     'CC01'        WMGKEY
     C* Programme Liste des Outq
     C* initialisations générales
     C                   Z-ADD     256           WLNG
     C                   MOVEL     WNPROG        ZPGM
     C                   EXSR      DATHEU
     C                   MOVE      WDAT          ZDATE
     C                   MOVE      WHEU          ZHEUR
     C                   MOVEL     WUSER         ZUSER
     C                   MOVEL     WJOB          ZJOB
     C                   SETON                                        091050
     C* Debut du traitement,
     C                   EXSR      INITSF
     C* Boucle d'attente de sortie
     C                   DOW       *IN50 = '1'
     C                   EXSR      TRTSFL
     C                   END
     C                   SETON                                        LR
     C* traitement ecran
     C     TRTSFL        BEGSR
     C********************************
     C                   MOVEL     '3'           PTYP
     C                   MOVEL     *BLANK        PFIM
     C                   MOVEL     *BLANK        PMID
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFIM             10
     C                   PARM                    PMID              7
     C                   PARM                    PMDT             99
     C* mise à blanc du sous fichier de messages
     C                   WRITE     WSFCTL
     C                   SETON                                        0405
     C* ecriture de l'écran
     C                   WRITE     FORE1                                  70
     C                   WRITE     FORB1
     C* attente lecture
     C                   READ      FORE1
     C* chargement de l'heure
     C                   EXSR      DATHEU
     C                   MOVE      WDAT          ZDATE
     C                   MOVE      WHEU          ZHEUR
     C                   SETON                                          5185
     C                   IF        WSUSR <> ZSUSR OR
     C                             WSDOC <> ZSDOC OR
     C                             WSPRT <> ZSPRT
     C                   EXSR      INITSF
     C                   SETOFF                                         51
     C                   END
     C* touches F3 et F12
     C   51              IF        *INKC = '1' OR
     C                             *INKL = '1'
     C* on met l'indicateur à Off
     C                   SETOFF                                       5051
     C                   END
     C* la suite n'est exécutée que si indicateur 51 = '1'
     C   51              IF        *IN02 = '1'
     C* page suivante
     C                   EXSR      CHGPAG
     C                   SETOFF                                       51
     C                   END
     C*
     C   51              IF        *INKF = '1'
     C* fonction création
     C     LSTLIG        ADD       1             LSTLIG
     C                   Z-ADD     LSTLIG        WRAN01
     C                   MOVEL     *BLANK        ZMUSR
     C                   MOVEL     *BLANK        ZMPRT
     C                   MOVEL     *BLANK        ZMDOC
     C* on rajoute une ligne à saisir dans le sous fichier
     C                   WRITE     SFL01
     C*                  SETON
     C                   SETOFF                                       51
     C                   ENDIF
     C   51              IF        *INKP = '1'
     C* ménage profils et outq inconnus
     C                   Z-ADD     0             HNREC
     C                   READ      FIOFP                                9070
     C                   DOW       *IN70 = '0'
     C                   EVAL      W10 = FOUSR
     C                   SETOFF                                         86
     C                   EXSR      EXECMD
     C                   IF        *IN90 = '1'
     C                   DELETE    FIOFP
     C                   SETON                                        85
     C                   ELSE
     C                   EVAL      W10 = FOOUQ
     C                   SETON                                          86
     C                   SETON                                        85
     C                   EXSR      EXECMD
     C                   IF        *IN90 = '1'
     C                   DELETE    FIOFP
     C                   SETON                                        85
     C                   END
     C                   END
     C                   READ      FIOFP                                9070
     C                   ENDDO
     C                   END
     C* vérification saisie/choix
     C   51              EXSR      CTLDTA
     C* en cas de modification on rafraichit l'écran
     C   85              EXSR      INITSF
     C* on recommence la boucle d'attente
     C                   ENDSR
     C* initialisation du sous fichier
     C     INITSF        BEGSR
     C                   eval      WSUSR = ZSUSR
     C                   eval      WSDOC = ZSDOC
     C                   eval      WSPRT = ZSPRT
     C* La dernière ligne écrite
     C                   Z-ADD     0             LSTLIG            4 0
     C* Le compteur de ligne par page
     C                   Z-ADD     0             NBRLIG            4 0
     C* Le fameux WRAN01
     C                   Z-ADD     0             WRAN01            4 0
     C* Effacement du sous=fichier
     C                   SETON                                        0607
     C                   SETOFF                                       0405
     C                   WRITE     FORE1
     C                   SETOFF                                       06
     C                   SETON                                        0405
     C* Positionnement en début de fichier
     C                   MOVEL     *LOVAL        FOUSR
     C     SKEY01        SETLL     FIOF
     C* Chargement de la première page
     C                   EXSR      CHGPAG
     C                   ENDSR
     C* vérification des données
     C     CTLDTA        BEGSR
     C********************
     C* lecture des enregistrements modifiés
     C                   Z-ADD     1             WRAN01
     C* Top pour rafraichir l'écran, si besoin
     C                   SETOFF                                       86
     C  N70              READC     SFL01
     C* boucle de lecture
     C     *IN70         DOWEQ     '0'
     C                   MOVEL     '1'           *IN85
     C* si les trois champs sont remis à blank = suppression
     C                   IF        ZMUSR = *BLANK AND
     C                             ZMPRT = *BLANK AND
     C                             ZMDOC = *BLANK
     C     HNREC         CHAIN     FIOFP                              70
     C                   IF        *IN71  = '0'
     C                   DELETE    FIOFP
     C                   END
     C                   ELSE
     C     KEY001        CHAIN     FIOF                               71
     C                   IF        *IN71 = '0'
     C* pas bon du tout
     C                   MOVEL     '0'           *IN85
     C                   ELSE
     C* le user doit exister
     C                   EVAL      W10 = ZMUSR
     C                   EXSR      EXECMD
     C                   IF        *IN90 = '1'
     C                   MOVEL     '0'           *IN85
     C                   MOVEL     'MSG0005'     WMGID            10
     C                   END
     C* et la outq aussi
     C                   IF        *IN85 = '1'
     C                   EVAL      W10  =  ZMPRT
     C                   SETON                                        86
     C                   EXSR      EXECMD
     C                   IF        *IN90 = '1'
     C                   MOVEL     '0'           *IN85
     C                   MOVEL     'MSG0006'     WMGID            10
     C                   END
     C                   END
     C                   END
     C* si c'est ok
     C                   IF        *IN85 = '1'
     C                   MOVEL     ZMUSR         FOUSR
     C                   MOVEL     ZMDOC         FODOC
     C                   MOVEL     ZMPRT         FOOUQ
     C                   WRITE     FIOF
     C                   ELSE
     C* message d'erreur
     C                   END
     C                   END
     C* mise à jour du sous fichier
     C                   UPDATE    SFL01
     C* lecture du suivant
     C                   READC     SFL01
     C                   END
     C                   ENDSR
     C**********************************
     C     CHGPAG        BEGSR
     C*  chargement de la page
     C                   SETOFF                                       08
     C*                  SETON                                        04
     C                   Z-ADD     LSTLIG        WRAN01
     C                   READ      FIOF
     C                   Z-ADD     0             NBRLIG            4 0
     C*
     C     *IN70         DOWEQ     '0'
     C     NBRLIG        ANDLT     14
     C* remplissage des zones écran
     C                   SETON                                        86
     C                   IF        ( FOUSR = ZSUSR OR
     C                             ZSUSR = *BLANK) AND
     C                             ( FODOC = ZSDOC OR
     C                             ZSDOC = *BLANK) AND
     C                             ( FOOUQ = ZSPRT OR
     C                             ZSPRT = *BLANK)
     C* On recherche la stricte égalité
     C                   MOVEL     FOUSR         ZMUSR
     C                   MOVEL     FODOC         ZMDOC
     C                   MOVEL     FOOUQ         ZMPRT
     C                   Z-ADD     WNRCFI        HNREC
     C                   ADD       1             NBRLIG
     C                   ADD       1             WRAN01
     C                   ADD       1             LSTLIG            4 0
     C                   WRITE     SFL01
     C                   END
     C* lecture du suivant
     C                   READ      FIOF
     C                   END
     C* on quitte la boucle soit en fin de page
     C*                     soit en fin de fichier
     C     *IN70         IFEQ      '1'
     C* le caractère de suite
     C                   SETON                                        07
     C                   END
     C* si le fichier est vide
     C     WRAN01        IFEQ      0
     C                   Z-ADD     1             NBRLIG
     C                   Z-ADD     1             LSTLIG            4 0
     C* un petit message
     C                   Z-ADD     1             WRAN01
     C* pas de saisie d'option
     C                   SETON                                        20
     C                   eval      ZMDOC = 'vide      '
     C                   IF        ZMUSR = *BLANK AND ZMDOC = *BLANK AND
     C                             ZMPRT = *BLANK
     C                   eval      ZMUSR = 'Fichier   '
     C                   ELSE
     C                   eval      ZMUSR = 'Sélection '
     C                   END
     C                   MOVEL     *BLANK        ZMPRT
     C                   MOVEL     *BLANK        WDSFIC
     C                   Z-ADD     0             HNREC
     C                   WRITE     SFL01
     C                   END
     C* le WRAN01 à 1 pour afficher le premier enregistrement
     C                   Z-ADD     1             WRAN01
     C                   ENDSR
     C* execution de commande, puisqu'on le fait plusieurs fois
     C     EXECMD        BEGSR
     C* On nettoie la variable
     C                   MOVEL     *BLANK        WCMD
     C* ça on le fait dans les deux cas
     C                   EVAL      WCMD = WTXT1+ W10
     C* selon le cas on teste user ou outq
     C                   IF        *IN86 = '0'
     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT2
     C                   ELSE
     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT3
     C                   END
     C* execution commande, WLNG = longueur de WCMD (init au début)
     C                   CALL      'QCMDEXC'
     C                   PARM                    WCMD
     C                   PARM                    WLNG
     C                   ENDSR
     C* procédure pour la date
     C     DATHEU        BEGSR
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
     C                   ENDSR
