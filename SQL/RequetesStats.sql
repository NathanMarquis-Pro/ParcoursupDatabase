--Pour commencer, observons les taux de candidates des deux IUT :

select SUM(effectif_candidates)/CAST(SUM(effectif_total) as float) *100 
from formations as f, etablissements as e
where f.eno_eta = e.eno
and e.nom_eta like '%IUT GRAND OUEST NORMANDIE - Pôle de Caen%' 
and f.nom LIKE '%BUT - Informatique%';

select SUM(effectif_candidates)/CAST(SUM(effectif_total) as float) *100 
from formations as f, etablissements as e
where f.eno_eta = e.eno
and e.nom_eta like '%I.U.T du Havre%' 
and f.nom LIKE '%BUT - Informatique%';

-- Puis continuons par les taux d’admis avec mention :

select SUM(i.effectif_admis_mention)/CAST(SUM(i.effectif_admis) as float) *100
from formations as f, etablissements as e, inscrits as i
where f.eno_eta = e.eno
and f.fno = i.fno
and e.nom_eta like '%I.U.T du Havre%' 
and f.nom LIKE '%BUT - Informatique%';

select SUM(i.effectif_admis_mention)/CAST(SUM(i.effectif_admis) as float) *100
from formations as f, etablissements as e, inscrits as i
where f.eno_eta = e.eno
and f.fno = i.fno
and e.nom_eta like '%IUT GRAND OUEST NORMANDIE - Pôle de Caen%' 
and f.nom LIKE '%BUT - Informatique%';

--Ensuite comparons les taux d'admis généraux et technologiques :

select SUM(i.effectif_admis)/CAST(SUM(i2.effectif_admis) as float) *100
from formations as f, etablissements as e, inscrits as i, inscrits as i2
where f.eno_eta = e.eno
and f.fno = i.fno
and f.fno = i2.fno
and e.nom_eta like '%IUT GRAND OUEST NORMANDIE - Pôle de Caen%' 
and f.nom LIKE '%BUT - Informatique%'
and i.type_inscrits = 'généraux';

select SUM(i.effectif_admis)/CAST(SUM(i2.effectif_admis) as float) *100
from formations as f, etablissements as e, inscrits as i, inscrits as i2
where f.eno_eta = e.eno
and f.fno = i.fno
and f.fno = i2.fno
and e.nom_eta like '%I.U.T du Havre%' 
and f.nom LIKE '%BUT - Informatique%'
and i.type_inscrits = 'généraux';

select SUM(i.effectif_admis)/CAST(SUM(i2.effectif_admis) as float) *100
from formations as f, etablissements as e, inscrits as i, inscrits as i2
where f.eno_eta = e.eno
and f.fno = i.fno
and f.fno = i2.fno
and e.nom_eta like '%IUT GRAND OUEST NORMANDIE - Pôle de Caen%' 
and f.nom LIKE '%BUT - Informatique%'
and i.type_inscrits = 'technologiques';

select SUM(i.effectif_admis)/CAST(SUM(i2.effectif_admis) as float) *100
from formations as f, etablissements as e, inscrits as i, inscrits as i2
where f.eno_eta = e.eno
and f.fno = i.fno
and f.fno = i2.fno
and e.nom_eta like '%I.U.T du Havre%' 
and f.nom LIKE '%BUT - Informatique%'
and i.type_inscrits = 'technologiques';

--On peut aussi comparer la capacité que chaque BUT a : 

select f.capacite 
from formations as f, etablissements as e
where f.eno_eta = e.eno
and e.nom_eta like '%IUT GRAND OUEST NORMANDIE - Pôle de Caen%' 
and f.nom LIKE '%BUT - Informatique%';

select f.capacite 
from formations as f, etablissements as e
where f.eno_eta = e.eno
and e.nom_eta like '%I.U.T du Havre%' 
and f.nom LIKE '%BUT - Informatique%';

--Ainsi que le pourcentage de candidats qui seront acceptés :

select f.capacite/cast(effectif_total as float) *100
from formations as f, etablissements as e
where f.eno_eta = e.eno
and e.nom_eta like '%IUT GRAND OUEST NORMANDIE - Pôle de Caen%' 
and f.nom LIKE '%BUT - Informatique%';

select f.capacite/cast(effectif_total as float) *100
from formations as f, etablissements as e
where f.eno_eta = e.eno
and e.nom_eta like '%I.U.T du Havre%' 
and f.nom LIKE '%BUT - Informatique%';