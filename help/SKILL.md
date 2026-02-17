---
name: help
description: >
  Affiche la liste des skills rl-analyzer avec une breve description et le flux d'analyse recommande.
  Utiliser quand l'utilisateur invoque "rl-analyzer:help" ou demande de l'aide sur les skills disponibles.
---

# rl-analyzer:help

Afficher la liste des skills et le flux d'analyse.

## Comportement

Afficher le message suivant a l'utilisateur :

---

**RL Analyzer** — Skills disponibles :

1. **rl-analyzer:init** — Initialise l'environnement de travail du projet (`.gitignore` et arborescence `.notes/claude/`).
2. **rl-analyzer:best-practices** `<comment>` — Ajoute des bonnes pratiques au fichier `.notes/claude/docs/best-practices.md`.
3. **rl-analyzer:analysis** `<path/to/ask.txt>` `<comment>` — Analyse une demande sans modifier le code. Produit une analyse avec table QA dans `.notes/claude/outs/`.
4. **rl-analyzer:review** `<path>` `<comment>` — Revue critique de l'analyse. Detecte les incoherences et pose des questions dans un "Rapport de revue".
5. **rl-analyzer:process** `<path>` `<comment>` — Applique les modifications de code selon l'analyse.
6. **rl-analyzer:validate** `<path>` `<comment>` — Revue critique des modifications de code. Produit un "Rapport de validation" (Valide/Non valide).
7. **rl-analyzer:re-process** `<path>` `<comment>` — Corrige le code selon les points du "Rapport de validation".

**Flux recommande :**

```
analysis ◄──► review ──► process ──► validate ◄──► re-process
```

- **Boucle 1** : `analysis` et `review` jusqu'a ce que l'analyse soit coherente.
- **Boucle 2** : `validate` et `re-process` jusqu'a obtenir le statut "Valide".
