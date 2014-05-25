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
      indice_Mirroir : Natural;
      Aux : Natural;
      Visite : tab_visite := (others => False);
   BEGIN
      FOR I IN A'RANGE LOOP
         Indice_Mirroir := Binary_Tools.Mirroir(I);
         IF Indice_Mirroir /= I AND not Visite(I) THEN
            Aux := A(I);
            A(I) := A(Indice_Mirroir);
            A(Indice_Mirroir) := Aux;
            Visite(Indice_Mirroir) := True;
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




   -- si D est le pas de quantification, on cherche p tq  X soit dans [p.D, (p+1).D[ soit
   -- X = p.D + R       avec 0<R<D
   FUNCTION Quantification_F (Nb_De_Bits : IN Positive ; Max : IN Float ; Valeurs : Tab_F) RETURN Tab_FQ IS
      Res : Tab_FQ;
      Pas : constant Float := 2.0*Max/(2.0**Nb_De_Bits);
   BEGIN
      FOR I IN Valeurs'RANGE LOOP
         Res (2*I) := Integer(Float'Floor((Max+Valeurs(I).Re)/Pas));
         Res (2*I+1) := Integer(Float'Floor((Max+Valeurs(I).Im)/Pas));
      END LOOP;
      Return res;
   END Quantification_F;


   FUNCTION Quantification_T (Nb_De_Bits : IN Positive ; Max : IN Float ; MaxQ : IN Natural; Valeurs : Tab_T) RETURN Tab_TQ IS
      Res : Tab_TQ;
      RealMax : constant Float := Max*Float((2**Bits_Per_Echantillon_Origine)/MaxQ);
      Pas : constant Float := 2.0*RealMax/(2.0**Nb_De_Bits);
   BEGIN
      FOR I IN Valeurs'RANGE LOOP
         Res (I) := Integer(Float'Floor((RealMax+Valeurs(I))/Pas));
      END LOOP;
      Return res;
   END Quantification_T;



   FUNCTION TFD (Coeffs : IN Tab_TQ ; Expo : IN Tab_Exp ; Nb_de_bits : IN natural) RETURN Resultat_TFD IS
      Travail : Tab_F;
      Res : Resultat_TFD;
      Pre_Quantification : Tab_F;
      Maximum : Float:=0.0;
      Ampli_Max : Natural := 0.0;
   BEGIN
      FOR I IN Travail'RANGE LOOP
         IF Travail(I) > 0 Ampli_Max

      FOR K IN Res.Tab'RANGE LOOP
         -- première itération pour remplir le tableau de travail
         FOR I IN Travail'range LOOP
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
      RETURN (Quantification_F (Nb_de_bits, Maximum, Pre_Quantification));
   END TFD;



  END Fft;
