PACKAGE Binary_Tools IS

   Nb_Bits_Insuffisant : exception;

   -- Conversion natural decimal <-> binaire sur Bits_per_frame bits sous forme de string
   FUNCTION Dec_2_Bin (Decimal : IN Natural ; Nb_de_Bits : IN Natural) RETURN String;
   FUNCTION Bin_2_Dec (Binaire : IN String) RETURN Natural;

   -- Renvoie le natural dont l'expression binaire est le symétrique de celle de l'argument
   FUNCTION Miroir (A : IN Natural ; Nb_de_Bits : IN Natural) RETURN Natural;


end Binary_Tools;
