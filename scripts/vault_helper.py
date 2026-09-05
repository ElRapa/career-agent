#!/usr/bin/env python3
"""
Hilfsskript zum Inspizieren und Durchsuchen des Obsidian-Vaults basierend auf .env.
Benötigt keine externen Abhängigkeiten (reine Python-Standardbibliothek).
"""

import os
import sys
from pathlib import Path


def load_env(env_path: Path) -> dict:
    env = {}
    if not env_path.exists():
        return env
    with open(env_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" in line:
                key, val = line.split("=", 1)
                key = key.strip()
                val = val.strip().strip('"').strip("'")
                env[key] = val
    return env


def get_vault_path() -> Path:
    root = Path(__file__).resolve().parent.parent
    env_file = root / ".env"
    env = load_env(env_file)

    vault_str = env.get("OBSIDIAN_VAULT_PATH") or os.environ.get("OBSIDIAN_VAULT_PATH")
    if not vault_str:
        print("❌ FEHLER: OBSIDIAN_VAULT_PATH ist nicht in .env oder Umgebung gesetzt.")
        sys.exit(1)

    vault_path = Path(os.path.expanduser(vault_str))
    if not vault_path.exists():
        print(f"❌ FEHLER: Obsidian-Pfad existiert nicht: {vault_path}")
        sys.exit(1)

    subdir = env.get("OBSIDIAN_CAREER_SUBDIR") or os.environ.get("OBSIDIAN_CAREER_SUBDIR", "")
    if subdir:
        target_path = vault_path / subdir
        if target_path.exists():
            return target_path

    return vault_path


def cmd_status():
    vault = get_vault_path()
    print(f"📁 Konfigurierter Pfad: {vault}")
    md_files = list(vault.glob("**/*.md"))
    print(f"📄 Gefundene Markdown-Notizen: {len(md_files)}")
    print("\nÜbersicht über Verzeichnisse:")
    subdirs = sorted({p.parent.relative_to(vault) for p in md_files})
    for s in subdirs[:15]:
        print(f"  - {s}")
    if len(subdirs) > 15:
        print(f"  ... und {len(subdirs) - 15} weitere")


def cmd_search(term: str):
    vault = get_vault_path()
    term_lower = term.lower()
    print(f"🔍 Suche nach '{term}' in {vault}...\n")
    matches = 0
    for md_file in vault.glob("**/*.md"):
        try:
            content = md_file.read_text(encoding="utf-8", errors="ignore")
            if term_lower in content.lower():
                matches += 1
                rel_path = md_file.relative_to(vault)
                # Finde erste Zeile mit Treffer
                for line in content.splitlines():
                    if term_lower in line.lower():
                        snippet = line.strip()[:100]
                        print(f"  • {rel_path}: {snippet}")
                        break
        except Exception:
            continue

    if matches == 0:
        print("Keine Treffer gefunden.")
    else:
        print(f"\n✅ {matches} relevante Notizen gefunden.")


def main():
    if len(sys.argv) < 2 or sys.argv[1] in ("-h", "--help"):
        print("Verwendung:")
        print("  python3 scripts/vault_helper.py status")
        print("  python3 scripts/vault_helper.py search <suchbegriff>")
        sys.exit(0)

    cmd = sys.argv[1]
    if cmd == "status":
        cmd_status()
    elif cmd == "search":
        if len(sys.argv) < 3:
            print("Bitte Suchbegriff angeben: python3 scripts/vault_helper.py search <begriff>")
            sys.exit(1)
        cmd_search(sys.argv[2])
    else:
        print(f"Unbekannter Befehl: {cmd}")
        sys.exit(1)


if __name__ == "__main__":
    main()
