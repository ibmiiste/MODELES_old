       //--------------------------------------------------------------------------------------Files
       Dcl-f Customers Usage(*Update:*Output:*Delete) Keyed;
       Dcl-f Custmntd Workstn Indds(Indicators);
       //------------------------------------------------------------------Indicators data structure
       Dcl-ds Indicators Len(99);
         Exit     Ind Pos(3);
         F10key   Ind Pos(10);
         Cancel   Ind Pos(12);
         Fkey     Ind Pos(25);
         Adderror Ind Pos(30);
         Chgerror Ind Pos(31);
         Dlterror Ind Pos(32);
         Addmode  Ind Pos(40);
         Chgmode  Ind Pos(41);
         Dltmode  Ind Pos(42);
       End-Ds;

       //----------------------------------------------------------------------------Main procedure
       Dow not Exit;
         Exfmt Custsel:

         Select;
           When Exit;
             Leave;
           When Action = 'A';
             Addrecord();
           When Action = 'B';
             Chgrecord();
           When Action = 'D';
             Dltrecord();
         EndSl;

       EndDo;

       *Inlr = *On;
       Return;


       //----------------------------------------------------------------------------------Addrecord
       Dcl-proc Addrecord;
         Setmode();
         Chain Custno Custumers;

       End-Proc;



