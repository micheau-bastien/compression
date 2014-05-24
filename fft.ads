with ADA.Numerics.Generic_Complex_types;

PACKAGE Fft IS

   PACKAGE Comp IS NEW ADA.Numerics.Generic_Complex_Types (Float);


   Puissance_De_2_Nb_Echantillons : CONSTANT Natural := 9;
   Taille_Tableaux_In : CONSTANT Natural := 2**Puissance_De_2_Nb_Echantillons;
   Taille_Tableaux_Out : CONSTANT Natural := 2**(Puissance_De_2_Nb_Echantillons-1);

   -- on travaille par paquet de 2^9 = 512 échantillons

   TYPE Tab_Exp IS ARRAY(1..Puissance_De_2_Nb_Echantillons,0..Taille_Tableaux_Out-1) of Comp.Complex;
   TYPE Tab_In IS ARRAY (0..Taille_Tableaux_In-1) OF Natural;
   TYPE Tab_Out IS ARRAY (0..Taille_Tableaux_Out-1) OF Comp.Complex;
   TYPE Tab_Out_Quantif IS ARRAY (0..Taille_Tableaux_In-1) OF Natural;

   TYPE Res_TFD IS RECORD
      Tab : Tab_Out;
      Max : Float;
   END RECORD;


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

   -- Reordonne les coefficients de A en préparation pour la TFD

   Procedure Reindexe (A : IN OUT Tab_In);


   -- Récupère le nombre de bits sur lequel quantifier et le maximum
   -- en valeur absolue des valeurs à quantifier, (on quantifie alors sur [-Max;Max])
   -- de façon à ce que le premier bit soit un bit de signe

   FUNCTION Quantification (Nb_de_bits : in Positive ; Max : in Float ; Valeurs : Tab_Out) return Tab_Out_Quantif;

   --FUNCTION TFD (Coeffs : in Tab_In ; expo : in Tab_Exp) return Res_TFD;

end Fft;
