# RL Analyzer

Ensemble de commandes pour agents IA. Structure et pilote le cycle d'analyse, de revue, d'implementation et de validation d'une demande ou tache.

## Installation

### Mode skill (commande unique)

Clone le repo complet. Toutes les commandes sont accessibles via `/rl-analyzer <commande>`.

```bash
# Claude Code
cd .claude/skills
git clone https://github.com/RivoLink/rl-analyzer.git
```

```bash
# Codex CLI
cd .agents/skills
git clone https://github.com/RivoLink/rl-analyzer.git
```

### Mode commandes individuelles

Copie les fichiers de `commands/` dans `.claude/commands/rl-analyzer/` du projet. Chaque commande est accessible via `/rl-analyzer:<nom>`.

```bash
# Claude Code
curl -fsSL https://github.com/rivolink/rl-analyzer/raw/main/commands.sh | sh -s -- --claude
```

```bash
# Codex CLI
curl -fsSL https://github.com/rivolink/rl-analyzer/raw/main/commands.sh | sh -s -- --codex
```

## Commandes

| Mode skill | Mode commandes | Description |
|------------|---------------|-------------|
| `/rl-analyzer help` | `/rl-analyzer:help` | Affiche les commandes disponibles |
| `/rl-analyzer init` | `/rl-analyzer:init` | Initialise l'environnement de travail |
| `/rl-analyzer best-practices <comment>` | `/rl-analyzer:best-practices <comment>` | Ajoute des bonnes pratiques |
| `/rl-analyzer analysis <path> [comment]` | `/rl-analyzer:analysis <path> [comment]` | Analyse une demande |
| `/rl-analyzer review <path> [comment]` | `/rl-analyzer:review <path> [comment]` | Revue critique de l'analyse |
| `/rl-analyzer process <path> [comment]` | `/rl-analyzer:process <path> [comment]` | Applique les modifications de code |
| `/rl-analyzer validate <path> [comment]` | `/rl-analyzer:validate <path> [comment]` | Revue critique du code |
| `/rl-analyzer re-process <path> [comment]` | `/rl-analyzer:re-process <path> [comment]` | Corrige selon le rapport de validation |

## Exemples

```
/rl-analyzer init
/rl-analyzer best-practices toujours utiliser 4 espaces pour l'indentation
/rl-analyzer analysis .notes/claude/asks/feature.txt
/rl-analyzer review .notes/claude/asks/feature.txt
/rl-analyzer process .notes/claude/asks/feature.txt
/rl-analyzer validate .notes/claude/asks/feature.txt
/rl-analyzer re-process .notes/claude/asks/feature.txt
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
