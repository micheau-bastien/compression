WITH Fft, Ada.Text_IO;
use fft, Ada.Text_IO;

PROCEDURE Test_Fft IS

BEGIN
   Put_Line("-------------------------------------------");
   Put_Line("1 : Test des conversions binaires-decimales");
   Put_Line("1.a Dec_2_Bin(261)");
   Put_Line("Attendu : 100000101");
   Put_Line("Resultat : " & Dec_2_Bin(261));
   Put_Line("1.b Dec_2_Bin(0)");
   Put_Line("Attendu : 000000000");
   Put_Line("Resultat : " & Dec_2_Bin(0));
   Put_Line("1.c Bin_2_Dec(""100000101"")");
   Put_Line("Attendu : 261");
   Put_Line("Resultat : " & Integer'Image(Bin_2_Dec("100000101")));
   Put_Line("1.d Bin_2_Dec("""")");
   Put_Line("Attendu : 0");
   Put_Line("Resultat : " & Integer'Image(Bin_2_Dec("")));
   Put_Line("-------------------------------------------");
   New_Line;

   Put_Line("-------------------------------------------");
   Put_Line("2 : Test de l'inversion");
   Put_Line("2.a Inverse(261)");
   Put_Line("Attendu : 321");
   Put_Line("Resultat : " & Integer'Image(Inverse(261)));
   Put_Line("-------------------------------------------");
   New_Line;





END Test_FFT;

