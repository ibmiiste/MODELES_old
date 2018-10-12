       ctl-opt debug decedit('0,') datedit(*dmy.);
     F*****************************************************
     F*                                                   *
     F* Détail personnel                                  *
     F*                                                   *
     F*****************************************************
       dcl-f PGMF02FM workstn infds(wdsecr);
       dcl-f FIC00P usage(*update);
       dcl-f FIC01L keyed usage(*update: *output) rename(ficf      :ficf1);
       dcl-f FIF01L keyed;
       dcl-c WTXT1 '         Modification         ';
       dcl-c WTXT2 '             Copie            ';
       dcl-c WTXT3 '         Suppression          ';
       dcl-c WTXT4 '           Affichage          ';
       dcl-c WTXT5 '           Création           ';
       dcl-c WTXT6 '        Fin de contrat        ';
       dcl-s WDAT char(8);
       dcl-s WHEU char(6);
       dcl-s W14 packed(14);
       dcl-s PCHX char(2);
       dcl-s PNREC char(10);
       dcl-s WNREC packed(10);
       dcl-s PACT char(2);
       dcl-s PGFCT char(3);
       dcl-ds WDI;
        WSSAI zoned(4) pos(1);
        WMI zoned(2) pos(5);
        WJI zoned(2) pos(7);
        WDATI zoned(8) pos(1);
       end-ds;
       dcl-ds WDE;
        WJE zoned(2) pos(1);
        WME zoned(2) pos(3);
        WSSAE zoned(4) pos(5);
        WDATE zoned(8) pos(1);
       end-ds;
       dcl-ds WDSPGM PSDS;
        WNMPGM char(10) pos(1);
        WSTATU zoned(5) pos(11);
        WSTPRE zoned(5) pos(16);
        WSRCSQ char(8) pos(21);
        WNMROU char(8) pos(29);
        WNBPAR zoned(3) pos(37);
        WTYEXC char(3) pos(40);
        WLICPF char(7) pos(40);
        WNUEXC char(4) pos(43);
        WMIODT char(4) pos(47);
        WZOMES char(30) pos(51);
        WBIPGM char(10) pos(81);
        WRTDTA char(80) pos(91);
        WCOERR char(4) pos(171);
        WDERFI char(8) pos(201);
        WFIINF char(35) pos(209);
        WJOB char(10) pos(244);
        WUSER char(10) pos(254);
        WJOBNM zoned(6) pos(264);
       end-ds;
       dcl-ds WDSECR;
        WNLIG int(5) pos(370);
        WRANP int(5) pos(378);
        WNBRS int(5) pos(380);
        WNULC int(5) pos(382);
        WRECMI int(5) pos(403);
       end-ds;
     C     *ENTRY        PLIST
     C                   PARM                    PCHX
     C                   PARM                    PNREC
     C     KEY001        KLIST
     C                   KFLD                    ZMATR
     C     KEY002        KLIST
     C                   KFLD                    ZFCOD
     C* début du programme
     C                   MOVEL     WNMPGM        ZPGM
     C                   EXSR      DATHEU
     C                   MOVE      WDAT          ZDATE
     C                   MOVE      WHEU          ZHEUR
     C                   MOVEL     WUSER         ZUSER
     C                   MOVEL     WJOB          ZJOB
     C                   MOVEL     '*  '         WPGMQ
     C                   MOVEL     'CC01'        WMGKEY
     C                   SETON                                        0910
     C                   SETON                                        141516
     C                   SETON                                        1718
     C                   SETOFF                                       8588
     C* constantes pour ce programme
     C                   MOVE      '1'           PTYP
     C                   MOVEL     'FICMSG    '  PFICM
     C                   SELECT
     C                   WHEN      (PCHX = 'MO')
     C* modification
     C                   MOVEL     WTXT1         ZMODE
     C* on ne peut modifier que ces zones
     C                   SETOFF                                       141516
     C                   WHEN      (PCHX = 'CO')
     C* copie
     C                   MOVEL     WTXT2         ZMODE
     C* toutes les zones sont autorisées
     C                   SETOFF                                       141516
     C                   SETOFF                                       1718
     C                   WHEN      (PCHX = 'SU')
     C* suppression
     C                   MOVEL     WTXT3         ZMODE
     C* aucune zone n'est saisisable
     C                   WHEN      (PCHX = 'AF')
     C* affichage
     C                   MOVEL     WTXT4         ZMODE
     C* aucune zone n'est saisisable
     C                   WHEN      (PCHX = 'CR')
     C* création
     C                   MOVEL     WTXT5         ZMODE
     C* tout est saisisable sauf date de sortie
     C                   SETOFF                                       141516
     C                   SETOFF                                       17
     C                   WHEN      (PCHX = 'PE')
     C* direction Ple Emploi
     C                   MOVEL     WTXT6         ZMODE
     C* on saisit simplement la date de fin
     C                   SETOFF                                         18
     C                   ENDSL
     C* Initialisation de l'écran si on un numéro d'enregistrement
     C                   IF        PNREC <> *BLANK
     C                   MOVE      PNREC         WNREC
     C     WNREC         CHAIN (N) FICF                               7090
     C                   IF        PCHX = 'CR' OR PCHX = 'CO'
     C* en création ou copie zone non renseignée
     C                   Z-ADD     0             ZMATR
     C                   ELSE
     C                   Z-ADD     FIMAT         ZMATR
     C                   END
     C                   MOVEL     FIFON         ZFCOD
     C* fichier des fonctions => libellé
     C     KEY002        CHAIN     FIFF                               7090
     C                   MOVEL     MILIB         ZFLIB
     C                   MOVEL     FINOM         ZNOM
     C                   MOVEL     FIPR1         ZPR1
     C                   MOVEL     FIPR2         ZPR2
     C                   MOVEL     FIAD1         ZAD1
     C                   MOVEL     FIAD2         ZAD2
     C                   MOVEL     FIAD3         ZAD3
     C                   MOVEL     FICPO         ZCPO
     C                   MOVEL     FIVIL         ZVIL
     C                   MOVEL     FITEL         ZTEL
     C                   MOVEL     FIPOR         ZPOR
     C* traitement des dates
     C                   Z-ADD     FIDAE         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAE
     C                   IF        PCHX = 'PE'
     C                   Z-ADD     ZDATE         ZDAS
     C                   ELSE
     C                   Z-ADD     FIDAS         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAS
     C                   END
     C* zones d'audit
     C                   Z-ADD     FIDAC         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAC
     C                   Z-ADD     FIHEC         ZHEC
     C                   MOVEL     FIUSC         ZUSC
     C                   Z-ADD     FIDAM         WDATI
     C                   EXSR      INVDAT
     C                   Z-ADD     WDATE         ZDAM
     C                   Z-ADD     FIHEM         ZHEM
     C                   MOVEL     FIUSM         ZUSM
     C                   ELSE
     C* pas grand chose, la date du jour
     C                   MOVE      WDAT          ZDAE
     C                   END
     C* Boucle d'attente de fin
     C                   SETON                                        50
     C                   DOW       *IN50 = '1'
     C                   EXSR      TRTSCR
     C                   ENDDO
     C*
     C                   SETON                                        LR
     C* Les procédures
     C     TRTSCR        BEGSR
     C                   WRITE     WMGCTL
     C* On écrit l'écran
     C                   WRITE     FORE1
     C* On attend l'appui sur une touche
     C                   READ      FORE1                                  70
     C                   SETON                                          51
     C* F3 ou F12 on termine
     C                   IF        *INKC = '1' OR
     C                             *INKL = '1'
     C                   SETOFF                                       5051
     C                   END
     C* on met  jour l'heure
     C   51              TIME                    ZHEUR
     C   51*INKD         IFEQ      '1'
     C* appui sur la touche F4
     C                   IF        WZOCUR = 'ZFCOD'
     C                   EVAL      PACT = 'GS'
     C                   CALL      'PGMI01'
     C                   PARM                    PACT
     C                   PARM                    PGFCT
     C                   IF        PGFCT <> *BLANK
     C                   MOVEL     PGFCT         ZFCOD
     C                   END
     C                   END
     C                   SETOFF                                         51
     C                   END
     C*
     C                   IF        PCHX = 'SU'
     C                   SETOFF                                         51
     C                   IF        *IN85 = '1'
     C     *INKP         IFEQ      '1'
     C* touche F15 on supprime si indicateur *IN85
     C     WNREC         CHAIN     FICF                               7090
     C  N70              DELETE    FICF
     C                   SETOFF                                       5051
     C                   END
     C                   ELSE
     C                   MOVEL     'MSG0004'     PMGID
     C                   MOVEL     *BLANK        PMGDT
     C                   EXSR      ENVMSG
     C                   SETON                                          85
     C                   END
     C                   END
     C* contrle des données saisies
     C                   IF        *IN51 = '1'
     C                   EXSR      CTLDTA
     C                   IF        *IN88 = '1'
     C* anomalie
     C                   EXSR      ENVMSG
     C                   SETOFF                                       88
     C                   ELSE
     C* confirmation  pour suppression
     C                   EXSR      VALID1
     C                   END
     C                   END
     C                   ENDSR
     C* controle des données/si suppression demande de confirmation
     C     CTLDTA        BEGSR
     C                   MOVE      '0'           *IN88
     C* on vérifie que tout est bon
     C                   IF        PCHX = 'SU'
     C* on demande confirmation
     C                   ELSE
     C* vérification du code fonction
     C     KEY002        CHAIN     FIFF                               7090
     C                   IF        *IN70 = '1'
     C                   MOVE      '0'           *IN88
     C                   MOVEL     'MSG0003'     PMGID
     C                   EVAL      PMGDT = '&1'+ ZFCOD
     C                   MOVE      '1'           *IN88
     C                   END
     C                   END
     C                   ENDSR
     C*** Création suppression et MJ selon le cas
     C     VALID1        BEGSR
     C                   IF        PCHX = 'SU'
     C* La suppression se fait par la touche F15
     C                   ELSE
     C     KEY001        CHAIN     FICF1                              7190
     C                   IF        PCHX = 'CR' OR PCHX = 'CO'
     C* On ne crée le matricule qu'en copie ou création
     C                   MOVE      'MAT'         PCOD
     C                   MOVE      '2'           PCPT
     C                   CALL      'PGMC01'
     C                   PARM                    PCOD              3
     C                   PARM                    PCPT              1
     C                   PARM                    PCP1              6
     C                   PARM                    PMAT             10
     C                   MOVE      PMAT          FIMAT
     C                   SETON                                        71
     C                   END
     C                   MOVEL     ZFCOD         FIFON
     C                   MOVEL     ZNOM          FINOM
     C                   MOVEL     ZPR1          FIPR1
     C                   MOVEL     ZPR2          FIPR2
     C                   MOVEL     ZAD1          FIAD1
     C                   MOVEL     ZAD2          FIAD2
     C                   MOVEL     ZAD3          FIAD3
     C                   MOVEL     ZCPO          FICPO
     C                   MOVEL     ZVIL          FIVIL
     C                   MOVEL     ZTEL          FITEL
     C                   MOVEL     ZPOR          FIPOR
     C* traitement des dates
     C                   Z-ADD     ZDAE          WDATE
     C                   EXSR      DATINV
     C                   Z-ADD     WDATI         FIDAE
     C                   Z-ADD     ZDAS          WDATE
     C                   EXSR      DATINV
     C                   Z-ADD     WDATI         FIDAS
     C* zones d'audit
     C                   EXSR      DATHEU
     C                   MOVE      WDAT          WDATE
     C                   EXSR      DATINV
     C                   Z-ADD     WDATI         FIDAM
     C                   MOVE      WHEU          FIHEM
     C                   MOVEL     WUSER         FIUSM
     C                   IF        *IN71 = '0'
     C* on met  jour directement
     C                   UPDATE    FICF1
     C                   ELSE
     C* création
     C                   Z-ADD     WDATI         FIDAC
     C                   MOVE      WHEU          FIHEC
     C                   MOVEL     WUSER         FIUSC
     C                   WRITE     FICF1
     C                   END
     C                   END
     C                   SETOFF                                       50
     C                   ENDSR
     C* Traitements de la date
     C     DATHEU        BEGSR
     C                   TIME                    W14
     C                   MOVE      W14           WDAT
     C                   MOVEL     W14           WHEU
     C                   ENDSR
     C     INVDAT        BEGSR
     C                   Z-ADD     WSSAI         WSSAE
     C                   Z-ADD     WMI           WME
     C                   Z-ADD     WJI           WJE
     C                   ENDSR
     C     DATINV        BEGSR
     C                   Z-ADD     WSSAE         WSSAI
     C                   Z-ADD     WME           WMI
     C                   Z-ADD     WJE           WJI
     C                   ENDSR
     C*****Envoi d'un message programme
     C     ENVMSG        BEGSR
     C                   CALL      'PGM001CL'
     C                   PARM                    PTYP              1
     C                   PARM                    PFICM            10
     C                   PARM                    PMGID             7
     C                   PARM                    PMGDT            99
     C                   ENDSR
