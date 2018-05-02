      //=================================================================*
      // MODULE NAME:    TRANSSVC (Transaction Services)
      // RELATED FILES:  N/A
      // RELATED SOURCE: TRANSRPT
      // EXPORTED PROCEDURES:  Trans_Inc  -- calculates the income
      //     for the transaction using the data in the fields in the
      //     parameter list.  It returns to the caller after all
      //     the calculations are done.
      //
      //     Prod_Name --  retrieves the product name based on the
      //     input parameter with the product number.
      //=================================================================*
      // This module contains only subprocedures; it is a NOMAIN module.
       ctl-opt nomain;
      //------------------------------------------------------------------
      // Pull in the prototypes from the /COPY member
      //------------------------------------------------------------------
      /COPY TRANSP
      //------------------------------------------------------------------
      // Subprocedure Trans_Inc
      //------------------------------------------------------------------
       dcl-proc Trans_Inc export;
       dcl-pi Trans_Inc packed(11: 2);
        ProdNum packed(10) value;
        Quantity packed(5) value;
        Discount packed(2: 2) value;
       end-pi;
       dcl-s Factor packed(5);
      //
      /FREE
       SELECT;
       WHEN ProdNum = 1;
         Factor = 1500;
       WHEN ProdNum = 2;
         Factor = 3500;
       WHEN ProdNum = 5;
         Factor = 20000;
       WHEN ProdNum = 8;
         Factor = 32000;
       WHEN ProdNum = 12;
         Factor = 64000;
       OTHER;
         Factor = 0;
       ENDSL;
       RETURN Factor * Quantity * (1 - Discount);
      /END-FREE
       end-proc;
      //------------------------------------------------------------------
      // Subprocedure Prod_Name
      //------------------------------------------------------------------
       dcl-proc Prod_Name export;
       dcl-pi Prod_Name char(40);
        ProdNum packed(10) value;
       end-pi;
      //
      /FREE
       SELECT;
       WHEN ProdNum = 1;
         RETURN 'Large';
       WHEN ProdNum = 2;
         RETURN 'Super';
       WHEN ProdNum = 5;
         RETURN 'Super Large';
       WHEN ProdNum = 8;
         RETURN 'Super Jumbo';
       WHEN ProdNum = 12;
         RETURN 'Incredibly Large Super Jumbo';
       OTHER;
         RETURN '***Unknown***';
       ENDSL;
      /END-FREE
       end-proc;
