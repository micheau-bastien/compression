WITH ADA.Numerics.Generic_Elementary_Functions,ADA.Text_IO,ADA.Numerics;
use ADA.Text_IO;


PACKAGE BODY Fft IS

   -- utilisé dans Reindexe
   type Tab_visite is array (0..Frame_Size-1) of Boolean;

   -- pour utiliser cos() et sin() afin de générer les coefficients exponentiels
   PACKAGE Num IS NEW ADA.Numerics.Generic_Elementary_Functions (Float);

  PI : constant float := ADA.Numerics.Pi;

   -- prépare le tableau A pour effectuer une FFT itérative
   -- Complexité temporelle en O(N) puisqu'on parcourt l'intégralité du tableau
   PROCEDURE Reindexe (A : IN OUT Tab_TQ) IS
      Indice_Miroir : Natural;
      Aux : Long_Long_Integer;
      Visite : tab_visite := (others => False);
   BEGIN
      FOR I IN A'RANGE LOOP
         Indice_Miroir := Binary_Tools.Miroir(I,Parametre_Frame);
         IF Indice_Miroir /= I AND not Visite(I) THEN
            Aux := A(I);
            A(I) := A(Indice_Miroir);
            A(Indice_Miroir) := Aux;
            Visite(Indice_Miroir) := True;
         END IF;
      END LOOP;
   END Reindexe;



   -- Calcul des facteurs exponentiels exp(-i*2pi*K/(2^P))
   -- complexité linéaire par rapport à la taille de la matrice
   -- on pourrait surement optimiser pour ne pas calculer 2 fois le même indice
   -- la première dimension correspond à la profondeur dans les récursions en quelque sorte
   -- la 2ème correspond à l'indice du coefficient de la TFD courant
   FUNCTION Tab_Expo_TFD RETURN Tab_Exp IS
      res : Tab_Exp;
   BEGIN
      FOR P IN Res'RANGE(1) LOOP
         FOR K IN Res'RANGE(2) LOOP
            Res(P,K).Re:=Num.Cos(PI*Float(2*K)/Float(2**P));
            Res(P,K).Im:=-Num.Sin(PI*Float(2*K)/Float(2**P));
         END LOOP;
      END LOOP;
      RETURN Res;
   END Tab_Expo_TFD;


   -- Calcul des facteurs exponentiels exp(i*2pi*K/(2^P))
   -- idem

   FUNCTION Tab_Expo_TFD_Inverse RETURN Tab_Exp_Inverse IS
      res : Tab_Exp_Inverse;
   BEGIN
      FOR P IN Res'RANGE(1) LOOP
         FOR K IN Res'RANGE(2) LOOP
            Res(P,K).Re:=Num.Cos(PI*Float(2*K)/Float(2**P));
            Res(P,K).Im:=Num.Sin(PI*Float(2*K)/Float(2**P));
         END LOOP;
      END LOOP;
      RETURN Res;
   END Tab_Expo_TFD_Inverse;


   -- La quantification n'est qu'une projection sur l'échelle souhaitée puis une troncature
   -- Le besoin de séparer positifs et négatifs et inhérents à la façon dont sont codé les entiers signés
   -- dans les fichiers sonores
   -- Les positifs sont quantifiés de 0 à 2^(Nb_De_Bits-1)-1 par ordre croissant
   -- Les négatifs sont quantifiés de 2^(Nb_De_Bits-1) à 2^Nb_De_Bits -1 par ordre décroissant en valeur absolue
   -- Plus visuel : 0 1 2 3 4 -4 -3 -2 -1 0 (il y a 2 zéros)
   -- complexité linéaire
   FUNCTION Quantification_F (Nb_De_Bits : IN Positive ; Max : IN Float ; Valeurs : Tab_F) RETURN Tab_FQ IS
      Res : Tab_FQ;
      Pas : CONSTANT Float := Max/(2.0**(Nb_De_Bits-1));   BEGIN
      FOR I IN Valeurs'RANGE LOOP
         -- Partie Réelle
         IF Valeurs(I).Re >= 0.0 THEN
            Res (2*I) := Natural(Float'Ceiling(Valeurs(I).Re/Pas)-1.0);
         ELSE
            Res (2*I) := 2**(Nb_de_Bits)-1-Natural(Float'Ceiling(-Valeurs(I).Re/Pas)-1.0);
         END IF;

         -- Partie Imaginaire
         IF Valeurs(I).Im >= 0.0 THEN
            Res (2*I+1) := Natural(Float'Ceiling(Valeurs(I).Im/Pas)-1.0);
         ELSE
            Res (2*I+1) := 2**(Nb_De_Bits)-1-Natural(Float'Ceiling(-Valeurs(I).Im/Pas)-1.0);
         END IF;
      END LOOP;
      Return res;
   END Quantification_F;


-- idem mais on utilise le ratio pour restituer la nuance
   FUNCTION Quantification_T (Nb_De_Bits : IN Positive ; Max : IN Float ; Occupation : in Ratio; Valeurs : Tab_T) RETURN Tab_TQ IS
      Res : Tab_TQ;
      RealMax : constant Float := Float(Occupation.Top)*Max*Float(Occupation.bottom);
      Pas : constant Float := 2.0*RealMax/(2.0**Nb_De_Bits);
   BEGIN
      FOR I IN Valeurs'RANGE LOOP
         IF Valeurs(I) >= 0.0 THEN
            Res (I) := Big_Natural(Float'Ceiling(Valeurs(I)/Pas)-1.0);
         ELSE
            Res(I) := Big_Natural(2**(Nb_De_Bits)-1)-Big_Natural(Float'Ceiling(-Valeurs(I)/Pas)-1.0);
         END IF;
      END LOOP;
      Return res;
   END Quantification_T;




   FUNCTION TFD (Coeffs : IN Tab_TQ ; Nb_bits_origine : IN natural ; Expo : IN Tab_Exp) RETURN Resultat_TFD IS
      Travail : Tab_F;
      Res : Resultat_TFD;
      Ampli_Max : Long_Long_Integer := 0;
   BEGIN
      -- calcul du ratio d'occupation en amplitude
      Res.Maximum :=0.0;
      FOR I IN Coeffs'RANGE LOOP
         IF ABS(Coeffs(I)) > Ampli_Max THEN
            Ampli_Max := ABS(Coeffs(I));
         END IF;
      END LOOP;
      Res.Occupation := (Ampli_Max,Big_Natural(2**(Nb_Bits_Origine-1)-1));



      FOR K IN Res.Tab'RANGE LOOP
         -- première itération pour remplir le tableau de travail
         FOR I IN Travail'RANGE LOOP
            Travail(I) := Float(Coeffs(2*I)) + Float(Coeffs(2*I+1))*Expo(1,K);
         END LOOP;


         -- et puis on itère jusqu'à n'avoir plus qu'une valeur
         FOR J IN 1..Parametre_Frame LOOP
            FOR I IN 0..Frame_Size/(2**(J+1))-1 LOOP
               Travail((2**(J))*I) := Travail((2**J)*I) + (Expo(J,K) * Travail(((2**J)*I+2**(J-1))));
            END LOOP;
         END LOOP;
         Res.Tab(K) := Travail(0);
         IF Abs(Travail(0).Re) > Res.Maximum THEN
            Res.Maximum := Abs(Travail(0).Re);
         END IF;
         IF ABS(Travail(0).Im) > Res.Maximum THEN
            Res.Maximum := Abs(Travail(0).Im);
         END IF;

      END LOOP;
     RETURN Res;
   END TFD;


   FUNCTION ITFD (Coeffs : IN Tab_FQ ; Expo : IN Tab_Exp_Inverse ; Nb_de_bits : IN natural) RETURN Resultat_ITFD IS
      Travail : Tab_F;

      Res : Resultat_ITFD;
   BEGIN
      Res.Maximum := 0.0;

      FOR K IN Res.Tab'RANGE LOOP
         -- première itération pour remplir le tableau de travail
         -- on utilise la symétrie des coefficients
         FOR I IN 0..(Half_Frame_Size/2)-1 LOOP
            Travail(I) := (Float(Coeffs(4*I)),Float(Coeffs(4*I+1))) + (Float(Coeffs(4*I+2)),Float(Coeffs(4*I+3)))*Expo(1,K);
            Travail(Half_Frame_Size-1-I) := (Float(Coeffs(4*I)),Float(-Coeffs(4*I+1))) + (Float(Coeffs(4*I+2)),Float(-Coeffs(4*I+3)))*Expo(1,K);
         END LOOP;


         -- et puis on itère jusqu'à n'avoir plus qu'une valeur
         FOR J IN 1..Parametre_Frame LOOP
            FOR I IN 0..Frame_Size/(2**(J+1))-1 LOOP
               Travail((2**(J))*I) := Travail((2**J)*I) + (Expo(J,K) * Travail(((2**J)*I+2**(J-1))));
            END LOOP;
         END LOOP;

         Res.Tab(K) := (Travail(0).Re)/Float(Res.Tab'Length);
         IF Abs(Res.Tab(K)) > Res.Maximum THEN
            Res.Maximum := Abs(Travail(0).Re);
         END IF;
      END LOOP;
     RETURN Res;
  END ITFD;





  END Fft;
