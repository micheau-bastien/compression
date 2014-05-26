PACKAGE Audio_IO IS


   -- d�finition des constantes

   Bits_Per_Frame : CONSTANT Natural := 9;
   Frame_Size : CONSTANT Natural := 2**Bits_Per_Frame;

   -- d�claration des types
   TYPE Tab_TQ IS ARRAY (0..Frame_Size-1) OF Long_Long_Integer;


   -- prototypes

   -- v�rifie que le fichier est "bon"
   FUNCTION Verification_Fichier (Adresse : IN String) RETURN Boolean;

   -- retourne la fr�quence d'�chantillonnage
   FUNCTION Frequence_D_Echantillonnage (Adresse : IN String) RETURN Long_Long_Integer;

   -- retourne le nombre de bits utilis� pour cod� chaque �chantillon
   FUNCTION Nb_Bits_Par_Echantillon (Adresse : IN String) RETURN Natural;

   -- retourne le num�ro de l'octet � partir duquel commence le bloc de donn�es
   FUNCTION Amorce_Data_Bloc (Adresse : IN String) RETURN Natural;

   -- donne la taille du bloc de donn�e en octets
   FUNCTION Size_Data_Bloc (Adresse : IN String) RETURN Long_Long_Integer;

   -- retourne le nombre de frames
   FUNCTION Nb_Frames (Adresse : IN String) RETURN Integer;

   -- transforme les naturals lu dans le bloc de donn�es en integer qu'on est sens� lire
   FUNCTION Natural_2_Integer (Nat : Long_Long_Integer ; Nb_Bits : Natural) return Long_Long_Integer;

   -- retourne la i-�me frame. Fonction non prot�g� contre les d�bordements de fichier
   FUNCTION Frame(Adresse : IN String ; Numero : IN natural) return Tab_TQ;



end Audio_IO;
