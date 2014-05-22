with ADA.Numerics.Generic_Complex_types;

PACKAGE Fft IS

   package Comp is new ADA.Numerics.Generic_Complex_types (Float);

   Puissance_De_2_Nb_Echantillons : CONSTANT Natural := 9;
   Taille_Tableaux_In : CONSTANT Natural := 2**Puissance_De_2_Nb_Echantillons;
   Taille_Tableaux_Out : CONSTANT Natural := 2**(Puissance_De_2_Nb_Echantillons-1);

   -- on travaille par paquet de 2^9 = 512 échantillons

   TYPE Tab_Exp IS ARRAY(1..Puissance_De_2_Nb_Echantillons,0..Taille_Tableaux_Out-1) of Comp.Complex;
   TYPE Tab_In IS ARRAY (1..Taille_Tableaux_In) OF Natural;
   TYPE Tab_Out IS ARRAY (1..Taille_Tableaux_Out) OF Comp.Complex;

   -- Convertit un natural decimal en binaire sous forme de string à 9 charactères
   FUNCTION Dec_2_Bin (Decimal : IN Natural) RETURN String;

   -- Convertit un binaire, sous forme de string
   -- (0 s'écrit comme une chaine vide), en natural
   FUNCTION Bin_2_Dec (Binaire : IN String) RETURN Natural;

   -- Renvoie le natural dont l'expression binaire et obtenu en miroir
   -- par rapport à celle de l'argument
   FUNCTION Inverse (A : IN Natural) RETURN Natural;

   -- Retourne un tableau contenant tous les facteurs exponentiels
   -- nécessaires au calcul de la TFD
   FUNCTION Init_Tab RETURN Tab_Exp;

end Fft;
