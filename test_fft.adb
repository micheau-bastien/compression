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


   Expo : Tab_Exp := Tab_Expo_TFD;
   T : Tab_TQ;
   T2 : Tab_F;
   T3 : Tab_FQ;
   T4 : Tab_T;
   T5 : Tab_TQ;
   Te : Float := 1.0/44100.0;
   Resultat : Res_TFD;
   T6 : Tab_FQ;

BEGIN



   Put_Line("-------------------------------------------");
   Put_Line("3 : Test de l'initialisation du tableau d'exponentielles");
   Put_Line("3.a afficher les 3*4 valeurs du coin supérieur gauche du tableau");
   Put_Line("Attendu : ");
   Put_Line("1      -1       1      -1");
   Put_Line("1      -i      -1       i");
   Put_Line("1   0.7-0.7i   -i   -0.7-0.7i");
   Put_Line("Resultat : ");
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

   Put_Line("-------------------------------------------");
   Put_Line("4 : Test de la procedure de reorganisation d'un tableau");
   Put_Line("4.a Reorganiser un tableau contenant les valeurs de 0 a 511");
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

   Put_Line("-------------------------------------------");
   Put_Line("5 : Test de la procedure de quantification");
   Put_Line("5.a : Quantifier sur 3 bits un tableau dont les valeurs vont de -1 a 1 avec un pas de 0.01");
   T2 := (OTHERS => (0.0,0.0));
   FOR I IN 0..99 LOOP         -- attention, peut être cause d'erreur pour Bits_per_Frame trop petit
      T2(I).Re := 2.0*Float(I)*0.01 - 1.0;
      T2(I).Im := T2(I).Re+0.01;
   END LOOP;
   T3 := Quantification_F(3,1.0,T2);
   Put_Line ("Valeur  Valeur quantifiee");
   FOR I IN 0..99 LOOP
      Put_Line (Float'Image(T2(I).Re) & "    " & Integer'Image(T3(2*I)));
      Put_Line (Float'Image(T2(I).Im) & "    " & Integer'Image(T3(2*I+1)));
   END LOOP;
   New_Line;
   Put_Line("-------------------------------------------");
   New_Line;

   Put_Line("-------------------------------------------");
   Put_Line("6 : Test de la TFD");
   Put_Line("6.a : TFD sur une sinusoide parfaite de fréquence 200 Hz");
   FOR I IN T4'RANGE LOOP
      T4(I) := sin(PI*Float(2*200*I)*Te);
   END LOOP;
   T5 := Quantification_T(16, 1.0,T4);
   Resultat := TFD(T5 , Expo);
   T6 := Quantification_F(8, Resultat.max, Resultat.tab);

   FOR I IN T6'RANGE LOOP
      Put(Integer'Image(T6(I)));
   END LOOP;

   Put_Line(Integer'Image(Integer'Last));

END Test_FFT;

