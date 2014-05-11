package body Audio_IO is

    package txt renames ada.text_io;

    function Entete (Adresse : in String) return T_Entete is
    Ent : T_Entete;
    begin
        null;
        return Ent;
    end Entete;

    function Corps (adresse : in String) return T_Echantillon is
    Corps : T_Echantillon;
    begin
        null;
        return Corps;
    end Corps;

    procedure Ecriture (Corps : in T_Echantillon; Entete : in T_Entete; Adresse : in String) is
    begin
        null;
    end Ecriture;

end audio_IO;
