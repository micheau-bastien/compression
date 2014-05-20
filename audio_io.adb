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

    procedure Corps (adresse : in String; Ech : out P_Echantillon) is
    f : File_Type;
	val : integer :=0;
	begin
		open (f, in_File, adresse);
		set_index(f, Taille_Entete);
		Ech := new T_Echantillon;
		for n in 1.. Taille_Echantillon loop
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
