       ctl-opt debug decedit('0,') datedit(*dmy.) bnddir('SERVICES');
       ctl-opt option(*srcstmt);
      /if defined(*crtbndrpg)
       ctl-opt DFTACTGRP(*no) actgrp(*caller);
      /Endif
      //*********************************************************************
      // OD 21/07/2015
      // liste du personnel
      //*********************************************************************
      // déclaration des fichiers
       dcl-f pgmf01fm workstn sfile(sfl01 :wran01) infds(dssfl1) indds(IndDS);

       dcl-f fic02l keyed infds(fic);

      // main function prototype
      // prototype fonction principale
       dcl-pr liste_personnel extpgm('PGMF01') end-pr;
       dcl-pi liste_personnel end-pi;

      // external functions prototypes
      // prototype fonctions externes
      * Gestion des messages
       dcl-pr gst_message extpgm('PGM001CL');
         a_typ like(r_typmsg);
         a_fim like(r_nomobj);
         a_mid like(r_msgid);
         a_mdt like(r_msgdta);
       end-pr;

      * Appel de l'écran détail du personnel
       dcl-pr detail_personnel extpgm('PGMF02');
         a_chx like(r_operation);
         a_nrec like(r_matricule);
       end-pr;

      * Impression
       dcl-pr impression extpgm('PGMF2SCL');
         a_mat like(r_matricule);
       end-pr;

      // Gestion des erreurs non prévues
       dcl-pr gest_erreur end-pr;

      // program status data structure
      // structure information programme
        /copy qcpysrc,psds

      // local functions prototypes
      // prototypes fonctions locales

      // global variables
      // variables globales
       dcl-s g_snom like(r_nom);
       dcl-s g_wsnop like(r_nom);

       dcl-s g_nblis1 like(r_nblign);
       dcl-s g_lstlig like(r_nblign);
       dcl-s g_nbrlig like(r_nblign);
       dcl-s g_i packed(3:0);
       dcl-s g_xnom like(r_nom);
       dcl-s a_typ like(r_typmsg);
       dcl-s a_fim like(r_nomobj);
       dcl-s a_mid like(r_msgid);
       dcl-s a_mdt like(r_msgdta);

       dcl-s a_chx char(2);
       dcl-s a_nrec like(r_matricule);
       dcl-s a_mat like(r_matricule);

      // Indicateurs
       dcl-s g_sortie ind;
       dcl-s g_trt_opt ind;
       dcl-s g_selection ind;
       dcl-s g_alimsfl ind;
       dcl-s g_filtre ind;

      // Touches de fonction
      /copy qcpysrc,fonction

      // data-structures
      // structures de données
      // Indicateurs renommés avec Indara et INDDS
       Dcls-ds IndDS;
         ROLLUP ind pos(2);
         SFLDSP ind pos(4);
         SFLDSPCTL ind pos(5);
         SFLCLR ind pos(6);
         SFLEND ind pos(7);
         SFLNXTCHG ind pos(8);
         SFLENDMSG ind pos(9);
         SFLINZ ind pos(10);
         PROTECT ind pos(20);
         ROUGE ind pos(30);
       end-ds;

      // la ds du sous=fichier
       dcl-ds dssfl1;
         wposc bindec(2:0) pos(370);
         wrrng bindec(2:0) pos(376);
         wrngp bindec(2:0) pos(378);
         wnbrsf bindec(2:0) pos(380);
       end-ds;

      // la ds du fichier
       dcl-ds fic;
         wnrc01 bindec(4:0) pos(397);
       end-ds;

       dcl-ds wdsfic;
         wcdfil char(8);
         wopenf char(1);
         wstsfi packed(5:0);
         wopcod char(5);
         wrpgsq char(8);
         wrpgnr char(8);
         werrfi char(7);
         wnfich char(10);
         wnlibr char(10);
         wspnam char(10);
         wsplib char(10);
         wspnum bindec(2:0);
         wlimbr char(10);
         wnbput bindec(4:0);
         wnbget bindec(4:0);
         wnbpg bindec(4:0);
         wnbio bindec(4:0);
         wrcdft char(10);
         wnbrcd bindec(4:0);
         wnrcfi bindec(4:0);
       end-ds;

      // inherited variables
      // héritage des types
      /copy QINHLESRC,INH32766

      // constants
      // constantes

      * main function
      * fonction principale
      /free
       monitor;
       // le nombre de lignes affichables, déclaration Ã  la volée
         g_nblis1=14;
         // initialisation des variables générales
         zpgm=PROCEDURE;
         zdate=%dec(%date():*eur);
         zheur=%dec(%time():*eur);
         zuser=USER;
         zjob=JOB_NAME;
         // initialisation du sous fichier des messages
         wpgmq='*  ';
         wmgkey='CC01';
         sflendmsg = *on;
         sflinz = *on;
         // indicateur fin
         g_sortie = *off;
         // début du traitement,
         exsr initsf;
         // boucle d'attente de sortie
         dow not g_sortie;
           exsr trtsfl;
         enddo;

       on-error;
         dump(a);
         gest_erreur();
       endmon;

       // indicateur de fin de programme
       *inlr = *on;
       // les procédures
       // traitement de l'écran
       begsr trtsfl;
         // effacement du sous=fichier de messages
          a_typ='3';
          a_fim=*blank;
          a_mid=*blank;
          gst_message(  a_typ
                      : a_fim
                      : a_mid
                      : a_mdt);
         write wsfctl;
         // ecriture de l'écran
         sfldsp = *on;
         sfldspctl = *on;
         write fore1;

         write forb1;
         // attente lecture
         read fore1;

         // une touche a été actionnée
         // chargement de l'heure
         zheur=%dec(%time());
         // indicateur pour ne pas tester d'autres actions
         g_trt_opt = *on;
         if rollup;
           // page suivante
           exsr chgpag;
           g_trt_opt = *off;
         endif;
         //
         if g_wsnop <> zsnom
         and g_trt_opt;
         // test si selection/ si changé on initialise
           exsr initsf;
           g_trt_opt = *off;
         endif;
         // touches f3 et f12
         if sortie or
               cancel;
           // on met l'indicateur à off = fin du programme
           g_sortie = *on;
           g_trt_opt = *off;
         endif;
         //
         if refresh;
           // f5 rafraichissement de l'écran
           exsr initsf;
           g_trt_opt = *off;
         endif;
         //
         if creer;
           // f6 création d'un nouveau matricule
            a_chx='CR';
            a_nrec=*zero;
            detail_personnel(a_chx:a_nrec);
            exsr initsf;
           g_trt_opt = *off;
         endif;
         if imprimer;
           // f8 impression du fichier
            a_mat=*zero;
            // on appelle le cl de routage sans soumission, sinon pgmf20cl
            impression(a_mat);
            g_trt_opt = *off;
         endif;
         // on ne fait ceci que s'il n'y a eu rien d'autre
         if g_trt_opt;
           exsr trtopt;
         endif;
         // on recommence la boucle d'attente
       endsr;
       // initialisation du sous-fichier
       begsr initsf;
         //    l'indicateur 20 conditionne la zone opt (protection)
         protect = *off;
         // initialisation de la variable de sélection
         g_wsnop=zsnom;
         g_snom=*blank;
         // initialisation de la clé pour positionnement
         fifon=*blank;
         finom=*blank;
         g_selection = *off;
         g_filtre = *off;
         if zsnom <> *blank;
           // si différent de blank il y a sélection
           g_selection = *on;
           g_i=0;
           g_i=%scan('*':zsnom);

           if g_i > 0;
              g_filtre=*on;
              g_i=g_i-1;
              g_snom=%subst(zsnom:1:g_i);
              // on est dans le cas d'une sélection générique
             // on se positionnera juste au bon endroit dans le fichier
              finom=g_snom;
           endif;
         endif;
         // la derniÃ¨re ligne écrite

         g_lstlig=0;
         // le compteur de ligne par page
         g_nbrlig=0;
         // le fameux wran01
         wran01=0;
         // effacement du sous=fichier
         sflclr = *on;
         sflend = *on;
         sfldsp = *off;
         sfldspctl = *off;
         write fore1;
         sflclr = *off;
         sfldsp = *on;
         sfldspctl = *on;
         // positionnement en début de fichier
         setll ( fifon: finom) fic02l;
         // chargement de la premiÃ¨re page
         exsr chgpag;
       endsr;
       // traitement des options, on ne lit que les enregistrements modifiés
       begsr trtopt;
         // lecture des enregistrements modifiés
          wran01=1;
          // top pour rafrachir l'écran, si besoin
         g_alimsfl = *off;
         readc sfl01;
         dow not %eof;
             a_nrec=hnrec;
             if htout='1';
                if zopt='2' or zopt='3' or zopt='4' or zopt='5';
               // si l'employé  quitté on ne peut plus rien modifier
                   zopt='5';
                endif;
             endif;
             g_filtre = *on;
             // selection en fonction du choix saisi
             select;
             when (zopt = '2') or (zopt = ' 2');
                a_chx='MO';
             when (zopt = '3') or (zopt = ' 3');
                a_chx='CO';
             when (zopt = '4') or (zopt = ' 4');
                a_chx='SU';
             when (zopt = '5') or (zopt = ' 5');
                a_chx='AF';
             when (zopt = '6') or (zopt = ' 6');
                a_mat=hmatr;
                impression(a_mat);
                g_filtre = *off;
             when (zopt = '99');
                a_chx='PE';
             other;
             // la saisie ne correspond  rien
                g_filtre = *off;
             // envoyer un message pour dire que l'option n'existe pas
                a_typ='1';
                a_fim='FICMSG   ';
                a_mid='MSG0002';
                gst_message(  a_typ
                            : a_fim
                            : a_mid
                            : a_mdt);
             endsl;
             if htout = '0';
             // pour ne pas perdre l'attribut couleur
               rouge = *off;
             else;
               rouge = *on;
             endif;
             // nettoyage
             zopt=*blanks;
             update(e) sfl01;
             // on aurait pu aussi faire if..., en tout cas le choix est bon
             detail_personnel(  a_chx
                              : a_nrec);
             g_alimsfl=*on;
             // on continue de boucler si autre option
           readc(e) sfl01;
         enddo;
         // potentiellement il y a eu mise  jour, on pourrait affiner
         if g_alimsfl;
            exsr initsf;
         ENDIF;
       endsr;
       // chargement d'une page
       begsr chgpag;
         // il faut positionner correctement les indicateurs et les variables
         sflnxtchg = *off;
         //                  seton                                        04
         wran01=g_lstlig;
         // lecture de l'enregistrement suivant
         read fic02l;

         // remise Ã  zéro du compteur de ligne, mais on pourrait faire autrement
         g_nbrlig=0;

         dow not %eof(fic02l)
         and g_nbrlig < 14;
           // remplissage des zones écran
           g_alimsfl = *on;
           // test s'il y a sélection
           if g_selection or g_filtre;
             if g_selection and not g_filtre;
               // on recherche la stricte égalité de nom
               if finom <> zsnom;
                 g_alimsfl = *off;
               endif;
             else;
                // on recherche si le nom commence par la valeur avant le '*'
                g_xnom=%subst( finom:1:g_i);
                if g_xnom <> g_snom;
                 g_alimsfl = *off;
               endif;
             endif;
           endif;
           // l'indicateur est  '1' si sélection ok ou pas de sélection
           if g_alimsfl;
              znom=finom;
              zpr1=fipr1;
              zfonc=fifon;
              zmatr=fimat;
              zcpo=ficpo;
              wdsfic=fic;
              hnrec=wnrcfi;
              hmatr=fimat;
              if fidas = 0;
               // top salarié licencié
              htout = *off;
              rouge = *off;
            else;
              htout = *on;
              rouge = *on;
             endif;
             // les compteurs, attention au wran01
             g_nbrlig+=1;
             g_lstlig+=1;
             wran01+=1;
             // ecriture de la ligne
             write sfl01;
           endif;
           // lecture du suivant
           read fic02l;

         enddo;
         // on quitte la boucle soit en fin de page
         //                     soit en fin de fichier
         if %eof(fic02l);
           // le caractÃ¨re de suite, on est en fin de fichier
           sflend = *on;
         else;
           sflend = *off;
         endif;
         // si le fichier est vide
         if wran01 = 0;
            g_nbrlig=1;
            g_lstlig=1;
            // un petit message
            wran01=1;
            // pas de saisie d'option
           protect = *on;
           if zsnom = *blank;
             znom = 'sélection vide';
           else;
             znom = 'Fichier vide';
           endif;
           // ne pas oublier de remettre  blanc
           zpr1=*blank;
           zfonc=*blank;
           zmatr=0;
           zcpo=*blank;
           wdsfic=*blank;
           hnrec=0;
           // ecriture du message sur la premiÃ¨re ligne
           write sfl01;
         endif;
       endsr;
      /end-free
