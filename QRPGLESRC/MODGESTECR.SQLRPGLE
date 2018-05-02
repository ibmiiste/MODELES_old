000100180502       //--------------------------------------------------------------------------------------Files
000200180502       Dcl-f Customers Usage(*Update:*Output:*Delete) Keyed;
000300180502       Dcl-f Custmntd Workstn Indds(Indicators);
000400180502       //------------------------------------------------------------------Indicators data structure
000500180502       Dcl-ds Indicators Len(99);
000600180502         Exit     Ind Pos(3);
000700180502         F10key   Ind Pos(10);
000800180502         Cancel   Ind Pos(12);
000900180502         Fkey     Ind Pos(25);
001000180502         Adderror Ind Pos(30);
001100180502         Chgerror Ind Pos(31);
001200180502         Dlterror Ind Pos(32);
001300180502         Addmode  Ind Pos(40);
001400180502         Chgmode  Ind Pos(41);
001500180502         Dltmode  Ind Pos(42);
001600180502       End-Ds;
001700180502
001800180502       //----------------------------------------------------------------------------Main procedure
001900180502       Dow not Exit;
002000180502         Exfmt Custsel:
002100180502
002200180502         Select;
002300180502           When Exit;
002400180502             Leave;
002500180502           When Action = 'A';
002600180502             Addrecord();
002700180502           When Action = 'B';
002800180502             Chgrecord();
002900180502           When Action = 'D';
003000180502             Dltrecord();
003100180502         EndSl;
003200180502
003300180502       EndDo;
003400180502
003500180502       *Inlr = *On;
003600180502       Return;
003700180502
003800180502
003900180502       //----------------------------------------------------------------------------------Addrecord
004000180502       Dcl-proc Addrecord;
004100180502         Setmode();
004200180502         Chain Custno Custumers;
004300180502
004400180502       End-Proc;
004500180502
004600180502
004700180502
