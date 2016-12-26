     H debug decedit('0,') datedit(*dmy.)
      //****************************************************
      //                                                   *
      // Le compteur double                                *
      //                                                   *
      //****************************************************
     Ffcp01l    uf a e           k disk

      * main function prototype
      * prototype fonction principale
     dP_pgmc01         PR                  extpgm('PGMC01')
     d pcod                                like(r_cod)
     d pcpt                                like(r_cpt)
     d pcp1                                like(r_cp6num)
     d pcp2                                like(r_cp10num)

     dP_pgmc01         PI
     d pcod                                like(r_cod)
     d pcpt                                like(r_cpt)
     d pcp1                                like(r_cp6num)
     d pcp2                                like(r_cp10num)
      * external functions prototypes
      * prototype fonctions externes

      * program status data structure
      * structure information programme

     d/copy qcpysrc,psds
      * local functions prototypes
      * prototypes fonctions locales

      * global variables
      * variables globales

      * inherited variables
      * héritage des types
     d/copy QINHLESRC,INH32766

      * constants
      * constantes


      * main function
      * fonction principale

      // Incremente le compteur souhaité
      /FREE
       chain(E) pcod fcpf;
       // le début
       // au cas ou il serait utilisé ailleurs
       dow %error;
         chain(E) pcod fcpf;

         // on boucle
       enddo;
       if not %error and %found;
         // le compteur existe
         if pcpt = '1';
           // on veut le compteur 1
           cpcp1+=1;
         else;
           // c'est le compteur 2
           cpcp2+=1;
         endif;
         cpdam=%date();
         cphem=%time();
         cpusm=user;
         update fcpf;
       else;
         // il y a un risque, c'est qu'un autre essaie de créer le même !!
         cpcod=pcod;
         if pcpt = '1';
           // on veut le compteur 1
            cpcp1=1;
            cpcp2=0;
         else;
           // c'est le compteur 2
            cpcp1=0;
            cpcp2=1;
         endif;
         cpdac=%date();
         cphec=%time();
         cpusc=user;
         cpdam=%date();
         cphem=%time();
         cpusm=user;
         write fcpf;
       endif;
         // et on retourne les valeurs
         pcp1=cpcp1;
         pcp2=cpcp2;
        // c'est fini il faut mettre LR   *ON
       *inlr = *on;
      /END-FREE
