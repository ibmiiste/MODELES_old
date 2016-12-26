000100160929     H debug decedit('0,') datedit(*dmy.)
000200160929      //****************************************************
000300160929      //                                                   *
000400160929      // Le compteur double                                *
000500160929      //                                                   *
000600160929      //****************************************************
000700160929     Ffcp01l    uf a e           k disk
000800160929
000900160929      * main function prototype
001000160929      * prototype fonction principale
001100160929     dP_pgmc01         PR                  extpgm('PGMC01')
001200160929     d pcod                                like(r_cod)
001300160929     d pcpt                                like(r_cpt)
001400160929     d pcp1                                like(r_cp6num)
001500160929     d pcp2                                like(r_cp10num)
001600160929
001700160929     dP_pgmc01         PI
001800160929     d pcod                                like(r_cod)
001900160929     d pcpt                                like(r_cpt)
002000160929     d pcp1                                like(r_cp6num)
002100160929     d pcp2                                like(r_cp10num)
002200160929      * external functions prototypes
002300160929      * prototype fonctions externes
002400160929
002500160929      * program status data structure
002600160929      * structure information programme
002700160929
002800160929     d/copy qcpysrc,psds
002900160929      * local functions prototypes
003000160929      * prototypes fonctions locales
003100160929
003200160929      * global variables
003300160929      * variables globales
003400160929
003500160929      * inherited variables
003600160929      * héritage des types
003700160929     d/copy QINHLESRC,INH32766
003800160929
003900160929      * constants
004000160929      * constantes
004100160929
004200160929
004300160929      * main function
004400160929      * fonction principale
004500160929
004600160929      // Incremente le compteur souhaité
004700160929      /FREE
004800160929       chain(E) pcod fcpf;
004900160929       // le début
005000160929       // au cas ou il serait utilisé ailleurs
005100160929       dow %error;
005200160929         chain(E) pcod fcpf;
005300160929
005400160929         // on boucle
005500160929       enddo;
005600160929       if not %error and %found;
005700160929         // le compteur existe
005800160929         if pcpt = '1';
005900160929           // on veut le compteur 1
006000160929           cpcp1+=1;
006100160929         else;
006200160929           // c'est le compteur 2
006300160929           cpcp2+=1;
006400160929         endif;
006500160929         cpdam=%date();
006600160929         cphem=%time();
006700160929         cpusm=user;
006800160929         update fcpf;
006900160929       else;
007000160929         // il y a un risque, c'est qu'un autre essaie de créer le même !!
007100160929         cpcod=pcod;
007200160929         if pcpt = '1';
007300160929           // on veut le compteur 1
007400160929            cpcp1=1;
007500160929            cpcp2=0;
007600160929         else;
007700160929           // c'est le compteur 2
007800160929            cpcp1=0;
007900160929            cpcp2=1;
008000160929         endif;
008100160929         cpdac=%date();
008200160929         cphec=%time();
008300160929         cpusc=user;
008400160929         cpdam=%date();
008500160929         cphem=%time();
008600160929         cpusm=user;
008700160929         write fcpf;
008800160929       endif;
008900160929         // et on retourne les valeurs
009000160929         pcp1=cpcp1;
009100160929         pcp2=cpcp2;
009200160929        // c'est fini il faut mettre LR   *ON
009300160929       *inlr = *on;
009400160929      /END-FREE
