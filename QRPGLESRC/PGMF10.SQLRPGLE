0001.00 H DEBUG DECEDIT(’0,’) DATEDIT(*DMY.)
0002.00 F*****************************************************
0003.00 F*                                                   *
0004.00 F* Pour test DTAARA                                  *
0005.00 F*                                                   *
0006.00 F*****************************************************
0007.00 DPSOC             S             10
0008.00 DWLIB             S             10
0009.00 DWSOC1            S           2000
0010.00 DWSOC2            S           2000
0011.00 DWSOC3            S           2000
0012.00 C* définition de la LDA, la variable contiendra la totalité de la zone
0013.00 DLDA             UDS
0014.00 DWLDA                     1   1024
0015.00 C     *ENTRY        PLIST
0016.00 C                   PARM                    PSOC
0017.00 C* déclaration des DTAARA
0018.00 C     *DTAARA       DEFINE    SOC1          WSOC1
0019.00 C     *DTAARA       DEFINE    SOC2          WSOC2
0020.00 C     *DTAARA       DEFINE    SOC3          WSOC3
0021.00 C* le fait d’avoir déclaré LDA en UDS fait la lecture
0022.00 C     *DTAARA       DEFINE    *LDA          LDA
0023.00 C* lecture et sélection
0024.00 C                   SELECT
0025.00 C                   WHEN      PSOC = ’SOC1’
0026.00 C                   IN        WSOC1
0027.00 C                   eval      WLIB = WSOC1
0028.00 C                   WHEN      PSOC = ’SOC2’
0029.00 C                   IN        WSOC2
0030.00 C                   eval      WLIB = WSOC2
0031.00 C                   WHEN      PSOC = ’SOC3’
0032.00 C                   IN        WSOC3
0033.00 C                   eval      WLIB = WSOC3
0034.00 C                   END
0035.00 C* La LDA, est écrite juste après
0036.00 C                   SETON                                        LR
