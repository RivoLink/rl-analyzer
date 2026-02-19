---
name: best-practices
description: >
  Ajoute des bonnes pratiques au fichier de reference .notes/claude/docs/best-practices.md.
  Utiliser quand l'utilisateur invoque "rl-analyzer:best-practices" suivi d'un commentaire
  decrivant les pratiques a ajouter.
---

# rl-analyzer:best-practices

Ajouter des bonnes pratiques au fichier de reference du projet.

## Arguments

- `<comment>` : Description des bonnes pratiques a ajouter.

## Comportement

1. Ouvrir `.notes/claude/docs/best-practices.md`.
   - Si le fichier n'existe pas, le creer avec un titre `# Bonnes pratiques`.
2. Ajouter les bonnes pratiques decrites dans `<comment>`, formulees de maniere concise.
3. Organiser les ajouts par sections thematiques si applicable.
4. Confirmer a l'utilisateur les pratiques ajoutees.
