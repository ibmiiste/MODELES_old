      //=================================================================*
      // MODULE NAME:    TRANSRPT
      // RELATED FILES:  TRNSDTA  (PF)
      // RELATED SOURCE: TRANSSVC (Transaction services)
      // EXPORTED PROCEDURE:  TRANSRPT
      //       The procedure TRANSRPT reads every tranasction record
      //       stored in the physical file TRNSDTA. It calls the
      //       subprocedure Trans_Inc which performs calculations and
      //       returns a value back.  Then it calls Prod_Name to
      //       to determine the product name.  TRANSRPT then prints
      //       the transaction record out.
      //=================================================================*
     FTRNSDTA   IP   E             DISK
       dcl-f QSYSPRT printer(80) oflind(*inof);
      /COPY QRPGLE,TRANSP
      // Define the readable version of the product name like the
      // return value of the procedure 'Prod_Name'
       dcl-s ProdName char(30);
       dcl-s Income packed(10: 2);
       dcl-s Total like(income:+5);
      //
     ITRNSREC       01
      //  Calculate the income using subprocedure Trans_Inc

       Income = Trans_Inc(PROD : QTY : DISC);
       Total = Total + Income;
       //  Find the name of the product
       ProdName = Prod_Name(PROD);

     OQSYSPRT   H    1P                     1
     O         OR    OF
     O                                           12 'Product name'
     O                                           40 'Quantity'
     O                                           54 'Income'
     OQSYSPRT   H    1P                     1
     O         OR    OF
     O                                           30 '----------+
     O                                              ----------+
     O                                              ----------'
     O                                           40 '--------'
     O                                           60 '------------'
     OQSYSPRT   D    01                     1
     O                       ProdName            30
     O                       QTY           1     40
     O                       Income        1     60
     OQSYSPRT   T    LR                     1
     O                                              'Total: '
     O                       Total         1
