with Ada.Text_IO, Integer_Direct_IO;
use Integer_Direct_IO;
package Audio_IO is
   
 
   
   type T_Entete is private;
   type P_Echantillon is private;   -- c'est ce que t'avais appelé P_Echantillon en fait, puisqu'on a pas besoin de faire un record avec Pointeur sur le premier élément + autre chose (y'a pas autre chose xD)

   
   
   -- type Tab_Entete is private;
   -- E : le type Tab_Entete ne doit pas être accessible à l'utilisateur, c'est intermédiaire, tout comme la fonction Rec_Entete non ? nous ce qu'on veut c'est direct le T_entete et faut développer les fonctions pour récupérer les éléments qui nous seront utiles (je sais pas encore lesquels mais je vais te dire ça très bientot !)
   
   
   Taille_Entete : constant Integer := 12;
   Taille_Echantillon : constant Integer := 512;
   Mauvaise_Taille_Entete : exception;
   TropDeCanaux : exception; -- dans ce projet on ne traite que les wav mono
   
   
   -- function Rec_Entete (Adresse : in String) return Tab_Entete; Cette fonction est dans le corps, mais pas utilisable pas l'utilisateur
   function Entete (Adresse : in String) return T_Entete;
   function Corps (Adresse : in String) return P_Echantillon;
   procedure Ecriture (Corps : in P_Echantillon ; Entete : in T_Entete ; Adresse : in String);

private
   
   type Pointeur_Sur_String is access String;
   -- a quoi servent les pointeurs sur string ?
   
   --type Tab_Entete is array (1..Taille_Entete) of Integer; 
   -- ça ça sera que dans le body
   
   type T_Entete is record
      
      -- Declaration fichier format wave
      
      --4 octets : 52-49-46-46 (RIFF) en hexa
      Cte_RIFF : String (1..4);    
      --4 octets : Taille du fichier -8 octets su
      File_Size : Natural; 
      --4 octets : 57-41-56-45 (WAVE) en hexa
      Format_Fichier : String (1..4); 
     
      
     
      -- Description format audio
      --4 octets : 66-6d-74-20 (FMT )
      Format_Bloc : String (1..4); 
      --4 octets : Taille de la structure WAVE-FORMAT  : 16 octets --> 00 00 00 10 
      Bloc_Size : Natural; 
      --2 octets : Normalement 1 (WAVE)
      Audio_Format : Natural; 
      --2 octets : 1 pour mono / 2 stereo / etc On traitera que le mono, erreur sur les autres
      Nb_Canaux : Natural; 
      -- 4 octets : En Hz Généralement 11 025 ou 22 050 ou 44 100 ou 48 000 ou 96 000
      Frequ_Echantillonnage : Natural; 
      -- 4 octets : 
      Octet_Par_Sec : Natural; 
      -- 2 Octets : Nb_Cannaux*bit_par_echantillon/8
      Octet_Par_Bloc : Natural; 
      -- 2octets : 16 ou 24
      Bit_Par_Echantillon : Natural; 
 
      
      -- Bloc de données
      --4 Octets : vaut data 64-61-74-61 en hexa
      Data_Bloc_ID : String (1..4); 
      -- 4 octets : Taille en octets des données = Taille_fichier-Taille_Entete avc Taille_Entete=44
      Data_Size : Natural; 

   end record;
   
   type Tab_Echantillon is array (1..Taille_Echantillon) of Integer;
   type T_Echantillon;
   type P_Echantillon is access T_Echantillon;
   type T_Echantillon is record
       Tab : Tab_Echantillon;
       Suiv : P_Echantillon;
   end record;
   
end Audio_IO;
