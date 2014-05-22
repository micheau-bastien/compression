WITH ADA.Numerics.Generic_Elementary_Functions,ADA.Text_IO,ADA.Numerics;
use ADA.Text_IO;

PACKAGE BODY Fft IS



   -- pour utilise exp() (en fait cos() et sin())
   PACKAGE Num IS NEW ADA.Numerics.Generic_Elementary_Functions (Float);

   PI : float := ADA.Numerics.pi;


   FUNCTION Dec_2_Bin (Decimal : IN Natural) RETURN String IS
      Aux : Natural := Decimal;
      Res : String (1 .. Puissance_De_2_Nb_Echantillons);
   BEGIN
      FOR I IN REVERSE 1..Puissance_De_2_Nb_Echantillons LOOP
         Res(I):=Integer'Image(Aux mod 2)(2);
         Aux := Aux/2;
      END LOOP;
      return Res;
   END Dec_2_Bin;



   FUNCTION Bin_2_Dec (Binaire : IN String) RETURN Natural IS
      Res : Natural := 0;
   BEGIN
      FOR I IN Binaire'RANGE LOOP
         Res := Res + Integer'Value(Binaire(I..I))*(2**(Binaire'Length-I));    -- Le A(I..I) est un bidouillage car Integer'Value s'applique à un string mais pas à un character...
      END LOOP;
      RETURN Res;
   END Bin_2_Dec;


   FUNCTION Inverse (A : Natural) RETURN Natural IS
      Bin : String := Dec_2_Bin (A);
      Aux : Character;
   BEGIN
      FOR I IN 0..(Bin'Length/2-1) LOOP
         Aux := Bin(Bin'First+I);
         Bin(Bin'First+I):=Bin(Bin'Last-I);
         Bin(Bin'Last-I):=Aux;
      END LOOP;
      RETURN Bin_2_Dec(Bin);
   END Inverse;


   -- chaque case du tableau contient le coefficient exp(-i*2pi*K/(2^P))

   FUNCTION Init_Tab RETURN Tab_Exp IS
      res : Tab_Exp;
   BEGIN
      FOR P IN Res'RANGE(1) LOOP
         FOR K IN Res'RANGE(2) LOOP
            Res(P,K):=(Num.Cos(PI*Float(2*K)/Float(2**P)),-Num.Sin(PI*Float(2*K)/Float(2**P)));
         END LOOP;
      END LOOP;
      RETURN Res;
   END Init_Tab;




   END Fft;
