package body Audio_IO is

    package txt renames ada.text_io;
    
    function Rec_Entete (Adresse : in String) return Tab_Entete is
        Tab : Tab_Entete;
        Fichier : File_type;
        Int : integer;
    begin
        open(Fichier, In_File, Adresse);
        for i in Tab'range loop
            read(Fichier, Int);
            Tab(i) := Int;
        end loop;
        Close(fichier); 
        return Tab;
    end Rec_Entete;

    function Entete (Adresse : in String) return T_Entete is
    Ent : T_Entete;
    begin
        null;
        return Ent;
    end Entete;

    function Corps (adresse : in String) return P_Echantillon is
    Corps : P_Echantillon;
    begin
        null;
        return Corps;
    end Corps;

    procedure Ecriture (Corps : in P_Echantillon; Entete : in T_Entete; Adresse : in String) is
    begin
        null;
    end Ecriture;

end audio_IO;
