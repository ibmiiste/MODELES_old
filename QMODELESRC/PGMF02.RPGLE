     H dftactgrp(*no) actgrp(*caller) expropts(*resdecpos)
     H datfmt(*iso) timfmt(*iso) option(*nodebugio: *nounref)
     H debug decedit('0,') datedit(*dmy.)
      //****************************************************
      //                                                   *
      // Détail personnel                                  *
      //                                                   *
      //****************************************************
     Fpgmf02fm  cf   e             workstn
     F                                     infds(wdsecr)
     Ffic00p    uf   e             disk
     Ffic01l    uf a e           k disk
     F                                     rename(ficf      :ficf1)
     Ffif01l    if   e           k disk

   ?  //--*STAND ALONE-------------------------------------------
     D l_cod           s              3a
     D l_cpt           s              1a
     D l_cp1           s              6a
     D l_ficm          s             10a
     D l_mat           s             10a
     D l_mgdt          s             99a
     D l_mgid          s              7a
     D l_typ           s              1a

     Dc_txt1           c                   '         Modification         '
     Dc_txt2           c                   '             Copie            '
     Dc_txt3           c                   '         Suppression          '
     Dc_txt4           c                   '           Affichage          '
     Dc_txt5           c                   '           Création           '
     Dc_txt6           c                   '        Fin de contrat        '
     Dwdat             s              8
     Dwheu             s              6
     Dw14              s             14  0
     Dpchx             s              2
     Dpnrec            s             10
     Dwnrec            s             10  0
     Dpact             s              2
     Dpgfct            s              3
     Dwdi              ds
     Dwssai                    1      4  0
     Dwmi                      5      6  0
     Dwji                      7      8  0
     Dwdati                    1      8  0
     Dwde              ds
     Dwje                      1      2  0
     Dwme                      3      4  0
     Dwssae                    5      8  0
     Dwdate                    1      8  0
     Dwdspgm          sds
     Dwnmpgm                   1     10
     Dwstatu                  11     15  0
     Dwstpre                  16     20  0
     Dwsrcsq                  21     28
     Dwnmrou                  29     36
     Dwnbpar                  37     39  0
     Dwtyexc                  40     42
     Dwlicpf                  40     46
     Dwnuexc                  43     46
     Dwmiodt                  47     50
     Dwzomes                  51     80
     Dwbipgm                  81     90
     Dwrtdta                  91    170
     Dwcoerr                 171    174
     Dwderfi                 201    208
     Dwfiinf                 209    243
     Dwjob                   244    253
     Dwuser                  254    263
     Dwjobnm                 264    269  0
     Dwdsecr           ds
     Dwnlig                  370    371b 0
     Dwranp                  378    379b 0
     Dwnbrs                  380    381b 0
     Dwnulc                  382    383b 0
     Dwrecmi                 403    404b 0
     C     *entry        plist
     C                   PARM                    pchx              2
     C                   PARM                    pnrec            10 0
     C     key001        klist
     C                   kfld                    zmatr
     C     key002        klist
     C                   kfld                    zfcod
      // début du programme
     C                   movel     wnmpgm        zpgm
      /FREE
       exsr datheu;
      /END-FREE
     C                   move      wdat          zdate
     C                   move      wheu          zheur
     C                   movel     wuser         zuser
     C                   movel     wjob          zjob
     C                   movel     '*  '         wpgmq
     C                   movel     'CC01'        wmgkey
      /FREE
       *IN09 = *ON;
       *IN10 = *ON;
       *IN14 = *ON;
       *IN15 = *ON;
       *IN16 = *ON;
       *IN17 = *ON;
       *IN18 = *ON;
       *IN85 = *OFF;
       *IN88 = *OFF;
       // constantes pour ce programme
      /END-FREE
     C                   move      '1'           ptyp
     C                   movel     'FICMSG    '  pficm
      /FREE
 1b    select;
 1x    when (pchx = 'MO');
         // modification
      /END-FREE
     C                   movel     wtxt1         zmode
      // on ne peut modifier que ces zones
      /FREE
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
 1x    when (pchx = 'CO');
         // copie
      /END-FREE
     C                   movel     wtxt2         zmode
      // toutes les zones sont autorisées
      /FREE
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
         *IN17 = *OFF;
         *IN18 = *OFF;
 1x    when (pchx = 'SU');
         // suppression
      /END-FREE
     C                   movel     wtxt3         zmode
      // aucune zone n'est saisisable
      /FREE
 1x    when (pchx = 'AF');
         // affichage
      /END-FREE
     C                   movel     wtxt4         zmode
      // aucune zone n'est saisisable
      /FREE
 1x    when (pchx = 'CR');
         // création
      /END-FREE
     C                   movel     wtxt5         zmode
      // tout est saisisable sauf date de sortie
      /FREE
         *IN14 = *OFF;
         *IN15 = *OFF;
         *IN16 = *OFF;
         *in17 = *off;
 1x    when (pchx = 'PE');
         // direction P le Emploi
      /END-FREE
     C                   movel     wtxt6         zmode
      // on saisit simplement la date de fin
      /FREE
         *in18 = *off;
 1e    endsl;
       // Initialisation de l'écran si on un numéro d'enregistrement
 1b    if pnrec <> *zero
      /END-FREE
     C                   eval      wnrec=pnrec
      /FREE
         chain(nE) wnrec ficf;
         *IN70 = NOT %ERROR AND NOT %FOUND;
         *IN90 = %ERROR;
 2b      if pchx = 'CR' or pchx = 'CO';
           // en création ou copie zone non renseignée
      /END-FREE
     C                   z-add     0             zmatr
      /FREE
 2x      else;
      /END-FREE
     C                   z-add     fimat         zmatr
      /FREE
 2e      endif;
      /END-FREE
     C                   movel     fifon         zfcod
      // fichier des fonctions => libellé
      /FREE
         chain(E) key002 fiff;
         *IN70 = NOT %ERROR AND NOT %FOUND;
         *IN90 = %ERROR;
      /END-FREE
     C                   movel     milib         zflib
     C                   movel     finom         znom
     C                   movel     fipr1         zpr1
     C                   movel     fipr2         zpr2
     C                   movel     fiad1         zad1
     C                   movel     fiad2         zad2
     C                   movel     fiad3         zad3
     C                   movel     ficpo         zcpo
     C                   movel     fivil         zvil
     C                   movel     fitel         ztel
     C                   movel     fipor         zpor
      // traitement des dates
     C                   z-add     fidae         wdati
      /FREE
         exsr invdat;
      /END-FREE
     C                   z-add     wdate         zdae
      /FREE
 2b      if pchx = 'PE';
      /END-FREE
     C                   z-add     zdate         zdas
      /FREE
 2x      else;
      /END-FREE
     C                   z-add     fidas         wdati
      /FREE
           exsr invdat;
      /END-FREE
     C                   z-add     wdate         zdas
      /FREE
 2e      endif;
         // zones d'audit
      /END-FREE
     C                   z-add     fidac         wdati
      /FREE
         exsr invdat;
      /END-FREE
     C                   z-add     wdate         zdac
     C                   z-add     fihec         zhec
     C                   movel     fiusc         zusc
     C                   z-add     fidam         wdati
      /FREE
         exsr invdat;
      /END-FREE
     C                   z-add     wdate         zdam
     C                   z-add     fihem         zhem
     C                   movel     fiusm         zusm
      /FREE
 1x    else;
         // pas grand chose, la date du jour
      /END-FREE
     C                   move      wdat          zdae
      /FREE
 1e    endif;
       // Boucle d'attente de fin
       *in50 = *on;
 1b    dow *in50 = '1';
         exsr trtscr;
 1e    enddo;
       //
       *inlr = *on;
       // Les procédures
       begsr trtscr;
         write wmgctl;
         // On écrit l'écran
         write fore1;
         // On attend l'appui sur une touche
         read fore1;
         *IN70 = %EOF;
         *in51 = *on;
         // F3 ou F12 on termine
 1b      if *inkc = '1' or
               *inkl = '1';
           *IN50 = *OFF;
           *IN51 = *OFF;
 1e      endif;
         // on met   jour l'heure
      /END-FREE
     C   51              time                    zheur
 1b  C   51              if        *inkd
      // appui sur la touche F4
      /FREE
 2b        if wzocur = 'ZFCOD';
             pact = 'GS';
      /END-FREE
     C                   call      'PGMI01'
     C                   parm                    pact
     C                   parm                    pgfct
      /FREE
 3b          if pgfct <> *blank;
      /END-FREE
     C                   movel     pgfct         zfcod
      /FREE
 3e          endif;
 2e        endif;
           *in51 = *off;
 1e      endif;
         //
 1b      if pchx = 'SU';
           *in51 = *off;
 2b        if *in85 = '1';
 3b          if *inkp;
               // touche F15 on supprime si indicateur *IN85
               chain(E) wnrec ficf;
               *IN70 = NOT %ERROR AND NOT %FOUND;
               *IN90 = %ERROR;
      /END-FREE
     C  n70              delete    ficf
      /FREE
               *IN50 = *OFF;
               *IN51 = *OFF;
 3e          endif;
 2x        else;
      /END-FREE
     C                   movel     'MSG0004'     pmgid
     C                   movel     *blank        pmgdt
      /FREE
             exsr envmsg;
             *in85 = *on;
 2e        endif;
 1e      endif;
         // contr le des données saisies
 1b      if *in51 = '1';
           exsr ctldta;
 2b        if *in88 = '1';
             // anomalie
             exsr envmsg;
             *in88 = *off;
 2x        else;
             // confirmation  pour suppression
             exsr valid1;
 2e        endif;
 1e      endif;
       endsr;
       // controle des données/si suppression demande de confirmation
       begsr ctldta;
         *in88 = *off;
         // on vérifie que tout est bon
 1b      if pchx = 'SU';
           // on demande confirmation
 1x      else;
           // vérification du code fonction
           chain(E) key002 fiff;
           *IN70 = NOT %ERROR AND NOT %FOUND;
           *IN90 = %ERROR;
 2b        if *in70 = '1';
             *in88 = *off;
      /END-FREE
     C                   movel     'MSG0003'     pmgid
      /FREE
             pmgdt = '&1'+ zfcod;
             *in88 = *on;
 2e        endif;
 1e      endif;
       endsr;
       //** Création suppression et M J selon le cas
       begsr valid1;
 1b      if pchx = 'SU';
           // La suppression se fait par la touche F15
 1x      else;
           chain(E) key001 ficf1;
           *IN71 = NOT %ERROR AND NOT %FOUND;
           *IN90 = %ERROR;
 2b        if pchx = 'CR' or pchx = 'CO';
             // On ne crée le matricule qu'en copie ou création
      /END-FREE
     C                   move      'MAT'         pcod
      /FREE
             pcpt = '2';
      /END-FREE
     C                   call      'PGMC01'
     C                   parm                    pcod              3
     C                   parm                    pcpt              1
     C                   parm                    pcp1              6
     C                   parm                    pmat             10
     C                   move      pmat          fimat
      /FREE
             *in71 = *on;
 2e        endif;
      /END-FREE
     C                   movel     zfcod         fifon
     C                   movel     znom          finom
     C                   movel     zpr1          fipr1
     C                   movel     zpr2          fipr2
     C                   movel     zad1          fiad1
     C                   movel     zad2          fiad2
     C                   movel     zad3          fiad3
     C                   movel     zcpo          ficpo
     C                   movel     zvil          fivil
     C                   movel     ztel          fitel
     C                   movel     zpor          fipor
      // traitement des dates
     C                   z-add     zdae          wdate
      /FREE
           exsr datinv;
      /END-FREE
     C                   z-add     wdati         fidae
     C                   z-add     zdas          wdate
      /FREE
           exsr datinv;
      /END-FREE
     C                   z-add     wdati         fidas
      // zones d'audit
      /FREE
           exsr datheu;
      /END-FREE
     C                   move      wdat          wdate
      /FREE
           exsr datinv;
      /END-FREE
     C                   z-add     wdati         fidam
     C                   move      wheu          fihem
     C                   movel     wuser         fiusm
      /FREE
 2b        if *in71 = '0';
             // on met   jour directement
             update ficf1;
 2x        else;
             // création
      /END-FREE
     C                   z-add     wdati         fidac
     C                   move      wheu          fihec
     C                   movel     wuser         fiusc
      /FREE
             write ficf1;
 2e        endif;
 1e      endif;
         *in50 = *off;
       endsr;
       // Traitements de la date
       begsr datheu;
      /END-FREE
     C                   time                    w14
     C                   move      w14           wdat
     C                   movel     w14           wheu
      /FREE
       endsr;
       begsr invdat;
      /END-FREE
     C                   z-add     wssai         wssae
     C                   z-add     wmi           wme
     C                   z-add     wji           wje
      /FREE
       endsr;
       begsr datinv;
      /END-FREE
     C                   z-add     wssae         wssai
     C                   z-add     wme           wmi
     C                   z-add     wje           wji
      /FREE
       endsr;
       //****Envoi d'un message programme
       begsr envmsg;
      /END-FREE
     C                   call      'PGM001CL'
     C                   parm                    ptyp              1
     C                   parm                    pficm            10
     C                   parm                    pmgid             7
     C                   parm                    pmgdt            99
      /FREE
       endsr;
      /END-FREE
