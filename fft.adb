WITH ADA.Numerics.Generic_Elementary_Functions,ADA.Text_IO,ADA.Numerics,Binary_Tools;
use ADA.Text_IO;


PACKAGE BODY Fft IS

   -- utilisé dans Reindexe
   type Tab_visite is array (0..Frame_Size-1) of Boolean;

   -- pour utilise exp() (en fait cos() et sin())
   PACKAGE Num IS NEW ADA.Numerics.Generic_Elementary_Functions (Float);


   PI : constant float := ADA.Numerics.pi;


   -- Reorganisation des coefficients du tableau

   PROCEDURE Reindexe (A : IN OUT Tab_TQ) IS
      indice_Miroir : Natural;
      Aux : Long_Long_Integer;
      Visite : tab_visite := (others => False);
   BEGIN
      FOR I IN A'RANGE LOOP
         Indice_Miroir := Binary_Tools.Miroir(I,Bits_Per_Frame);
         IF Indice_Miroir /= I AND not Visite(I) THEN
            Aux := A(I);
            A(I) := A(Indice_Miroir);
            A(Indice_Miroir) := Aux;
            Visite(Indice_Miroir) := True;
         END IF;
      END LOOP;
   END Reindexe;




   -- Calcul des facteurs exponentiels exp(-i*2pi*K/(2^P))

   FUNCTION Tab_Expo_TFD RETURN Tab_Exp IS
      res : Tab_Exp;
   BEGIN
      FOR P IN Res'RANGE(1) LOOP
         FOR K IN Res'RANGE(2) LOOP
            Res(P,K):=(Num.Cos(PI*Float(2*K)/Float(2**P)),-Num.Sin(PI*Float(2*K)/Float(2**P)));
         END LOOP;
      END LOOP;
      RETURN Res;
   END Tab_Expo_TFD;




   FUNCTION Quantification_F (Nb_De_Bits : IN Positive ; Max : IN Float ; Valeurs : Tab_F) RETURN Tab_FQ IS
      Res : Tab_FQ;
      Pas : constant Float := 2.0*Max/(2.0**Nb_De_Bits);
   BEGIN
      FOR I IN Valeurs'RANGE LOOP
         IF Valeurs(I).Re >= 0.0 THEN
            -- Un peu sale mais je vois pas comment faire autrement
            Res (2*I) := Integer(Float'Floor((Valeurs(I).Re)/Pas));
            IF Res(2*I) = 2**(Nb_De_Bits-1) THEN
               Res(2*I) := 2**(Nb_De_Bits-1)-1;
            END IF;

         ELSE
            -- ici il y a parfois une erreur de calcul, avec Res(2*I) qui vaut 2^Nb_De_Bits alors que c'est impossible puisque (2.0**Nb_De_Bits)+Valeurs(I).Re/Pas) < (2.0**Nb_De_Bits)
            Res (2*I) := Integer(Float'Floor((2.0**Nb_De_Bits)+Valeurs(I).Re/Pas));
            -- d'où la vérification suivante, qui ralentit cependant l'opération :
            IF Res(2*I) = 2**Nb_De_Bits THEN
               Res(2*I) := 2**Nb_De_Bits-1;
            END IF;
         END IF;

         IF Valeurs(I).Im >= 0.0 THEN
            Res (2*I+1) := Integer(Float'Floor((Valeurs(I).Im)/Pas));
            IF Res(2*I+1) = 2**(Nb_De_Bits-1) THEN
               Res(2*I+1) := 2**(Nb_De_Bits-1)-1;
            END IF;

         ELSE
            -- idem
            Res (2*I+1) := Integer(Float'Floor((2.0**Nb_De_Bits)+Valeurs(I).Im/Pas));
            IF Res(2*I+1) = 2**Nb_De_Bits THEN
               Res(2*I+1) := 2**Nb_De_Bits-1;
            END IF;

         END IF;
      END LOOP;
      Return res;
   END Quantification_F;



   FUNCTION Quantification_T (Nb_De_Bits : IN Positive ; Max : IN Float ; Occupation : in Ratio; Valeurs : Tab_T) RETURN Tab_TQ IS
      Res : Tab_TQ;
      RealMax : constant Float := Float(Occupation.Top)*Max*Float(Occupation.bottom);
      Pas : constant Float := 2.0*RealMax/(2.0**Nb_De_Bits);
   BEGIN
      FOR I IN Valeurs'RANGE LOOP
         IF Valeurs(I) >= 0.0 THEN
            Res (I) := Long_Long_Integer(Float'Floor((Valeurs(I))/Pas));
         ELSE
            Res(I) := Long_Long_Integer(Float'Floor((2.0**Nb_De_Bits)+Valeurs(I)/Pas));
            -- idem
            IF Res(I) = 2**Nb_De_Bits THEN
               Res(I) := 2**Nb_De_Bits-1;
            END IF;
         END IF;

      END LOOP;
      Return res;
   END Quantification_T;



   FUNCTION TFD (Coeffs : IN Tab_TQ ; Nb_bits_origine : in natural ; Expo : IN Tab_Exp ; Nb_de_bits : IN natural) RETURN Resultat_TFD IS
      Travail : Tab_F;
      Res : Resultat_TFD;
      Pre_Quantification : Tab_F;
      Maximum : Float:=0.0;
      Ampli_Max : Long_Long_Integer := 0;
   BEGIN
      -- calcul du ration d'occupation en amplitude
      FOR I IN Coeffs'RANGE LOOP
         IF ABS(Coeffs(I)) > Ampli_Max THEN
            Ampli_Max := ABS(Coeffs(I));
         END IF;
      END LOOP;
      Res.Occupation := (Ampli_Max,Long_Long_Integer(2**(Nb_Bits_Origine-1)-1));



      FOR K IN Pre_Quantification'RANGE LOOP
         -- première itération pour remplir le tableau de travail
         FOR I IN Travail'RANGE LOOP
            Travail(I) := Float(Coeffs(2*I)) + Float(Coeffs(2*I+1))*Expo(1,K);
         END LOOP;


         -- et puis on itère jusqu'à n'avoir plus qu'une valeur
         FOR J IN 1..Bits_per_Frame LOOP
            FOR I IN 0..Frame_Size/(2**(J+1))-1 LOOP
               Travail((2**(J))*I) := Travail((2**J)*I) + (Expo(J,K) * Travail(((2**J)*I+2**(J-1))));
            END LOOP;
         END LOOP;
         Pre_Quantification(K) := Travail(0);
         IF Abs(Travail(0).Re) > Maximum THEN
            Maximum := Abs(Travail(0).Re);
         END IF;
         IF ABS(Travail(0).Im) > Maximum THEN
            Maximum := Abs(Travail(0).Im);
         END IF;

      END LOOP;
     RETURN (Quantification_F (Nb_de_Bits, Maximum, Pre_Quantification), Res.Occupation);
  END TFD;



  END Fft;
