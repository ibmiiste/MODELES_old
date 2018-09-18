      // Option de compilation et de programme
      // ctl-opt;


      // déclaration des fichiers
      // dcl-f fichier disk;

      // main function prototype
      // prototype fonction principale
      // dcl-pr programme extpgm('PGM');
      //   paramentre char(5);
      //   paramsortie packed(9:6);
      // END-PR;

      // global variables
      // variables globales
      // dcl-s donnee3 like(r_ref3);

      // dcl-pi programme;
      //   paramentre char(5);
      //   paramsortie packed(9:6);
      // END-Pi;

      // external functions prototypes
      // prototype fonctions externes
      // dcl-pr proc_ext varchar(300) extproc('PROC_EXT1');
      //   donnees1 packed(10:0);
      // end-pr;

      // program status data structure
      // structure information programme
      ///copy qcpysrc,psds

      // local functions prototypes
      // prototypes fonctions locales
      // dcl-pr sous_proc1 ind;
      //   donnees2 char(150);
      // end-pr;




      // Indicateurs
      // dcl-s g_indic1 ind;

      // Touches de fonction
      ///copy qcpysrc,fonction

      // data-structures
      // structures de données
      // Indicateurs renommés avec Indara et INDDS
      // dcl-ds ds1;
      //   donneeds1 like(r_ref4);
      //   donneeds2 like(r_ref5);
      // end-ds;


      // inherited variables
      // héritage des types
      ///copy QINHLESRC,INH32766

      // constants
      // constantes
      // dcl-c constante1 'CONSTANTE';

      // main function
      // fonction principale

      // indicateur de fin de programme
      // *inlr = *on;
      // monitor;

      // on-error;
      //   dump(a);
      //   gest_erreur();
      // endmon;


      // les sous-routines
      // traitement de l'écran
      // begsr sr1;

      // endsr;


      // --------------------------------------------------
      // Procedure name: sous_proc1
      // Purpose:
      // Returns:
      // --------------------------------------------------
      // DCL-PROC sous_proc1 ;

      // dcl-pi sous_proc1 ind;
      //   donnees2 char(150);
      // end-pi;
           // Données locales
      // DCL-S l_donnee1 like(r_ref6);
           // Programmation


      // END-PROC ;

