with ada.text_io, ada.direct_IO;

procedure lect is
    package txt renames Ada.text_IO;
    package Dir_IO is new Ada.Direct_IO (integer);
    use Dir_IO;

    type P_string is access string;

MonFichier : File_type;
c : integer;

begin
    open(MonFichier,In_File, "test.wav");
    for n in 1 .. 100 loop
        read(MonFichier, C);
        txt.put(integer'image(C));
    end loop;
    Close(MonFichier);
end lect;
