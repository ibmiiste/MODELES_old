      *=================================================================*
      * MODULE NAME:    TRANSSVC (Transaction Services)
      * RELATED FILES:  N/A
      * RELATED SOURCE: TRANSRPT
      * EXPORTED PROCEDURES:  Trans_Inc  -- calculates the income
      *     for the transaction using the data in the fields in the
      *     parameter list.  It returns to the caller after all
      *     the calculations are done.
      *
      *     Prod_Name --  retrieves the product name based on the
      *     input parameter with the product number.
      *=================================================================*
      * This module contains only subprocedures; it is a NOMAIN module.
       ctl-opt nomain;
      *------------------------------------------------------------------
      * Pull in the prototypes from the /COPY member
      *------------------------------------------------------------------
      /COPY TRANSP
      *------------------------------------------------------------------
      * Subprocedure Trans_Inc
      *------------------------------------------------------------------
       dcl-proc Trans_Inc export;
       dcl-pi Trans_Inc packed(11: 2);
        ProdNum packed(10) value;
        Quantity packed(5) value;
        Discount packed(2: 2) value;
       end-pi;
       dcl-s Factor packed(5);
      *
     C                   SELECT
     C                   WHEN      ProdNum = 1
     C                   EVAL      Factor = 1500
     C                   WHEN      ProdNum = 2
     C                   EVAL      Factor = 3500
     C                   WHEN      ProdNum = 5
     C                   EVAL      Factor = 20000
     C                   WHEN      ProdNum = 8
     C                   EVAL      Factor = 32000
     C                   WHEN      ProdNum = 12
     C                   EVAL      Factor = 64000
     C                   OTHER
     C                   EVAL      Factor = 0
     C                   ENDSL
     C                   RETURN    Factor * Quantity * (1 - Discount)
       end-proc;
      *------------------------------------------------------------------
      * Subprocedure Prod_Name
      *------------------------------------------------------------------
       dcl-proc Prod_Name export;
       dcl-pi Prod_Name char(40);
        ProdNum packed(10) value;
       end-pi;
      *
     C                   SELECT
     C                   WHEN      ProdNum = 1
     C                   RETURN    'Large'
     C                   WHEN      ProdNum = 2
     C                   RETURN    'Super'
     C                   WHEN      ProdNum = 5
     C                   RETURN    'Super Large'
     C                   WHEN      ProdNum = 8
     C                   RETURN    'Super Jumbo'
     C                   WHEN      ProdNum = 12
     C                   RETURN    'Incredibly Large Super Jumbo'
     C                   OTHER
     C                   RETURN    '***Unknown***'
     C                   ENDSL
       end-proc;
