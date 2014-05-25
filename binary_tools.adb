PACKAGE BODY Binary_Tools IS

   FUNCTION Dec_2_Bin (Decimal : IN Natural; Nb_de_Bits : IN Natural) RETURN String IS
      Aux : Natural := Decimal;
      Res : String(1..Nb_de_Bits);
   BEGIN
      FOR I IN REVERSE 1..Nb_de_Bits LOOP
         Res(I):=Integer'Image(Aux mod 2)(2);
         Aux := Aux/2;
      END LOOP;
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


   FUNCTION Mirroir (A : IN Natural ; Nb_de_Bits : IN Natural) RETURN Natural IS
      Bin : String := Dec_2_Bin (A,Nb_de_Bits);
      Aux : Character;
   BEGIN
      FOR I IN 0..(Bin'Length/2-1) LOOP
         Aux := Bin(Bin'First+I);
         Bin(Bin'First+I):=Bin(Bin'Last-I);
         Bin(Bin'Last-I):=Aux;
      END LOOP;
      RETURN Bin_2_Dec(Bin);
   END Mirroir;

  END Binary_Tools;
