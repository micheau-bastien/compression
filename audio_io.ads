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






 -- Renvoie la taille du fichier
  -- function File_size (Adresse : in String) return Natural;


   --Renvoie la taille d'un bloc
   --function Bloc_Size (Adresse : in String) return Natural;

   -- Renvoie True si le Nombre de cannaux est 1 (correspondant à notre compression)
   --function Nb_Cannaux_OK (adresse : in String) return Boolean;

   -- Renvoie la fr�quence d'�chantillonnage
   --function Freq_echantillonage (adresse : in String) return Natural;

   -- Renvoie le pointeur vers les �chantillons du corps
   --procedure Corps (Adresse : in String; Ech : out P_Echantillon);

   -- Ecrit une entete et un �chantillon dans un fichier cr�e à l'adresse donn�e
   --procedure Ecriture (Corps : in P_Echantillon ; Entete : in T_Entete ; Adresse : in String);



   --type T_Entete is record
      -- Declaration fichier format wave
     -- Cte_RIFF : String (1..4);
      --4 octets : 52-49-46-46 (RIFF) en hexa --> 0-3
      --File_Size : Natural;
      --4 octets : Taille du fichier -8 octets su  -> 4-7
      --Format_Fichier : String (1..4);
      --4 octets : 57-41-56-45 (WAVE) en hexa -> 8-11

      -- Description format audio
      --Format_Bloc : String (1..4);
      --4 octets : 66-6d-74-20 (FMT ) -> 12-15
      --Bloc_Size : Natural;
      --4 octets : Taille de la structure WAVE-FORMAT  : 16 octets --> 00 00 00 10  -> 16-19
      --Audio_Format : Natural;
      --2 octets : Normalement 1 (WAVE)
      --Nb_Canaux : Natural;
      --2 octets : 1 pour mono / 2 stereo / Erreur autres (on ne les traite pas, seulement st�r�o)
      --Frequ_Echantillonnage : Natural;
      -- 4 octets : En Hz G�n�ralement 11 025 ou 22 050 ou 44 100 ou 48 000 ou 96 000
      --Octet_Par_Sec : Natural;
      -- 4 octets :
      --Octet_Par_Bloc : Natural;
      -- 2 Octets : Nb_Cannaux*bit_par_echantillon/8
      --Bit_Par_Echantillon : Natural;
      -- 2octets : 16 ou 24

      -- Bloc de donn�es
      --Data_Bloc_ID : String (1..4);
      --4 Octets : vaut data 64-61-74-61 en hexa
      --Data_Size : Natural;
      -- 4 octets : Taille en octets des donn�es = Taille_fichier-Taille_Entete avc Taille_Entete=44
   --end record;


end Audio_IO;
