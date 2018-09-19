      // Option de compilation et de programme
      // ctl-opt;


      // Déclaration des fichiers
      // dcl-f fichier disk;

      // Main procedure prototype
      // Prototype Procédure principale
      // dcl-pr programme extpgm('PGM');
      //   paramentre char(5);
      //   paramsortie packed(9:6);
      // END-PR;

      // External subprocedures prototypes globales
      // prototype sous-procédures externes
      // dcl-pr proc_ext varchar(300) extproc('PROC_EXT1');
      //   donnees1 packed(10:0);
      // end-pr;

      // Internal subprocedures prototypes globales
      // Prototype sous-procédures internes
      // dcl-pr proc_int varchar(150);
      //   donnees1 packed(10:0);
      // end-pr;

      // Global data-structures
      // Structures de données globales
      // Indicateurs renommés avec Indara et INDDS
      // dcl-ds ds1;
      //   donneeds1 like(r_ref4);
      //   donneeds2 like(r_ref5);
      // end-ds;

      // global variables
      // variables globales
      // dcl-s donnee3 like(r_ref3);

      // Program status data structure
      // Data Structure d'information programme
      ///copy qcpysrc,psds

      // Définition de l'Interface de la procédure
      // Paramètres d'appel
      // Procedure-Interface definition
      // dcl-pi programme;
      //   paramentre char(5);
      //   paramsortie packed(9:6);
      // END-Pi;

        // local functions prototypes
        // prototypes fonctions locales
        // dcl-pr sous_proc1 ind;
        //   donnees2 char(150);
        // end-pr;

        // Indicateurs
        // dcl-s g_indic1 ind;

        // Touches de fonction
        ///copy qcpysrc,fonction

        // Local data-structures
        // structures de données locales
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
        // Procédure principale

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

