with ada.text_io, audio_io;
use ada.text_io, audio_io;

procedure test_audio_io is
	
	procedure test_is_riff is
	begin
		if RIFF_OK ("test.wav") then
			put("RIFF : OK ! ");
		else
			put("RIFF : ERROR ! ");
		end	if;
	end test_is_riff;
	
begin
   
   aff_hex("test.wav");
	test_is_riff;
end test_audio_io;
