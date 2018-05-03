     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Pour test DTAARA                                  *
     F*                                                   *
     F*****************************************************
     DPSOC             S             10
     DWLIB             S             10
     DWSOC1            S           2000
     DWSOC2            S           2000
     DWSOC3            S           2000
     C* définition de la LDA, la variable contiendra la totalité de la zone
     DLDA             UDS
     DWLDA                     1   1024
     C     *ENTRY        PLIST
     C                   PARM                    PSOC
     C* déclaration des DTAARA
     C     *DTAARA       DEFINE    SOC1          WSOC1
     C     *DTAARA       DEFINE    SOC2          WSOC2
     C     *DTAARA       DEFINE    SOC3          WSOC3
     C* le fait d'avoir déclaré LDA en UDS fait la lecture
     C     *DTAARA       DEFINE    *LDA          LDA
     C* lecture et sélection
     C                   SELECT
     C                   WHEN      PSOC = 'SOC1'
     C                   IN        WSOC1
     C                   eval      WLIB = WSOC1
     C                   WHEN      PSOC = 'SOC2'
     C                   IN        WSOC2
     C                   eval      WLIB = WSOC2
     C                   WHEN      PSOC = 'SOC3'
     C                   IN        WSOC3
     C                   eval      WLIB = WSOC3
     C                   END
     C* La LDA, est écrite juste après
     C                   SETON                                        LR
