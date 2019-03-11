-- 1. Afficher tous les jeux sans afficher l'id 

SELECT nom FROM jeux_video


-- 2. Afficher les jeux ordonnés par prix descendant

SELECT nom, prix FROM jeux_video ORDER by prix DESC


-- 3. Afficher tous les jeux de Patrick

SELECT * FROM jeux_video WHERE possesseur LIKE 'patrick%' 


-- 3.1 Afficher tous les jeux de Patrick

SELECT nom, possesseur FROM jeux_video WHERE possesseur LIKE 'patrick%'


-- 4. Répondre à la question : "Quel est la moyenne du nombre de joueur par jeu ?"

SELECT nom, nbre_joueurs_max AVG FROM `jeux_video` AS nbre_joueurs_max ORDER BY AVG 
DESC


-- 5. Répondre à la question : "Quel est le ou les jeu(x) le plus cher ?"

SELECT nom, prix FROM `jeux_video` WHERE prix=ALL(SELECT MAX(prix)FROM jeux_video)


-- 6. Afficher les jeux qui sont sur "Xbox"

SELECT nom , console FROM `jeux_video` WHERE console='Xbox' 


-- 7. Affcher le nombre de jeux qui sont sur la "Xbox"

SELECT console, COUNT(console) FROM `jeux_video` WHERE console='Xbox' 

-- 8. Afficher le nombre de jeux par console

SELECT console, COUNT( console ) FROM `jeux_video` GROUP BY console ORDER BY COUNT(console) ASC 

-- 9. Afficher le nombre de jeux par personne

SELECT possesseur, COUNT( nom ) FROM `jeux_video` GROUP BY possesseur ORDER BY COUNT(possesseur) ASC 

-- 10. Afficher les jeux qui contiennent la lettre "x" dans leur nom

SELECT nom FROM `jeux_video` WHERE nom LIKE '%x%'

-- 11. Afficher les jeux qui commence par "fi"

SELECT nom FROM `jeux_video` WHERE nom LIKE 'fi%' 

-- 12. Repondre à la question : "Quels sont les personnes qui possèdent les jeux qui commence par "fi" ?"

SELECT nom, possesseur FROM `jeux_video` WHERE nom LIKE 'fi%' 

-- 13. Repondre à la question : "Combien Corentin a t il de console ?"

SELECT possesseur, COUNT(console) FROM `jeux_video` WHERE possesseur='Corentin' 


-- # Exercice 3 : Optimisation --

-- Voici une règle d'or : --
-- " Une donnée qui ne fait pas partie de la clé ne doit être stockée qu'à un seul endroit dans la base de données. " --

-- Sachant cela, on voudrait réaliser une nouvelle base de données sur les jeux, qui contiennent les même informations, mais sans aucunes répétitions. --

-- Comment faire ?--

-- A rendre : une capture d'écran du concepteur(Designer en anglais), si possible, sinon l'exportation de la base de données.  --



INSERT INTO possesseur (nom_possesseur) SELECT DISTINCT possesseur FROM `jeux_video`

INSERT INTO console (nom_console) SELECT DISTINCT console FROM `jeux_video`


-- Exercice 3 tableau --

-- 1. Afficher tous les jeux sans afficher l'id 

SELECT nom FROM jeux_video


-- 2. Afficher les jeux ordonnés par prix descendant

SELECT nom, prix FROM jeux_video ORDER by prix DESC


-- 3. Afficher tous les jeux de Patrick

SELECT nom FROM jeux_video WHERE jeux_video.id_possesseur=2

-- 3.1 Afficher tous les jeux de Patrick

SELECT nom, possesseur.nom_possesseur  FROM jeux_video JOIN possesseur ON jeux_video.id_possesseur=possesseur.id_possesseur WHERE possesseur.nom_possesseur LIKE 'patrick%'

-- 4. Répondre à la question : "Quel est la moyenne du nombre de joueur par jeu ?"

SELECT nom, nbre_joueurs_max AVG FROM `jeux_video` AS nbre_joueurs_max ORDER BY AVG 
DESC


-- 5. Répondre à la question : "Quel est le ou les jeu(x) le plus cher ?"

SELECT nom, prix FROM `jeux_video` WHERE prix=ALL(SELECT MAX(prix)FROM jeux_video)


-- 6. Afficher les jeux qui sont sur "Xbox"

SELECT nom, console.nom_console FROM jeux_video JOIN console ON jeux_video.id_console=console.id_console WHERE console.nom_console LIKE 'xbox%'

-- 7. Affcher le nombre de jeux qui sont sur la "Xbox"

SELECT console.nom_console, COUNT(nom_console) FROM jeux_video JOIN console ON jeux_video.id_console=console.id_console WHERE console.nom_console LIKE 'xbox'

-- 8. Afficher le nombre de jeux par console

SELECT console.nom_console, COUNT(nom) FROM jeux_vid JOIN console ON jeux_vid.id_console=console.id_console GROUP BY nom_console ASC

-- 9. Afficher le nombre de jeux par personne

SELECT nom_possesseur, COUNT(nom) FROM jeux_vid JOIN possesseur ON possesseur.id_possesseur=jeux_vid.id_possesseur GROUP BY possesseur.nom_possesseur

-- 10. Afficher les jeux qui contiennent la lettre "x" dans leur nom

SELECT nom FROM `jeux_video` WHERE nom LIKE '%x%'

-- 11. Afficher les jeux qui commence par "fi"

SELECT nom FROM `jeux_video` WHERE nom LIKE 'fi%' 

-- 12. Repondre à la question : "Quels sont les personnes qui possèdent les jeux qui commence par "fi" ?"

SELECT
    nom,
    nom_possesseur
FROM
    `jeux_vid`
JOIN possesseur ON possesseur.id_possesseur = jeux_vid.id_possesseur
WHERE
    nom LIKE 'fi%'
    
-- 13. Repondre à la question : "Combien Corentin a t il de console ?"

SELECT
    nom_possesseur,
    COUNT(nom_console)
FROM
    jeux_vid
JOIN possesseur ON possesseur.id_possesseur = jeux_vid.id_possesseur
JOIN console ON console.id_console = jeux_vid.id_console
WHERE
    nom_possesseur LIKE 'corentin%'