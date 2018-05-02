000100180502      //=================================================================*
000200180502      // MODULE NAME:    TRANSRPT
000300180502      // RELATED FILES:  TRNSDTA  (PF)
000400180502      // RELATED SOURCE: TRANSSVC (Transaction services)
000500180502      // EXPORTED PROCEDURE:  TRANSRPT
000600180502      //       The procedure TRANSRPT reads every tranasction record
000700180502      //       stored in the physical file TRNSDTA. It calls the
000800180502      //       subprocedure Trans_Inc which performs calculations and
000900180502      //       returns a value back.  Then it calls Prod_Name to
001000180502      //       to determine the product name.  TRANSRPT then prints
001100180502      //       the transaction record out.
001200180502      //=================================================================*
001300180502     FTRNSDTA   IP   E             DISK
001400180502       dcl-f QSYSPRT printer(80) oflind(*inof);
001500180502      /COPY QRPGLE,TRANSP
001600180502      // Define the readable version of the product name like the
001700180502      // return value of the procedure 'Prod_Name'
001800180502       dcl-s ProdName char(30);
001900180502       dcl-s Income packed(10: 2);
002000180502       dcl-s Total like(income:+5);
002100180502      //
002200180502     ITRNSREC       01
002300180502      //  Calculate the income using subprocedure Trans_Inc
002400180502
002500180502       Income = Trans_Inc(PROD : QTY : DISC);
002600180502       Total = Total + Income;
002700180502       //  Find the name of the product
002800180502       ProdName = Prod_Name(PROD);
002900180502
003000180502     OQSYSPRT   H    1P                     1
003100180502     O         OR    OF
003200180502     O                                           12 'Product name'
003300180502     O                                           40 'Quantity'
003400180502     O                                           54 'Income'
003500180502     OQSYSPRT   H    1P                     1
003600180502     O         OR    OF
003700180502     O                                           30 '----------+
003800180502     O                                              ----------+
003900180502     O                                              ----------'
004000180502     O                                           40 '--------'
004100180502     O                                           60 '------------'
004200180502     OQSYSPRT   D    01                     1
004300180502     O                       ProdName            30
004400180502     O                       QTY           1     40
004500180502     O                       Income        1     60
004600180502     OQSYSPRT   T    LR                     1
004700180502     O                                              'Total: '
004800180502     O                       Total         1
