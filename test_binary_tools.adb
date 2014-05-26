WITH Binary_Tools, ADA.Text_IO;
USE Binary_Tools, ADA.Text_IO;


Procedure Test_Binary_Tools IS



   PROCEDURE UT_Dec_2_Bin IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("1 : Test de Dec_2_Bin");

      New_Line;
      Put_Line("   1.a Dec_2_Bin(16,5)");
      Put("Attendu : 10000      ");
      Put_Line("Resultat : " & Dec_2_Bin(16,5));
      IF Dec_2_Bin(16,5) = "10000" THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   1.b Dec_2_Bin(16,4)");
      Put_Line("Attendu : exception Nb_Bits_Insuffisant");
      DECLARE
      BEGIN
         Put_Line("Resultat : " & Dec_2_Bin(16,4));
         Put_Line("Erreur");
      EXCEPTION
         WHEN Nb_Bits_Insuffisant => Put_Line("Resultat : exception Nb_Bits_Insuffisant");
            Put_Line("Correct");
      END;

      New_Line;
      Put_Line("   1.c Dec_2_Bin(0,4)");
      Put("Attendu : 0000      ");
      Put_Line("Resultat : " & Dec_2_Bin(0,4));
      IF Dec_2_Bin(0,4) = "0000" THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   1.d Dec_2_Bin(65000,16)");
      Put("Attendu : 1111110111101000      ");
      Put_Line("Resultat : " & Dec_2_Bin(65000,16));
      IF Dec_2_Bin(65000,16) = "1111110111101000" THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;


      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Dec_2_Bin;


   PROCEDURE UT_Bin_2_Dec IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("2 : Test de Bin_2_Dec");

      New_Line;
      Put_Line("   2.a Bin_2_Dec(""10000"")");
      Put("Attendu : 16      ");
      Put_Line("Resultat : " & Integer'Image(Bin_2_Dec("10000")));
      IF Bin_2_Dec("10000") = 16 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   2.b Dec_2_Bin(""0000000"")");
      Put("Attendu : 0      ");
      Put_Line("Resultat : " & Integer'Image(Bin_2_Dec("0000000")));
      IF Bin_2_Dec("0000000") = 0 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;


      New_Line;
      Put_Line("   2.c Dec_2_Bin(""1111111111111111111111111111111"")");
      Put("Attendu : 2147483647      ");
      Put_Line("Resultat : " & Integer'Image(Bin_2_Dec("1111111111111111111111111111111")));
      IF Bin_2_Dec("1111111111111111111111111111111") = 2147483647 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;


      Put_Line("-------------------------------------------");
      New_Line;

   END UT_Bin_2_Dec;

   PROCEDURE UT_Big_Bin_2_Dec IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("3 : Test de Big_Bin_2_Dec");

      New_Line;
      Put_Line("   3.a Bin_2_Dec(""00000000000000001010110001000100"")");
      Put("Attendu : 44100      ");
      Put_Line("Resultat : " & Long_Long_Integer'Image(Big_Bin_2_Dec("00000000000000001010110001000100")));
      IF Big_Bin_2_Dec("00000000000000001010110001000100") = Long_Long_Integer(44100) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put_Line("   3.b Valeur maximale : Bin_2_Dec(""111111111111111111111111111111111111111111111111111111111111111"")");
      Put("Attendu : 9223372036854775807      ");
      Put_Line("Resultat : " & Long_Long_Integer'Image(Big_Bin_2_Dec("111111111111111111111111111111111111111111111111111111111111111")));
      IF Big_Bin_2_Dec("111111111111111111111111111111111111111111111111111111111111111") = Long_Long_Integer(9223372036854775807) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Big_Bin_2_Dec;



   PROCEDURE UT_Miroir IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("4 : Test de Miroir");

      New_Line;
      Put("   4.a Miroir(16,5)  ");
      Put_Line("Soit en binaire : " & Dec_2_Bin(16,5));
      Put("Attendu : 1      ");
      Put_Line("Soit en binaire : 00001");
      Put_Line("Resultat : " & Integer'Image(Miroir(16,5)));
      IF Miroir(16,5) = 1 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;

      New_Line;
      Put("   4.b Miroir(15,4)");
      Put_Line("Soit en binaire : " & Dec_2_Bin(15,4));
      Put("Attendu : 15      ");
      Put_Line("Soit en binaire : 1111");
      Put_Line("Resultat : " & Integer'Image(Miroir(15,4)));
      IF Miroir(15,4) = 15 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      Put_Line("-------------------------------------------");
      New_Line;

   END UT_Miroir;


BEGIN

   UT_Dec_2_Bin;

   UT_Bin_2_Dec;

   UT_Big_Bin_2_Dec;

   UT_Miroir;

END Test_Binary_Tools;

