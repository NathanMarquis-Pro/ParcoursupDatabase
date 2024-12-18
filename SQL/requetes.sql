select n57,(n56-n58-n59) from import;

select count(*) from import where n57<>(n56-n58-n59);

select n74,ROUND((n51/n47)*100) from import where n47 <> 0;

select count(*) from import where n47 <> 0 and n74<>ROUND((n51/n47)*100);

select n76,ROUND((n53/n47)*100) from import where n47 <> 0;

select round((f.effectif_admis_recu_proposition_avant_fin/i.effectif_admis)*100) from formations as f, inscrits as i where f.fno = i.fno and i.effectif_admis <> 0;

select n81,round((n55/n56)*100) from import where n56 <> 0;

select round((effectif_admis_boursiers_neobacheliers/effectif_admis)*100) 
from formations as f, inscrits as i 
where f.fno = i.fno and effectif_admis <> 0 and (type_inscrits = 'généraux' OR type_inscrits = 'technologiques' OR type_inscrits = 'professionnels');