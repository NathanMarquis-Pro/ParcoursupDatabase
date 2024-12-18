DROP TABLE if exists import CASCADE;
DROP TABLE if exists inscrits CASCADE;
DROP TABLE if exists formations CASCADE;
DROP TABLE if exists etablissements CASCADE;
DROP TABLE if exists communes CASCADE;

\! rm -f -r ./tmp
\! mkdir ./tmp 
--Crée un dossier tmp

\echo téléchargement du fichier
\! curl "https://data.enseignementsup-recherche.gouv.fr/api/explore/v2.1/catalog/datasets/fr-esr-parcoursup/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&delimiter=%3B" > ./tmp/data.csv

\echo nombre de lignes du fichier initial :
\! wc -l tmp/data.csv 
--compte le nombre de lignes, Q1.1 il y en a 13870

--Q1.2 Une ligne représente un ensemble de donnée dont l'intitulé est inscrit dans la première ligne, chaque donnée étant séparée par un séparateur : ";"

\echo nombre de colonnes du fichier initial :
\! head -n1 tmp/data.csv | tr ";" "\n" | wc -l
--compte le nombre de colonnes, Q1.3 il y en a 118
--On obtient ce nombre en isolant la 1ère ligne, en remplaçant chaque séparateur par un retour à la ligne (\n) et en comptant le nombre de lignes


CREATE temp TABLE import (
    n1 NUMERIC(4) default null,n2 text default null,n3 char(8) default null,n4 text default null,n5 char(3) default null,n6 text default null,n7 text default null,n8 text default null,n9 text default null,
    n10 text default null,n11 text default null,n12 text default null,n13 text default null,n14 text default null,n15 text default null,n16 text default null,n17 text default null,
    n18 int default null,n19 int default null,n20 int default null,n21 int default null,n22 text default null,n23 int default null,n24 int default null,n25 int default null,
    n26 int default null,n27 int default null,n28 int default null,n29 int default null,n30 int default null,n31 int default null,n32 int default null,n33 int default null,
    n34 int default null,n35 int default null,n36 int default null,n37 text default null,n38 text default null,n39 int default null,n40 int default null,n41 int default null,
    n42 int default null,n43 int default null,n44 int default null,n45 int default null,n46 int default null,n47 int default null,n48 int default null,n49 int default null,
    n50 int default null,n51 real default null,n52 real default null,n53 real default null,n54 text default null,n55 int default null,n56 int default null,n57 int default null,
    n58 int default null,n59 int default null,n60 int default null,n61 int default null,n62 int default null,n63 int default null,n64 int default null,n65 int default null,
    n66 real default null,n67 real default null,n68 int default null,n69 int default null,n70 text default null,n71 text default null,n72 int default null,n73 int default null,
    n74 real default null,n75 real default null,n76 real default null,n77 real default null,n78 real default null,n79 real default null,n80 real default null,n81 real default null,
    n82 real default null,n83 real default null,n84 real default null,n85 real default null,n86 real default null,n87 real default null,n88 real default null,n89 real default null,
    n90 real default null,n91 real default null,n92 real default null,n93 real default null,n94 real default null,n95 real default null,n96 real default null,n97 real default null,
    n98 real default null,n99 real default null,n100 real default null,n101 real default null,n102 text default null,n103 text default null,n104 text default null,n105 text default null,
    n106 text default null,n107 text default null,n108 text default null,n109 text default null,n110 int default null,n111 text default null,n112 text default null,n113 text default null,
    n114 real default null,n115 real default null,n116 real default null,n117 text default null,n118 text );

\copy import from './tmp/data.csv' with (delimiter ';', encoding 'UTF-8', HEADER) 
--.mod csv
--.separator ";"
--.import --skip 1 -v tmp/data.csv import 
\echo Création des tables

CREATE TABLE communes (
    cno serial,
    nom_com text,
    depno char(3),
    nom_departement text,
    region text,
    constraint pk_communes primary key (cno)
);

CREATE TABLE etablissements (
    eno serial,
    UAI text,
    nom_eta text,
    statut_eta text,
    academie text,
    cno int,
    constraint pk_etablissements primary key (eno),
    constraint fk_communes foreign key (cno)
    references communes(cno)
    on update cascade
);

CREATE TABLE formations (
    fno serial,
    code_form int,
    nom text not null,
    eno_eta int,
    coordonnees text,
    annee date default '2023-01-01',
    selectivite text,
    lien text,
    capacite int,
    concours text,
    effectif_total int,
    effectif_candidates int,
    effectif_total_phase_principale int,
    effectif_total_internat text,
    effectif_total_classe_principale int,
    effectif_total_classe_complementaire int,
    effectif_total_classe_internat text,
    effectif_total_recu_proposition int,
    effectif_admises int,
    effectif_admis_principale int,
    effectif_admis_complementaire int,
    effectif_admis_internat text,
    effectif_admis_boursiers_neobacheliers int,
    effectif_admis_recu_proposition_ouverture int,
    effectif_admis_recu_proposition_avant_fin int,
    effectif_admis_sans_mention int,
    effectif_admis_mentionAB int,
    effectif_admis_mentionB int,
    effectif_admis_mentionTB int,
    effectif_admis_mentionTB_felicitations int,
    constraint pk_formations primary key (fno),
    constraint fk_etablissements foreign key (eno_eta)
    references etablissements(eno)
    on update cascade
);

CREATE TABLE inscrits (
    fno int,
    type_inscrits text check(type_inscrits = 'généraux' OR type_inscrits = 'technologiques' 
        OR type_inscrits = 'professionnels' OR type_inscrits = 'autres'),
    effectif_phase_principale int,
    effectif_phase_principale_boursiers int default 0,
    effectif_phase_complementaire int,
    effectif_classés int,
    effectif_classés_boursiers int default 0,
    effectif_admis int,
    effectif_admis_mention int default 0,
    constraint pk_inscrits primary key (fno, type_inscrits),
    constraint fk_formations foreign key (fno)
    references formations(fno)
    on update cascade
);

\echo Insertions des données dans communes

INSERT INTO communes(nom_com, depno, nom_departement, region)
select distinct n9, n5, n6, n7 from import where n9 <> '' order by n5 asc;

\echo Insertions des données dans etablissements

INSERT INTO etablissements(UAI, nom_eta, statut_eta, academie, cno)
select distinct n3, n4, n2, n8, cno from import, communes where n9=nom_com 
order by n3;

DELETE FROM etablissements
where eno IN (select e1.eno
FROM etablissements AS e1, etablissements AS e2
WHERE e1.eno > e2.eno
AND e1.UAI = e2.UAI);

\echo Insertions des données dans formations

INSERT INTO formations(code_form, nom,eno_eta,coordonnees,selectivite,lien,capacite,concours,effectif_total,effectif_candidates,
effectif_total_phase_principale,effectif_total_internat,effectif_total_classe_principale,
effectif_total_classe_complementaire,effectif_total_classe_internat,effectif_total_recu_proposition,effectif_admises,
effectif_admis_principale,effectif_admis_complementaire,effectif_admis_internat,effectif_admis_boursiers_neobacheliers,
effectif_admis_recu_proposition_ouverture,effectif_admis_recu_proposition_avant_fin,effectif_admis_sans_mention,effectif_admis_mentionAB,
effectif_admis_mentionB,effectif_admis_mentionTB,effectif_admis_mentionTB_felicitations)
select distinct n110, n10, eno, n17, n11, n112, n18, n111, n19, n20,
n21, n22, n35, n36, n37, n46, n48, n49, n50, n54, n55, n51, n53, n62, n63,n64,n65,n66
from import, etablissements
where nom_eta = n4
order by n110 asc ;

DELETE FROM formations
where fno IN (select f1.fno
FROM formations AS f1, formations AS f2
WHERE f1.fno > f2.fno
AND f1.code_form = f2.code_form);


INSERT INTO inscrits(fno, type_inscrits, effectif_phase_principale, effectif_phase_principale_boursiers,
    effectif_phase_complementaire, effectif_classés, effectif_classés_boursiers, effectif_admis, effectif_admis_mention)
select fno, 'généraux', n23, n24, n31, n39, n40, n57, n67
from formations, import
where code_form = n110;

INSERT INTO inscrits(fno, type_inscrits, effectif_phase_principale, effectif_phase_principale_boursiers,
    effectif_phase_complementaire, effectif_classés, effectif_classés_boursiers, effectif_admis, effectif_admis_mention)
select fno, 'technologiques', n25, n26, n32, n41, n42, n58, n68
from formations, import
where code_form = n110;

INSERT INTO inscrits(fno, type_inscrits, effectif_phase_principale, effectif_phase_principale_boursiers,
    effectif_phase_complementaire, effectif_classés, effectif_classés_boursiers, effectif_admis, effectif_admis_mention)
select fno, 'professionnels', n27, n28, n33, n43, n44, n59, n69
from formations, import
where code_form = n110;

INSERT INTO inscrits(fno, type_inscrits, effectif_phase_principale, effectif_phase_complementaire, effectif_classés, effectif_admis)
select fno, 'autres', n29, n34, n45, n60
from formations, import
where code_form = n110;

\! rm -f -r ./tmp
\echo Suppression du dossier temporaire
