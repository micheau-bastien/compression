WITH FFT, Binary_Tools;
use Binary_Tools;

PACKAGE Audio_IO IS


   -- définition des constantes

   Bits_Per_Frame : CONSTANT Natural := 9;
   Frame_Size : CONSTANT Natural := 2**Bits_Per_Frame;



   -- prototypes

   -- vérifie que le fichier est "bon"
   FUNCTION Verification_Fichier (Adresse : IN String) RETURN Boolean;

   -- retourne la taille du fichier - 8 octets
   FUNCTION Size (Adresse : In string) return Big_Natural;

   -- retourne la fréquence d'échantillonnage
   FUNCTION Frequence_D_Echantillonnage (Adresse : IN String) RETURN Big_Natural;

   -- retourne le nombre de bits utilisé pour codé chaque échantillon
   FUNCTION Nb_Bits_Par_Echantillon (Adresse : IN String) RETURN Natural;

   -- retourne le numéro de l'octet à partir duquel commence le bloc de données
   FUNCTION Amorce_Data_Bloc (Adresse : IN String) RETURN Natural;

   -- donne la taille du bloc de donnée en octets
   FUNCTION Size_Data_Bloc (Adresse : IN String) RETURN Big_Natural;

   -- retourne le nombre de frames
   FUNCTION Nb_Frames (Adresse : IN String) RETURN Integer;

   -- retourne la i-ème frame. Fonction non protégé contre les débordements de fichier
   FUNCTION Lire_Frame(Adresse : IN String ; Numero : IN natural) return FFT.Tab_TQ;

   -- créé une structure de fichier wave, avec data_bloc vide pour l'instant
   PROCEDURE Creer_Fichier(Adresse : IN String ; Freq : Big_Natural ; Bit_Par_Echantillon : Natural);

   -- écrit la frame à la fin du fichier et met à jour la taille
   PROCEDURE Ajouter_Frame (Adresse : IN String ; Frame : FFT.Tab_TQ);

end Audio_IO;
