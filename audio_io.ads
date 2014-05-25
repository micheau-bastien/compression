WITH ADA.Direct_IO, ADA.Text_IO;


package Audio_IO is

   PACKAGE Natural_Direct_IO IS NEW ADA.Direct_IO(Character);
   use Natural_Direct_Io;

   PACKAGE Txt RENAMES ADA.Text_IO;


   -- définition des constantes utiles

   Bits_Per_Frame : CONSTANT Natural := 9;
   Frame_Size : CONSTANT Natural := 2**Bits_Per_Frame;


   TYPE Frame IS ARRAY (0..Frame_Size-1) OF Integer;

   type L_Frame;
   type P_Frame is access L_Frame;
   type L_Frame is record
       Tab : Frame;
       Suiv : P_Frame;
   end record;





   procedure Lire_Fichier (Adresse : IN String);




-- Renvoie si le code RIFF de l'entète correspond au code voulu dans le cadre de notre compression
--   function RIFF_OK (Adresse : in String) return Boolean;

   -- Renvoie la taille du fichier
  -- function File_size (Adresse : in String) return Natural;

   -- Renvoie true si le fichier est un wave
  -- function Is_Wave (Adresse : in String) return boolean;

   --Renvoie la taille d'un bloc
   --function Bloc_Size (Adresse : in String) return Natural;

   -- Renvoie True si le Nombre de cannaux est 1 (correspondant Ã  notre compression)
   --function Nb_Cannaux_OK (adresse : in String) return Boolean;

   -- Renvoie la fréquence d'échantillonnage
   --function Freq_echantillonage (adresse : in String) return Natural;

   -- Renvoie le pointeur vers les échantillons du corps
   --procedure Corps (Adresse : in String; Ech : out P_Echantillon);

   -- Ecrit une entete et un échantillon dans un fichier crée Ã  l'adresse donnée
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
      --2 octets : 1 pour mono / 2 stereo / Erreur autres (on ne les traite pas, seulement stéréo)
      --Frequ_Echantillonnage : Natural;
      -- 4 octets : En Hz Généralement 11 025 ou 22 050 ou 44 100 ou 48 000 ou 96 000
      --Octet_Par_Sec : Natural;
      -- 4 octets :
      --Octet_Par_Bloc : Natural;
      -- 2 Octets : Nb_Cannaux*bit_par_echantillon/8
      --Bit_Par_Echantillon : Natural;
      -- 2octets : 16 ou 24

      -- Bloc de données
      --Data_Bloc_ID : String (1..4);
      --4 Octets : vaut data 64-61-74-61 en hexa
      --Data_Size : Natural;
      -- 4 octets : Taille en octets des données = Taille_fichier-Taille_Entete avc Taille_Entete=44
   --end record;


end Audio_IO;
