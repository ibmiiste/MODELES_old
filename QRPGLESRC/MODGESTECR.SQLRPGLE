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

       // --------------------------------------------------
       // Prototype for procedure: Addrecord
       // --------------------------------------------------
       DCL-PR Addrecord ;
       END-PR ;


       // --------------------------------------------------
       // Prototype for procedure: Chgrecord
       // --------------------------------------------------
       DCL-PR Chgrecord ;
       END-PR ;


       //----------------------------------------------------------------------------Main procedure
       Dow not Exit;
         Exfmt Custsel;

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


       // --------------------------------------------------
       // Procedure name: Addrecord
       // Purpose:        Add a customer record
       // Returns:
       // --------------------------------------------------
       DCL-PROC Addrecord ;
       Dcl-pi Addrecord End-pi;
         Dcl-ds Ds_Customers Extname('CUSTOMERS') Qualified End-ds;

         Setmode();
         EXEC SQL
           SELECT Custno,
                  Cfname,
                  Clname,
                  Caddr,
                  Czip,
                  Cphonet,
                  Cemail,
                  Cdobl,
                  Cgender
             INTO Ds_Customers.Custno,
                  Ds_Customers.Cfname,
                  Ds_Customers.Clname,
                  Ds_Customers.Caddr,
                  Ds_Customers.Czip,
                  Ds_Customers.Cphonet,
                  Ds_Customers.Cemail,
                  Ds_Customers.Cdobl,
                  Ds_Customers.Cgender
             FROM Customers
             WHERE Custno = :Custno;

         Adderror = Sqlcode = 0;

         If Not Adderror;
           Resetdata();
           Custmnt();

           If Not Fkey;
             Insert into Custrec ;

             Reset Action;
             Reset Custno;
           EndIf;

         EndIf;

         Return;

       End-Proc;

       // --------------------------------------------------
       // Procedure name: Chgrecord
       // Purpose:        Change a customer record
       // Returns:
       // --------------------------------------------------
       DCL-PROC Chgrecord ;

         Setmode();

         EXEC SQL
           SELECT Custno,
                  Cfname,
                  Clname,
                  Caddr,
                  Czip,
                  Cphonet,
                  Cemail,
                  Cdobl,
                  Cgender
             INTO Ds_Customers.Custno,
                  Ds_Customers.Cfname,
                  Ds_Customers.Clname,
                  Ds_Customers.Caddr,
                  Ds_Customers.Czip,
                  Ds_Customers.Cphonet,
                  Ds_Customers.Cemail,
                  Ds_Customers.Cdobl,
                  Ds_Customers.Cgender
             FROM Customers
             WHERE Custno = :Custno;

             Chgerror = Sqlcode = 100;

             If Not Chgerror;
               Exfmt Custmnt;

               If Not Fkey;

               EndIf;
             EndIf;
         return ;
       END-PROC ;

