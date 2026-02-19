---
name: init
description: >
  Initialise l'environnement de travail rl-analyzer pour un projet.
disable-model-invocation: true
---

Initialiser l'environnement de travail du projet.

1. Verifier si le fichier `.gitignore` a la racine du projet existe. Si non, le creer.
2. Verifier si le `.gitignore` contient le bloc suivant. Si absent (en tout ou en partie), l'ajouter ou le completer :
   ```
   # Custom
   *.rl
   /.notes
   ```
3. Creer l'arborescence suivante (ignorer les dossiers/fichiers qui existent deja) :
   ```
   {project-dir}
   └── .notes
       └── claude
           ├── asks/
           ├── docs/
           │   └── best-practices.md
           ├── imgs/
           ├── outs/
           └── ASK.txt
   ```
4. Confirmer a l'utilisateur les actions realisees.
