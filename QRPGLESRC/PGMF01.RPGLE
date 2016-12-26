000100160929     h debug decedit('0,') datedit(*dmy.) bnddir('SERVICES')
000200160929     h option(*srcstmt)
000300160929     h/if defined(*crtbndrpg)
000400160929     h DFTACTGRP(*no) actgrp(*caller)
000500160929     h/Endif
000600160929      //*********************************************************************
000700160929      // OD 21/07/2015
000800160929      // liste du personnel
000900160929      //*********************************************************************
001000160929      // déclaration des fichiers
001100160929     fpgmf01fm  cf   e             workstn
001200160929     f                                     sfile(sfl01 :wran01)
001300160929     f                                     infds(dssfl1)
001400160929     f                                     indds(IndDS)
001500160929     ffic02l    if   e           k disk
001600160929     f                                     infds(fic)
001700160929
001800160929      // main function prototype
001900160929      // prototype fonction principale
002000160929     dliste_personnel  pr                  extpgm('PGMF01')
002100160929     dliste_personnel  pi
002200160929
002300160929      // external functions prototypes
002400160929      // prototype fonctions externes
002500160929      * Gestion des messages
002600160929     dgst_message      pr                  extpgm('PGM001CL')
002700160929     d a_typ                               like(r_typmsg)
002800160929     d a_fim                               like(r_nomobj)
002900160929     d a_mid                               like(r_msgid)
003000160929     d a_mdt                               like(r_msgdta)
003100160929
003200160929      * Appel de l'écran détail du personnel
003300160929     ddetail_personnel...
003400160929     d                 pr                  extpgm('PGMF02')
003500160929     d a_chx                               like(r_operation)
003600160929     d a_nrec                              like(r_matricule)
003700160929
003800160929     d* Impression
003900160929     dimpression       pr                  extpgm('PGMF2SCL')
004000160929     d a_mat                               like(r_matricule)
004100160929
004200160929      // Gestion des erreurs non prévues
004300160929     d gest_erreur     pr
004400160929
004500160929      // program status data structure
004600160929      // structure information programme
004700160929     d/copy qcpysrc,psds
004800160929
004900160929      // local functions prototypes
005000160929      // prototypes fonctions locales
005100160929
005200160929      // global variables
005300160929      // variables globales
005400160929     dg_snom           s                   like(r_nom)
005500160929     dg_wsnop          s                   like(r_nom)
005600160929
005700160929     dg_nblis1         s                   like(r_nblign)
005800160929     dg_lstlig         s                   like(r_nblign)
005900160929     dg_nbrlig         s                   like(r_nblign)
006000160929     dg_i              s              3p 0
006100160929     dg_xnom           s                   like(r_nom)
006200160929     da_typ            s                   like(r_typmsg)
006300160929     da_fim            s                   like(r_nomobj)
006400160929     da_mid            s                   like(r_msgid)
006500160929     da_mdt            s                   like(r_msgdta)
006600160929
006700160929     d a_chx           s              2a
006800160929     d a_nrec          s                   like(r_matricule)
006900160929     d a_mat           s                   like(r_matricule)
007000160929
007100160929      // Indicateurs
007200160929     d g_sortie        s               n
007300160929     d g_trt_opt       s               n
007400160929     d g_selection     s               n
007500160929     d g_alimsfl       s               n
007600160929     d g_filtre        s               n
007700160929
007800160929      // Touches de fonction
007900160929      /copy qcpysrc,fonction
008000160929
008100160929      // data-structures
008200160929      // structures de données
008300160929      // Indicateurs renommés avec Indara et INDDS
008400160929     D IndDS           ds
008500160929     D  ROLLUP                         N   Overlay(IndDS:2)
008600160929     D  SFLDSP                         N   Overlay(IndDS:4)
008700160929     D  SFLDSPCTL                      N   Overlay(IndDS:5)
008800160929     D  SFLCLR                         N   Overlay(IndDS:6)
008900160929     d  SFLEND                         N   Overlay(IndDS:7)
009000160929     d  SFLNXTCHG                      N   Overlay(IndDS:8)
009100160929     d  SFLENDMSG                      N   Overlay(IndDS:9)
009200160929     D  SFLINZ                         N   Overlay(IndDS:10)
009300160929     D  PROTECT                        N   Overlay(IndDS:20)
009400160929     D  ROUGE                          N   Overlay(IndDS:30)
009500160929
009600160929      // la ds du sous=fichier
009700160929     ddssfl1           ds
009800160929     dwposc                  370    371b 0
009900160929     dwrrng                  376    377b 0
010000160929     dwrngp                  378    379b 0
010100160929     dwnbrsf                 380    381b 0
010200160929
010300160929      // la ds du fichier
010400160929     dfic              ds
010500160929     dwnrc01                 397    400b 0
010600160929     dwdsfic           ds
010700160929     dwcdfil                   1      8
010800160929     dwopenf                   9      9
010900160929     dwstsfi                  11     15  0
011000160929     dwopcod                  16     21
011100160929     dwrpgsq                  30     37
011200160929     dwrpgnr                  38     45
011300160929     dwerrfi                  46     52
011400160929     dwnfich                  83     92
011500160929     dwnlibr                  93    102
011600160929     dwspnam                 103    112
011700160929     dwsplib                 113    122
011800160929     dwspnum                 123    124b 0
011900160929     dwlimbr                 129    138
012000160929     dwnbput                 243    246b 0
012100160929     dwnbget                 247    250b 0
012200160929     dwnbpg                  251    254b 0
012300160929     dwnbio                  255    258b 0
012400160929     dwrcdft                 261    270
012500160929     dwnbrcd                 283    286b 0
012600160929     dwnrcfi                 397    400b 0
012700160929
012800160929      // inherited variables
012900160929      // héritage des types
013000160929     d/copy QINHLESRC,INH32766
013100160929
013200160929      // constants
013300160929      // constantes
013400160929
013500160929      * main function
013600160929      * fonction principale
013700160929      /free
013800160929       monitor;
013900160929       // le nombre de lignes affichables, déclaration à la volée
014000160929         g_nblis1=14;
014100160929         // initialisation des variables générales
014200160929         zpgm=PROCEDURE;
014300160929         zdate=%dec(%date():*eur);
014400160929         zheur=%dec(%time():*eur);
014500160929         zuser=USER;
014600160929         zjob=JOB_NAME;
014700160929         // initialisation du sous fichier des messages
014800160929         wpgmq='*  ';
014900160929         wmgkey='CC01';
015000160929         sflendmsg = *on;
015100160929         sflinz = *on;
015200160929         // indicateur fin
015300160929         g_sortie = *off;
015400160929         // début du traitement,
015500160929         exsr initsf;
015600160929         // boucle d'attente de sortie
015700160929         dow not g_sortie;
015800160929           exsr trtsfl;
015900160929         enddo;
016000160929
016100160929         on-error;
016200160929           dump(a);
016300160929           gest_erreur();
016400160929         endmon;
016500160929
016600160929       // indicateur de fin de programme
016700160929       *inlr = *on;
016800160929       // les procédures
016900160929       // traitement de l'écran
017000160929       begsr trtsfl;
017100160929         // effacement du sous=fichier de messages
017200160929          a_typ='3';
017300160929          a_fim=*blank;
017400160929          a_mid=*blank;
017500160929          gst_message(  a_typ
017600160929                      : a_fim
017700160929                      : a_mid
017800160929                      : a_mdt);
017900160929         write wsfctl;
018000160929         // ecriture de l'écran
018100160929         sfldsp = *on;
018200160929         sfldspctl = *on;
018300160929         write fore1;
018400160929
018500160929         write forb1;
018600160929         // attente lecture
018700160929         read fore1;
018800160929
018900160929         // une touche a été actionnée
019000160929         // chargement de l'heure
019100160929         zheur=%dec(%time());
019200160929         // indicateur pour ne pas tester d'autres actions
019300160929         g_trt_opt = *on;
019400160929         if rollup;
019500160929           // page suivante
019600160929           exsr chgpag;
019700160929           g_trt_opt = *off;
019800160929         endif;
019900160929         //
020000160929         if g_wsnop <> zsnom
020100160929         and g_trt_opt;
020200160929         // test si selection/ si changé on initialise
020300160929           exsr initsf;
020400160929           g_trt_opt = *off;
020500160929         endif;
020600160929         // touches f3 et f12
020700160929         if sortie or
020800160929               cancel;
020900160929           // on met l'indicateur  off = fin du programme
021000160929           g_sortie = *on;
021100160929           g_trt_opt = *off;
021200160929         endif;
021300160929         //
021400160929         if refresh;
021500160929           // f5 rafraichissement de l'écran
021600160929           exsr initsf;
021700160929           g_trt_opt = *off;
021800160929         endif;
021900160929         //
022000160929         if creer;
022100160929           // f6 création d'un nouveau matricule
022200160929            a_chx='CR';
022300160929            a_nrec=*zero;
022400160929            detail_personnel(a_chx:a_nrec);
022500160929            exsr initsf;
022600160929           g_trt_opt = *off;
022700160929         endif;
022800160929         if imprimer;
022900160929           // f8 impression du fichier
023000160929            a_mat=*zero;
023100160929            // on appelle le cl de routage sans soumission, sinon pgmf20cl
023200160929            impression(a_mat);
023300160929            g_trt_opt = *off;
023400160929         endif;
023500160929         // on ne fait ceci que s'il n'y a eu rien d'autre
023600160929         if g_trt_opt;
023700160929           exsr trtopt;
023800160929         endif;
023900160929         // on recommence la boucle d'attente
024000160929       endsr;
024100160929       // initialisation du sous-fichier
024200160929       begsr initsf;
024300160929         //    l'indicateur 20 conditionne la zone opt (protection)
024400160929         protect = *off;
024500160929         // initialisation de la variable de sélection
024600160929         g_wsnop=zsnom;
024700160929         g_snom=*blank;
024800160929         // initialisation de la clé pour positionnement
024900160929         fifon=*blank;
025000160929         finom=*blank;
025100160929         g_selection = *off;
025200160929         g_filtre = *off;
025300160929         if zsnom <> *blank;
025400160929           // si différent de blank il y a sélection
025500160929           g_selection = *on;
025600160929           g_i=0;
025700160929           g_i=%scan('*':zsnom);
025800160929
025900160929           if g_i > 0;
026000160929              g_filtre=*on;
026100160929              g_i=g_i-1;
026200160929              g_snom=%subst(zsnom:1:g_i);
026300160929              // on est dans le cas d'une sélection générique
026400160929             // on se positionnera juste au bon endroit dans le fichier
026500160929              finom=g_snom;
026600160929           endif;
026700160929         endif;
026800160929         // la dernière ligne écrite
026900160929
027000160929         g_lstlig=0;
027100160929         // le compteur de ligne par page
027200160929         g_nbrlig=0;
027300160929         // le fameux wran01
027400160929         wran01=0;
027500160929         // effacement du sous=fichier
027600160929         sflclr = *on;
027700160929         sflend = *on;
027800160929         sfldsp = *off;
027900160929         sfldspctl = *off;
028000160929         write fore1;
028100160929         sflclr = *off;
028200160929         sfldsp = *on;
028300160929         sfldspctl = *on;
028400160929         // positionnement en début de fichier
028500160929         setll ( fifon: finom) fic02l;
028600160929         // chargement de la première page
028700160929         exsr chgpag;
028800160929       endsr;
028900160929       // traitement des options, on ne lit que les enregistrements modifiés
029000160929       begsr trtopt;
029100160929         // lecture des enregistrements modifiés
029200160929          wran01=1;
029300160929          // top pour rafrachir l'écran, si besoin
029400160929         g_alimsfl = *off;
029500160929         readc sfl01;
029600160929         dow not %eof;
029700160929             a_nrec=hnrec;
029800160929             if htout='1';
029900160929                if zopt='2' or zopt='3' or zopt='4' or zopt='5';
030000160929               // si l'employé  quitté on ne peut plus rien modifier
030100160929                   zopt='5';
030200160929                endif;
030300160929             endif;
030400160929             g_filtre = *on;
030500160929             // selection en fonction du choix saisi
030600160929             select;
030700160929             when (zopt = '2') or (zopt = ' 2');
030800160929                a_chx='MO';
030900160929             when (zopt = '3') or (zopt = ' 3');
031000160929                a_chx='CO';
031100160929             when (zopt = '4') or (zopt = ' 4');
031200160929                a_chx='SU';
031300160929             when (zopt = '5') or (zopt = ' 5');
031400160929                a_chx='AF';
031500160929             when (zopt = '6') or (zopt = ' 6');
031600160929                a_mat=hmatr;
031700160929                impression(a_mat);
031800160929                g_filtre = *off;
031900160929             when (zopt = '99');
032000160929                a_chx='PE';
032100160929             other;
032200160929             // la saisie ne correspond  rien
032300160929                g_filtre = *off;
032400160929             // envoyer un message pour dire que l'option n'existe pas
032500160929                a_typ='1';
032600160929                a_fim='FICMSG   ';
032700160929                a_mid='MSG0002';
032800160929                gst_message(  a_typ
032900160929                            : a_fim
033000160929                            : a_mid
033100160929                            : a_mdt);
033200160929             endsl;
033300160929             if htout = '0';
033400160929             // pour ne pas perdre l'attribut couleur
033500160929               rouge = *off;
033600160929             else;
033700160929               rouge = *on;
033800160929             endif;
033900160929             // nettoyage
034000160929             zopt=*blanks;
034100160929             update(e) sfl01;
034200160929             // on aurait pu aussi faire if..., en tout cas le choix est bon
034300160929             detail_personnel(  a_chx
034400160929                              : a_nrec);
034500160929             g_alimsfl=*on;
034600160929             // on continue de boucler si autre option
034700160929           readc(e) sfl01;
034800160929         enddo;
034900160929         // potentiellement il y a eu mise  jour, on pourrait affiner
035000160929         if g_alimsfl;
035100160929            exsr initsf;
035200160929         ENDIF;
035300160929       endsr;
035400160929       // chargement d'une page
035500160929       begsr chgpag;
035600160929         // il faut positionner correctement les indicateurs et les variables
035700160929         sflnxtchg = *off;
035800160929         //                  seton                                        04
035900160929         wran01=g_lstlig;
036000160929         // lecture de l'enregistrement suivant
036100160929         read fic02l;
036200160929
036300160929         // remise à zéro du compteur de ligne, mais on pourrait faire autrement
036400160929         g_nbrlig=0;
036500160929
036600160929         dow not %eof(fic02l)
036700160929         and g_nbrlig < 14;
036800160929           // remplissage des zones écran
036900160929           g_alimsfl = *on;
037000160929           // test s'il y a sélection
037100160929           if g_selection or g_filtre;
037200160929             if g_selection and not g_filtre;
037300160929               // on recherche la stricte égalité de nom
037400160929               if finom <> zsnom;
037500160929                 g_alimsfl = *off;
037600160929               endif;
037700160929             else;
037800160929                // on recherche si le nom commence par la valeur avant le '*'
037900160929                g_xnom=%subst( finom:1:g_i);
038000160929                if g_xnom <> g_snom;
038100160929                 g_alimsfl = *off;
038200160929               endif;
038300160929             endif;
038400160929           endif;
038500160929           // l'indicateur est  '1' si sélection ok ou pas de sélection
038600160929           if g_alimsfl;
038700160929              znom=finom;
038800160929              zpr1=fipr1;
038900160929              zfonc=fifon;
039000160929              zmatr=fimat;
039100160929              zcpo=ficpo;
039200160929              wdsfic=fic;
039300160929              hnrec=wnrcfi;
039400160929              hmatr=fimat;
039500160929              if fidas = 0;
039600160929               // top salarié licencié
039700160929              htout = *off;
039800160929              rouge = *off;
039900160929            else;
040000160929              htout = *on;
040100160929              rouge = *on;
040200160929             endif;
040300160929             // les compteurs, attention au wran01
040400160929             g_nbrlig+=1;
040500160929             g_lstlig+=1;
040600160929             wran01+=1;
040700160929             // ecriture de la ligne
040800160929             write sfl01;
040900160929           endif;
041000160929           // lecture du suivant
041100160929           read fic02l;
041200160929
041300160929         enddo;
041400160929         // on quitte la boucle soit en fin de page
041500160929         //                     soit en fin de fichier
041600160929         if %eof(fic02l);
041700160929           // le caractère de suite, on est en fin de fichier
041800160929           sflend = *on;
041900160929         else;
042000160929           sflend = *off;
042100160929         endif;
042200160929         // si le fichier est vide
042300160929         if wran01 = 0;
042400160929            g_nbrlig=1;
042500160929            g_lstlig=1;
042600160929            // un petit message
042700160929            wran01=1;
042800160929            // pas de saisie d'option
042900160929           protect = *on;
043000160929           if zsnom = *blank;
043100160929             znom = 'sélection vide';
043200160929           else;
043300160929             znom = 'Fichier vide';
043400160929           endif;
043500160929           // ne pas oublier de remettre  blanc
043600160929           zpr1=*blank;
043700160929           zfonc=*blank;
043800160929           zmatr=0;
043900160929           zcpo=*blank;
044000160929           wdsfic=*blank;
044100160929           hnrec=0;
044200160929           // ecriture du message sur la première ligne
044300160929           write sfl01;
044400160929         endif;
044500160929       endsr;
044600160929      /end-free
