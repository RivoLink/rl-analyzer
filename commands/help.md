---
name: help
description: >
  Affiche la liste des commandes rl-analyzer avec une breve description et le flux d'analyse recommande.
disable-model-invocation: true
---

Afficher le message suivant a l'utilisateur :

**RL Analyzer** — Commandes disponibles :

1. **rl-analyzer:init** — Initialise l'environnement de travail du projet.
2. **rl-analyzer:best-practices** `<comment>` — Ajoute des bonnes pratiques.
3. **rl-analyzer:analysis** `<path/to/ask.txt>` `<comment>` — Analyse une demande sans modifier le code.
4. **rl-analyzer:review** `<path>` `<comment>` — Revue critique de l'analyse.
5. **rl-analyzer:process** `<path>` `<comment>` — Applique les modifications de code.
6. **rl-analyzer:validate** `<path>` `<comment>` — Revue critique des modifications de code.
7. **rl-analyzer:re-process** `<path>` `<comment>` — Corrige le code selon le rapport de validation.

**Syntaxe :** `/rl-analyzer:<commande> [arguments]`

**Flux recommande :**

```
analysis <──> review ──> process ──> validate <──> re-process
```

- **Boucle 1** : `analysis` et `review` jusqu'a ce que l'analyse soit coherente.
- **Boucle 2** : `validate` et `re-process` jusqu'a obtenir le statut "Valide".
