with ada.text_IO, Integer_Direct_IO;
use Integer_Direct_IO;
package Audio_IO is
   
 
   
   type T_Entete is private;
   type P_Echantillon is private;
   type Tab_Entete is private;
   -- on instanciera un package de liste, avec le type T_echantillon, qu'on appelera T_Corps
   
   
   Taille_Entete : constant Integer := 12;
   Taille_Echantillon : constant Integer := 512;
   Mauvaise_Taille_Entete : exception;
   
   
   function Rec_Entete (Adresse : in String) return Tab_Entete;
   function Entete (Adresse : in String) return T_Entete;
   function Corps (Adresse : in String) return P_Echantillon;
   procedure Ecriture (Corps : in P_Echantillon ; Entete : in T_Entete ; Adresse : in String);

private
   
   type Pointeur_Sur_String is access String;
   type Tab_Entete is array (1..Taille_Entete) of Integer; 
   type T_Entete is record
      
      -- Declaration fichier format wave
      Cte_RIFF : String (1..4); 
      --4 octets : 52-49-46-46 (RIFF) en hexa
      File_Size : Natural; 
      --4 octets : Taille du fichier -8 octets su
      Format_Fichier : String (1..4); 
      --4 octets : 57-41-56-45 (WAVE) en hexa
      
      -- Description format audio
      Format_Bloc : String (1..4); 
      --4 octets : 66-6d-74-20 (FMT )
      Bloc_Size : Natural; 
      --4 octets : Taille de la structure WAVE-FORMAT  : 16 octets --> 00 00 00 10 
      Audio_Format : Natural; 
      --2 octets : Normalement 1 (WAVE)
      Nb_Canaux : Natural; 
      --2 octets : 1 pour mono / 2 stereo / Erreur autres (on ne les traite pas, seulement stéréo)
      Frequ_Echantillonnage : Natural; 
      -- 4 octets : En Hz Généralement 11 025 ou 22 050 ou 44 100 ou 48 000 ou 96 000
      Octet_Par_Sec : Natural; 
      -- 4 octets : 
      Octet_Par_Bloc : Natural; 
      -- 2 Octets : Nb_Cannaux*bit_par_echantillon/8
      Bit_Par_Echantillon : Natural; 
      -- 2octets : 16 ou 24
      
      -- Bloc de données
      Data_Bloc_ID : String (1..4); 
      --4 Octets : vaut data 64-61-74-61 en hexa
      Data_Size : Natural; 
      -- 4 octets : Taille en octets des données = Taille_fichier-Taille_Entete avc Taille_Entete=44
   end record;
   
   type Tab_Echantillon is array (1..Taille_Echantillon) of Integer;
   type T_Echantillon;
   type P_Echantillon is access T_Echantillon;
   type T_Echantillon is record
       Tab : Tab_Echantillon;
       Suiv : P_Echantillon;
   end record;
end Audio_IO;
