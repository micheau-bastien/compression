PACKAGE Audio_IO IS


   -- définition des constantes

   Bits_Per_Frame : CONSTANT Natural := 9;
   Frame_Size : CONSTANT Natural := 2**Bits_Per_Frame;

   -- déclaration des types
   TYPE Tab_TQ IS ARRAY (0..Frame_Size-1) OF Long_Long_Integer;


   -- prototypes

   -- vérifie que le fichier est "bon"
   FUNCTION Verification_Fichier (Adresse : IN String) RETURN Boolean;

   -- retourne la fréquence d'échantillonnage
   FUNCTION Frequence_D_Echantillonnage (Adresse : IN String) RETURN Long_Long_Integer;

   -- retourne le nombre de bits utilisé pour codé chaque échantillon
   FUNCTION Nb_Bits_Par_Echantillon (Adresse : IN String) RETURN Natural;

   -- retourne le numéro de l'octet à partir duquel commence le bloc de données
   FUNCTION Amorce_Data_Bloc (Adresse : IN String) RETURN Natural;

   -- donne la taille du bloc de donnée en octets
   FUNCTION Size_Data_Bloc (Adresse : IN String) RETURN Long_Long_Integer;

   -- retourne le nombre de frames
   FUNCTION Nb_Frames (Adresse : IN String) RETURN Integer;

   -- transforme les naturals lu dans le bloc de données en integer qu'on est sensé lire
   FUNCTION Natural_2_Integer (Nat : Long_Long_Integer ; Nb_Bits : Natural) return Long_Long_Integer;

   -- retourne la i-ème frame. Fonction non protégé contre les débordements de fichier
   FUNCTION Frame(Adresse : IN String ; Numero : IN natural) return Tab_TQ;



end Audio_IO;
