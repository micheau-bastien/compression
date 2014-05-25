
PACKAGE BODY Audio_IO IS




   PROCEDURE Lire_Fichier (Adresse : IN String) is
      Fichier : File_Type;
      Buffer : character;
   BEGIN
      Open(Fichier,In_File,Adresse);
      For i in 1..100 loop
         Read(Fichier,Buffer,Count(I));
         Txt.Put_Line(Integer'Image(Character'Pos(Buffer)));
      END LOOP;
   END Lire_Fichier;




   -- function RIFF_OK (Adresse : in String) return Boolean is
	--	f : File_Type;
	--	val : Integer := 0;
	--begin
--		open(f, In_File, Adresse);
--		read(f,val);
--		return Val=1179011410;
--	end RIFF_OK;
--
  --  function File_size (Adresse : in String) return Natural is
	--	f : File_Type;
	--	Taille : P_String;
	--	val : integer;
--	begin
--		open(f, In_File, adresse);
--		set_index(f, 4);
--		for n in 1..4 loop
--			read(f,val);
--			-- FAIRE SUPPRESSION STRING NON utilisés
--			Taille := new string'(Taille.all & integer'image(val));
--		end loop;
--		return natural'value(Taille.all);
--	end File_size;
--
--  function Is_Wave (Adresse : in String) return boolean is
--	begin
--		return TRUE;
--	end Is_Wave;
--
--    function Bloc_Size (Adresse : in String) return Natural is
--	begin
--		return 0;
--	end Bloc_Size;
--
--  function Nb_Cannaux_OK (adresse : in String) return Boolean is
--	begin
--		return false;
--	end Nb_Cannaux_OK;
--
--    function Freq_echantillonage (adresse : in String) return Natural is
--	begin
--		return 0;
--	end Freq_echantillonage;
--
--  procedure Corps (adresse : in String; Ech : out P_Echantillon) is
--    f : File_Type;
--	val : integer :=0;
--	begin
--		open (f, in_File, adresse);
--		set_index(f, Taille_Entete);
--		Ech := new T_Echantillon;
--		for n in 1.. Taille_Echantillon loop
--			-- Voir fin de fichier possible ds un echantillon -> Erreur
--			Read(f,val);
--			Ech.all.Tab(n) := val;
--		end loop;
--		Corps(Adresse,Ech.all.suiv);
--  end Corps;

--    procedure Ecriture (Corps : in P_Echantillon; Entete : in T_Entete; Adresse : in String) is
--    begin
--        null;
--    end Ecriture;

end audio_IO;
