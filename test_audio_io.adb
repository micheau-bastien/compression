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

      Put_Line("-------------------------------------------");
      New_Line;

   END UT_Frequence_D_Echantillonnage;



   PROCEDURE UT_Nb_Bits_Par_Echantillon IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("3 : Test de Nb_Bits_Par_Echantillon");

      New_Line;
      Put_Line("   3.a Fichier en 24 bits");
      Put("Attendu : 24      ");
      Put_Line("Resultat : "&Integer'Image(Nb_Bits_Par_Echantillon("sine440HzMono.wav")));
      IF Nb_Bits_Par_Echantillon("sine440HzMono.wav") = 24 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   3.b Fichier en 64 bits");
      Put("Attendu : 64      ");
      Put_Line("Resultat : "&Integer'Image(Nb_Bits_Par_Echantillon("sine440Hz64bits.wav")));
      IF Nb_Bits_Par_Echantillon("sine440Hz64bits.wav") = 64 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;


      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Nb_Bits_Par_Echantillon;


   PROCEDURE UT_Amorce_Data_Bloc IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("4 : Test de Amorce_Data_Bloc");

      New_Line;
      Put_Line("   4.a Fichier avec amorce en 737eme position");
      Put("Attendu : 737      ");
      Put_Line("Resultat : "&Integer'Image(Amorce_Data_Bloc("sine440HzMono.wav")));
      IF Amorce_Data_Bloc("sine440HzMono.wav") = 737 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Amorce_Data_Bloc;


   PROCEDURE UT_Size_Data_Bloc IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("5 : Test de Size_Data_Bloc");

      New_Line;
      Put_Line("   5.a Fichier avec un bloc de donnees de 396900 octets ");
      Put("Attendu : 396900      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Size_Data_Bloc("sine440HzMono.wav")));
      IF Size_Data_Bloc("sine440HzMono.wav") = Long_Long_Integer(396900) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Size_Data_Bloc;


   PROCEDURE UT_Nb_Frames IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("6 : Test de Nb_Frames");

      New_Line;
      Put_Line("   6.a Fichier avec un bloc de donnees de 396900 octets soit 258 frames de 512 echantillons de 3 octets");
      Put("Attendu : 258      ");
      Put_Line("Resultat : "&Integer'Image(Nb_Frames("sine440HzMono.wav")));
      IF Nb_Frames("sine440HzMono.wav") = 258 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Nb_Frames;

   PROCEDURE UT_Natural_2_Integer IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("7 : Test de Natural_2_Integer");

      New_Line;
      Put_Line("   7.a Plus grand entier positif : Natural_2_Integer(32767,16)");
      Put("Attendu : 32767      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Natural_2_Integer(Long_Long_Integer(32767),16)));
      IF Natural_2_Integer(32767,16) = Long_Long_Integer(32767) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   7.b Le plus petit entier négatif : Natural_2_Integer(32768,16)");
      Put("Attendu : -32767      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Natural_2_Integer(Long_Long_Integer(32768),16)));
      IF Natural_2_Integer(32768,16) = Long_Long_Integer(-32767) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   7.c Le premier zero: Natural_2_Integer(0,16)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Natural_2_Integer(Long_Long_Integer(0),16)));
      IF Natural_2_Integer(0,16) = Long_Long_Integer(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   7.D Le zero: Natural_2_Integer(65535,16)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "&Long_Long_Integer'Image(Natural_2_Integer(Long_Long_Integer(65535),16)));
      IF Natural_2_Integer(65535,16) = Long_Long_Integer(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      Put_Line("Resultat : "&Long_Long_Integer'Image(Natural_2_Integer(Long_Long_Integer(34952),16)));
      Put_Line("Resultat : "&Long_Long_Integer'Image(Natural_2_Integer(Long_Long_Integer(39321),16)));


      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Natural_2_Integer;

   PROCEDURE UT_Frame IS
      Tab : Tab_TQ;
      OK : boolean;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("8 : Test de Frame");

      New_Line;
      Put_Line("   8.a Fichier dont la première frame est connue : Frame(""test_frame_16bits.wav"",1)");
      Put_Line(" Attendu :");
      Put_Line(" 32 fois chacune des valeurs : codés par 0000, 1111, 2222, 3333, 4444, ..., FFFF en hexadecimal");
      Put_Line(" C'est à dire : 0, 4369, 8738, 13107, 17476, 21845, 26214, 30583, -30583, -26214, -21845, -17476, -13107, -8738, -4368, 0");
      Tab := Frame("test_frame_16bits.wav",1);


      FOR I IN Tab'Range LOOP
         Put(Long_Long_Integer'Image(Tab(I)));
      END LOOP;
      New_Line;

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Frame;



BEGIN

   UT_Verification_Fichier;

   UT_Frequence_D_Echantillonnage;

   UT_Nb_Bits_Par_Echantillon;

   UT_Amorce_Data_Bloc;

   UT_Size_Data_Bloc;

   UT_Nb_Frames;

   UT_Natural_2_Integer;

   UT_Frame;


END Test_Audio_Io;


