WITH Binary_Tools, ADA.Text_IO;
USE Binary_Tools, ADA.Text_IO;


Procedure Test_Binary_Tools IS



   PROCEDURE UT_Dec_2_Bin IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Dec_2_Bin");
      --------------------------------------------------------
      New_Line;
      Put_Line("   a. Plus grand Natural possible 2^31-1 : Dec_2_Bin(2147483647,31)");
      Put("Attendu : 1111111111111111111111111111111     ");
      Put_Line("Resultat : " & Dec_2_Bin(2147483647,31));
      IF Dec_2_Bin(2147483647,31) = "1111111111111111111111111111111" THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b Pas assez de bits : Dec_2_Bin(16,4)");
      Put_Line("Attendu : exception Nb_Bits_Insuffisant");
      DECLARE
      BEGIN
         Put_Line("Resultat : " & Dec_2_Bin(16,4));
         Put_Line("Erreur");
      EXCEPTION
         WHEN Nb_Bits_Insuffisant => Put_Line("Resultat : exception Nb_Bits_Insuffisant");
            Put_Line("Correct");
      END;
      --------------------------------------------------------
      New_Line;
      Put_Line("   c Le zero : Dec_2_Bin(0,4)");
      Put("Attendu : 0000      ");
      Put_Line("Resultat : " & Dec_2_Bin(0,4));
      IF Dec_2_Bin(0,4) = "0000" THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Dec_2_Bin;




   PROCEDURE UT_Bin_2_Dec IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Bin_2_Dec");
      --------------------------------------------------------
      New_Line;
      Put_Line("   a. Plus grand Natural : Bin_2_Dec(""1111111111111111111111111111111"")");
      Put("Attendu : 2147483647      ");
      Put_Line("Resultat : " & Integer'Image(Bin_2_Dec("1111111111111111111111111111111")));
      IF Bin_2_Dec("1111111111111111111111111111111") = 2147483647 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b. Le zéro : Dec_2_Bin(""0000000"")");
      Put("Attendu : 0      ");
      Put_Line("Resultat : " & Integer'Image(Bin_2_Dec("0000000")));
      IF Bin_2_Dec("0000000") = 0 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Bin_2_Dec;



   PROCEDURE UT_Big_Dec_2_Bin IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Big_Dec_2_Bin");
      --------------------------------------------------------
      New_Line;
      Put_Line("   a. Le plus grand Big Natural 2^63-1 : Big_Dec_2_Bin(Big_Natural(9223372036854775807),63)");
      Put("Attendu : 63 fois 1      ");
      Put_Line("Resultat : " & Big_Dec_2_Bin(Big_Natural(9223372036854775807),63));
      IF Big_Dec_2_Bin(Big_Natural(9223372036854775807),63) = "111111111111111111111111111111111111111111111111111111111111111" THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b. Pas assez de bits : Big_Dec_2_Bin(Big_Natural(2^36),19)");
      Put_Line("Attendu : exception Nb_Bits_Insuffisant");
      DECLARE
      BEGIN
         Put_Line("Resultat : " & Big_Dec_2_Bin(Big_Natural(2**36),19));
         Put_Line("Erreur");
      EXCEPTION
         WHEN Nb_Bits_Insuffisant => Put_Line("Resultat : exception Nb_Bits_Insuffisant");
            Put_Line("Correct");
      END;
      --------------------------------------------------------
      New_Line;
      Put_Line("   c. Dec_2_Bin(0,36)");
      Put("Attendu : 36 fois 0      ");
      Put_Line("Resultat : " & Dec_2_Bin(0,36));
      IF Dec_2_Bin(0,36) = "000000000000000000000000000000000000" THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Big_Dec_2_Bin;



   PROCEDURE UT_Big_Bin_2_Dec IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Big_Bin_2_Dec");
      --------------------------------------------------------
      New_Line;
      Put_Line("   a. Plus grand Big_Natural : Bin_2_Dec(""111111111111111111111111111111111111111111111111111111111111111"")");
      Put("Attendu : 9223372036854775807      ");
      Put_Line("Resultat : " & Big_Natural'Image(Big_Bin_2_Dec("111111111111111111111111111111111111111111111111111111111111111")));
      IF Big_Bin_2_Dec("111111111111111111111111111111111111111111111111111111111111111") = Big_Natural(9223372036854775807) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b. Le 0 : Bin_2_Dec(""0000000000000000000000000000000000000000"")");
      Put("Attendu : 0      ");
      Put_Line("Resultat : " & Long_Long_Integer'Image(Big_Bin_2_Dec("0000000000000000000000000000000000000000")));
      IF Big_Bin_2_Dec("0000000000000000000000000000000000000000") = Long_Long_Integer(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Big_Bin_2_Dec;



   PROCEDURE UT_Signe IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Signe");
      --------------------------------------------------------
      New_Line;
      Put_Line("   a. Plus grand Natural 2^30-1: Signe(1073741823,31)");
      Put("Attendu : 1073741823      ");
      Put_Line("Resultat : "& Integer'Image(Signe(1073741823,31)));
      IF Signe(1073741823,31) = Integer(1073741823) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b. Le plus petit entier negatif 2^30: Signe(1073741824,31)");
      Put("Attendu : -1073741823      ");
      Put_Line("Resultat : "& Integer'Image(Signe(1073741824,31)));
      IF Signe(1073741824,31) = Integer(-1073741823) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   c. Le premier zero: Signe(0,31)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "& Integer'Image(Signe(0,31)));
      IF Signe(0,31) = Integer(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   d. Le deuxieme zero : 2^31-1 : Signe(2147483647,31)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "& Integer'Image(Signe(2147483647,31)));
      IF Signe(2147483647,31) = Integer(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Signe;



   PROCEDURE UT_Non_Signe IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Non_Signe");

      New_Line;
      Put_Line("   a. Plus grand Natural 2^30-1: Non_Signe(1073741823,31)");
      Put("Attendu : 1073741823      ");
      Put_Line("Resultat : "& Natural'Image(Non_Signe(1073741823,31)));
      IF Non_Signe(1073741823,31) = 1073741823 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b. Le plus petit entier negatif 2^30: Non_Signe(-1073741823,31)");
      Put("Attendu : 1073741824      ");
      Put_Line("Resultat : "& Natural'Image(Non_Signe(-1073741823,31)));
      IF Non_Signe(-1073741823,31) = 1073741824 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   c. Le zero: Non_Signe(0,31)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "& Natural'Image(Non_Signe(0,31)));
      IF Non_Signe(0,31) = 0 THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Non_Signe;


   PROCEDURE UT_Big_Signe IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Big_Signe");
      --------------------------------------------------------
      New_Line;
      Put_Line("   a. Plus grand Natural 2^61-1: Big_Signe(2305843009213693951,62)");
      Put("Attendu : 2305843009213693951      ");
      Put_Line("Resultat : "& Long_Long_Integer'Image(Big_Signe(2305843009213693951,62)));
      IF Big_Signe(2305843009213693951,62) = Long_Long_Integer(2305843009213693951) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b. Le plus petit entier negatif 2^61: Big_Signe(2305843009213693952,62)");
      Put("Attendu : -2305843009213693951      ");
      Put_Line("Resultat : "& Long_Long_Integer'Image(Big_Signe(2305843009213693952,62)));
      IF Big_Signe(2305843009213693952,62) = Long_Long_Integer(-2305843009213693951) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   c. Le premier zero: Big_Signe(0,62)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "& Long_Long_Integer'Image(Big_Signe(0,62)));
      IF Big_Signe(0,62) = Long_Long_Integer(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   d. Le deuxieme zero : 2^62-1 : Big_Signe(4611686018427387903,62)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "& Long_Long_Integer'Image(Big_Signe(4611686018427387903,62)));
      IF Big_Signe(4611686018427387903,62) = Long_Long_Integer(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Big_Signe;

   PROCEDURE UT_Big_Non_Signe IS
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Big_Non_Signe");

      New_Line;
      Put_Line("   a. Plus grand Natural 2^61-1: Big_Non_Signe(2305843009213693951,62)");
      Put("Attendu : 2305843009213693951      ");
      Put_Line("Resultat : "& Big_Natural'Image(Big_Non_Signe(2305843009213693951,62)));
      IF Big_Non_Signe(2305843009213693951,62) = Big_Natural(2305843009213693951) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   b. Le plus petit entier negatif 2^61: Big_Non_Signe(-2305843009213693951,62)");
      Put("Attendu : 2305843009213693952      ");
      Put_Line("Resultat : "& Big_Natural'Image(Big_Non_Signe(-2305843009213693951,62)));
      IF Big_Non_Signe(-2305843009213693951,62) = Big_Natural(2305843009213693952) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      New_Line;
      Put_Line("   d. Le zero: Big_Non_Signe(0,62)");
      Put("Attendu : 0      ");
      Put_Line("Resultat : "& Big_Natural'Image(Big_Non_Signe(0,62)));
      IF Big_Non_Signe(0,62) = Big_Natural(0) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      --------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Big_Non_Signe;



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

   Put_Line("Plus grand Natural :" & Natural'Image(Natural'Last));
   Put_Line("Intervalle des Integer :" & Integer'Image(Integer'First) & " -> " & integer'Image(Integer'Last));
   Put_Line("Plus grand Big_Natural :" & Big_Natural'Image(Big_Natural'Last));
   Put_Line("Plus grand Long_Long_Integer :" & Long_Long_Integer'Image(Long_Long_Integer'Last));

   UT_Dec_2_Bin;

   UT_Bin_2_Dec;

   UT_Big_Dec_2_Bin;

   UT_Big_Bin_2_Dec;

   UT_Signe;

   UT_Non_Signe;

   UT_Big_Signe;

   UT_Big_Non_Signe;

   UT_Miroir;

END Test_Binary_Tools;

