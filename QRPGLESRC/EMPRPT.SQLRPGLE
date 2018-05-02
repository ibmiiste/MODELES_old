      *===============================================================*
      * MODULE NAME:    EMPRPT
      * RELATED FILES:  EMPMST   (PHYSICAL FILE)
      *                 QSYSPRT  (PRINTER FILE)
      * DESCRIPTION:    This program prints employee information
      *                 from the file EMPMST.
      *===============================================================*
     FQSYSPRT   O    F   80        PRINTER
     FEMPMST    IP   E           K DISK
     D TYPE            S              8A
     D EMPTYPE         PR             8A
     D   CODE                         1A
     IEMPREC        01
     C                   EVAL      TYPE = EMPTYPE(ETYPE)
     OPRINT     H    1P                     2  6
     O                                           50 'EMPLOYEE INFORMATION'
     O          H    1P
     O                                           12 'NAME'
     O                                           34 'SERIAL #'
     O                                           45 'DEPT'
     O                                           56 'TYPE'
     O          D    01
     O                       ENAME               20
     O                       ENUM                32
     O                       EDEPT               45
     O                       TYPE                60
      * Procedure EMPTYPE returns a string representing the employee
      *   type indicated by the parameter CODE.
     P EMPTYPE         B
     D EMPTYPE         PI             8A
     D   CODE                         1A
     C                   SELECT
     C                   WHEN      CODE = 'M'
     C                   RETURN    'Manager'
     C                   WHEN      CODE = 'R'
     C                   RETURN    'Regular'
     C                   OTHER
     C                   RETURN    'Unknown'
     C                   ENDSL
     P EMPTYPE         E

