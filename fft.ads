WITH ADA.Numerics.Generic_Complex_Types, Binary_Tools;
USE Binary_Tools;

PACKAGE Fft IS

   -- instanciation package FComplex pour utilisation de nombres complexes
   PACKAGE FComplex IS NEW ADA.Numerics.Generic_Complex_Types (Float);
   USE FComplex;



   -- A r�cup�rer dans l'ent�te

   Bits_Per_Echantillon_Origine : Natural := 16;


   -- constantes pour d�finir la taille des frames sur lesquels la TFD travaille
   Parametre_Frame : CONSTANT Natural := 9;
   Frame_Size : CONSTANT Natural := 2**Parametre_Frame;
   Half_Frame_Size : CONSTANT Natural := 2**(Parametre_Frame-1);


   -- tous les types tableaux sur lesquels on va travailler
   -- T : temporel (tableaux de r�el car notre signal l'est, ou d'entiersquantifi�s)
   -- F : fr�quentiel (tableaux de complexes, ou de couple de natural quantifi�s)
   -- Q : quantifi� (donc tableaux de natural et plus float)

   TYPE Tab_TQ IS ARRAY (0..Frame_Size-1) OF Big_Natural;
   -- Si le signal d'origine est quantifi� sur 32 bits par exemple, on obtient un overflow en utilisant
   -- des integer, d'o� l'utilisation des Long_Long_Integer
   TYPE Tab_T IS ARRAY (0..Frame_Size-1) OF Float;

   TYPE Tab_FQ IS ARRAY (0..Frame_Size-1) OF Natural;
   -- En revanche, le but �tant de r�duire la taille du fichier, on quantifiera toujours sur 16 bits ou moins,
   -- donc pas d'overflow sur des Natural
   TYPE Tab_F IS ARRAY (0..Half_Frame_Size-1) OF Complex;

   TYPE Tab_Exp IS ARRAY(1..Parametre_Frame,0..Half_Frame_Size-1) OF Complex;

   TYPE Tab_Exp_Inverse IS ARRAY(1..Parametre_Frame,0..Frame_Size-1) OF Complex;


   -- Pour chaque frame on obtient le spectre �chantillon�, et quantifi�.
   -- Lorsqu'on va appliquer la transformation inverse, on aura amplifier le signal � cause de la quantification
   -- c'est pourquoi on conserve le ratio entre la valeur maximum de la frame en entr�e et la valeur maximal de quantification
   -- de fa�on � restituer les nuances
   TYPE RATIO IS RECORD
      Top : Big_Natural;
      Bottom : Big_Natural;
   END RECORD;

   -- Pour chaque frame trait�e, on garde donc le tableau, et le ratio
   TYPE Resultat_TFD IS RECORD
      Tab : Tab_F;
      Occupation : Ratio;
      Maximum : Float;
   END RECORD;

   TYPE Resultat_ITFD IS RECORD
      Tab : Tab_T;
      Maximum : Float;
   END RECORD;






   -- Fonctions interm�diaires utilis�es par la TFD :


   -- R�organise les indices du tableau en pr�paration pour la TFD
   PROCEDURE Reindexe (A : IN OUT Tab_TQ);

   -- Retourne un tableau contenant les facteurs exponentiels pour la TFD
   FUNCTION Tab_Expo_TFD RETURN Tab_Exp;

   -- Retourne un tableau contenant les facteurs exponentiels pour la TFD inverse
   FUNCTION Tab_Expo_TFD_Inverse return Tab_Exp_Inverse;

   -- Fonctions de quantification
   -- Pour le spectre, on quantifie l'intervalle [-Max,Max] sur l'�chelle pleine de 0 � 2^Nb_de_bits
   FUNCTION Quantification_F (Nb_de_bits : in Positive ; Max : in Float ; Valeurs : Tab_F) return Tab_FQ;
   -- Pour le signal temporel, afin de conserver les nuances, il ne faut pas quantifier chaque frame sur l'�chelle pleine
   -- Au Max, on fait correspondre une valeur quantifi�e MaxQ
   FUNCTION Quantification_T (Nb_de_bits : in Positive ; Max : in Float ; Occupation : in Ratio; Valeurs : Tab_T) return Tab_TQ;



   -- fonction qui calcule la TFD a proprement parler
   FUNCTION TFD (Coeffs : in Tab_TQ ; Nb_bits_origine : in Natural ; Expo : in Tab_Exp) return Resultat_TFD;

   -- fonction qui inverse la TFD
   FUNCTION ITFD (Coeffs : in Tab_FQ ; Expo : in Tab_Exp_Inverse ; Nb_de_bits : in Natural) return Resultat_ITFD;

end Fft;
