WITH ADA.Direct_IO, ADA.Text_IO, Binary_Tools;
USE Binary_Tools;

PACKAGE BODY Audio_IO IS

   PACKAGE Txt RENAMES ADA.Text_IO;

   PACKAGE Character_Direct_IO IS NEW ADA.Direct_IO(Character);
   use Character_Direct_Io;

   -- structure
   -- declaration fichier format wave
   SUBTYPE Riff IS Integer RANGE 1..4;            -- doit être 82-73-70-70 (RIFF)
   --SUBTYPE File_Size IS Integer RANGE 5..8;
   SUBTYPE Format_Fichier IS Integer RANGE 9..12; -- doit être 87-65-86-69 (WAVE)
   -- description format audio
   SUBTYPE Format_Bloc IS Integer RANGE 13..16;   -- doit être 102-109-116-32 (FMT )
   --SUBTYPE Bloc_Size IS Integer RANGE 17..20;     -- sur le premier octet
   --SUBTYPE Audio_Format IS Integer RANGE 21..22;  -- doit être 0-1 (pour le wave)
   SUBTYPE Nb_Canaux IS Integer RANGE 23..24;     -- on ne traite que le cas mono 0-1
   SUBTYPE Frequence_Echantillonnage IS Integer RANGE 25..28;   -- attention, octets en ordre inverse
   --SUBTYPE Octets_Par_Sec IS Integer RANGE 29..32;              -- idem
   --SUBTYPE Octets_Par_Bloc IS Integer RANGE 33..34;             -- idem
   SUBTYPE Bits_Par_Echantillon IS Integer RANGE 35..36;        -- idem
   -- bloc de données

 --Le Data_Bloc commence par 100-97-116-97 (data) ou en HEXA : 64-61-74-61
 --et est suivi par le Data_Size sur 4 octets


   FUNCTION Char_2_String (Char : IN Character) RETURN String IS
      Res : String(1..1);
   BEGIN
      Res(1) := Char;
      RETURN Res;
   END Char_2_String;




   FUNCTION Verification_Fichier (Adresse : IN String) RETURN Boolean IS
      Fichier : File_Type;
      Buffer1 : Character;
      Buffer2 : Character;
      Buffer3 : Character;
      Buffer4 : Character;
      res : Boolean := True;
   BEGIN
      Open(Fichier,In_File,Adresse);

      -- vérification constante RIFF
      Read(Fichier,Buffer1,Count(Riff'First));
      Read(Fichier,Buffer2,Count(Riff'First+1));
      Read(Fichier,Buffer3,Count(Riff'First+2));
      Read(Fichier,Buffer4,Count(Riff'First+3));
      IF Buffer1 = 'R' AND Buffer2 = 'I' AND Buffer3 = 'F' AND Buffer4 = 'F' THEN
         Txt.Put_Line("Constante RIFF : OK");
      ELSE
         Res := False;
         Txt.Put_Line("Constante RIFF erronee");
      END IF;

      -- vérification format fichier
      Read(Fichier,Buffer1,Count(Format_Fichier'First));
      Read(Fichier,Buffer2,Count(Format_Fichier'First+1));
      Read(Fichier,Buffer3,Count(Format_Fichier'First+2));
      Read(Fichier,Buffer4,Count(Format_Fichier'First+3));
      Txt.Put_Line("Format fichier : " & Char_2_String(Buffer1) & Char_2_String(Buffer2) & Char_2_String(Buffer3) & Char_2_String(Buffer4));
      IF Buffer1 = 'W' AND Buffer2 = 'A' AND Buffer3 = 'V' AND Buffer4 = 'E' THEN
         Txt.Put_Line("Format correct");
      ELSE
         Res := False;
         Txt.Put_Line("Format incorrect, veuillez utiliser un fichier WAVE");
      END IF;

      -- vérification format bloc
      Read(Fichier,Buffer1,Count(Format_Bloc'First));
      Read(Fichier,Buffer2,Count(Format_Bloc'First+1));
      Read(Fichier,Buffer3,Count(Format_Bloc'First+2));
      Read(Fichier,Buffer4,Count(Format_Bloc'First+3));
      IF Buffer1 = 'f' AND Buffer2 = 'm' AND Buffer3 = 't' AND Buffer4 = ' ' THEN
         Txt.Put_Line("Format bloc : OK");
      Else
         Res := False;
         Txt.Put_Line("Format bloc incorrect");
      END IF;

      -- vérification nombre de canaux
      Read(Fichier,Buffer1,Count(Nb_Canaux'First));
      Read(Fichier,Buffer2,Count(Nb_Canaux'First+1));
      IF Character'Pos(Buffer1) = 1 AND Character'Pos(Buffer2) = 0 THEN
         Txt.Put_Line("Nombre de canaux : MONO");
      ELSE
         Res := False;
         Txt.Put_Line("Ce fichier n'est pas un fichier MONO, veuillez y remedier s'il vous plait");
      END IF;

      Close(Fichier);
      RETURN Res;
   END Verification_Fichier;


   FUNCTION Frequence_d_Echantillonnage (Adresse : IN String) RETURN Long_Long_Integer IS
      Fichier : File_Type;
      Buffer1 : Character;
      Buffer2 : Character;
      Buffer3 : Character;
      Buffer4 : Character;
   BEGIN
      Open(Fichier,In_File,Adresse);

      Read(Fichier,Buffer1,Count(Frequence_Echantillonnage'First));
      Read(Fichier,Buffer2,Count(Frequence_Echantillonnage'First+1));
      Read(Fichier,Buffer3,Count(Frequence_Echantillonnage'First+2));
      Read(Fichier,Buffer4,Count(Frequence_Echantillonnage'First+3));

      Close (Fichier);


      RETURN Big_Bin_2_Dec(Dec_2_Bin(Character'Pos(Buffer4),8)&Dec_2_Bin(Character'Pos(Buffer3),8)&Dec_2_Bin(Character'Pos(Buffer2),8)&Dec_2_Bin(Character'Pos(Buffer1),8));
   END Frequence_d_Echantillonnage;



   FUNCTION Nb_Bits_Par_Echantillon (Adresse : IN String) RETURN Natural IS
      Fichier : File_Type;
      Buffer1 : Character;
      Buffer2 : Character;
   BEGIN
      Open(Fichier,In_File,Adresse);
      Read(Fichier,Buffer1,Count(Bits_Par_Echantillon'First));
      Read(Fichier,Buffer2,Count(Bits_Par_Echantillon'First+1));
      Close (Fichier);
      RETURN Bin_2_Dec(Dec_2_Bin(Character'Pos(Buffer2),8)&Dec_2_Bin(Character'Pos(Buffer1),8));
   END Nb_Bits_Par_Echantillon;


   FUNCTION Amorce_Data_Bloc (Adresse : IN String) RETURN Natural IS
      Fichier : File_Type;
      Buffer1 : Character := ' ';
      Buffer2 : Character := ' ';
      Buffer3 : Character := ' ';
      Buffer4 : Character := ' ';
      I : natural := 0;
   BEGIN
      Open(Fichier,In_File,Adresse);
      WHILE NOT (Buffer1 = 'd' AND Buffer2 = 'a' AND Buffer3 = 't' AND Buffer4 = 'a') LOOP
         I := I+1;
         Read(Fichier,Buffer1,Count(I));
         Read(Fichier,Buffer2,Count(I+1));
         Read(Fichier,Buffer3,Count(I+2));
         Read(Fichier,Buffer4,Count(I+3));
      END LOOP;
      Close (Fichier);
      RETURN I+8;
   END Amorce_Data_Bloc;


   FUNCTION Size_Data_Bloc (Adresse : IN String) RETURN Long_Long_Integer IS
      Fichier : File_Type;
      Buffer1 : Character;
      Buffer2 : Character;
      Buffer3 : Character;
      Buffer4 : Character;
      I : constant natural := Amorce_Data_Bloc(Adresse);
   BEGIN
      Open(Fichier,In_File,Adresse);
      Read(Fichier,Buffer1,Count(I-4));
      Read(Fichier,Buffer2,Count(I-3));
      Read(Fichier,Buffer3,Count(I-2));
      Read(Fichier,Buffer4,Count(I-1));
      Close (Fichier);
      RETURN Big_Bin_2_Dec(Dec_2_Bin(Character'Pos(Buffer4),8)&Dec_2_Bin(Character'Pos(Buffer3),8)&Dec_2_Bin(Character'Pos(Buffer2),8)&Dec_2_Bin(Character'Pos(Buffer1),8));
   END Size_Data_Bloc;



   FUNCTION Nb_Frames (Adresse : IN String) return Integer IS
      Taille_Bloc_Donnees : constant Long_Long_Integer := Size_Data_Bloc(Adresse);
      Octets_par_echantillon : constant Natural := Nb_Bits_Par_Echantillon(Adresse) / 8;
   BEGIN
      RETURN Integer(Taille_Bloc_Donnees / (Long_Long_Integer (Octets_Par_Echantillon)*Long_Long_Integer(Frame_Size)));
   END Nb_Frames;


   FUNCTION Natural_2_Integer (Nat : Long_Long_Integer ; Nb_Bits : Natural) RETURN Long_Long_Integer IS
   BEGIN
      IF Nat < Long_Long_Integer(2**(Nb_Bits-1)) THEN
         RETURN Nat;
      ELSE
         RETURN Nat-Long_Long_Integer(2**(Nb_Bits)-1);
      END IF;
   END Natural_2_Integer;




   FUNCTION Frame(Adresse : IN String ; Numero : IN natural) return FFT.Tab_TQ is
      Fichier : File_Type;
      Depart : CONSTANT Natural := Amorce_Data_Bloc (Adresse);
      Bits : constant Natural := Nb_Bits_Par_Echantillon (Adresse);
      Pas : constant Natural := Nb_Bits_Par_Echantillon (Adresse)/8;
      Res : FFT.Tab_TQ := (others => 0);
      Buffer : Character;
   BEGIN
      Open(Fichier,In_File,Adresse);
      FOR J IN Res'RANGE LOOP
         FOR K IN 1..Pas LOOP
            Read(Fichier,Buffer,Count(Depart+(Numero-1)*Frame_Size+Pas*J+(K-1)));
            Res(J) := Res(J)+Long_Long_Integer(Character'Pos(Buffer))*Long_Long_Integer(16**(2*(Pas-K)));
         END LOOP;
         Res(J):=Natural_2_Integer(Res(J),Bits);
      END LOOP;
      Close(Fichier);
      RETURN Res;
   END Frame;



END Audio_IO;

