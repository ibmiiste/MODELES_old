000100180502      *===============================================================*
000200180502      * MODULE NAME:    EMPRPT
000300180502      * RELATED FILES:  EMPMST   (PHYSICAL FILE)
000400180502      *                 QSYSPRT  (PRINTER FILE)
000500180502      * DESCRIPTION:    This program prints employee information
000600180502      *                 from the file EMPMST.
000700180502      *===============================================================*
000800180502     FQSYSPRT   O    F   80        PRINTER
000900180502     FEMPMST    IP   E           K DISK
001000180502     D TYPE            S              8A
001100180502     D EMPTYPE         PR             8A
001200180502     D   CODE                         1A
001300180502     IEMPREC        01
001400180502     C                   EVAL      TYPE = EMPTYPE(ETYPE)
001500180502     OPRINT     H    1P                     2  6
001600180502     O                                           50 'EMPLOYEE INFORMATION'
001700180502     O          H    1P
001800180502     O                                           12 'NAME'
001900180502     O                                           34 'SERIAL #'
002000180502     O                                           45 'DEPT'
002100180502     O                                           56 'TYPE'
002200180502     O          D    01
002300180502     O                       ENAME               20
002400180502     O                       ENUM                32
002500180502     O                       EDEPT               45
002600180502     O                       TYPE                60
002700180502      * Procedure EMPTYPE returns a string representing the employee
002800180502      *   type indicated by the parameter CODE.
002900180502     P EMPTYPE         B
003000180502     D EMPTYPE         PI             8A
003100180502     D   CODE                         1A
003200180502     C                   SELECT
003300180502     C                   WHEN      CODE = 'M'
003400180502     C                   RETURN    'Manager'
003500180502     C                   WHEN      CODE = 'R'
003600180502     C                   RETURN    'Regular'
003700180502     C                   OTHER
003800180502     C                   RETURN    'Unknown'
003900180502     C                   ENDSL
004000180502     P EMPTYPE         E
004100180502
