**FREE
// Option de compilation et de programme
 /Copy Qcpysrc,Cpyctlstm


// D�claration des fichiers
// dcl-f fichier disk;

// Main procedure prototype
// Prototype Proc�dure principale
// dcl-pr programme extpgm('PGM');
//   paramentre char(5);
//   paramsortie packed(9:6);
// END-PR;

// External subprocedures prototypes globales
// prototype sous-proc�dures externes
// dcl-pr proc_ext varchar(300) extproc('PROC_EXT1');
//   donnees1 packed(10:0);
// end-pr;

// Internal subprocedures prototypes globales
// Prototype sous-proc�dures internes globales
// dcl-pr proc_int varchar(150);
//   donnees1 packed(10:0);
// end-pr;

// Global data-structures
// Structures de donn�es globales
// Indicateurs renomm�s avec Indara et INDDS
// dcl-ds ds1;
//   donneeds1 like(r_ref4);
//   donneeds2 like(r_ref5);
// end-ds;

// global variables
// variables globales
// Dcl-s g_Donnee3 like(r_ref3);

// Program status data structure
// Data Structure d'information programme
///copy qcpysrc,psds

// D�finition de l'Interface de la proc�dure
// Param�tres d'appel
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
  // structures de donn�es locales
  // Indicateurs renomm�s avec Indara et INDDS
  // dcl-ds ds1;
  //   donneeds1 like(r_ref4);
  //   donneeds2 like(r_ref5);
  // end-ds;

  // Local variables
  // variables locales
  // Dcl-s l_Donnee4 like(r_ref4);

  // inherited variables
  // h�ritage des types
  ///copy QINHLESRC,INH32766

  // constants
  // constantes
  // dcl-c constante1 'CONSTANTE';

  // main function
  // Proc�dure principale

  // indicateur de fin de programme
  *inlr = *on;
   monitor;

  on-error;
    dump(a);
    gest_erreur();
  endmon;


  // les sous-routines
  // traitement de l'�cran
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
     // Donn�es locales
// DCL-S l_donnee1 like(r_ref6);
     // Programmation


// END-PROC ;
