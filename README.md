# RL Analyzer

Ensemble de skills pour agents IA. Structure et pilote le cycle d'analyse, de revue, d'implementation et de validation d'une demande ou tache.

## Installation

### Claude Code

```bash
cd ~/.claude/skills
git clone https://github.com/RivoLink/rl-analyzer.git
```

### Codex CLI

```bash
cd ~/.agents/skills
git clone https://github.com/RivoLink/rl-analyzer.git
```

## Skills

### `help`

Affiche la liste des skills disponibles et le flux d'analyse recommande.

```
/rl-analyzer:help
```

### `init`

Initialise l'environnement de travail du projet : ajoute les entrees `*.rl` et `/.notes` au `.gitignore`, puis cree l'arborescence `.notes/claude/` (asks, docs, imgs, outs).

```
/rl-analyzer:init
```

### `best-practices`

Ajoute des bonnes pratiques au fichier `.notes/claude/docs/best-practices.md`. Les pratiques sont organisees par sections thematiques.

```
/rl-analyzer:best-practices toujours utiliser 4 espaces pour l'indentation
```

### `analysis`

Analyse une demande ou tache decrite dans un fichier ask sans modifier le code source. Produit une analyse detaillee avec une table QA de 10 tests dans `.notes/claude/outs/`. Si un "Rapport de revue" existe dans l'analyse, il traite les corrections et integre les reponses aux questions.

```
/rl-analyzer:analysis .notes/claude/asks/feature.txt
```

### `review`

Effectue une revue critique de l'analyse : detecte les incoherences entre la demande et l'analyse, les regressions potentielles, et pose des questions. Ajoute une section "Rapport de revue" a l'analyse. Ne modifie pas le code.

```
/rl-analyzer:review .notes/claude/asks/feature.txt
```

### `process`

Applique les modifications de code selon l'analyse, en respectant les normes du projet et les bonnes pratiques.

```
/rl-analyzer:process .notes/claude/asks/feature.txt
```

### `validate`

Effectue une revue critique des modifications de code : verifie la coherence avec la demande et l'analyse, les bonnes pratiques et les regressions. Produit un "Rapport de validation" (Valide/Non valide) dans l'analyse. Ne modifie pas le code.

```
/rl-analyzer:validate .notes/claude/asks/feature.txt
```

### `re-process`

Traite les corrections identifiees dans le "Rapport de validation". Modifie le code uniquement pour resoudre les points du rapport, sans analyse supplementaire.

```
/rl-analyzer:re-process .notes/claude/asks/feature.txt
```

## Workflow

```
init ─► best-practices ─► analysis ◄──► review ─► process ─► validate
                                                                 │
                                                                 ▼
                                                            Non valide ?
                                                                 │
                                                                 ▼
                                                 validate ◄─ re-process
                                                     │
                                                     ▼
                                                  Valide ? ─► Termine
```

**Deux boucles :**

1. **analysis / review** : la revue identifie les incoherences et pose des questions. L'utilisateur repond aux questions, puis relance analysis qui corrige l'analyse en consequence. Ce cycle continue jusqu'a ce que la revue ne detecte plus de probleme.

2. **validate / re-process** : la validation identifie les points non conformes. re-process corrige le code, puis validate est relance. Ce cycle continue jusqu'a obtenir le statut "Valide".
