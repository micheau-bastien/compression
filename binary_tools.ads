PACKAGE Binary_Tools IS

   Nb_Bits_Insuffisant : EXCEPTION;

   Subtype Big_Natural is Long_Long_Integer range 0..Long_Long_Integer'Last;

   -- Conversion natural decimal <-> binaire sur Bits_per_frame bits sous forme de string
   -- Pour les entiers positifs codés sur 31 bits ou moins
   FUNCTION Dec_2_Bin (Decimal : IN Natural ; Nb_de_Bits : IN Natural) RETURN String;
   FUNCTION Bin_2_Dec (Binaire : IN String) RETURN Natural;
   -- pour les entiers positifs codés sur 62 bits ou moins Attention, sur 63 bits, arithmetic overflow everywhere
   FUNCTION Big_Dec_2_Bin (Decimal : IN Big_Natural ; Nb_de_Bits : IN Natural) RETURN String;
   FUNCTION Big_Bin_2_Dec (Binaire : IN String) RETURN Big_Natural;

   -- transforme un entier non signé sur Nb_Bits<=31 en entier signé sur Nb_Bits en complément à 1
   FUNCTION Signe (Nat : Natural ; Nb_Bits : Natural) RETURN Integer;
   FUNCTION Non_Signe (Neg : Integer ; Nb_Bits : Natural) return Natural;

   -- idem pour les entiers sur Nb_Bits<=62
   FUNCTION Big_Signe (Nat : Big_Natural ; Nb_Bits : Natural) RETURN Long_Long_Integer;
   FUNCTION Big_Non_Signe (Signe : Long_Long_Integer ; Nb_Bits : Natural) return Big_Natural;

   -- Renvoie le natural dont l'expression binaire est le symétrique de celle de l'argument
   FUNCTION Miroir (A : IN Natural ; Nb_de_Bits : IN Natural) RETURN Natural;

   -- Si l'on souhaite coder A sur X<=3 octets, Renvoie le naturel correspondant au N_ième octet
   FUNCTION Decompose (A : Natural ; N : Positive) RETURN Natural;
   -- et pour les Big_Natural, X<=7 octets
   FUNCTION Big_Decompose (A : Big_Natural ; N : Positive) RETURN Natural;

end Binary_Tools;
