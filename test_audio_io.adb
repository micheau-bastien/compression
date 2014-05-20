with audio_io, ada.text_io;
use audio_io, ada.text_io;

procedure test_audio_io is
	
	procedure Test (Desc, Voul, Obt : in string) is
	begin -- Test
		put_line("-----------------------------------------------------");
		put_line("Decription du test : " & Desc);
		put_line("Voulu : " & Voul);
		put_line("Obtenu : " & Obt);
		if Voul = Obt then
			put_line("SUCCES !");
		else
			put_line("ECHEEEEEEC CRITIQUE !");
		end if;
		put_line("-----------------------------------------------------");
	end Test;
	
	
begin -- test_audio_io
	null;
end test_audio_io;