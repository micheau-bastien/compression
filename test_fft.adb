WITH Fft, Ada.Text_IO, ADA.Numerics, ADA.Numerics.Generic_Elementary_Functions;
use fft, Ada.Text_IO;

PROCEDURE Test_Fft IS

     -- pour utilise sin()
   PACKAGE Num IS NEW ADA.Numerics.Generic_Elementary_Functions (Float);

   use Num;

   PI : constant float := ADA.Numerics.pi;


   FUNCTION Complex_2_String (A : IN FComplex.Complex) RETURN String IS
   BEGIN
      IF A.Im = 0.0 THEN
         return Float'Image(A.Re);
      ELSIF A.Re = 0.0 THEN
         RETURN Float'Image(A.Im)&"i";
      ELSE
         RETURN Float'Image(A.Re)&" + "&Float'Image(A.Im)&"i";
      END IF;
   END Complex_2_String;


   PROCEDURE UT_Reindexe IS
      T : Tab_TQ;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("1 : Test de Reindexe");
      Put_Line("1.a Reorganiser un tableau contenant les valeurs de 0 a 511");
      Put_Line("Depart Attendu : 0 256 128 384 64 320");
      FOR I IN T'RANGE LOOP
         T(I):=I;
      END LOOP;
      Reindexe(T);
      Put("Depart Obtenu : ");
      FOR I IN 0..5 LOOP
         Put(Integer'Image((T(I))));
      END LOOP;
      New_Line;
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Reindexe;

   PROCEDURE UT_Tab_Expo_TFD IS
      Expo : Tab_Exp;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("2 : Test de Tab_Expo_TFD");
      Put_Line("2.a afficher les 3*4 valeurs du coin superieur gauche du tableau");
      Put_Line("Attendu : ");
      Put_Line("1      -1       1      -1");
      Put_Line("1      -i      -1       i");
      Put_Line("1   0.7-0.7i   -i   -0.7-0.7i");
      Put_Line("Resultat : ");
      Expo := Tab_Expo_TFD;
      Put(Complex_2_String(Expo(1,0))&"   ");
      Put(Complex_2_String(Expo(1,1))&"   ");
      Put(Complex_2_String(Expo(1,2))&"   ");
      Put(Complex_2_String(Expo(1,3))&"   ");
      New_Line;
      Put(Complex_2_String(Expo(2,0))&"   ");
      Put(Complex_2_String(Expo(2,1))&"   ");
      Put(Complex_2_String(Expo(2,2))&"   ");
      Put(Complex_2_String(Expo(2,3))&"   ");
      New_Line;
      Put(Complex_2_String(Expo(3,0))&"   ");
      Put(Complex_2_String(Expo(3,1))&"   ");
      Put(Complex_2_String(Expo(3,2))&"   ");
      Put(Complex_2_String(Expo(3,3))&"   ");
      New_Line;
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Tab_Expo_TFD;


   PROCEDURE UT_Quantification_F IS
      Argument : Tab_F;
      Resultat : Tab_FQ;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("3 : Test de Quantification_F");
      Put_Line("3.a : Quantifier sur 3 bits un tableau dont les valeurs vont de -1 a 1");
      Argument := (OTHERS => (0.0,0.0));
      FOR I IN Argument'RANGE LOOP
         Argument(I).Re := 2.0*(Float(I)/Float(Argument'Last)) - 1.0;
         Argument(I).Im := Argument(I).Re;
      END LOOP;
      Resultat := Quantification_F(3,1.0,Argument);
      Put_Line ("Valeur  Valeur quantifiee");
      FOR I IN Argument'Range LOOP
         Put_Line (Float'Image(Argument(I).Re) & "    " & Integer'Image(Resultat(2*I)));
      END LOOP;

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Quantification_F;


   PROCEDURE UT_Quantification_T IS
      Argument : Tab_T;
      Resultat : Tab_TQ;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("4 : Test de Quantification_F");
      Put_Line("4.a : Quantifier sur 4 bits un tableau dont les valeurs vont de -1 a 1");
      Put_Line("On restreint l'utilisation de cet intervalle a 50 %");
      Argument := (OTHERS => 0.0);
      FOR I IN Argument'RANGE LOOP
         Argument(I) := 2.0*(Float(I)/Float(Argument'Last)) - 1.0;
      END LOOP;
      Resultat := Quantification_T(4,1.0,2.0,Argument);
      Put_Line ("Valeur  Valeur quantifiee");
      FOR I IN Argument'Range LOOP
         Put(Float'Image(Argument(I)) & " " & Integer'Image(Resultat(I))&"       ");
      END LOOP;
      New_line;
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Quantification_T;



BEGIN

   UT_Reindexe;

   UT_Tab_Expo_TFD;

   UT_Quantification_F;

   UT_Quantification_T;






END Test_FFT;

