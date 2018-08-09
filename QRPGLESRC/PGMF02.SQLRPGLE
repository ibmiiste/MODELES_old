       /Copy Qcpysrc,cpyctlstm
      //****************************************************
      //                                                   *
      // Détail personnel                                  *
      //                                                   *
      //****************************************************
      * >>PRE-COMPILER<<
      *   >>CRTCMD<<  CRTSQLRPGI SRCFILE(&SL/&SF) SRCMBR(&SM);
      *   >>IMPORTANT<<
      *     >>PARM<<  OBJ(&LI/&OB);
      *     >>PARM<<  OBJTYPE(*PGM);
      *     >>PARM<<  OPTION(*EVENTF);
      *     >>PARM<<  RPGPPOPT(*LVL2);
      *     >>PARM<<  CLOSQLCSR(*ENDACTGRP);
      *     >>PARM<<  DATFMT(*ISO);
      *     >>PARM<<  TIMFMT(*ISO);
      *   >>END-IMPORTANT<<
      *   >>EXECUTE<<
      * >>END-PRE-COMPILER<<

       dcl-f PGMF02FM workstn infds(PGM02FM_INFDS) Indds(IndDs);


       // External procedure Prototypes
       // Programme gérant les compteurs
       Dcl-pr compteur_double Extpgm('PGMC01');
         PCOD Char(3);
         PCPT Char(1);
         PCP1 Char(6);
         PMAT Char(10);
       End-Pr;

       // Programme de gestion des messages et du sous-fichier de message
       Dcl-pr Gestion_message Extpgm('PGM001CL');
         PTYP Char(1);
         PFICM Char(10);
         PMGID Char(7);
         PMGDT Char(99);
       End-pr;

       // Programme d'invite des fonctions
       Dcl-pr Invite_fonction Extpgm('PGMI01');
         PACT Char(2);
         PGFCT Char(2);
       End-pr;

       dcl-c WTXT1 '         Modification         ';
       dcl-c WTXT2 '             Copie            ';
       dcl-c WTXT3 '         Suppression          ';
       dcl-c WTXT4 '           Affichage          ';
       dcl-c WTXT5 '           Création           ';
       dcl-c WTXT6 '        Fin de contrat        ';
       dcl-s WDAT char(8);
       dcl-s WHEU char(6);
       dcl-s W14 packed(14);
       dcl-s WNREC packed(10);
       dcl-s PACT char(2);
       dcl-s PGFCT char(3);

       // Indicateurs utilisés dans le programme
       Dcl-s g_Confirmation_suppression Ind;
       Dcl-s g_Anomalie Ind;
       Dcl-s g_Fin_traitement Ind;
       Dcl-s g_Traitement_donnees Ind;

       //Constante SQLCODE
       Dcl-c c_trouve 0;
       Dcl-c c_non_trouve 100;


       // Paramètres appel programme compteur double
       Dcl-s PCOD Char(3);
       Dcl-s PCPT Char(1);
       Dcl-s PCP1 Char(6);
       Dcl-s PMAT Char(10);

       // Paramètres d'appel du programme de gestion des messages
       Dcl-s PTYP Char(1);
       Dcl-s PFICM Char(10);
       Dcl-s PMGID Char(7);
       Dcl-s PMGDT Char(99);

       // Copy de déclaration de la PROGRAM STATUS DATA STRUCTURE
       /Copy Qcpysrc,Psds

       // Héritage de la data structure info fichier
       /Copy Qcpysrc,Cpy_infds

       // Data structure du fichier PGM02FM
       Dcl-ds PGM02FM_INFDS likeDS(FichierDS);

       // Le DS des indicateurs de l'écran
       Dcl-ds IndDs;
         Code_PR_UL Ind Pos(14);
         Nom_PR_UL Ind Pos(15);
         PR_UL Ind Pos(16);
         Date_entree_PR_UL Ind Pos(17);
         Date_depart_PR_UL Ind Pos(18);
         Sflinz_Msgf Ind Pos(10);
         Sflend_Msgf Ind Pos(09);
       End-ds;

       // DS table du personnel
       Dcl-ds DS_FIC00P Extname('FIC00P') End-ds;

       // DS table des fonction
       Dcl-ds DS_FIF00P Extname('FIF00P') End-ds;

       Dcl-pi Personnal_detail Extpgm('PGMF02');
         Pchx Char(2);
         Pnrec Char(10);
       End-Pi;

       // --------------------------------------------------
       // Prototype for procedure: Lecture_FIC00P
       // --------------------------------------------------
       DCL-PR Lecture_FIC00P LIKE(sqlcode);
         l_nrec PACKED(10:0);
       END-PR ;

       // --------------------------------------------------
       // Prototype for procedure: Lecture_FIC00P_MAT
       // --------------------------------------------------
       DCL-PR Lecture_FIC00P_MAT LIKE(sqlcode);
         l_Mat PACKED(10:0);
       END-PR ;

       // --------------------------------------------------
       // Prototype for procedure: Lecture_FIF00P
       // --------------------------------------------------
       DCL-PR Lecture_FIF00P LIKE(sqlcode);
         l_fifon CHAR(3);
       END-PR ;


      // début du programme
       ZPGM=PROCEDURE;
       ZDATE=%DATE();
       ZHEUR=%TIME();
       ZUSER=USER;
       ZJOB=JOB_NAME;
       WPGMQ='*  ';
       WMGKEY='CC01';

       Sflend_Msgf = *ON;
       Sflinz_Msgf = *ON;
       Code_PR_UL = *ON;
       Nom_PR_UL = *ON;
       PR_UL = *ON;
       Date_entree_PR_UL = *ON;
       Date_depart_PR_UL = *ON;
       g_Confirmation_suppression = *OFF;
       g_Anomalie = *OFF;
       // constantes pour ce programme
       PTYP='1';
       PFICM='FICMSG    ';

       SELECT;
       WHEN (PCHX = 'MO');
         // modification
         ZMODE=WTXT1;
      // on ne peut modifier que ces zones
         Code_PR_UL = *OFF;
         Nom_PR_UL = *OFF;
         PR_UL = *OFF;
       WHEN (PCHX = 'CO');
         // copie
         ZMODE=WTXT2;
       // toutes les zones sont autorisées
         Code_PR_UL = *OFF;
         Nom_PR_UL = *OFF;
         PR_UL = *OFF;
         Date_entree_PR_UL = *OFF;
         Date_depart_PR_UL = *OFF;
       WHEN (PCHX = 'SU');
         // suppression
         ZMODE=WTXT3;
       // aucune zone n'est saisisable
       WHEN (PCHX = 'AF');
         // affichage
         ZMODE=WTXT4;
      // aucune zone n'est saisisable
       WHEN (PCHX = 'CR');
         // création
         ZMODE=WTXT5;
      // tout est saisisable sauf date de sortie
         Code_PR_UL = *OFF;
         Nom_PR_UL = *OFF;
         PR_UL = *OFF;
         Date_entree_PR_UL = *OFF;
       WHEN (PCHX = 'PE');
         // direction Ple Emploi
         ZMODE=WTXT6;
         // on saisit simplement la date de fin
         Date_depart_PR_UL = *OFF;
       ENDSL;
       // Initialisation de l'écran si on un numéro d'enregistrement
       IF PNREC <> *BLANK;
         WNREC=%Dec(PNREC:10:0);
         sqlcode=Lecture_Fic00p(Wnrec);

         IF PCHX = 'CR' OR PCHX = 'CO';
           // en création ou copie zone non renseignée
           ZMATR=0;
         ELSE;
           ZMATR=FIMAT;
         ENDIF;

         ZFCOD=FIFON;
      // fichier des fonctions => libellé
         SQlcode=Lecture_FIF00P(Zfcod);

         ZFLIB=MILIB;
         ZNOM=FINOM ;
         ZPR1=FIPR1;
         ZPR2=FIPR2;
         ZAD1=FIAD1;
         ZAD2=FIAD2;
         ZAD3=FIAD3;
         ZCPO=FICPO;
         ZVIL=FIVIL;
         ZTEL=FITEL;
         ZPOR=FIPOR;
         ZDAE=FIDAE;

        IF PCHX = 'PE';
          ZDATE=ZDAS;
        ELSE;
          ZDAS=FIDAS;
        ENDIF;
        // zones d'audit
        ZDAC=FIDAC;
        ZHEC=FIHEC;
        ZUSC=FIUSC;
        ZDAM=FIDAM;
        ZHEM=FIHEM;
        ZUSM=FIUSM;
       ELSE;
         // pas grand chose, la date du jour
         ZDAE=%Date();
       ENDIF;
       // Boucle d'attente de fin
       g_Fin_traitement = *ON;
       DOW g_Fin_traitement = '1';
         EXSR TRTSCR;
       ENDDO;
       //
       *INLR = *ON;
       // Les procédures
       BEGSR TRTSCR;
         WRITE WMGCTL;
         // On écrit l'écran
         WRITE FORE1;
         // On attend l'appui sur une touche
         READ FORE1;
         *IN70 = %EOF;
         g_Traitement_donnees = *ON;
         // F3 ou F12 on termine
         IF *INKC = '1' OR
               *INKL = '1';
           g_Fin_traitement = *OFF;
           g_Traitement_donnees = *OFF;
         ENDIF;
         // on met à jour l'heure
         If g_Traitement_donnees;
           ZHEUR=%Time();
           If *Inkd;
             IF WZOCUR = 'ZFCOD';
               PACT = 'GS';
             Endif;
             Invite_fonction( PACT
                             :PGFCT);
             IF PGFCT <> *BLANK;

               ZFCOD =PGFCT;

             ENDIF;
           ENDIF;
           g_Traitement_donnees = *OFF;
         ENDIF;

         //
         IF PCHX = 'SU';
           g_Traitement_donnees = *OFF;
           IF g_Confirmation_suppression = '1';
             IF *INKP = '1';
               // touche F15 on supprime si indicateur l_Confirmation_suppression
               Sqlcode=Lecture_FIC00P(Wnrec);
               If Sqlcode=c_trouve;
                 EXEC SQL DELETE fic00p
                           WHERE RRN( fic00p) = :wnrec;
               endif;
               g_Fin_traitement = *OFF;
               g_Traitement_donnees = *OFF;
             ENDIF;
           ELSE;
             PMGID='MSG0004';
             PMGDT=*BLANK;
             EXSR ENVMSG;
             g_Confirmation_suppression = *ON;
           ENDIF;
         ENDIF;
         // contrle des données saisies
         IF g_Traitement_donnees = '1';
           EXSR CTLDTA;
           IF g_Anomalie = '1';
             // anomalie
             EXSR ENVMSG;
             g_Anomalie = *OFF;
           ELSE;
             // confirmation  pour suppression
             EXSR VALID1;
           ENDIF;
         ENDIF;
       ENDSR;
       // controle des données/si suppression demande de confirmation
       BEGSR CTLDTA;
         g_Anomalie=*Off;
         // on vérifie que tout est bon
         IF PCHX = 'SU';
           // on demande confirmation
         ELSE;
           // vérification du code fonction
           SQlcode=Lecture_FIF00P(Zfcod);

           IF Sqlcode=c_Non_trouve;
             g_Anomalie=*Off;
             PMGID='MSG0003' ;
             PMGDT = '&1'+ ZFCOD;
             g_Anomalie=*Off;
           ENDIF;
         ENDIF;
       ENDSR;
       //** Création suppression et MJ selon le cas
       BEGSR VALID1;
         IF PCHX = 'SU';
           // La suppression se fait par la touche F15
         ELSE;
           SQlcode=Lecture_FIC00P_MAT(ZMATR);

           IF PCHX = 'CR' OR PCHX = 'CO';
             // On ne crée le matricule qu'en copie ou création
             PCOD='MAT';
             PCPT='2';
             compteur_double( PCOD
                             :PCPT
                             :PCP1
                             :PMAT);
             FIMAT=%Int(PMAT);
             *IN71 = *ON;
           ENDIF;

           FIFON=ZFCOD;
           FINOM=ZNOM;
           FIPR1=ZPR1;
           FIPR2=ZPR2;
           FIAD1=ZAD1;
           FIAD2=ZAD2;
           FIAD3=ZAD3;
           FICPO=ZCPO;
           FIVIL=ZVIL;
           FITEL=ZTEL;
           FIPOR=ZPOR;
           // traitement des dates
           FIDAE=ZDAE;

           FIDAS=ZDAS;

          // zones d'audit
          FIDAM=%Date();
          FIHEM=%Time();
          FIUSM=USER;
          IF *IN71 = '0';
            // on met  jour directement
            EXEC SQL UPDATE fic00p
                        SET fifon=:fifon,
                            finom=:finom,
                            fipr1=:fipr1,
                            fipr2=:fipr2,
                            fiad1=:fiad1,
                            fiad2=:fiad2,
                            fiad3=:fiad3,
                            ficpo=:ficpo,
                            fivil=:fivil,
                            fitel=:fitel,
                            fipor=:fipor,
                            fidae=:fidae,
                            fidas=:fidas,
                            fidam=:fidam,
                            fihem=:fihem,
                            fiusm=:fiusm
                      WHERE fimat=:zmatr;
          ELSE;
             // création
            FIDAC=%Date();
            FIHEC=%Time();
            FIUSC=USER;
            EXEC SQL INSERT INTO fic00p
                          ( fifon,
                            finom,
                            fipr1,
                            fipr2,
                            fiad1,
                            fiad2,
                            fiad3,
                            ficpo,
                            fivil,
                            fitel,
                            fipor,
                            fidae,
                            fidas,
                            fidam,
                            fihem,
                            fiusm,
                            fidac,
                            fihec,
                            fiusc)
                    VALUES( :fifon,
                            :finom,
                            :fipr1,
                            :fipr2,
                            :fiad1,
                            :fiad2,
                            :fiad3,
                            :ficpo,
                            :fivil,
                            :fitel,
                            :fipor,
                            :fidae,
                            :fidas,
                            :fidam,
                            :fihem,
                            :fiusm,
                            :fidac,
                            :fihec,
                            :fiusc);
           endif;
         ENDIF;
         g_Fin_traitement = *OFF;
       ENDSR;

       //****Envoi d'un message programme
       BEGSR ENVMSG;
         Gestion_message( PTYP
                         :PFICM
                         :PMGID
                         :PMGDT);
       ENDSR;


       // --------------------------------------------------
       // Procedure name: Lecture_FIC00P
       // Purpose:        Lecture d'un enregistrement de FIC00P avec comme cl...
       //                          ef le numéro relatif d'enregistrement
       // Returns:
       // Parameter:      l_nrec => Numréro relatif d'enregistrement
       // --------------------------------------------------
       DCL-PROC Lecture_FIC00P ;
         DCL-PI *N LIKE(sqlcode);
           l_nrec PACKED(10:0);
         END-PI ;
         // Your local fields go here

         DCL-S retField LIKE(sqlcode);
         // Your calculation code goes here
         EXEC SQL SELECT fimat,
                         fifon,
                         finom,
                         fipr1,
                         fipr2,
                         fiad1,
                         fiad2,
                         fiad3,
                         ficpo,
                         fivil,
                         fitel,
                         fipor,
                         fidae,
                         fidas,
                         fidac,
                         fihec,
                         fiusc,
                         fidam,
                         fihem,
                         fiusm
                    INTO :fimat,
                         :fifon,
                         :finom,
                         :fipr1,
                         :fipr2,
                         :fiad1,
                         :fiad2,
                         :fiad3,
                         :ficpo,
                         :fivil,
                         :fitel,
                         :fipor,
                         :fidae,
                         :fidas,
                         :fidac,
                         :fihec,
                         :fiusc,
                         :fidam,
                         :fihem,
                         :fiusm
                     FROM fic00p
                    WHERE RRN( fic00p ) = :l_nrec;

         retField=sqlcode;

         return retField ;
       END-PROC ;

       // --------------------------------------------------
       // Procedure name: Lecture_FIC00P
       // Purpose:        Lecture d'un enregistrement de FIC00P avec comme cl...
       //                          ef le numéro de matricule
       // Returns:
       // Parameter:      l_nrec => Numréro relatif d'enregistrement
       // --------------------------------------------------
       DCL-PROC Lecture_FIC00P_MAT ;
         DCL-PI *N LIKE(sqlcode);
           l_MAT PACKED(10:0);
         END-PI ;
         // Your local fields go here

         DCL-S retField LIKE(sqlcode);
         // Your calculation code goes here
         EXEC SQL SELECT fimat,
                         fifon,
                         finom,
                         fipr1,
                         fipr2,
                         fiad1,
                         fiad2,
                         fiad3,
                         ficpo,
                         fivil,
                         fitel,
                         fipor,
                         fidae,
                         fidas,
                         fidac,
                         fihec,
                         fiusc,
                         fidam,
                         fihem,
                         fiusm
                    INTO :fimat,
                         :fifon,
                         :finom,
                         :fipr1,
                         :fipr2,
                         :fiad1,
                         :fiad2,
                         :fiad3,
                         :ficpo,
                         :fivil,
                         :fitel,
                         :fipor,
                         :fidae,
                         :fidas,
                         :fidac,
                         :fihec,
                         :fiusc,
                         :fidam,
                         :fihem,
                         :fiusm
                     FROM fic00p
                    WHERE fimat = :l_mat;

         retField=sqlcode;

         return retField ;
       END-PROC ;


       // --------------------------------------------------
       // Procedure name: Lecture_FIF00P
       // Purpose:        Lecture d'un enregistrement de FIF00P avec la clé FIFON
       // Returns:
       // Parameter:      l_fifon => Fonction
       // --------------------------------------------------
       DCL-PROC Lecture_FIF00P ;
         DCL-PI *N LIKE(sqlcode);
           l_fifon CHAR(3);
         END-PI ;
         // Your local fields go here

         DCL-S retField LIKE(sqlcode);
         // Your calculation code goes here
         EXEC SQL SELECT mifon,
                         milib,
                         mitsc,
                         miusc,
                         mitsm,
                         miusm
                    INTO :mifon,
                         :milib,
                         :mitsc,
                         :miusc,
                         :mitsm,
                         :miusm
                     FROM fif00p
                    WHERE mifon = :l_fifon;

         Retfield=Sqlcode;
         return retField ;

       END-PROC ;

