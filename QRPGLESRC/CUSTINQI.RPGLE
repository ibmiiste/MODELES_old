000100180502       Dcl-F Customers Keyed;
000200180502       Dcl-F Custinqd  Workstn Indds(Indicators);
000300180502
000400180502       Dcl-Ds Indicators Len(99);
000500180502         Exit   Ind Pos(03);
000600180502         Cancel Ind Pos(12);
000700180502       END-DS;
000800180502
000900180502         Dow Not Exit;
001000180502           Exfmt Custsel;
001100180502           If Not Exit;
001200180502             Chain Custno Customers;
001300180502             If %Found(Customers);
001400180502               Exfmt Custinq;
001500180502             ENDIF;
001600180502           ENDIF;
001700180502         ENDDO;
001800180502
001900180502       *Inlr = *On;
002000180502
002100180502       Return;
