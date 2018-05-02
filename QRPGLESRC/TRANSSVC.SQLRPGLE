000100180502      //=================================================================*
000200180502      // MODULE NAME:    TRANSSVC (Transaction Services)
000300180502      // RELATED FILES:  N/A
000400180502      // RELATED SOURCE: TRANSRPT
000500180502      // EXPORTED PROCEDURES:  Trans_Inc  -- calculates the income
000600180502      //     for the transaction using the data in the fields in the
000700180502      //     parameter list.  It returns to the caller after all
000800180502      //     the calculations are done.
000900180502      //
001000180502      //     Prod_Name --  retrieves the product name based on the
001100180502      //     input parameter with the product number.
001200180502      //=================================================================*
001300180502      // This module contains only subprocedures; it is a NOMAIN module.
001400180502       ctl-opt nomain;
001500180502      //------------------------------------------------------------------
001600180502      // Pull in the prototypes from the /COPY member
001700180502      //------------------------------------------------------------------
001800180502      /COPY TRANSP
001900180502      //------------------------------------------------------------------
002000180502      // Subprocedure Trans_Inc
002100180502      //------------------------------------------------------------------
002200180502       dcl-proc Trans_Inc export;
002300180502       dcl-pi Trans_Inc packed(11: 2);
002400180502        ProdNum packed(10) value;
002500180502        Quantity packed(5) value;
002600180502        Discount packed(2: 2) value;
002700180502       end-pi;
002800180502       dcl-s Factor packed(5);
002900180502      //
003000180502      /FREE
003100180502       SELECT;
003200180502       WHEN ProdNum = 1;
003300180502         Factor = 1500;
003400180502       WHEN ProdNum = 2;
003500180502         Factor = 3500;
003600180502       WHEN ProdNum = 5;
003700180502         Factor = 20000;
003800180502       WHEN ProdNum = 8;
003900180502         Factor = 32000;
004000180502       WHEN ProdNum = 12;
004100180502         Factor = 64000;
004200180502       OTHER;
004300180502         Factor = 0;
004400180502       ENDSL;
004500180502       RETURN Factor * Quantity * (1 - Discount);
004600180502      /END-FREE
004700180502       end-proc;
004800180502      //------------------------------------------------------------------
004900180502      // Subprocedure Prod_Name
005000180502      //------------------------------------------------------------------
005100180502       dcl-proc Prod_Name export;
005200180502       dcl-pi Prod_Name char(40);
005300180502        ProdNum packed(10) value;
005400180502       end-pi;
005500180502      //
005600180502      /FREE
005700180502       SELECT;
005800180502       WHEN ProdNum = 1;
005900180502         RETURN 'Large';
006000180502       WHEN ProdNum = 2;
006100180502         RETURN 'Super';
006200180502       WHEN ProdNum = 5;
006300180502         RETURN 'Super Large';
006400180502       WHEN ProdNum = 8;
006500180502         RETURN 'Super Jumbo';
006600180502       WHEN ProdNum = 12;
006700180502         RETURN 'Incredibly Large Super Jumbo';
006800180502       OTHER;
006900180502         RETURN '***Unknown***';
007000180502       ENDSL;
007100180502      /END-FREE
007200180502       end-proc;
