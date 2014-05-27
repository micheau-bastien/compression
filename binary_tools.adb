WITH ADA.Text_IO;
use ADA.Text_IO;

PACKAGE BODY Binary_Tools IS

   FUNCTION Dec_2_Bin (Decimal : IN Natural; Nb_de_Bits : IN Natural) RETURN String IS
      Aux : Natural := Decimal;
      Res : String(1..Nb_de_Bits);
   BEGIN
      FOR I IN REVERSE 1..Nb_de_Bits LOOP
         Res(I):=Integer'Image(Aux mod 2)(2);
         Aux := Aux/2;
      END LOOP;
      IF Aux /= 0 THEN
         RAISE Nb_Bits_Insuffisant;
      END IF;
      return Res;
   END Dec_2_Bin;


   FUNCTION Bin_2_Dec (Binaire : IN String) RETURN Natural IS
      Res : Natural := 0;
   BEGIN
      FOR I IN Binaire'RANGE LOOP
         Res := Res + Natural'Value(Binaire(I..I))*(2**(Binaire'Length-I));    -- Le A(I..I) est un bidouillage car Integer'Value s'applique à un string mais pas à un character...
      END LOOP;
      RETURN Res;
   END Bin_2_Dec;



   FUNCTION Big_Dec_2_Bin (Decimal : IN Big_Natural; Nb_de_Bits : IN Natural) RETURN String IS
      Aux : Big_Natural := Decimal;
      Res : String(1..Nb_de_Bits);
   BEGIN
      FOR I IN REVERSE 1..Nb_de_Bits LOOP
         Res(I):=Big_Natural'Image(Aux mod 2)(2);
         Aux := Aux/2;
      END LOOP;
      IF Aux /= 0 THEN
         RAISE Nb_Bits_Insuffisant;
      END IF;
      return Res;
   END Big_Dec_2_Bin;



   FUNCTION Big_Bin_2_Dec (Binaire : IN String) RETURN Big_Natural IS
      Res : Big_Natural := 0;
      Power : Big_Natural;
   BEGIN
      FOR I IN Binaire'RANGE LOOP
         IF Binaire(I) = '1' THEN
            Power := 2**(Binaire'Length-I);
            Res := Res + Power;
         END IF;
      END LOOP;
      RETURN Res;
   END Big_Bin_2_Dec;


   FUNCTION Signe (Nat : Natural ; Nb_Bits : Natural) RETURN Integer IS
   BEGIN
      IF Nat < 2**(Nb_Bits-1) THEN
         RETURN Integer(Nat);
      ELSE
         RETURN Integer(Nat)-Integer((2**(Nb_Bits)-1));
      END IF;
   END Signe;

   FUNCTION Non_Signe (Neg : Integer ; Nb_Bits : Natural) RETURN Natural IS
   BEGIN
      IF Neg < 0 THEN

         RETURN Natural(2**(Nb_Bits)-1)-Natural(Abs(Neg));
      ELSE
         RETURN Natural(Neg);
      END IF;
   END Non_Signe;


   FUNCTION Big_Signe (Nat : Big_Natural ; Nb_Bits : Natural) RETURN Long_Long_Integer IS
   BEGIN
      IF Nat < Big_Natural(2**(Nb_Bits-1)) THEN
         RETURN Long_Long_Integer(Nat);
      ELSE
         RETURN Long_Long_Integer(Nat)-Long_Long_Integer(2**(Nb_Bits)-1);
      END IF;
   END Big_Signe;


   FUNCTION Big_Non_Signe (Signe : Long_Long_Integer ; Nb_Bits : Natural) RETURN Big_Natural IS
   BEGIN
      IF Signe < 0 THEN
         RETURN Big_Natural(2**(Nb_Bits)-1)-Big_Natural(Abs(Signe));
      ELSE
         RETURN Big_Natural(Signe);
      END IF;
   END Big_Non_Signe;



   FUNCTION Miroir (A : IN Natural ; Nb_de_Bits : IN Natural) RETURN Natural IS
      Bin : String := Dec_2_Bin (A,Nb_de_Bits);
      Aux : Character;
   BEGIN
      FOR I IN 0..(Bin'Length/2-1) LOOP
         Aux := Bin(Bin'First+I);
         Bin(Bin'First+I):=Bin(Bin'Last-I);
         Bin(Bin'Last-I):=Aux;
      END LOOP;
      RETURN Bin_2_Dec(Bin);
   END Miroir;

  END Binary_Tools;
