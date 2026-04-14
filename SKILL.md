---
name: rl-analyzer
description: >
  Ensemble de commandes pour structurer et piloter le cycle d'analyse, de revue, d'implementation
  et de validation d'une demande ou tache. Commandes disponibles : help, init, best-practices,
  asking, analysis, review, process, validate, re-process.
argument-hint: <commande> [arguments]
disable-model-invocation: true
---

# RL Analyzer

Executer la commande **$0**.

Identifier la commande parmi les sections ci-dessous et suivre ses instructions. Les arguments supplementaires sont : `$ARGUMENTS`.

## Resolution du parametre

Applicable aux commandes qui acceptent `<path/to/ask.txt|ask-analysis.md>` :

- Si le parametre est un fichier de demande (`ask.txt`, `ask.md`), retrouver l'analyse correspondante dans `.notes/claude/outs/` (meme nom sans extension + `-analysis.md`).
- Si le parametre est directement un fichier `*-analysis.md`, l'utiliser et retrouver la demande correspondante dans `.notes/claude/asks/` (meme nom sans le suffixe `-analysis`, au format `.txt` ou `.md`).

---

## Commande : help

Afficher le message suivant a l'utilisateur :

**RL Analyzer** — Commandes disponibles :

1. **init** — Initialise l'environnement de travail du projet.
2. **best-practices** `<comment>` — Ajoute des bonnes pratiques.
3. **asking** `<prompt>` — Cree un fichier de demande a partir d'un prompt.
4. **analysis** `<path/to/ask.txt>` `<comment>` — Analyse une demande sans modifier le code.
5. **review** `<path>` `<comment>` — Revue critique de l'analyse.
6. **process** `<path>` `<comment>` — Applique les modifications de code.
7. **validate** `<path>` `<comment>` — Revue critique des modifications de code.
8. **re-process** `<path>` `<comment>` — Corrige le code selon le rapport de validation.

**Syntaxe :** `/rl-analyzer <commande> [arguments]`

**Flux recommande :**

```
asking ──> analysis <──> review ──> process ──> validate <──> re-process
```

- **Boucle 1** : `analysis` et `review` jusqu'a ce que l'analyse soit coherente.
- **Boucle 2** : `validate` et `re-process` jusqu'a obtenir le statut "Valide".

---

## Commande : init

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

---

## Commande : best-practices

Ajouter des bonnes pratiques au fichier de reference du projet.

**Arguments :** `<comment>` — Description des bonnes pratiques a ajouter.

1. Ouvrir `.notes/claude/docs/best-practices.md`. Si le fichier n'existe pas, le creer avec un titre `# Bonnes pratiques`.
2. Ajouter les bonnes pratiques decrites dans `<comment>`, formulees de maniere concise.
3. Organiser les ajouts par sections thematiques si applicable.
4. Confirmer a l'utilisateur les pratiques ajoutees.

---

## Commande : asking

Creer un fichier de demande a partir du prompt utilisateur.

**Arguments :**
- `<prompt>` — Prompt libre decrivant la demande.

**Fichier de sortie :** `.notes/claude/asks/<slug>.txt`.

**Comportement :**

1. Si le prompt est vide, **demander interactivement** a l'utilisateur de fournir un prompt. Ne pas continuer tant qu'un prompt non vide n'est pas obtenu.
2. **Reformuler** le prompt pour plus de clarte tout en conservant strictement le sens d'origine : corriger la syntaxe, clarifier les tournures ambigues, retirer les typos. Ne pas ajouter d'information absente de l'original.
3. Generer un nom de fichier en **kebab-case** derive du prompt (slug) :
   - Conserver uniquement les caracteres `[a-zA-Z0-9]`, passer en minuscules.
   - Remplacer tout autre caractere (espaces, ponctuation, accents, symboles) par `-`.
   - Fusionner les tirets consecutifs, retirer les tirets de debut/fin.
   - Tronquer le slug a **60 caracteres maximum** (limite appliquee au slug seul, avant tout suffixe). Retrimer les tirets de fin apres troncature.
4. Cible : `.notes/claude/asks/<slug>.txt`.
5. **Collision de nom** : si `<slug>.txt` existe deja, utiliser une **indexation numerique** incrementale (`<slug>-1.txt`, `<slug>-2.txt`, ...) jusqu'a obtenir un nom libre. Pas d'ecrasement.
6. Creer le dossier `.notes/claude/asks/` s'il n'existe pas.
7. Ecrire dans le fichier le **prompt reformule** (texte brut, sans en-tete, sans metadonnees).
8. Afficher a l'utilisateur :
   - Le chemin relatif cree : `.notes/claude/asks/<slug>.txt`.
   - La commande pour enchainer : `/rl-analyzer analysis .notes/claude/asks/<slug>.txt`.

**Regles :**
- **Ne jamais modifier le code source.** Cette commande ne produit qu'un fichier ask.
- **Ne pas declencher l'analyse automatiquement.** Se contenter de la proposer.
- **Ne pas ajouter d'en-tete** dans le fichier (pas de date, pas d'auteur, pas de titre).
- **Ne pas alterer le sens du prompt** lors de la reformulation.

---

## Commande : analysis

Analyser une demande ou une tache sans modifier le code source.

**Arguments :**
- `<path/to/ask.txt>` — Chemin vers le fichier de demande (normalement dans `.notes/claude/asks/`, generalement `.txt`, peut aussi etre `.md`).
- `<comment>` — Informations supplementaires (optionnel).

**Fichier de sortie :** `.notes/claude/outs/` avec le meme nom que la source (sans extension), suffixe par `-analysis.md`.
- `.notes/claude/asks/feature.txt` → `.notes/claude/outs/feature-analysis.md`
- `.notes/claude/asks/feature.md` → `.notes/claude/outs/feature-analysis.md`

**Comportement :**

1. Lire et analyser la demande decrite dans `<path/to/ask.txt>`.
2. Prendre en compte les informations supplementaires fournies dans `<comment>`.
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

**Regles :**
- **Ne jamais modifier le code source.** Cette commande produit uniquement une analyse.
- **Ne jamais remplir** les colonnes Etat et Screenshot de la table QA. Elles sont reservees a une validation manuelle.

---

## Commande : review

Effectuer une revue critique d'une analyse existante sans modifier le code source.

**Arguments :**
- `<path/to/ask.txt|ask-analysis.md>` — Chemin vers le fichier de demande ou directement vers l'analyse.
- `<comment>` — Informations supplementaires (optionnel).

**Prerequis :** L'analyse correspondante doit exister dans `.notes/claude/outs/`. Si elle est absente, **demander a l'utilisateur** de d'abord produire une analyse. Ne pas continuer sans l'analyse.

**Comportement :**

1. Lire la demande originale et l'analyse correspondante.
2. Detecter les **incoherences** entre la demande et l'analyse.
3. Detecter les **incoherences internes** dans l'analyse elle-meme.
4. Detecter les **regressions potentielles** si applicable.
5. Poser des **questions** si des zones d'ombre subsistent.
6. Mettre a jour le fichier `*-analysis.md` pour y ajouter une section **"Rapport de revue"** contenant les incoherences et les questions identifiees.

**Regles :**
- **Ne jamais modifier le code source.** Cette commande produit uniquement une revue.

---

## Commande : process

Realiser les modifications de code en suivant strictement une analyse existante.

**Arguments :**
- `<path/to/ask.txt|ask-analysis.md>` — Chemin vers le fichier de demande ou directement vers l'analyse.
- `<comment>` — Informations supplementaires (optionnel).

**Prerequis :** L'analyse correspondante doit exister dans `.notes/claude/outs/`. Si elle est absente, **demander a l'utilisateur** de d'abord produire une analyse. Ne pas continuer sans l'analyse.

**Comportement :**

1. Lire l'analyse correspondante.
2. Appliquer les modifications de code decrites dans l'analyse.
3. Respecter les **normes et standards** du code existant dans le projet.
4. Suivre les **bonnes pratiques** definies dans `.notes/claude/docs/best-practices.md` si le fichier existe.

**Regles :**
- **Modifier le code** en suivant strictement l'analyse.
- **Ne pas prendre de decisions** en dehors du perimetre de l'analyse.

---

## Commande : validate

Effectuer une revue critique des modifications de code sans modifier le code source.

**Arguments :**
- `<path/to/ask.txt|ask-analysis.md>` — Chemin vers le fichier de demande ou directement vers l'analyse.
- `<comment>` — Informations supplementaires (optionnel).

**Prerequis :** L'analyse correspondante doit exister dans `.notes/claude/outs/`. Si elle est absente, **demander a l'utilisateur** de d'abord produire une analyse. Ne pas continuer sans l'analyse.

**Comportement :**

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

**Regles :**
- **Ne jamais modifier le code source.** Cette commande produit uniquement un rapport de validation.

---

## Commande : re-process

Traiter les corrections identifiees dans le rapport de validation.

**Arguments :**
- `<path/to/ask.txt|ask-analysis.md>` — Chemin vers le fichier de demande ou directement vers l'analyse.
- `<comment>` — Informations supplementaires (optionnel).

**Prerequis :**
- L'analyse correspondante doit exister dans `.notes/claude/outs/`. Si elle est absente, **demander a l'utilisateur** de d'abord produire une analyse.
- L'analyse doit contenir une section **"Rapport de validation"**. Si elle est absente, **demander a l'utilisateur** de d'abord lancer une validation.
- Ne pas continuer si l'un de ces prerequis n'est pas rempli.

**Comportement :**

1. Lire la section **"Rapport de validation"** dans l'analyse.
2. Traiter chaque point/note identifie dans le rapport.
3. Appliquer les corrections de code necessaires.
4. Respecter les **normes et standards** du code existant dans le projet.
5. Suivre les **bonnes pratiques** definies dans `.notes/claude/docs/best-practices.md` si le fichier existe.

**Regles :**
- **Modifier le code** uniquement pour traiter les points du rapport de validation.
- **Ne faire aucune analyse.** Ne pas prendre de decisions en dehors du perimetre du rapport.
- **Ne pas modifier la section "Rapport de validation".** Sa mise a jour est le role de la commande validate.
