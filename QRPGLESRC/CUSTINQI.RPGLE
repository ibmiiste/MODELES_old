000100171208       Dcl-F Customers Keyed;
000101171208       Dcl-F Custinqd  Workstn Indds(Indicators);
000102171208
000103171208       Dcl-Ds Indicators Len(99);
000104171208         Exit   Ind Pos(03);
000105171208         Cancel Ind Pos(12);
000106171208       END-DS;
000107171208
000108171208         Dow Not Exit;
000109171208           Exfmt Custsel;
000110171208           If Not Exit;
000111171208             Chain Custno Customers;
000112171208             If %Found(Customers);
000113171208               Exfmt Custinq;
000114171208             ENDIF;
000115171208           ENDIF;
000116171208         ENDDO;
000117171208
000118171208       *Inlr = *On;
000119171208
000120171208       Return;
