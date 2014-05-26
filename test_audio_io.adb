with Audio_IO, ADA.Text_IO;
use Audio_IO, ADA.Text_IO;

PROCEDURE Test_Audio_Io IS

   PROCEDURE UT_Verification_Fichier IS
      Resultat : Boolean;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("1 : Test de Verification_Fichier");

      New_Line;
      Put_Line("   1.a Fichier mauvais format");
      Put("Attendu : Rapport + False      ");
      Put_Line("Resultat : ");
      Resultat := Verification_Fichier("Bad_RIFF.appref-ms");
      Put_Line(Boolean'Image(Resultat));
      IF not Resultat THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;


      New_Line;
      Put_Line("   1.b Fichier non mono");
      Put("Attendu : Rapport + False      ");
      Put_Line("Resultat : ");
      Resultat := Verification_Fichier("Sine440HzStereo.wav");
      Put_Line(Boolean'Image(Resultat));
      IF not Resultat THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;


      New_Line;
      Put_Line("   1.c Fichier correct");
      Put("Attendu : Rapport + True      ");
      Put_Line("Resultat : ");
      Resultat := Verification_Fichier("Sine440HzMono.wav");
      Put_Line(Boolean'Image(Resultat));
      IF Resultat THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Verification_Fichier;


   PROCEDURE UT_Frequence_D_Echantillonnage IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("2 : Test de Frequence_D_Echantillonnage");

      New_Line;
      Put_Line("   2.a Fichier a 44100 Hz");
      Put("Attendu : 44100      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Frequence_D_Echantillonnage("sine440HzMono.wav")));
      IF Frequence_D_Echantillonnage("sine440HzMono.wav") = Long_Long_Integer(44100) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   2.b Fichier a 192000 Hz");
      Put("Attendu : 192000      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Frequence_D_Echantillonnage("sine440Hz192000Hz.wav")));
      IF Frequence_D_Echantillonnage("sine440Hz192000Hz.wav") = Long_Long_Integer(192000) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;


   END UT_Frequence_D_Echantillonnage;





BEGIN

   Put_Line(Integer'Image(Integer'Last));
   Put_Line(Long_Integer'Image(Long_Integer'Last));
   Put_Line(Long_Long_Integer'Image(Long_Long_Integer'Last));
   UT_Verification_Fichier;
   UT_Frequence_D_Echantillonnage;

END Test_Audio_Io;


