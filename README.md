# RL Analyzer

Ensemble de commandes pour agents IA. Structure et pilote le cycle d'analyse, de revue, d'implementation et de validation d'une demande ou tache.

## Installation

### Mode skill

Clone le repo complet. Toutes les commandes sont accessibles via `/rl-analyzer <commande>`.

```bash
# Claude Code
p=.claude/skills && mkdir -p $p && cd $p
git clone https://github.com/RivoLink/rl-analyzer.git
```

```bash
# Codex CLI
p=.codex/skills && mkdir -p $p && cd $p
git clone https://github.com/RivoLink/rl-analyzer.git
```

### Mode commandes (Claude Code uniquement)

Copie les fichiers de `commands/` dans `.claude/commands/rl-analyzer/` du projet. Chaque commande est accessible via `/rl-analyzer:<nom>`.

```bash
# Claude Code
curl -fsSL https://github.com/rivolink/rl-analyzer/raw/main/commands.sh | sh
```

## Configuration pour Termux

Pour que la commande `/rl-analyzer` soit automatiquement disponible au démarrage de chaque session dans Termux, ajouter la configuration suivante au fichier `~/.claude/settings.json` :

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cat /data/data/com.termux/files/home/.claude/skills/rl-analyzer/SKILL.md"
          }
        ]
      }
    ]
  }
}
```

## Skills

| Skill | Description |
|------------|-------------|
| `/rl-analyzer help` | Affiche les commandes disponibles |
| `/rl-analyzer init` | Initialise l'environnement de travail |
| `/rl-analyzer best-practices <comment>` | Ajoute des bonnes pratiques |
| `/rl-analyzer asking <prompt>` | Cree un fichier de demande a partir d'un prompt |
| `/rl-analyzer analysis <path> [comment]` | Analyse une demande |
| `/rl-analyzer review <path> [comment]` | Revue critique de l'analyse |
| `/rl-analyzer process <path> [comment]` | Applique les modifications de code |
| `/rl-analyzer validate <path> [comment]` | Revue critique du code |
| `/rl-analyzer re-process <path> [comment]` | Corrige selon le rapport de validation |

## Exemples

```
# Claude Code
/rl-analyzer init
/rl-analyzer asking Ajouter un endpoint /health a l'API
/rl-analyzer analysis .notes/claude/asks/feature.txt
/rl-analyzer review .notes/claude/asks/feature.txt
/rl-analyzer process .notes/claude/asks/feature.txt
/rl-analyzer validate .notes/claude/asks/feature.txt

# Codex Cli
$rl-analyzer init
$rl-analyzer asking Ajouter un endpoint /health a l'API
$rl-analyzer analysis .notes/claude/asks/feature.txt
$rl-analyzer review .notes/claude/asks/feature.txt
$rl-analyzer process .notes/claude/asks/feature.txt
$rl-analyzer validate .notes/claude/asks/feature.txt
```

## Mode Commandes

```
# Claude Code
/rl-analyzer:init
/rl-analyzer:asking Ajouter un endpoint /health a l'API
/rl-analyzer:analysis .notes/claude/asks/feature.txt
/rl-analyzer:review .notes/claude/asks/feature.txt
/rl-analyzer:process .notes/claude/asks/feature.txt
/rl-analyzer:validate .notes/claude/asks/feature.txt
```

## Workflow

```
init ─► best-practices ─► asking ─► analysis ◄──► review ─► process ─► validate
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
