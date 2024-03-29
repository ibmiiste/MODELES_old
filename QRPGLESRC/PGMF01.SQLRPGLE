       ctl-opt debug decedit('0,') datedit(*dmy.);
      //*********************************************************************
      // CC 01/01/2009
      // Liste du personnel
      //*********************************************************************
      // D�claration des fichiers
       dcl-f PGMF01FM workstn sfile(sfl01 :wran01) infds(dssfl1) indds(IndDs);


       // Prototypes d'appel
       Dcl-pr Gestion_Fiche Extpgm('PGMF02');
         PCHX char(2);
         NREC char(10);
       end-pr;

       Dcl-pr Impression Extpgm('PGMF2SCL');
         PMAT char(10);
       End-pr;

       Dcl-pr Gestion_message Extpgm('PGM001CL');
         PTYP Char(1);
         PFIM Char(10);
         PMID Char(7);
         PMDT Char(99);
       End-pr;

       // D�claration des variables
       Dcl-s WSNOM char(35);
       Dcl-s WSNOP char(35);
       Dcl-s I packed(3);

       // Num�ro relatif d"enregistrement de FIC00P
       Dcl-s g_Num_rel Like(r_Numero_relatif);

       // Gestion sous-fichier
       Dcl-s LSTLIG Packed(4:0);
       // Le compteur de ligne par page
       Dcl-s NBRLIG Packed(4:0);
       // Le fameux WRAN01
       Dcl-s WRAN01 Packed(4:0);
       Dcl-s g_Nblis1 Packed(4:0);

       // Gestion des messages
       Dcl-s PTYP Char(1);
       Dcl-s PFIM Char(10);
       Dcl-s PMID Char(7);
       Dcl-s PMDT Char(99);

       // Variables personnel
       Dcl-s PMAT Char(10);
       Dcl-s PCHX Char(2);
       Dcl-s NREC Char(10);

       // Indicateurs bool�ens
       Dcl-s g_Fin_actions Ind;
       Dcl-s g_Selection Ind;
       Dcl-s g_Selection_generique Ind;
       Dcl-s g_Sortie Ind;
       Dcl-s g_Traitement_option Ind;
       Dcl-s g_Selection_OK Ind;

       // Valeurs possible de SQLCODE
       Dcl-c c_trouve 0;

       // La DS du programme, noter le S indispensable
       /copy qcpysrc,Psds

       // La DS du sous=fichier
       Dcl-ds DSSFL1;
        WPOSC int(5) pos(370);
        WRRNG int(5) pos(376);
        WRNGP int(5) pos(378);
        WNBRSF int(5) pos(380);
       end-ds;

       // Le DS des indicateurs de l'�cran
       Dcl-ds IndDs;
        Rollup Ind Pos(2);
        Sflnxtchg Ind Pos(8);
        Zoptpr Ind Pos(20);
        Znomred Ind Pos(30);
        Sflend Ind Pos(7);
        Sfldsp Ind Pos(4);
        Sfldspctl Ind Pos(5);
        Sflclr Ind Pos(6);
        Sflend_no_rollup Ind Pos(7);
        Sflinz_Msgf Ind Pos(10);
        Sflend_Msgf Ind Pos(09);
       End-ds;

       //
       // Renommage des touches de fonction
       /Copy Qcpysrc,Fonction

       //H�ritage des templates
       /copy qcpysrc,Inhtemplat

       // la ds de la table FIC00P
       Dcl-ds FIC00P Extname('FIC00P') End-ds;

       // le nombre de lignes afichables, d�claration a la vol�e
       g_Nblis1 = 14;
       // initialisation des variables syst�me affich�es � l'�cran
       Zpgm = Procedure;
       Zdate=%Date;
       Zheur=%Time;
       Zjob=Job_name;

       // Initialisation du sous=fichier des messages
       WPGMQ='*  ';
       WMGKEY='CC01';

       Sflend_Msgf = *ON;
       Sflinz_Msgf = *ON;
       // Indicateur fin
       g_Sortie = *ON;
       // Debut du traitement,
       EXSR INITSF;
       // Boucle d'attente de sortie
       DOW g_Sortie;
         EXSR TRTSFL;
       ENDDO;
       // Indicateur de fin de programme
       *INLR = *ON;
       // Les proc�dures
       // Traitement de l'�cran
       BEGSR TRTSFL;
         // Effacement du sous=fichier de messages
         PTYP = '3';
         PFIM = *Blank;
         PMID = *Blank;
         Gestion_message( PTYP
                         :PFIM
                         :PMID
                         :PMDT);

         WRITE WSFCTL;
         // Ecriture de l'�cran
         Sfldsp = *ON;
         Sfldspctl = *ON;
         WRITE FORE1;

         WRITE FORB1;
         // Attente lecture
         READ FORE1;

         // Une touche a �t� actionn�e
         // Chargement de l'heure
         ZHEUR=%TIME;

      // Indicateur pour ne pas tester d'autres actions
         g_Fin_actions = *ON;
         IF Rollup;
           // page suivante
           EXSR CHGPAG;
           g_Fin_actions = *OFF;
         ENDIF;
         //
         IF WSNOP <> ZSNOM And g_Fin_actions;
         // Test si selection/ si chang� on initialise
           EXSR INITSF;
           g_Fin_actions = *OFF;
         ENDIF;

         // touches F3 et F12
         IF Sortie OR
            Annuler;
           // on met l'indicateur � Off = fin du programme
           g_Sortie = *OFF;
           g_Fin_actions = *OFF;
         ENDIF;
         //
         IF Rachaichir;
           // F5 Rafraichissement de l'�cran
           EXSR INITSF;
           g_Fin_actions = *OFF;
         ENDIF;
         //
         IF Creer;
           // F6 cr�ation d'un nouveau matricule
           PCHX = 'CR';
           Clear NREC;

           Gestion_Fiche( PCHX
                         :NREC);

           EXSR INITSF;
           g_Fin_actions = *OFF;
         ENDIF;
         IF Imprimer;
           // F8 impression du fichier
           clear PMAT;
           // On appelle le CL de routage sans soumission, sinon PGMF20CL
           Impression( PMAT);
           g_Fin_actions = *OFF;
         ENDIF;
         // On ne fait ceci que s'il n'y a eu rien d'autre
         IF g_Fin_actions;
           EXSR TRTOPT;
         ENDIF;
         // On recommence la boucle d'attente
       ENDSR;
       // Initialisation du sous-fichier
       BEGSR INITSF;
         //    l'indicateur 20 conditionne la zone OPT (protection)
         Zoptpr = *OFF;
         // Initialisation de la variable de s�lection
         WSNOP=ZSNOM;
         Clear WSNOM;
      // Initialisation de la cl� pour positionnement
         Clear FIFON;
         Clear FINOM;
         g_Selection = *OFF;
         g_Selection_generique = *OFF;
         IF ZSNOM <> *BLANK;
           // Si diff�rent de blank il y a selection
           g_Selection = *ON;
           Reset I;

           I = %Scan( '*':ZSNOM);

           IF I > 0;
             I=I-1;
             WSNOM=%Subst(ZSNOM:1:I);
             // On est dans le cas d'une s�lection g�n�rique
             g_Selection_generique = *ON;
             // On se positionnera juste au bon endroit dans le fichier
             FINOM = WSNOM;
           ENDIF;
         ENDIF;

         // La derni�re ligne �crite
         Clear LSTLIG;
      // Le compteur de ligne par page
         Clear NBRLIG;
      // Le fameux WRAN01
         Clear WRAN01;

      // Effacement du sous=fichier
         Sflclr = *ON;
         Sflend_no_rollup = *ON;
         Sfldsp = *OFF;
         Sfldspctl = *OFF;
         WRITE FORE1;
         Sflclr = *OFF;
         Sfldsp = *ON;
         Sfldspctl = *ON;
         // Positionnement en d�but de fichier
         EXEC SQL CLOSE fic00p_s1;

         EXEC SQL DECLARE fic00p_s1
               CURSOR FOR
                   SELECT finom,
                          fipr1,
                          fifon,
                          fimat,
                          ficpo,
                          fidas,
                          RRN( fic00p)
                     FROM fic00p
                    WHERE fifon>=:fifon
                      AND finom>=:finom
                 ORDER BY fifon,
                          finom;
         EXEC SQL OPEN fic00p_s1;
         *in70 = %equal;
         // Chargement de la premi�re page
         EXSR CHGPAG;
       ENDSR;
       // Traitement des options, on ne lit que les enregistrements modifi�s
       BEGSR TRTOPT;
         // Lecture des enregistrements modifi�s
         WRAN01=1;
         // Top pour rafraichir l'�cran, si besoin
         g_Selection_OK = *OFF;

         If %Found;
           READC SFL01;
         EndIf;
         //
         DOW not %Eof;
           NREC=%Char(HNREC);
           IF HTOUT = '1';
             IF ZOPT='2' OR ZOPT='3' OR ZOPT='4' OR ZOPT='99';
               // Si l'employ� � quitt� on ne peut plus rien modifier
               ZOPT = '5 ';
             ENDIF;
           ENDIF;
           g_Traitement_option = *ON;
           // Selection en fonction du choix saisi
           SELECT;
           WHEN (ZOPT = '2') OR (ZOPT = ' 2');
             PCHX = 'MO';
            WHEN (ZOPT = '3') OR (ZOPT = ' 3');
              PCHX = 'CO';
           WHEN (ZOPT = '4') OR (ZOPT = ' 4');
             PCHX = 'SU';
           WHEN (ZOPT = '5') OR (ZOPT = ' 5');
             PCHX = 'AF';
           WHEN (ZOPT = '6') OR (ZOPT = ' 6');
             PMAT = %char(HMATR);
             Impression( PMAT);
             g_Traitement_option = *OFF;
           WHEN (ZOPT = '99');
             PCHX = 'PE';
           OTHER;
             // La saisie ne correspond � rien
             g_Traitement_option = *OFF;
             // Envoyer un message pour dire que l'option n'existe pas
             PTYP = '1';
             PFIM = 'FICMSG   ';
             PMID = 'MSG0002';
             Gestion_message( PTYP
                             :PFIM
                             :PMID
                             :PMDT);
           ENDSL;

           IF HTOUT = '0';
             // Pour ne pas perdre l'attribut couleur
             Znomred = *OFF;
           ELSE;
             Znomred = *ON;
           ENDIF;

           // Nettoyage
           Clear ZOPT;
           UPDATE(E) SFL01;
           // On aurait pu aussi faire IF..., en tout cas le choix est bon
           If g_Traitement_option;
             Gestion_fiche( PCHX
                           :NREC);
             g_Selection_OK=*on;
           EndIf;

      // On continue de boucler si autre option
           READC(E) SFL01;
         ENDDO;

         // Potentiellement il y a eu mise � jour, on pourrait affiner
         If g_Selection_OK;
           EXSR INITSF;
         EndIf;
       ENDSR;

       // Chargement d'une page
       BEGSR CHGPAG;
         // Il faut positionner correctement les indicateurs et les variables
         Sflnxtchg = *OFF;
         //                  SETON                                        04
         Wran01 = LSTLIG;
      // Lexture de l'enregistrement suivant
         EXEC SQL FETCH fic00p_s1 INTO  :finom,
                                        :fipr1,
                                        :fifon,
                                        :fimat,
                                        :ficpo,
                                        :fidas,
                                        :g_num_rel;

         // Remise � z�ro du compteur de ligne, mais on pourrait faire autrement
         clear nbrlig;
      //
         DOW Sqlcode=c_trouve
         AND NBRLIG < 14;
           // Remplissage des zones �cran
           g_Selection_OK = *ON;
           // Test s'il y a selection
           IF g_Selection OR g_Selection_generique;
             IF g_Selection AND g_Selection_generique;
               // On recherche la stricte �galit� de nom
               IF FINOM <> ZSNOM;
                 g_Selection_OK = *OFF;
               ENDIF;
             ELSE;
               // On recherche si le nom commence par la valeur avant le '*'
               IF %Subst(FINOM:1:I) <> WSNOM;
                 g_Selection_OK = *OFF;
               ENDIF;
             ENDIF;
           ENDIF;
           // L'indicateur est � '1' si s�lection OK ou pas de s�lection
           IF g_Selection_OK;
             ZNOM = FINOM;
             ZPR1 = FIPR1;
             ZFONC = FIFON;
             ZMATR =  FIMAT;
             ZCPO  = FICPO;
             HNREC=g_Num_rel;
             FIMAT = HMATR;
             IF FIDAS = 0;
               // Top salari� licenci�
               HTOUT = '0';
               Znomred = *OFF;
             ELSE;
               HTOUT = '1';
               Znomred = *ON;
             ENDIF;
             // Les compteurs, attention au WRAN01
             NBRLIG+=1;
             LSTLIG+=1;
             WRAN01+=1;
             // Ecriture de la ligne
             WRITE SFL01;
           ENDIF;
           // Lecture du suivant
           EXEC SQL FETCH fic00p_s1 INTO :finom,
                                         :fipr1,
                                         :fifon,
                                         :fimat,
                                         :ficpo,
                                         :fidas,
                                         :g_num_rel;

         enddo;
         // On quitte la boucle soit en fin de page
         //                     soit en fin de fichier
         IF %Eof;
           // Le caract�re de suite, on est en fin de fichier
           Sflend_no_rollup = *ON;
         ELSE;
           Sflend_no_rollup = *OFF;
         ENDIF;

         // Si le fichier est vide
         IF WRAN01 = 0;
           NBRLIG=1;
           LSTLIG=1;
           // Un petit message
           WRAN01=1;
           // Pas de saisie d'option
           Zoptpr = *ON;
           IF ZSNOM = *BLANK;
             ZNOM = 'S�lection Vide';
           ENDIF;

           // Ne pas oublier de remettre � blanc
           Clear ZPR1;
           Clear ZFONC;
           Clear ZMATR;
           Clear ZCPO;
           Clear HNREC;

           // Ecriture du message sur la premi�re ligne
           WRITE SFL01;
         ENDIF;

           WRAN01 = LSTLIG;
       ENDSR;
