     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
     F*****************************************************
     F*                                                   *
     F* Edition simple                                    *
     F*                                                   *
     F*****************************************************
     FFIC00P    IF   E             DISK
     FQPRINT    O    F  132        PRINTER OFLIND(IN99)
     C* Listing clair et simple pas de paramètres
     C* Edition en tete
     C                   EXCEPT    ENTETE
     C* Lecture du fichier, sans aucun classement
     C                   SETOFF                                       99
     C                   READ      FIC00P                               9070
     C     *IN70         DOWEQ     '0'
     C* Edition ligne
     C                   EXCEPT    DETAIL
     C* Fin de page nouvel en tete
     C   99              EXCEPT    ENTETE
     C   99              SETOFF                                       99
     C* On boucle jusqu'à fin de fichier
     C                   READ      FIC00P                               9070
     C                   ENDDO
     C                   SETON                                        LR
     C* Le fichier de sortie d'impression
     OQPRINT    E            ENTETE      2  3
     O                                           35 'Liste du Personnel'
     O          E            ENTETE      1  1
     O                                            9 'Matricule'
     O                                           14 'Fct'
     O                                           18 'Nom'
     O                                           57 'Prénom'
     O          E            DETAIL      1
     O                       FIMAT               10
     O                       FIFON               14
     O                       FINOM               50
     O                       FIPR1               86
