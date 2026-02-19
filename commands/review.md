---
name: review
description: >
  Effectue une revue critique de l'analyse associee a une demande, sans modifier le code source.
  Detecte les incoherences, regressions potentielles et pose des questions.
argument-hint: <path/to/ask.txt|ask-analysis.md> [comment]
disable-model-invocation: true
---

Effectuer une revue critique d'une analyse existante sans modifier le code source.

**Parametre :** `$0`
**Informations supplementaires :** `$ARGUMENTS`

## Resolution du parametre

- Si le parametre est un fichier de demande (`ask.txt`, `ask.md`), retrouver l'analyse correspondante dans `.notes/claude/outs/` (meme nom sans extension + `-analysis.md`).
- Si le parametre est directement un fichier `*-analysis.md`, l'utiliser et retrouver la demande correspondante dans `.notes/claude/asks/` (meme nom sans le suffixe `-analysis`, au format `.txt` ou `.md`).

## Prerequis

L'analyse correspondante doit exister dans `.notes/claude/outs/`. Si elle est absente, **demander a l'utilisateur** de d'abord produire une analyse. Ne pas continuer sans l'analyse.

## Comportement

1. Lire la demande originale et l'analyse correspondante.
2. Detecter les **incoherences** entre la demande et l'analyse.
3. Detecter les **incoherences internes** dans l'analyse elle-meme.
4. Detecter les **regressions potentielles** si applicable.
5. Poser des **questions** si des zones d'ombre subsistent.
6. Mettre a jour le fichier `*-analysis.md` pour y ajouter une section **"Rapport de revue"** contenant les incoherences et les questions identifiees.

## Regles

- **Ne jamais modifier le code source.** Cette commande produit uniquement une revue.
