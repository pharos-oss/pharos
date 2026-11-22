# justfile commands

# Imposta la shell di default
set shell := ["bash", "-c"]

# Mostra la lista dei comandi disponibili
default:
    @just --list

# Compila un singolo documento. Uso: `just build rad` oppure `just build sdd`
[arg('doc', pattern='[A-Za-z0-9][A-Za-z0-9._-]*')]
build $doc:
    @mkdir -p docs/out
    @echo "Compilazione di $doc in corso..."
    typst compile --root . "docs/$doc/main.typ" "docs/out/$doc.pdf"
    @echo "✓ Compilazione completata: docs/out/$doc.pdf"

# Compila TUTTI i documenti trovati nelle sottocartelle di docs/
build-all:
    @mkdir -p docs/out
    @echo "Compilazione massiva di tutti i documenti in corso..."
    @set -e; for file in docs/*/main.typ; do \
        nome_doc=$(basename $(dirname "$file")); \
        typst compile --root . "$file" docs/out/"$nome_doc".pdf; \
        echo "✓ $nome_doc.pdf generato"; \
    done
    @echo "Tutti i documenti sono stati compilati"

# Rimuove tutti i PDF generati
clean:
    @echo "Pulizia della cartella di output in corso..."
    rm -f docs/out/*.pdf
    @echo "✓ File PDF rimossi con successo."

# Esegue i controlli di qualità
lint:
    @echo "Esecuzione dei controlli di qualità (prek)..."
    prek run --all-files

# Avvia Typst in modalità "watch". Uso: `just watch rad`
[arg('doc', pattern='[A-Za-z0-9][A-Za-z0-9._-]*')]
watch $doc:
    @mkdir -p docs/out
    @echo "Modalità watch avviata per '$doc' (Premi Ctrl+C per uscire)..."
    typst watch "docs/$doc/main.typ" "docs/out/$doc.pdf"