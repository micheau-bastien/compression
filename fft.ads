with ADA.Numerics.Generic_Complex_types;

PACKAGE Fft IS

   -- instanciation package FComplex pour utilisation de nombres complexes

   PACKAGE FComplex IS NEW ADA.Numerics.Generic_Complex_Types (Float);
   USE FComplex;

   -- A r�cup�rer dans l'ent�te

   Bits_Per_Echantillon_Origine : Natural := 16;

   -- constantes pour d�finir la taille des frames sur lesquels la TFD travaille

   Bits_per_Frame : CONSTANT Natural := 9;
   Frame_Size : CONSTANT Natural := 2**Bits_per_Frame;
   Half_Frame_Size : CONSTANT Natural := 2**(Bits_per_Frame-1);


   -- tous les types tableaux sur lesquels on va travailler
   -- T : temporel (tableaux de r�el car notre signal l'est, ou de natural quantifi�s)
   -- F : fr�quentiel (tableaux de complexes, ou de couple de natural quantifi�s)
   -- Q : quantifi� (donc tableaux de natural et plus float)

   TYPE Tab_TQ IS ARRAY (0..Frame_Size-1) OF Natural;
   TYPE Tab_T IS ARRAY (0..Frame_Size-1) OF Float;

   TYPE Tab_FQ IS ARRAY (0..Frame_Size-1) OF Natural;
   TYPE Tab_F IS ARRAY (0..Half_Frame_Size-1) OF Complex;

   TYPE Tab_Exp IS ARRAY(1..Bits_per_Frame,0..Half_Frame_Size-1) of Complex;


   -- Pour chaque frame on obtient le spectre �chantillon�, et on conserve la valeur maximale
   -- des �chantillons temporels, pour ne pas amplifier les parties calmes des morceaux
   -- en mettant toutes les frames au m�me niveau d'amplitude � la d�compression

   TYPE Resultat_TFD IS RECORD
      Tab : Tab_FQ;
      Amplitude_Max : Natural;
   END RECORD;






   -- Fonctions interm�diaires utilis�es par la TFD :


   -- Conversion natural decimal <-> binaire sur Bits_per_frame bits sous forme de string
   FUNCTION Dec_2_Bin (Decimal : IN Natural) RETURN String;
   FUNCTION Bin_2_Dec (Binaire : IN String) RETURN Natural;
   -- Renvoie le natural dont l'expression binaire est le sym�trique de celle de l'argument
   FUNCTION Mirroir (A : IN Natural) RETURN Natural;
   -- R�organise les indices du tableau en pr�paration pour la TFD
   PROCEDURE Reindexe (A : IN OUT Tab_TQ);

   -- Retourne un tableau contenant les facteurs exponentiels pour la TFD
   FUNCTION Tab_Expo_TFD RETURN Tab_Exp;

   -- Fonctions de quantification
   -- Pour le spectre, on quantifie l'intervalle [-Max,Max] sur l'�chelle pleine de 0 � 2^Nb_de_bits
   FUNCTION Quantification_F (Nb_de_bits : in Positive ; Max : in Float ; Valeurs : Tab_F) return Tab_FQ;
   -- Pour le signal temporel, afin de conserver les nuances, il ne faut pas quantifier chaque frame sur l'�chelle pleine
   -- Au Max, on fait correspondre une valeur quantifi�e MaxQ
   FUNCTION Quantification_T (Nb_de_bits : in Positive ; Max : in Float ; MaxQ : in Natural; Valeurs : Tab_T) return Tab_TQ;



   -- fonction qui calcule la TFD a proprement parler
   FUNCTION TFD (Coeffs : in Tab_TQ ; Expo : in Tab_Exp; Nb_de_bits : in natural) return Resultat_TFD;

end Fft;
