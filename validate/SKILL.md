---
name: validate
description: >
  Effectue une revue critique des modifications de code en cours, sans modifier le code source.
  Verifie la coherence avec la demande et l'analyse, les bonnes pratiques et les regressions.
  Produit un rapport de validation (Valide/Non valide) dans l'analyse.
  Utiliser quand l'utilisateur invoque "rl-analyzer:validate" avec un chemin vers un fichier
  ask ou ask-analysis.
---

# rl-analyzer:validate

Effectuer une revue critique des modifications de code sans modifier le code source.

## Arguments

- `<path/to/ask.txt|ask-analysis.md>` : Chemin vers le fichier de demande ou directement vers l'analyse.
- `<comment>` : Informations supplementaires (optionnel).

## Resolution du parametre

- Si le parametre est un fichier de demande (`ask.txt`, `ask.md`), retrouver l'analyse correspondante dans `.notes/claude/outs/` (meme nom sans extension + `-analysis.md`).
- Si le parametre est directement un fichier `*-analysis.md`, l'utiliser et retrouver la demande correspondante dans `.notes/claude/asks/` (meme nom sans le suffixe `-analysis`, au format `.txt` ou `.md`).

## Prerequis

L'analyse correspondante doit exister dans `.notes/claude/outs/`. Si elle est absente, **demander a l'utilisateur** de d'abord produire une analyse. Ne pas continuer sans l'analyse.

## Comportement

1. Faire une revue critique des modifications de code realisees.
2. Verifier la **coherence** entre les modifications, la demande et l'analyse.
3. Verifier que les modifications respectent les **bonnes pratiques** definies dans `.notes/claude/docs/best-practices.md` si le fichier existe.
4. Verifier les **regressions potentielles** introduites par les modifications.
5. Mettre a jour l'analyse en ajoutant (ou en mettant a jour) une section **"Rapport de validation"** contenant :
   - Le statut de validation : **Valide** ou **Non valide**.
   - Si **Non valide** : les notes, remarques et questions detaillees, suffisamment documentees pour etre traitees.
6. Si une section "Rapport de validation" existe deja :
   - Verifier si les points precedemment releves ont ete traites.
   - Supprimer les points resolus.
   - Conserver les points non resolus dans la version mise a jour de la section.

## Regles

- **Ne jamais modifier le code source.** Ce skill produit uniquement un rapport de validation.
