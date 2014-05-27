WITH ADA.Direct_IO, ADA.Text_IO;


PACKAGE BODY Audio_IO IS

   PACKAGE Txt RENAMES ADA.Text_IO;

   PACKAGE Character_Direct_IO IS NEW ADA.Direct_IO(Character);
   use Character_Direct_Io;

   -- structure
   -- declaration fichier format wave
   SUBTYPE Riff IS Integer RANGE 1..4;            -- doit être 82-73-70-70 (RIFF)
   SUBTYPE File_Size IS Integer RANGE 5..8;
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

 --Le Data_Bloc commence par 100-97-116-97 (data en MINUSCULE!) ou en HEXA : 64-61-74-61
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

   FUNCTION Size (Adresse : IN String) RETURN Big_Natural IS
      Fichier : File_Type;
      Buffer1 : Character;
      Buffer2 : Character;
      Buffer3 : Character;
      Buffer4 : Character;
   BEGIN
      Open(Fichier,In_File,Adresse);

      Read(Fichier,Buffer1,Count(File_Size'First));
      Read(Fichier,Buffer2,Count(File_Size'First+1));
      Read(Fichier,Buffer3,Count(File_Size'First+2));
      Read(Fichier,Buffer4,Count(File_Size'First+3));

      Close (Fichier);


      RETURN Big_Bin_2_Dec(Dec_2_Bin(Character'Pos(Buffer4),8)&Dec_2_Bin(Character'Pos(Buffer3),8)&Dec_2_Bin(Character'Pos(Buffer2),8)&Dec_2_Bin(Character'Pos(Buffer1),8));
   END Size;



   FUNCTION Frequence_d_Echantillonnage (Adresse : IN String) RETURN Big_Natural IS
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


   FUNCTION Size_Data_Bloc (Adresse : IN String) RETURN Big_Natural IS
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



   FUNCTION Lire_Frame(Adresse : IN String ; Numero : IN natural) return FFT.Tab_TQ is
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
         Res(J):=Big_Signe(Res(J),Bits);
      END LOOP;
      Close(Fichier);
      RETURN Res;
   END Lire_Frame;





   PROCEDURE Creer_Fichier(Adresse : IN String ; Freq : Big_Natural ; Bit_Par_Echantillon : Natural) IS
      Fichier : File_Type;
      Octets_par_bloc : constant Natural := Bit_Par_Echantillon / 8;
      Octets_par_sec : constant Big_Natural := Freq * Big_Natural(Octets_par_bloc);
   BEGIN
      Create(Fichier,Out_File,Adresse);
      -- mot RIFF
      Write(Fichier,'R',Count(1));
      Write(Fichier,'I',Count(2));
      Write(Fichier,'F',Count(3));
      Write(Fichier,'F',Count(4));
      -- taille du fichier - 8 octets : 36 octets =
      Write(Fichier,Character'Val(36),Count(5));
      Write(Fichier,Character'Val(0),Count(6));
      Write(Fichier,Character'Val(0),Count(7));
      Write(Fichier,Character'Val(0),Count(8));
      -- mot WAVE
      Write(Fichier,'W',Count(9));
      Write(Fichier,'A',Count(10));
      Write(Fichier,'V',Count(11));
      Write(Fichier,'E',Count(12));
      -- mot fmt
      Write(Fichier,'f',Count(13));
      Write(Fichier,'m',Count(14));
      Write(Fichier,'t',Count(15));
      Write(Fichier,' ',Count(16));
      -- octets restant jusqu'au mot DATA
      Write(Fichier,Character'Val(16),Count(17));
      Write(Fichier,Character'Val(0),Count(18));
      Write(Fichier,Character'Val(0),Count(19));
      Write(Fichier,Character'Val(0),Count(20));
      -- audioFormat (PCM)
      Write(Fichier,Character'Val(1),Count(21));
      Write(Fichier,Character'Val(0),Count(22));
      -- Nb de canaux (1 : Mono)
      Write(Fichier,Character'Val(1),Count(23));
      Write(Fichier,Character'Val(0),Count(24));
      -- Frequence
      Write(Fichier, Character'Val(Big_Decompose(Freq,1)), Count(25));
      Write(Fichier, Character'Val(Big_Decompose(Freq,2)), Count(26));
      Write(Fichier, Character'Val(Big_Decompose(Freq,3)), Count(27));
      Write(Fichier, Character'Val(Big_Decompose(Freq,4)), Count(28));
      -- Octets par seconde
      Write(Fichier, Character'Val(Big_Decompose(Octets_par_sec,1)), Count(29));
      Write(Fichier, Character'Val(Big_Decompose(Octets_par_sec,2)), Count(30));
      Write(Fichier, Character'Val(Big_Decompose(Octets_par_sec,3)), Count(31));
      Write(Fichier, Character'Val(Big_Decompose(Octets_Par_Sec,4)), Count(32));
      -- Octets par bloc
      Write(Fichier, Character'Val(Decompose(Octets_par_bloc,1)), Count(33));
      Write(Fichier, Character'Val(Decompose(Octets_Par_Bloc,2)), Count(34));
      -- bits par échantillon
      Write(Fichier, Character'Val(Decompose(Bit_Par_Echantillon,1)), Count(35));
      Write(Fichier, Character'Val(Decompose(Bit_Par_Echantillon,2)), Count(36));
      -- mot DATA
      Write(Fichier,'d',Count(37));
      Write(Fichier,'a',Count(38));
      Write(Fichier,'t',Count(39));
      Write(Fichier,'a',Count(40));
      -- taille du bloc de données : 0 car il est vide pour l'instant;
      Write(Fichier,Character'Val(0),Count(41));
      Write(Fichier,Character'Val(0),Count(42));
      Write(Fichier,Character'Val(0),Count(43));
      Write(Fichier,Character'Val(0),Count(44));

      Close (Fichier);
   END Creer_Fichier;


   PROCEDURE Ajouter_Frame (Adresse : IN String ; Frame : FFT.Tab_TQ) IS
      Fichier : File_Type;
      Octet_Par_Echantillon : Natural;
      Size_data : Big_Natural;
      Total_Size : Big_Natural;
      Index : Integer;
      test : count;
   BEGIN
      Octet_Par_Echantillon := Nb_Bits_Par_Echantillon (Adresse) /8;
      Size_Data := Size_Data_Bloc (Adresse);
      Total_Size := Size(Adresse);


      Open(Fichier,Out_File,Adresse);
      Index := Natural(Size(Fichier));
      For I in Frame'Range loop
         FOR J IN 1..Octet_Par_Echantillon LOOP
            Txt.Put_Line(Integer'Image(I)&Integer'Image(J)&Char_2_String(Character'Val(Big_Decompose(Big_Non_Signe(Frame(I),Octet_Par_Echantillon*8),J))));
            Write(Fichier,Character'Val(Big_Decompose(Big_Non_Signe(Frame(I),Octet_Par_Echantillon*8),J)), count(Index+I*Octet_par_echantillon+J));
         END LOOP;
      END LOOP;
      -- mise à jour de la taille bloc donnees
      Size_data := Size_data + Big_Natural(Octet_Par_Echantillon*(Frame'Last-1));
      Write(Fichier,Character'Val(Big_Decompose(Size_data,1)),Count(41));
      Write(Fichier,Character'Val(Big_Decompose(Size_data,2)),Count(42));
      Write(Fichier,Character'Val(Big_Decompose(Size_data,3)),Count(43));
      Write(Fichier,Character'Val(Big_Decompose(Size_data,4)),Count(44));
      -- mise à jour de la taille totale
      Total_Size := Total_Size + Big_Natural(Octet_Par_Echantillon*(Frame'Last-1));
      Write(Fichier,Character'Val(Big_Decompose(Total_Size,1)),Count(5));
      Write(Fichier,Character'Val(Big_Decompose(Total_Size,2)),Count(6));
      Write(Fichier,Character'Val(Big_Decompose(Total_Size,3)),Count(7));
      Write(Fichier,Character'Val(Big_Decompose(Total_Size,4)),Count(8));

      Close(Fichier);


   END Ajouter_Frame;







END Audio_IO;

