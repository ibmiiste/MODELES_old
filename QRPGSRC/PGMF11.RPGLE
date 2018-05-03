     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Détail fonction                                   *
     F*                                                   *
     F*****************************************************
     FPGMF11FM  CF   E             WORKSTN
     F                                     INFDS(WDSECR)
     FFIF00P    UF A E             DISK
     FFIF01L    IF   E           K DISK
     F                                     RENAME(FIFF      :FIFF1   )
     DWTXT1            C                   '         Modification         '
     DWTXT2            C                   '             Copie            '
     DWTXT3            C                   '           Création           '
     DWTXT4            C                   '         Suppression          '
     DWTXT5            C                   '           Affichage          '
     DPOPT             S              2
     DW14              S             14  0
     DW8               S              8
     DWDAT             S              8
     DWHEU             S              6
     DWHS              S               Z
     DPNREC            S             10
     DWNREC            S             10  0
     DW6               S              6
     DWS               DS
     DWSA                      1      4
     DWMA                      6      7
     DWJA                      9     10
     DWHA                     12     13
     DWIA                     15     16
     DWKA                     18     19
     DWMU                     21     26
     DWASTA                    1     26
     DWDSPGM          SDS
     DWNMPGM                   1     10
     DWSTATU                  11     15  0
     DWSTPRE                  16     20  0
     DWSRCSQ                  21     28
     DWNMROU                  29     36
     DWNBPAR                  37     39  0
     DWTYEXC                  40     42
     DWLICPF                  40     46
     DWNUEXC                  43     46
     DWMIODT                  47     50
     DWZOMES                  51     80
     DWBIPGM                  81     90
     DWRTDTA                  91    170
     DWCOERR                 171    174
     DWDERFI                 201    208
     DWFIINF                 209    243
     DWJOB                   244    253
     DWUSER                  254    263
     DWJOBNM                 264    269  0
     DWDSECR           DS
     DWNLIG                  370    371B 0
     DWRANP                  378    379B 0
     DWNBRS                  380    381B 0
     DWNULC                  382    383B 0
     DWRECMI                 403    404B 0
     C     *ENTRY        PLIST
     C                   PARM                    POPT
     C                   PARM                    PNREC
     C* Début du programme
     C     KEY001        KLIST
     C                   KFLD                    ZFCOD
     C                   MOVEL     '*   '        WPGMQ
     C                   MOVEL     'CC01'        WMGKEY
     C                   SETON                                        0910
     C                   SETOFF                                       1213
     C* cette DS découpe automatiquement le time stamp
     C                   MOVEL     WNMPGM        ZPGM
     C                   EXSR      DATHEU
     C                   MOVE      WDAT          ZDATE
     C                   MOVE      WHEU          ZHEUR
     C                   MOVEL     WUSER         ZUSER
     C                   MOVEL     WJOB          ZJOB
     C* constantes pour ce programme
     C                   MOVE      '1'           PTYP
     C                   MOVEL     'FICMSG    '  PFICM
     C                   SELECT
     C                   WHEN      (POPT = 'MO')
     C* modification, forcement du libellé
     C                   MOVEL     WTXT1         ZMODE
     C                   SETON                                          13
     C                   WHEN      (POPT = 'CO')
     C* tout est saisissable
     C                   MOVEL     WTXT2         ZMODE
     C                   SETON                                        1213
     C                   WHEN      (POPT = 'CR')
     C* tout est saisissable
     C                   MOVEL     WTXT3         ZMODE
     C                   SETON                                        1213
     C                   WHEN      (POPT = 'SU')
     C* rien n'est saisissable
     C                   MOVEL     WTXT4         ZMODE
     C                   WHEN      (POPT = 'AF')
     C* rien n'est saisissable
     C                   MOVEL     WTXT5         ZMODE
     C                   ENDSL
     C*
     C                   MOVE      PNREC         WNREC
     C                   IF        WNREC <> 0
     C* sauf si c'est de la création l'enregistrement doit exister
     C     WNREC         CHAIN (N) FIFF                               7090
     C                   IF        *IN70 = '0'
     C* et dans ce cas on renseigne les valeurs, sinon
     C* les variables sont initialisées à zéro
     C                   MOVEL     MIFON         ZFCOD
     C                   MOVEL     MILIB         ZFLIB
     C* date et heure création
     C                   TEST (Z)                MITSC                  90
     C     *IN90         IFEQ      '1'
     C                   MOVEL     *LOVAL        WHS
     C                   ELSE
     C                   MOVEL     MITSC         WHS
     C                   END
     C                   EXSR      CVTDAT
     C* il ne reste plus qu'a charger dans la zone écran
     C                   MOVE      W8            ZDAC
     C                   MOVE      W6            ZHEC
     C                   MOVEL     MIUSC         ZUSC
     C* date et heure de modif
     C                   TEST (Z)                MITSM                  90
     C     *IN90         IFEQ      '1'
     C                   MOVEL     *LOVAL        WHS
     C                   ELSE
     C                   MOVEL     MITSM         WHS
     C                   END
     C                   EXSR      CVTDAT
     C                   MOVE      W8            ZDAM
     C                   MOVE      W6            ZHEM
     C                   MOVEL     MIUSM         ZUSM
     C                   END
     C                   END
     C*
     C                   SETON                                        50
     C                   DOW       *IN50 = '1'
     C                   EXSR      TRTSCR
     C                   ENDDO
     C*
     C                   SETON                                        LR
     C********* les procédures
     C     TRTSCR        BEGSR
     C                   WRITE     WMGCTL
     C* On écrit l'écran
     C                   WRITE     FORE1
     C* On attend l'appui sur une touche
     C                   READ      FORE1                                  70
     C                   SETON                                          51
     C*
     C                   EXSR      DATHEU
     C                   IF        *INKC = '1' OR
     C                             *INKL = '1'
     C                   SETOFF                                       5051
     C                   END
     C*                  IF        POPT = 'SU'
     C*                  SETOFF                                         51
     C*                  END
     C                   IF        *IN85 = '1'
     C     *INKP         IFEQ      '1'
     C* touche F15 on supprime si indicateur *IN85
     C     WNREC         CHAIN     FIFF                               7090
     C  N70              DELETE    FIFF
     C                   SETOFF                                       5051
     C                   END
     C                   END
     C* contrôle des données saisies
     C                   IF        *IN51 = '1'
     C                   EXSR      CTLDTA
     C                   IF        *IN88 = '1'
     C* anomalie
     C                   EXSR      ENVMSG
     C                   SETOFF                                       88
     C                   ELSE
     C* pas d'anomalie, on valide
     C                   EXSR      VALID
     C                   SETOFF                                       5051
     C                   END
     C                   END
     C* fin procedure
     C                   ENDSR
     C******************
     C     CTLDTA        BEGSR
     C                   SETOFF                                       8885
     C* dans ce cas la seule vérification est en création/copie
     C                   IF         (POPT = 'CR' OR POPT = 'CO')
     C     KEY001        CHAIN     FIFF1                              7090
     C* pour éviter de s'auto verrouiller
     C                   IF        *IN70 = '0'
     C* le code fonction existe                           ZFCOD
     C                   SETON                                        12
     C                   MOVEL     'MSG0007'     PMGID
     C                   MOVEL     *BLANK        PMGDT
     C* top anomalie
     C                   SETON                                        88
     C                   END
     C                   END
     C* On ne fait la suite que si indicateur 88 à zéro
     C  N88              IF          POPT = 'SU'
     C* Suppression on prévient avant de supprimer
     C                   MOVEL     'MSG0004'     PMGID
     C                   MOVEL     *BLANK        PMGDT
     C                   SETON                                        8885
     C                   END
     C                   ENDSR
     C*
     C     VALID         BEGSR
     C* il n'y a eu aucune erreur on charge les zones communes
     C                   TIME                    WHS
     C     WNREC         CHAIN     FIFF                               7090
     C* c'est pas joli joli, on ne devrait le faire qu'en cas de modif.
     C                   MOVEL     ZFLIB         MILIB
     C                   MOVEL     WHS           MITSM
     C                   MOVEL     WUSER         MIUSM
     C                   IF        (POPT = 'MO')
     C* et on met à jour
     C                   UPDATE    FIFF
     C                   END
     C                   IF        (POPT = 'CO') OR
     C                             (POPT = 'CR')
     C* on rajoute le reste pour la création
     C                   MOVEL     ZFCOD         MIFON
     C                   MOVEL     MITSM         MITSC
     C                   MOVEL     WUSER         MIUSC
     C                   WRITE     FIFF
     C                   END
     C                   ENDSR
     C* mise à jour date et heure système
     C     DATHEU        BEGSR
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
     C                   ENDSR
     C* conversion de la date
     C     CVTDAT        BEGSR
     C                   MOVEL     WHS           WASTA
     C* la DS découpe les valeurs que l'on concatène
     C                   EVAL      W8 = WJA+ WMA+ WSA
     C                   EVAL      W6 = WHA+ WIA+ WKA
     C                   ENDSR
     C*****Envoi d'un message programme
     C     ENVMSG        BEGSR
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFICM            10
     C                   PARM                    PMGID             7
     C                   PARM                    PMGDT            99
     C                   ENDSR
