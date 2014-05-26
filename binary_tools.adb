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
         Res := Res + Natural'Value(Binaire(I..I))*(2**(Binaire'Length-I));    -- Le A(I..I) est un bidouillage car Integer'Value s'applique � un string mais pas � un character...
      END LOOP;
      RETURN Res;
   END Bin_2_Dec;



   FUNCTION Big_Bin_2_Dec (Binaire : IN String) RETURN Long_Long_Integer IS
      Res : Long_Long_Integer := 0;
      Power : Long_Long_Integer;
   BEGIN
      FOR I IN Binaire'RANGE LOOP
         IF Binaire(I) = '1' THEN
            Power := 2**(Binaire'Length-I);
            Res := Res + Power;
         END IF;
      END LOOP;
      RETURN Res;
   END Big_Bin_2_Dec;



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