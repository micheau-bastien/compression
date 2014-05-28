WITH AUDIO_IO, Fft, Ada.Text_IO, ADA.Numerics, ADA.Numerics.Generic_Elementary_Functions, Binary_Tools;
use fft, Ada.Text_IO;

PROCEDURE Test_Fft IS

     -- pour utilise sin()
   PACKAGE Num IS NEW ADA.Numerics.Generic_Elementary_Functions (Float);

   use Num;

   PI : constant float := ADA.Numerics.pi;


   FUNCTION Complex_2_String (A : IN FComplex.Complex) RETURN String IS
   BEGIN
      IF A.Im = 0.0 THEN
         RETURN Float'Image(A.Re);
      ELSIF A.Re = 0.0 THEN
         RETURN Float'Image(A.Im)&"i";
      ELSE
         RETURN Float'Image(A.Re)&"+"&Float'Image(A.Im)&"i";
      END IF;
   END Complex_2_String;


   PROCEDURE UT_Reindexe IS
      T : Tab_TQ;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Reindexe");
      -------------------------------------------------------
      Put_Line("   A. Reorganiser un tableau contenant les valeurs de 0 a 511");
      Put_Line("Depart Attendu : 0 256 128 384 64 320");
      FOR I IN T'RANGE LOOP
         T(I):=Long_Long_Integer(I);
      END LOOP;
      Reindexe(T);
      Put("Depart Obtenu : ");
      FOR I IN 0..5 LOOP
         Put(Long_Long_Integer'Image((T(I))));
      END LOOP;
      New_Line;
      If (T(0) = Long_Long_integer(0))
            AND (T(1) = Long_Long_Integer(256))
            AND (T(2) = Long_Long_Integer(128))
            AND (T(3) = Long_Long_Integer(384))
            AND (T(4) = Long_Long_Integer(64))
            AND (T(5) = Long_Long_Integer(320)) THEN
         Put_Line("Correct");
      ELSE
         Put_Line("Erreur");
      END IF;
      -------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Reindexe;



   PROCEDURE UT_Tab_Expo_TFD IS
      Expo : Tab_Exp;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Tab_Expo_TFD");
      -------------------------------------------------------
      Put_Line("a. afficher les 3*4 valeurs du coin superieur gauche du tableau");
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
      -------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Tab_Expo_TFD;

   PROCEDURE UT_Tab_Expo_ITFD IS
      Expo : Tab_Exp_Inverse;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Tab_Expo_TFD_Inverse");
      -------------------------------------------------------
      Put_Line("a. afficher les 3*4 valeurs du coin superieur gauche du tableau");
      Put_Line("Attendu : ");
      Put_Line("1      -1       1      -1");
      Put_Line("1      i      -1       -i");
      Put_Line("1   0.7+0.7i   +i   -0.7+0.7i");
      Put_Line("Resultat : ");
      Expo := Tab_Expo_TFD_Inverse;
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
      -------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Tab_Expo_ITFD;



   PROCEDURE UT_Quantification_F IS
      Argument : Tab_F;
      Resultat : Tab_FQ;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Quantification_F");
      -------------------------------------------------------
      Put_Line("   a. : Quantifier sur 4 bits un tableau dont les valeurs vont de -1 a 1");
      Argument := (OTHERS => (0.0,0.0));
      FOR I IN Argument'RANGE LOOP
         Argument(I).Re := 2.0*(Float(I)/Float(Argument'Last)) - 1.0;
         Argument(I).Im := Argument(I).Re;
      END LOOP;
      Resultat := Quantification_F(3,1.0,Argument);
      Put_Line ("Valeur  Valeur quantifiee signee  Valeur quantifiee non signe");
      FOR I IN Argument'Range LOOP
         Put_Line (Float'Image(Argument(I).Re) & "    " & Integer'Image(Resultat(2*I)) & Natural'Image(Binary_Tools.Non_Signe(Resultat(2*I),3)));
      END LOOP;
      -------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Quantification_F;


   PROCEDURE UT_Quantification_T IS
      Argument : Tab_T;
      Resultat : Tab_TQ;
      Occup : Ratio := (2,1);
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("Test de Quantification_F");
      -------------------------------------------------------
      Put_Line("   a. : Quantifier sur 4 bits un tableau dont les valeurs vont de -1 a 1");
      Put_Line("On restreint l'utilisation de cet intervalle a 50 % (soit sur 3 bits)");
      Argument := (OTHERS => 0.0);
      FOR I IN Argument'RANGE LOOP
         Argument(I) := 2.0*(Float(I)/Float(Argument'Last)) - 1.0;
      END LOOP;
      Resultat := Quantification_T(4,1.0,Occup,Argument);
      Put_Line ("Valeur  Valeur quantifiee");
      FOR I IN Argument'Range LOOP
         Put_Line(Float'Image(Argument(I)) & " " & Long_Long_Integer'Image(Resultat(I))&"       ");
      END LOOP;
      New_Line;
      -------------------------------------------------------
      Put_Line("-------------------------------------------");
      New_Line;
   END UT_Quantification_T;


   PROCEDURE UT_TFD IS
      Frame_Test : Tab_TQ := Audio_IO.Lire_Frame("sine440HzMono.wav",1);
      Nb_Bits_Origine : Natural := Audio_IO.Nb_Bits_Par_Echantillon("sine440HzMono.wav");
      Expon : Tab_Exp := Tab_Expo_TFD;
      Expon_I : Tab_Exp_Inverse := Tab_Expo_TFD_Inverse;
      Nb_De_Bits_Sortie : Natural := 8;
      Res : Resultat_TFD;
      Res_Inverse : Tab_TQ;
   BEGIN
      Put_Line("-------------------------------------------");
      Put_Line("5 : Test de TFD");
      Put_Line("5.a : TFD sur la premi�re frame d'une sinusoide pure � 440 Hz, quantifie sur 8 bits");
      Put_Line("Attendu : un pic a une seule frequence");
      Res := TFD(Frame_Test,Nb_Bits_Origine,Expon,Nb_De_Bits_Sortie);
      Put_Line("Resultat :");
      Res_Inverse := ITFD(Res,Expon_I,Nb_Bits_Origine);

      FOR I IN Frame_Test'RANGE LOOP
         Put(Long_Long_Integer'Image(Frame_Test(I)));
         Put_Line(Long_Long_Integer'Image(Res_Inverse(I)));
      END LOOP;
      Put_Line (Float'Image(Float(Res.Occupation.Top)/Float(Res.Occupation.Bottom)));

      Put_Line("-------------------------------------------");
      New_Line;
   END UT_TFD;




BEGIN

   UT_Reindexe;

   UT_Tab_Expo_TFD;

   UT_Tab_Expo_ITFD;

   UT_Quantification_F;

   UT_Quantification_T;

   --UT_TFD;




END Test_FFT;

