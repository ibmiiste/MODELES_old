       Dcl-F Customers Keyed;
       Dcl-F Custinqd  Workstn Indds(Indicators);

       Dcl-Ds Indicators Len(99);
         Exit   Ind Pos(03);
         Cancel Ind Pos(12);
       END-DS;

         Dow Not Exit;
           Exfmt Custsel;
           If Not Exit;
             Chain Custno Customers;
             If %Found(Customers);
               Exfmt Custinq;
             ENDIF;
           ENDIF;
         ENDDO;

       *Inlr = *On;

       Return;
