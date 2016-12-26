000100160929     H dftactgrp(*no) actgrp(*caller) expropts(*resdecpos)
000200160929     H datfmt(*iso) timfmt(*iso) option(*nodebugio: *nounref)
000300160929     H debug decedit('0,') datedit(*dmy.)
000400160929      //****************************************************
000500160929      //                                                   *
000600160929      // Détail personnel                                  *
000700160929      //                                                   *
000800160929      //****************************************************
000900160929     Fpgmf02fm  cf   e             workstn
001000160929     F                                     infds(wdsecr)
001100160929     Ffic00p    uf   e             disk
001200160929     Ffic01l    uf a e           k disk
001300160929     F                                     rename(ficf      :ficf1)
001400160929     Ffif01l    if   e           k disk
001500160929
001600160929   ?  //--*STAND ALONE-------------------------------------------
001700160929     D l_cod           s              3a
001800160929     D l_cpt           s              1a
001900160929     D l_cp1           s              6a
002000160929     D l_ficm          s             10a
002100160929     D l_mat           s             10a
002200160929     D l_mgdt          s             99a
002300160929     D l_mgid          s              7a
002400160929     D l_typ           s              1a
002500160929
002600160929     Dc_txt1           c                   '         Modification         '
002700160929     Dc_txt2           c                   '             Copie            '
002800160929     Dc_txt3           c                   '         Suppression          '
002900160929     Dc_txt4           c                   '           Affichage          '
003000160929     Dc_txt5           c                   '           Création           '
003100160929     Dc_txt6           c                   '        Fin de contrat        '
003200160929     Dwdat             s              8
003300160929     Dwheu             s              6
003400160929     Dw14              s             14  0
003500160929     Dpchx             s              2
003600160929     Dpnrec            s             10
003700160929     Dwnrec            s             10  0
003800160929     Dpact             s              2
003900160929     Dpgfct            s              3
004000160929     Dwdi              ds
004100160929     Dwssai                    1      4  0
004200160929     Dwmi                      5      6  0
004300160929     Dwji                      7      8  0
004400160929     Dwdati                    1      8  0
004500160929     Dwde              ds
004600160929     Dwje                      1      2  0
004700160929     Dwme                      3      4  0
004800160929     Dwssae                    5      8  0
004900160929     Dwdate                    1      8  0
005000160929     Dwdspgm          sds
005100160929     Dwnmpgm                   1     10
005200160929     Dwstatu                  11     15  0
005300160929     Dwstpre                  16     20  0
005400160929     Dwsrcsq                  21     28
005500160929     Dwnmrou                  29     36
005600160929     Dwnbpar                  37     39  0
005700160929     Dwtyexc                  40     42
005800160929     Dwlicpf                  40     46
005900160929     Dwnuexc                  43     46
006000160929     Dwmiodt                  47     50
006100160929     Dwzomes                  51     80
006200160929     Dwbipgm                  81     90
006300160929     Dwrtdta                  91    170
006400160929     Dwcoerr                 171    174
006500160929     Dwderfi                 201    208
006600160929     Dwfiinf                 209    243
006700160929     Dwjob                   244    253
006800160929     Dwuser                  254    263
006900160929     Dwjobnm                 264    269  0
007000160929     Dwdsecr           ds
007100160929     Dwnlig                  370    371b 0
007200160929     Dwranp                  378    379b 0
007300160929     Dwnbrs                  380    381b 0
007400160929     Dwnulc                  382    383b 0
007500160929     Dwrecmi                 403    404b 0
007600160929     C     *entry        plist
007700160929     C                   PARM                    pchx              2
007800160929     C                   PARM                    pnrec            10 0
007900160929     C     key001        klist
008000160929     C                   kfld                    zmatr
008100160929     C     key002        klist
008200160929     C                   kfld                    zfcod
008300160929      // début du programme
008400160929     C                   movel     wnmpgm        zpgm
008500160929      /FREE
008600160929       exsr datheu;
008700160929      /END-FREE
008800160929     C                   move      wdat          zdate
008900160929     C                   move      wheu          zheur
009000160929     C                   movel     wuser         zuser
009100160929     C                   movel     wjob          zjob
009200160929     C                   movel     '*  '         wpgmq
009300160929     C                   movel     'CC01'        wmgkey
009400160929      /FREE
009500160929       *IN09 = *ON;
009600160929       *IN10 = *ON;
009700160929       *IN14 = *ON;
009800160929       *IN15 = *ON;
009900160929       *IN16 = *ON;
010000160929       *IN17 = *ON;
010100160929       *IN18 = *ON;
010200160929       *IN85 = *OFF;
010300160929       *IN88 = *OFF;
010400160929       // constantes pour ce programme
010500160929      /END-FREE
010600160929     C                   move      '1'           ptyp
010700160929     C                   movel     'FICMSG    '  pficm
010800160929      /FREE
010900160929 1b    select;
011000160929 1x    when (pchx = 'MO');
011100160929         // modification
011200160929      /END-FREE
011300160929     C                   movel     wtxt1         zmode
011400160929      // on ne peut modifier que ces zones
011500160929      /FREE
011600160929         *IN14 = *OFF;
011700160929         *IN15 = *OFF;
011800160929         *IN16 = *OFF;
011900160929 1x    when (pchx = 'CO');
012000160929         // copie
012100160929      /END-FREE
012200160929     C                   movel     wtxt2         zmode
012300160929      // toutes les zones sont autorisées
012400160929      /FREE
012500160929         *IN14 = *OFF;
012600160929         *IN15 = *OFF;
012700160929         *IN16 = *OFF;
012800160929         *IN17 = *OFF;
012900160929         *IN18 = *OFF;
013000160929 1x    when (pchx = 'SU');
013100160929         // suppression
013200160929      /END-FREE
013300160929     C                   movel     wtxt3         zmode
013400160929      // aucune zone n'est saisisable
013500160929      /FREE
013600160929 1x    when (pchx = 'AF');
013700160929         // affichage
013800160929      /END-FREE
013900160929     C                   movel     wtxt4         zmode
014000160929      // aucune zone n'est saisisable
014100160929      /FREE
014200160929 1x    when (pchx = 'CR');
014300160929         // création
014400160929      /END-FREE
014500160929     C                   movel     wtxt5         zmode
014600160929      // tout est saisisable sauf date de sortie
014700160929      /FREE
014800160929         *IN14 = *OFF;
014900160929         *IN15 = *OFF;
015000160929         *IN16 = *OFF;
015100160929         *in17 = *off;
015200160929 1x    when (pchx = 'PE');
015300160929         // direction P le Emploi
015400160929      /END-FREE
015500160929     C                   movel     wtxt6         zmode
015600160929      // on saisit simplement la date de fin
015700160929      /FREE
015800160929         *in18 = *off;
015900160929 1e    endsl;
016000160929       // Initialisation de l'écran si on un numéro d'enregistrement
016100160929 1b    if pnrec <> *zero
016200160929      /END-FREE
016300160929     C                   eval      wnrec=pnrec
016400160929      /FREE
016500160929         chain(nE) wnrec ficf;
016600160929         *IN70 = NOT %ERROR AND NOT %FOUND;
016700160929         *IN90 = %ERROR;
016800160929 2b      if pchx = 'CR' or pchx = 'CO';
016900160929           // en création ou copie zone non renseignée
017000160929      /END-FREE
017100160929     C                   z-add     0             zmatr
017200160929      /FREE
017300160929 2x      else;
017400160929      /END-FREE
017500160929     C                   z-add     fimat         zmatr
017600160929      /FREE
017700160929 2e      endif;
017800160929      /END-FREE
017900160929     C                   movel     fifon         zfcod
018000160929      // fichier des fonctions => libellé
018100160929      /FREE
018200160929         chain(E) key002 fiff;
018300160929         *IN70 = NOT %ERROR AND NOT %FOUND;
018400160929         *IN90 = %ERROR;
018500160929      /END-FREE
018600160929     C                   movel     milib         zflib
018700160929     C                   movel     finom         znom
018800160929     C                   movel     fipr1         zpr1
018900160929     C                   movel     fipr2         zpr2
019000160929     C                   movel     fiad1         zad1
019100160929     C                   movel     fiad2         zad2
019200160929     C                   movel     fiad3         zad3
019300160929     C                   movel     ficpo         zcpo
019400160929     C                   movel     fivil         zvil
019500160929     C                   movel     fitel         ztel
019600160929     C                   movel     fipor         zpor
019700160929      // traitement des dates
019800160929     C                   z-add     fidae         wdati
019900160929      /FREE
020000160929         exsr invdat;
020100160929      /END-FREE
020200160929     C                   z-add     wdate         zdae
020300160929      /FREE
020400160929 2b      if pchx = 'PE';
020500160929      /END-FREE
020600160929     C                   z-add     zdate         zdas
020700160929      /FREE
020800160929 2x      else;
020900160929      /END-FREE
021000160929     C                   z-add     fidas         wdati
021100160929      /FREE
021200160929           exsr invdat;
021300160929      /END-FREE
021400160929     C                   z-add     wdate         zdas
021500160929      /FREE
021600160929 2e      endif;
021700160929         // zones d'audit
021800160929      /END-FREE
021900160929     C                   z-add     fidac         wdati
022000160929      /FREE
022100160929         exsr invdat;
022200160929      /END-FREE
022300160929     C                   z-add     wdate         zdac
022400160929     C                   z-add     fihec         zhec
022500160929     C                   movel     fiusc         zusc
022600160929     C                   z-add     fidam         wdati
022700160929      /FREE
022800160929         exsr invdat;
022900160929      /END-FREE
023000160929     C                   z-add     wdate         zdam
023100160929     C                   z-add     fihem         zhem
023200160929     C                   movel     fiusm         zusm
023300160929      /FREE
023400160929 1x    else;
023500160929         // pas grand chose, la date du jour
023600160929      /END-FREE
023700160929     C                   move      wdat          zdae
023800160929      /FREE
023900160929 1e    endif;
024000160929       // Boucle d'attente de fin
024100160929       *in50 = *on;
024200160929 1b    dow *in50 = '1';
024300160929         exsr trtscr;
024400160929 1e    enddo;
024500160929       //
024600160929       *inlr = *on;
024700160929       // Les procédures
024800160929       begsr trtscr;
024900160929         write wmgctl;
025000160929         // On écrit l'écran
025100160929         write fore1;
025200160929         // On attend l'appui sur une touche
025300160929         read fore1;
025400160929         *IN70 = %EOF;
025500160929         *in51 = *on;
025600160929         // F3 ou F12 on termine
025700160929 1b      if *inkc = '1' or
025800160929               *inkl = '1';
025900160929           *IN50 = *OFF;
026000160929           *IN51 = *OFF;
026100160929 1e      endif;
026200160929         // on met   jour l'heure
026300160929      /END-FREE
026400160929     C   51              time                    zheur
026500160929 1b  C   51              if        *inkd
026600160929      // appui sur la touche F4
026700160929      /FREE
026800160929 2b        if wzocur = 'ZFCOD';
026900160929             pact = 'GS';
027000160929      /END-FREE
027100160929     C                   call      'PGMI01'
027200160929     C                   parm                    pact
027300160929     C                   parm                    pgfct
027400160929      /FREE
027500160929 3b          if pgfct <> *blank;
027600160929      /END-FREE
027700160929     C                   movel     pgfct         zfcod
027800160929      /FREE
027900160929 3e          endif;
028000160929 2e        endif;
028100160929           *in51 = *off;
028200160929 1e      endif;
028300160929         //
028400160929 1b      if pchx = 'SU';
028500160929           *in51 = *off;
028600160929 2b        if *in85 = '1';
028700160929 3b          if *inkp;
028800160929               // touche F15 on supprime si indicateur *IN85
028900160929               chain(E) wnrec ficf;
029000160929               *IN70 = NOT %ERROR AND NOT %FOUND;
029100160929               *IN90 = %ERROR;
029200160929      /END-FREE
029300160929     C  n70              delete    ficf
029400160929      /FREE
029500160929               *IN50 = *OFF;
029600160929               *IN51 = *OFF;
029700160929 3e          endif;
029800160929 2x        else;
029900160929      /END-FREE
030000160929     C                   movel     'MSG0004'     pmgid
030100160929     C                   movel     *blank        pmgdt
030200160929      /FREE
030300160929             exsr envmsg;
030400160929             *in85 = *on;
030500160929 2e        endif;
030600160929 1e      endif;
030700160929         // contr le des données saisies
030800160929 1b      if *in51 = '1';
030900160929           exsr ctldta;
031000160929 2b        if *in88 = '1';
031100160929             // anomalie
031200160929             exsr envmsg;
031300160929             *in88 = *off;
031400160929 2x        else;
031500160929             // confirmation  pour suppression
031600160929             exsr valid1;
031700160929 2e        endif;
031800160929 1e      endif;
031900160929       endsr;
032000160929       // controle des données/si suppression demande de confirmation
032100160929       begsr ctldta;
032200160929         *in88 = *off;
032300160929         // on vérifie que tout est bon
032400160929 1b      if pchx = 'SU';
032500160929           // on demande confirmation
032600160929 1x      else;
032700160929           // vérification du code fonction
032800160929           chain(E) key002 fiff;
032900160929           *IN70 = NOT %ERROR AND NOT %FOUND;
033000160929           *IN90 = %ERROR;
033100160929 2b        if *in70 = '1';
033200160929             *in88 = *off;
033300160929      /END-FREE
033400160929     C                   movel     'MSG0003'     pmgid
033500160929      /FREE
033600160929             pmgdt = '&1'+ zfcod;
033700160929             *in88 = *on;
033800160929 2e        endif;
033900160929 1e      endif;
034000160929       endsr;
034100160929       //** Création suppression et M J selon le cas
034200160929       begsr valid1;
034300160929 1b      if pchx = 'SU';
034400160929           // La suppression se fait par la touche F15
034500160929 1x      else;
034600160929           chain(E) key001 ficf1;
034700160929           *IN71 = NOT %ERROR AND NOT %FOUND;
034800160929           *IN90 = %ERROR;
034900160929 2b        if pchx = 'CR' or pchx = 'CO';
035000160929             // On ne crée le matricule qu'en copie ou création
035100160929      /END-FREE
035200160929     C                   move      'MAT'         pcod
035300160929      /FREE
035400160929             pcpt = '2';
035500160929      /END-FREE
035600160929     C                   call      'PGMC01'
035700160929     C                   parm                    pcod              3
035800160929     C                   parm                    pcpt              1
035900160929     C                   parm                    pcp1              6
036000160929     C                   parm                    pmat             10
036100160929     C                   move      pmat          fimat
036200160929      /FREE
036300160929             *in71 = *on;
036400160929 2e        endif;
036500160929      /END-FREE
036600160929     C                   movel     zfcod         fifon
036700160929     C                   movel     znom          finom
036800160929     C                   movel     zpr1          fipr1
036900160929     C                   movel     zpr2          fipr2
037000160929     C                   movel     zad1          fiad1
037100160929     C                   movel     zad2          fiad2
037200160929     C                   movel     zad3          fiad3
037300160929     C                   movel     zcpo          ficpo
037400160929     C                   movel     zvil          fivil
037500160929     C                   movel     ztel          fitel
037600160929     C                   movel     zpor          fipor
037700160929      // traitement des dates
037800160929     C                   z-add     zdae          wdate
037900160929      /FREE
038000160929           exsr datinv;
038100160929      /END-FREE
038200160929     C                   z-add     wdati         fidae
038300160929     C                   z-add     zdas          wdate
038400160929      /FREE
038500160929           exsr datinv;
038600160929      /END-FREE
038700160929     C                   z-add     wdati         fidas
038800160929      // zones d'audit
038900160929      /FREE
039000160929           exsr datheu;
039100160929      /END-FREE
039200160929     C                   move      wdat          wdate
039300160929      /FREE
039400160929           exsr datinv;
039500160929      /END-FREE
039600160929     C                   z-add     wdati         fidam
039700160929     C                   move      wheu          fihem
039800160929     C                   movel     wuser         fiusm
039900160929      /FREE
040000160929 2b        if *in71 = '0';
040100160929             // on met   jour directement
040200160929             update ficf1;
040300160929 2x        else;
040400160929             // création
040500160929      /END-FREE
040600160929     C                   z-add     wdati         fidac
040700160929     C                   move      wheu          fihec
040800160929     C                   movel     wuser         fiusc
040900160929      /FREE
041000160929             write ficf1;
041100160929 2e        endif;
041200160929 1e      endif;
041300160929         *in50 = *off;
041400160929       endsr;
041500160929       // Traitements de la date
041600160929       begsr datheu;
041700160929      /END-FREE
041800160929     C                   time                    w14
041900160929     C                   move      w14           wdat
042000160929     C                   movel     w14           wheu
042100160929      /FREE
042200160929       endsr;
042300160929       begsr invdat;
042400160929      /END-FREE
042500160929     C                   z-add     wssai         wssae
042600160929     C                   z-add     wmi           wme
042700160929     C                   z-add     wji           wje
042800160929      /FREE
042900160929       endsr;
043000160929       begsr datinv;
043100160929      /END-FREE
043200160929     C                   z-add     wssae         wssai
043300160929     C                   z-add     wme           wmi
043400160929     C                   z-add     wje           wji
043500160929      /FREE
043600160929       endsr;
043700160929       //****Envoi d'un message programme
043800160929       begsr envmsg;
043900160929      /END-FREE
044000160929     C                   call      'PGM001CL'
044100160929     C                   parm                    ptyp              1
044200160929     C                   parm                    pficm            10
044300160929     C                   parm                    pmgid             7
044400160929     C                   parm                    pmgdt            99
044500160929      /FREE
044600160929       endsr;
044700160929      /END-FREE
