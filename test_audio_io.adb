with Audio_IO, ADA.Text_IO, fft, Binary_Tools;
use Audio_IO, ADA.Text_IO, Binary_Tools;

PROCEDURE Test_Audio_Io IS

   PROCEDURE UT_Verification_Fichier IS
      Resultat : Boolean;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Verification_Fichier");
      -------------------------------------------
      New_Line;
      Put_Line("   a. Fichier mauvais format");
      Put("Attendu : Rapport + False      ");
      Put_Line("Resultat : ");
      Resultat := Verification_Fichier("Bad_RIFF.appref-ms");
      Put_Line(Boolean'Image(Resultat));
      IF not Resultat THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      New_Line;
      Put_Line("   b. Fichier non mono");
      Put("Attendu : Rapport + False      ");
      Put_Line("Resultat : ");
      Resultat := Verification_Fichier("Sine440HzStereo.wav");
      Put_Line(Boolean'Image(Resultat));
      IF not Resultat THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      New_Line;
      Put_Line("   c. Fichier correct");
      Put("Attendu : Rapport + True      ");
      Put_Line("Resultat : ");
      Resultat := Verification_Fichier("Sine440HzMono.wav");
      Put_Line(Boolean'Image(Resultat));
      IF Resultat THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Verification_Fichier;


   PROCEDURE UT_Frequence_D_Echantillonnage IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Frequence_D_Echantillonnage");
      -------------------------------------------
      New_Line;
      Put_Line("   a. Fichier a 44100 Hz");
      Put("Attendu : 44100      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Frequence_D_Echantillonnage("sine440HzMono.wav")));
      IF Frequence_D_Echantillonnage("sine440HzMono.wav") = Long_Long_Integer(44100) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      New_Line;
      Put_Line("   b. Fichier a 192000 Hz");
      Put("Attendu : 192000      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Frequence_D_Echantillonnage("sine440Hz192000Hz.wav")));
      IF Frequence_D_Echantillonnage("sine440Hz192000Hz.wav") = Long_Long_Integer(192000) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Frequence_D_Echantillonnage;


   PROCEDURE UT_Nb_Bits_Par_Echantillon IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Nb_Bits_Par_Echantillon");
      -------------------------------------------
      New_Line;
      Put_Line("   a. Fichier en 24 bits");
      Put("Attendu : 24      ");
      Put_Line("Resultat : "&Integer'Image(Nb_Bits_Par_Echantillon("sine440HzMono.wav")));
      IF Nb_Bits_Par_Echantillon("sine440HzMono.wav") = 24 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      New_Line;
      Put_Line("   b. Fichier en 64 bits");
      Put("Attendu : 64      ");
      Put_Line("Resultat : "&Integer'Image(Nb_Bits_Par_Echantillon("sine440Hz64bits.wav")));
      IF Nb_Bits_Par_Echantillon("sine440Hz64bits.wav") = 64 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Nb_Bits_Par_Echantillon;


   PROCEDURE UT_Amorce_Data_Bloc IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Amorce_Data_Bloc");
      -------------------------------------------
      New_Line;
      Put_Line("   a. Fichier avec amorce en 737eme position");
      Put("Attendu : 737      ");
      Put_Line("Resultat : "&Integer'Image(Amorce_Data_Bloc("sine440HzMono.wav")));
      IF Amorce_Data_Bloc("sine440HzMono.wav") = 737 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Amorce_Data_Bloc;


   PROCEDURE UT_Size_Data_Bloc IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Size_Data_Bloc");
      -------------------------------------------
      New_Line;
      Put_Line("   a. Fichier avec un bloc de donnees de 396900 octets ");
      Put("Attendu : 396900      ");
      Put_Line("Resultat : "&Big_Natural'Image(Size_Data_Bloc("sine440HzMono.wav")));
      IF Size_Data_Bloc("sine440HzMono.wav") = Big_Natural(396900) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Size_Data_Bloc;


   PROCEDURE UT_Nb_Frames IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Nb_Frames");
      -------------------------------------------
      New_Line;
      Put_Line("   a. Fichier avec un bloc de donnees de 396900 octets soit 258 frames de 512 echantillons de 3 octets");
      Put("Attendu : 258      ");
      Put_Line("Resultat : "&Integer'Image(Nb_Frames("sine440HzMono.wav")));
      IF Nb_Frames("sine440HzMono.wav") = 258 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Nb_Frames;

   PROCEDURE UT_Creer_Fichier IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Creer_Fichier");
      -------------------------------------------
      New_Line;
      Put_Line("   a. Fichier appele ""jeanlouis.wav"" en 44100 Hz et 16 bits, aller verifier avec editeur hexa");
      Creer_Fichier("jeanlouis.wav",Big_Natural(44100),16);
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Creer_Fichier;

   PROCEDURE UT_Lire_Frame_Ajouter_Frame IS
      Copie : FFT.Tab_TQ;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Lire_Frame et Ajouter_Frame");
      -------------------------------------------
      New_Line;
      Put_Line("   a. recopie un fichier wav ");
      Creer_Fichier("copie.wav",Frequence_D_Echantillonnage("sine440HzMono.wav"),Nb_Bits_Par_Echantillon("sine440HzMono.wav"));
      Put_Line("Fichier cree");
      FOR I IN 1..Nb_Frames("sine440HzMono.wav") LOOP
         Copie := Lire_Frame("sine440HzMono.wav",I);
         Ajouter_Frame("copie.wav", Copie);
      END LOOP;
      Put_Line("verifier avec un editeur hexa");
      -------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Lire_Frame_Ajouter_Frame;


BEGIN

   UT_Verification_Fichier;

   UT_Frequence_D_Echantillonnage;

   UT_Nb_Bits_Par_Echantillon;

   UT_Amorce_Data_Bloc;

   UT_Size_Data_Bloc;

   UT_Nb_Frames;

   UT_Creer_Fichier;

   UT_Lire_Frame_Ajouter_Frame;


END Test_Audio_Io;


