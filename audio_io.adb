package body Audio_IO is

    package txt renames ada.text_io;
    
    function Rec_Entete (Adresse : in String) return Tab_Entete is
        Tab : Tab_Entete;
        Fichier : File_type;
        -- On déclare le type fichier pour manipuler le fichier
        Int : integer;
        -- On passe par un integer car la fonction read n'est pas dans la déclaration de ada.direct_IO.ads.. DOnc on passe par une procedure avec Int en out
    begin
        open(Fichier, In_File, Adresse);
        -- Ouverture du fichier en mode lecture seule puisque le mode InOut serait inutile.
        for i in Tab'range loop
            read(Fichier, Int);
            Tab(i) := Int;
        end loop;
        Close(fichier); 
        return Tab;
    end Rec_Entete;

	function Entete_Tot (adresse : in String) return T_Entete is
		Ent : T_Entete;
		f : File_Type;
		val : integer;
	begin -- Entete_Tot
		open(F, In_File, Adresse);
		for i in 1..4  loop
			read(f, val);
			Ent.Cte_RIFF(i) := character'value(Integer'Image(Val));
		end loop;
		close(f);
		return Ent;
	end Entete_Tot;
	
	type P_string is access string;
    function RIFF_OK (Adresse : in String) return Boolean is
		f : File_Type;
		val : integer;
	begin
		open(f, In_File, Adresse);
		read(f,val);
		-- Série de IF un peu lourde mais optimisée pour éviter d'avoir à charger les 4 premiers integer d'un coup.
		if val=52 then
			read(f,val);
			set_index(f,1);
			if val = 49 then
				read(f,val);
				if val=46 then
					read(f,val);
					if val=46 then
						close(f);
						return true;
					else
						close(f);
						return false;
					end if;
				else
					close(f);
					return false;
				end if;
			else
				close(f);
				return false;
			end if;
		else
			close(f);
			return false;
		end if;
	end RIFF_OK;
	
    function File_size (Adresse : in String) return Natural is
		f : File_Type;
		Taille : P_String;
		val : integer;
	begin
		open(f, In_File, adresse);
		set_index(f, 4);
		for n in 1..4 loop
			read(f,val);
			-- FAIRE SUPPRESSION STRING NON utilisés
			Taille := new string'(Taille.all & integer'image(val));
		end loop;
		return natural'value(Taille.all);
	end File_size;
	
    function Is_Wave (Adresse : in String) return boolean is
	begin
		return TRUE;
	end Is_Wave;
	
    function Bloc_Size (Adresse : in String) return Natural is
	begin
		return 0;
	end Bloc_Size;
	
    function Nb_Cannaux (adresse : in String) return Natural is
	begin
		return 0;
	end Nb_Cannaux;
	
    function Freq_echantillonage (adresse : in String) return Natural is
	begin
		return 0;
	end Freq_echantillonage;

    procedure Corps (adresse : in String; Ech : out P_Echantillon) is
    f : File_Type;
	val : integer :=0;
	begin
		open (f, in_File, adresse);
		set_index(f, Taille_Entete);
		Ech := new T_Echantillon;
		for n in 1.. Taille_Echantillon loop
			-- Voir fin de fichier possible ds un echantillon -> Erreur
			Read(f,val);
			Ech.all.Tab(n) := val;
		end loop;
		Corps(Adresse,Ech.all.suiv);
    end Corps;

    procedure Ecriture (Corps : in P_Echantillon; Entete : in T_Entete; Adresse : in String) is
    begin
        null;
    end Ecriture;

end audio_IO;
