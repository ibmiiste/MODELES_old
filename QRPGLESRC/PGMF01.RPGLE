000001180516       ctl-opt debug decedit('0,') datedit(*dmy.);
000002180516      //*********************************************************************
000003180516      // CC 01/01/2009
000004180516      // Liste du personnel
000005180516      //*********************************************************************
000006180516      // Déclaration des fichiers
000007180516       dcl-f PGMF01FM workstn sfile(sfl01 :wran01) infds(dssfl1) indds(IndDs);
000008180516       dcl-f FIC02L keyed infds(fic);
000009180516
000010180516
000011180516       // Prototypes d'appel
000012180516       Dcl-pr Gestion_Fich Extpgm('PGMF02');
000013180516         PCHX char(2);
000014180516         NREC char(10);
000015180516       end-pr;
000016180516
000017180516       Dcl-pr Gestion_Fich Extpgm('PGMF2SCL');
000018180516         PMAT char(10);
000019180516       End-pr;
000020180516
000021180516       Dcl-pr Gestion_message Extpgm('PGM001CL');
000022180516         PTYP Char(2);
000023180516         PFIM Char(10);
000024180516         PMID Char(7);
000025180516         PMDT Char(99);
000026180516       End-pr;
000027180516
000028180516       // Déclaration des variables
000029180516       Dcl-s WSNOM char(35);
000030180516       Dcl-s WSNOP char(35);
000031180516       Dcl-s I packed(3);
000032180516
000033180516       // Gestion sous-fichier
000034180516       Dcl-s LSTLIG Packed(4:0);
000035180516       // Le compteur de ligne par page
000036180516       Dcl-s NBRLIG Packed(4:0);
000037180516       // Le fameux WRAN01
000038180516       Dcl-s WRAN01 Packed(4:0);
000039180516       Dcl-s g_Nblis1 Packed(4:0);
000040180516
000041180516       // Gestion des messages
000042180516       Dcl-s PTYP Char(1);
000043180516       Dcl-s PFIM Char(10);
000044180516       Dcl-s PMID Char(7);
000045180516       Dcl-s PMDT Char(99);
000046180516
000047180516      // Variables personnel
000048180516       Dcl-s PMAT Char(10);
000049180516       Dcl-s PCHX Char(2);
000050180516
000051180516      // La DS du programme, noter le S indispensable
000052180516       /copy qcpysrc,Psds
000053180516
000054180516      // La DS du sous=fichier
000055180516       Dcl-ds DSSFL1;
000056180516        WPOSC int(5) pos(370);
000057180516        WRRNG int(5) pos(376);
000058180516        WRNGP int(5) pos(378);
000059180516        WNBRSF int(5) pos(380);
000060180516       end-ds;
000061180516
000062180516      // Le DS des indicateurs de l'écran
000063180516       Dcl-ds IndDs;
000064180516        Rollup Ind Pos(2);
000065180516        Sflnxtchg Ind Pos(8);
000066180516        Zoptpr Ind Pos(20);
000067180516        Znomred Ind Pos(30);
000068180516        Sflend Ind Pos(7);
000069180516        Sfldsp Ind Pos(4);
000070180516        Sfldspctl Ind Pos(5);
000071180516        Sflclr Ind Pos(6);
000072180516        Sflend_no_rollup Ind Pos(7);
000073180516        Sflinz_Msgf Ind Pos(10);
000074180516        Sflend_Msgf Ind Pos(09);
000075180516       End-ds;
000076180516
000077180516      // Renommage des touches de fonction
000078180516       /Copy Qcpysrc,Fonction
000079180516
000080180516      // La DS du fichier
000081180516       dcl-ds FIC;
000082180516        WNRC01 int(10) pos(397);
000083180516       end-ds;
000084180516
000085180516
000086180516       dcl-ds WDSFIC;
000087180516        WCDFIL char(8) pos(1);
000088180516        WOPENF char(1) pos(9);
000089180516        WSTSFI zoned(5) pos(11);
000090180516        WOPCOD char(6) pos(16);
000091180516        WRPGSQ char(8) pos(30);
000092180516        WRPGNR char(8) pos(38);
000093180516        WERRFI char(7) pos(46);
000094180516        WNFICH char(10) pos(83);
000095180516        WNLIBR char(10) pos(93);
000096180516        WSPNAM char(10) pos(103);
000097180516        WSPLIB char(10) pos(113);
000098180516        WSPNUM int(5) pos(123);
000099180516        WLIMBR char(10) pos(129);
000100180516        WNBPUT int(10) pos(243);
000101180516        WNBGET int(10) pos(247);
000102180516        WNBPG int(10) pos(251);
000103180516        WNBIO int(10) pos(255);
000104180516        WRCDFT char(10) pos(261);
000105180516        WNBRCD int(10) pos(283);
000106180516        WNRCFI int(10) pos(397);
000107180516       end-ds;
000108180516
000109180516       // la clé d'accés au fichier
000110180516       Dcl-ds Key likerec(FICF : *key);
000111180516
000112180516       // le nombre de lignes afichables, déclaration a la volée
000113180516       g_Nblis1 = 14;
000114180516       // initialisation des variables système affichées à l'écran
000115180516       Zpgm = Procedure;
000116180516       Zdate=%char(%Date());
000117180516       Zheur=%char(%Time());
000118180516       Zjob=Job_name;
000119180516
000120180516       // Initialisation du sous=fichier des messages
000121180516       WPGMQ='*  ';
000122180516       WMGKEY='CC01';
000123180516
000124180516       Sflend_Msgf = *ON;
000125180516       Sflinz_Msgf = *ON;
000126180516       // Indicateur fin
000127180516       g_Sortie = *ON;
000128180516       // Debut du traitement,
000129180516       EXSR INITSF;
000130180516       // Boucle d'attente de sortie
000131180516       DOW g_Sortie = '1';
000132180516         EXSR TRTSFL;
000133180516       ENDDO;
000134180516       // Indicateur de fin de programme
000135180516       *INLR = *ON;
000136180516       // Les procédures
000137180516       // Traitement de l'écran
000138180516       BEGSR TRTSFL;
000139180516         // Effacement du sous=fichier de messages
000140180516         PTYP = '3';
000141180516         PFIM = *Blank;
000142180516         PMID = *Blank;
000143180516         Gestion_message( PTYP
000144180516                         :PFIM
000145180516                         :PMID
000146180516                         :PMDT);
000147180516
000148180516         WRITE WSFCTL;
000149180516         // Ecriture de l'écran
000150180516         Sfldsp = *ON;
000151180516         Sfldspctl = *ON;
000152180516         WRITE FORE1;
000153180516
000154180516         WRITE FORB1;
000155180516         // Attente lecture
000156180516         READ FORE1;
000157180516
000158180516         // Une touche a été actionnée
000159180516         // Chargement de l'heure
000160180516         ZHEUR=%TIME();
000161180516
000162180516      // Indicateur pour ne pas tester d'autres actions
000163180516         g_Fin_actions = *ON;
000164180516         IF Rollup = '1';
000165180516           // page suivante
000166180516           EXSR CHGPAG;
000167180516           g_Fin_actions = *OFF;
000168180516         ENDIF;
000169180516         //
000170180516         IF WSNOP <> ZSNOM And g_Fin_actions;
000171180516         // Test si selection/ si changé on initialise
000172180516           EXSR INITSF;
000173180516           g_Fin_actions = *OFF;
000174180516         ENDIF;
000175180516
000176180516         // touches F3 et F12
000177180516         IF Sortie = '1' OR
000178180516               Annuler = '1';
000179180516           // on met l'indicateur à Off = fin du programme
000180180516           g_Sortie = *OFF;
000181180516           g_Fin_actions = *OFF;
000182180516         ENDIF;
000183180516         //
000184180516         IF Rachaichir = '1';
000185180516           // F5 Rafraichissement de l'écran
000186180516           EXSR INITSF;
000187180516           g_Fin_actions = *OFF;
000188180516         ENDIF;
000189180516         //
000190180516         IF Creer = '1';
000191180516           // F6 création d'un nouveau matricule
000192180516           PCHX = 'CR';
000193180516           Clear NREC;
000194180516
000195180516           Gestion_Fiche( PCHX
000196180516                         :NREC);
000197180516
000198180516           EXSR INITSF;
000199180516           g_Fin_actions = *OFF;
000200180516         ENDIF;
000201180516         IF Imprimer = '1';
000202180516           // F8 impression du fichier
000203180516           clear PMAT;
000204180516           // On appelle le CL de routage sans soumission, sinon PGMF20CL
000205180516           Imprimer( PMAT);
000206180516           g_Fin_actions = *OFF;
000207180516         ENDIF;
000208180516         // On ne fait ceci que s'il n'y a eu rien d'autre
000209180516         IF g_Fin_actions = '1';
000210180516           EXSR TRTOPT;
000211180516         ENDIF;
000212180516         // On recommence la boucle d'attente
000213180516       ENDSR;
000214180516       // Initialisation du sous-fichier
000215180516       BEGSR INITSF;
000216180516         //    l'indicateur 20 conditionne la zone OPT (protection)
000217180516         Zoptpr = *OFF;
000218180516         // Initialisation de la variable de sélection
000219180516         ZSNOM =  WSNOP;
000220180516         Clear WSNOM;
000221180516      // Initialisation de la clé pour positionnement
000222180516         Clear FIFON;
000223180516         Clear FINOM;
000224180516         g_Selection = *OFF;
000225180516         g_Selection_generique = *OFF;
000226180516         IF ZSNOM <> *BLANK;
000227180516           // Si différent de blank il y a selection
000228180516           g_Selection = *ON;
000229180516           Reset I;
000230180516           g_Selection_generique = I = %Scan( '*'
000231180516                                             :ZSNOM);
000232180516
000233180516           IF I > 0;
000234180516             I=I-1;
000235180516             WSNOM=%Subst(ZSNOM:1:I);
000236180516             // On est dans le cas d'une sélection générique
000237180516             g_Selection_generique = *ON;
000238180516             // On se positionnera juste au bon endroit dans le fichier
000239180516             FINOM = WSNOM;
000240180516           ENDIF;
000241180516         ENDIF;
000242180516
000243180516         // La dernière ligne écrite
000244180516         Clear LSTLIG;
000245180516      // Le compteur de ligne par page
000246180516         Clear NBRLIG;
000247180516      // Le fameux WRAN01
000248180516         Clear WRAN01;
000249180516
000250180516      // Effacement du sous=fichier
000251180516         Sflclr = *ON;
000252180516         Sflend_no_rollup = *ON;
000253180516         Sfldsp = *OFF;
000254180516         Sfldspctl = *OFF;
000255180516         WRITE FORE1;
000256180516         Sflclr = *OFF;
000257180516         Sfldsp = *ON;
000258180516         Sfldspctl = *ON;
000259180516         // Positionnement en début de fichier
000260180516         SETLL KEY001 FICF;
000261180516         *IN70 = %EQUAL;
000262180516         // Chargement de la première page
000263180516         EXSR CHGPAG;
000264180516       ENDSR;
000265180516       // Traitement des options, on ne lit que les enregistrements modifiés
000266180516       BEGSR TRTOPT;
000267180516         // Lecture des enregistrements modifiés
000268180516         WRAN01=1;
000269180516         // Top pour rafraichir l'écran, si besoin
000270180516         g_Selection_OK = *OFF;
000271180516
000272180516         If %Found;
000273180516           READC SFL01;
000274180516         EndIf;
000275180516         //
000276180516         DOW not %Eof;
000277180516           NREC=HNREC;
000278180516           IF HTOUT = '1';
000279180516             IF ZOPT='2' OR ZOPT='3' OR ZOPT='4' OR ZOPT='99';
000280180516               // Si l'employé à quitté on ne peut plus rien modifier
000281180516               ZOPT = '5 ';
000282180516             ENDIF;
000283180516           ENDIF;
000284180516           g_Traitement_option = *ON;
000285180516           // Selection en fonction du choix saisi
000286180516           SELECT;
000287180516           WHEN (ZOPT = '2') OR (ZOPT = ' 2');
000288180516             PCHX = 'MO';
000289180516            WHEN (ZOPT = '3') OR (ZOPT = ' 3');
000290180516              PCHX = 'CO';
000291180516           WHEN (ZOPT = '4') OR (ZOPT = ' 4');
000292180516             PCHX = 'SU';
000293180516           WHEN (ZOPT = '5') OR (ZOPT = ' 5');
000294180516             PCHX = 'AF;'
000295180516           WHEN (ZOPT = '6') OR (ZOPT = ' 6');
000296180516             PMAT =  HMATR;
000297180516             Imprimer( PMAT);
000298180516             g_Traitement_option = *OFF;
000299180516           WHEN (ZOPT = '99');
000300180516             PCHX = 'PE';
000301180516           OTHER;
000302180516             // La saisie ne correspond à rien
000303180516             g_Traitement_option = *OFF;
000304180516             // Envoyer un message pour dire que l'option n'existe pas
000305180516             PTYP = '1';
000306180516             PFIM = 'FICMSG   ';
000307180516             PMID = 'MSG0002';
000308180516             Gestion_message( PTYP
000309180516                             :PFIM
000310180516                             :PMID
000311180516                             :PMDT);
000312180516           ENDSL;
000313180516
000314180516           IF HTOUT = '0';
000315180516             // Pour ne pas perdre l'attribut couleur
000316180516             Znomred = *OFF;
000317180516           ELSE;
000318180516             Znomred = *ON;
000319180516           ENDIF;
000320180516
000321180516           // Nettoyage
000322180516           Clear ZOPT;
000323180516           UPDATE(E) SFL01;
000324180516           // On aurait pu aussi faire IF..., en tout cas le choix est bon
000325180516           If g_Traitement_option;
000326180516             Gestion_fiche( PCHX
000327180516                           :NREC);
000328180516             g_Selection_OK=*on;
000329180516           EndIf;
000330180516
000331180516      // On continue de boucler si autre option
000332180516           READC(E) SFL01;
000333180516         ENDDO;
000334180516
000335180516         // Potentiellement il y a eu mise à jour, on pourrait affiner
000336180516         If g_Selection_OK;
000337180516           EXSR INITSF;
000338180516         EndIf;
000339180516       ENDSR;
000340180516
000341180516       // Chargement d'une page
000342180516       BEGSR CHGPAG;
000343180516         // Il faut positionner correctement les indicateurs et les variables
000344180516         Sflnxtchg = *OFF;
000345180516         //                  SETON                                        04
000346180516         Wran1 = LSTLIG;
000347180516      // Lexture de l'enregistrement suivant
000348180516         READ FICF;
000349180516         // Remise à zéro du compteur de ligne, mais on pourrait faire autrement
000350180516         Clear NBRLIG;
000351180516      //
000352180516         DOW Not %eof
000353180516         AND NBRLIG < 14;
000354180516           // Remplissage des zones écran
000355180516           g_Selection_OK = *ON;
000356180516           // Test s'il y a selection
000357180516           IF g_Selection = '1' OR g_Selection_generique = '1';
000358180516             IF g_Selection = '1' AND g_Selection_generique = '0';
000359180516               // On recherche la stricte égalité de nom
000360180516               IF FINOM <> ZSNOM;
000361180516                 g_Selection_OK = *OFF;
000362180516               ENDIF;
000363180516             ELSE;
000364180516               // On recherche si le nom commence par la valeur avant le '*'
000365180516               IF %Subst(FINOM:1:I) <> WSNOM;
000366180516                 g_Selection_OK = *OFF;
000367180516               ENDIF;
000368180516             ENDIF;
000369180516           ENDIF;
000370180516           // L'indicateur est à '1' si sélection OK ou pas de sélection
000371180516           IF g_Selection_OK;
000372180516             ZNOM = FINOM;
000373180516             ZPR1 = FIPR1;
000374180516             ZFONC = FIFON;
000375180516             ZMATR =  FIMAT;
000376180516             ZCPO  = FICPO;
000377180516             WDSFIC = FIC;
000378180516             WNRCFIC = HNREC;
000379180516             FIMAT = MATR;
000380180516             IF FIDAS = 0;
000381180516               // Top salarié licencié
000382180516               HTOUT = '0';
000383180516               Znomred = *OFF;
000384180516             ELSE;
000385180516               HTOUT = '1';
000386180516               Znomred = *ON;
000387180516             ENDIF;
000388180516             // Les compteurs, attention au WRAN01
000389180516             NBRLIG+=1;
000390180516             LSTLIG+=1;
000391180516             WRAN01+=1;
000392180516      // Ecriture de la ligne
000393180516             WRITE SFL01;
000394180516           ENDIF;
000395180516           // Lecture du suivant
000396180516           READ FICF;
000397180516
000398180516         ENDDO;
000399180516         // On quitte la boucle soit en fin de page
000400180516         //                     soit en fin de fichier
000401180516         IF %Eof;
000402180516           // Le caractère de suite, on est en fin de fichier
000403180516           Sflend_no_rollup = *ON;
000404180516         ELSE;
000405180516           Sflend_no_rollup = *OFF;
000406180516         ENDIF;
000407180516
000408180516         // Si le fichier est vide
000409180516         IF WRAN01 = 0;
000410180516           NBRLIG=1;
000411180516           LSTLIG=1;
000412180516           // Un petit message
000413180516           WRAN01=1;
000414180516           // Pas de saisie d'option
000415180516           Zoptpr = *ON;
000416180516           IF ZSNOM = *BLANK;
000417180516             ZNOM = 'Sélection Vide';
000418180516           ENDIF;
000419180516
000420180516           // Ne pas oublier de remettre à blanc
000421180516           Clear ZPR1;
000422180516           Clear ZFONC;
000423180516           Clear ZMATR;
000424180516           Clear ZCPO;
000425180516           Clear WDSFIC;
000426180516           Clear HNREC;
000427180516
000428180516           // Ecriture du message sur la première ligne
000429180516           WRITE SFL01;
000430180516         ENDIF;
000431180516
000432180516           WRAN01 = LSTLIG;
000433180516       ENDSR;
