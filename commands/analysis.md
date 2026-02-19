---
name: analysis
description: >
  Analyse une demande ou tache decrite dans un fichier ask sans modifier le code source.
  Produit une analyse detaillee avec table QA dans .notes/claude/outs/.
argument-hint: <path/to/ask.txt> [comment]
disable-model-invocation: true
---

Analyser une demande ou une tache sans modifier le code source.

**Fichier de demande :** `$0`
**Informations supplementaires :** `$ARGUMENTS`

## Fichier de sortie

Le resultat est enregistre dans `.notes/claude/outs/` avec le meme nom que la source (sans extension), suffixe par `-analysis.md`.
- `.notes/claude/asks/feature.txt` → `.notes/claude/outs/feature-analysis.md`
- `.notes/claude/asks/feature.md` → `.notes/claude/outs/feature-analysis.md`

## Comportement

1. Lire et analyser la demande decrite dans le fichier de demande.
2. Prendre en compte les informations supplementaires si fournies.
3. Si le fichier de sortie existe deja, verifier s'il contient une section **"Rapport de revue"**. Si oui :
   - Lire chaque incoherence et question identifiee dans le rapport de revue.
   - Corriger les points concernes dans l'analyse (reformuler, completer ou supprimer les parties incoherentes).
   - Les questions du rapport de revue sont repondues manuellement par l'utilisateur. Integrer ses reponses dans l'analyse.
   - Si des questions n'ont pas encore de reponse, les conserver dans la section "Rapport de revue".
   - Une fois tous les points traites et toutes les questions repondues, supprimer la section "Rapport de revue" de l'analyse mise a jour.
4. Explorer le code source du projet pour comprendre le contexte technique.
5. Produire (ou mettre a jour) une analyse detaillee au format Markdown couvrant :
   - Comprehension de la demande
   - Impact sur le code existant
   - Approche technique recommandee
   - Points d'attention
6. Ajouter en fin d'analyse une **table QA** avec trois colonnes et 10 lignes de tests :

   | Intitule | Etat | Screenshot |
   |----------|------|------------|
   | Test 1   |      |            |
   | ...      |      |            |

7. Enregistrer le resultat dans le fichier de sortie.

## Regles

- **Ne jamais modifier le code source.** Cette commande produit uniquement une analyse.
- **Ne jamais remplir** les colonnes Etat et Screenshot de la table QA. Elles sont reservees a une validation manuelle.
