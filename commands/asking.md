---
name: asking
description: >
  Cree un fichier de demande (ask) a partir d'un prompt utilisateur dans
  .notes/claude/asks/ et propose de lancer l'analyse.
argument-hint: <prompt>
disable-model-invocation: true
---

Creer un fichier de demande a partir du prompt utilisateur.

**Prompt :** `$ARGUMENTS`

## Comportement

1. Si `$ARGUMENTS` est vide, **demander interactivement** a l'utilisateur de fournir un prompt. Ne pas continuer tant qu'un prompt non vide n'est pas obtenu.
2. **Reformuler** le prompt pour plus de clarte tout en conservant strictement le sens d'origine : corriger la syntaxe, clarifier les tournures ambigues, retirer les typos. Ne pas ajouter d'information absente de l'original.
3. Generer un nom de fichier en **kebab-case** derive du prompt (slug) :
   - Conserver uniquement les caracteres `[a-zA-Z0-9]`, passer en minuscules.
   - Remplacer tout autre caractere (espaces, ponctuation, accents, symboles) par `-`.
   - Fusionner les tirets consecutifs, retirer les tirets de debut/fin.
   - Tronquer le slug a **35 caracteres maximum** (limite appliquee au slug seul, avant tout suffixe). Retrimer les tirets de fin apres troncature.
4. Cible : `.notes/claude/asks/<slug>.txt`.
5. **Collision de nom** : si `<slug>.txt` existe deja, utiliser une **indexation numerique** incrementale (`<slug>-1.txt`, `<slug>-2.txt`, ...) jusqu'a obtenir un nom libre. Pas d'ecrasement.
6. Creer le dossier `.notes/claude/asks/` s'il n'existe pas.
7. Ecrire dans le fichier le **prompt reformule** (texte brut, sans en-tete, sans metadonnees).
8. Afficher a l'utilisateur :
   - Le chemin relatif cree : `.notes/claude/asks/<slug>.txt`.
   - La commande pour enchainer : `/rl-analyzer:analysis .notes/claude/asks/<slug>.txt`.

## Regles

- **Ne jamais modifier le code source.** Cette commande ne produit qu'un fichier ask.
- **Ne pas declencher l'analyse automatiquement.** Se contenter de la proposer.
- **Ne pas ajouter d'en-tete** dans le fichier (pas de date, pas d'auteur, pas de titre).
- **Ne pas alterer le sens du prompt** lors de la reformulation.
