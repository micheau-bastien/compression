WITH ADA.Numerics.Generic_Elementary_Functions,ADA.Text_IO;
use ADA.Text_IO;

PACKAGE BODY Fft IS



   -- pour utilise exp()
   PACKAGE Num IS NEW ADA.Numerics.Generic_Elementary_Functions (Float);




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


   END Fft;
