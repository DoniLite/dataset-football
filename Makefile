# Variables
VENV = .venv
ifeq ($(OS),Windows_NT)
    PYTHON = $(VENV)/Scripts/python
    PIP = $(VENV)/Scripts/pip
    ACTIVATE = $(VENV)/Scripts/activate
else
    PYTHON = $(VENV)/bin/python
    PIP = $(VENV)/bin/pip
    ACTIVATE = $(VENV)/bin/activate
endif
PROJECT_NAME = dataset-football
SRC_DIR = src
TEST_DIR = tests
CRAWLER_SCRIPT = $(SRC_DIR)/main.py

# Environnement virtuel et dépendances
.PHONY: setup
setup: $(ACTIVATE)

$(ACTIVATE): requirements.txt
	python -m venv $(VENV)
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r requirements.txt

.PHONY: install
install: setup

# Nettoyage
.PHONY: clean
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.pyd" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name "*.egg" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".tox" -exec rm -rf {} +
	find . -type f -name ".DS_Store" -delete

.PHONY: clean-venv
clean-venv: clean
	rm -rf $(VENV)

# Tests
.PHONY: test
test:
	$(PYTHON) -m pytest $(TEST_DIR) -v --cov=$(SRC_DIR)

# Linting et formatage
.PHONY: lint
lint:
	$(PYTHON) -m flake8 $(SRC_DIR)
	$(PYTHON) -m flake8 $(TEST_DIR)

.PHONY: format
format:
	$(PYTHON) -m black $(SRC_DIR)
	$(PYTHON) -m black $(TEST_DIR)

# Exécution du crawler
.PHONY: run
run:
	$(PYTHON) $(CRAWLER_SCRIPT)

# Sécurité
.PHONY: security
security:
	$(PYTHON) -m safety check
	$(PYTHON) -m bandit -r $(SRC_DIR)

# Génération des dépendances
.PHONY: freeze
freeze:
	$(PIP) freeze > requirements.txt

# Documentation
.PHONY: docs
docs:
	$(PYTHON) -m pdoc --html --output-dir docs $(SRC_DIR)

# Vérifie que le message de migration est fourni
check-message:
ifndef m
	$(error La description de la migration est requise. Utilisez 'make migration m="description"')
endif

# Vérifie que la révision est fournie
check-revision:
ifndef revision
	$(error Le numéro de révision est requis. Utilisez 'make downgrade-to revision=<revision_id>')
endif

# Génère une nouvelle migration
migration: check-message
	alembic revision --autogenerate -m "$(m)"

# Applique toutes les migrations en attente
migrate:
	alembic upgrade head

# Revient en arrière d'une migration
downgrade:
	alembic downgrade -1

# Revient à une migration spécifique
downgrade-to: check-revision
	alembic downgrade $(revision)

# Affiche l'état actuel des migrations
migration-status:
	alembic current

# Affiche l'historique des migrations
migration-history:
	alembic history

# Réinitialise la base de données (revient au début)
migration-reset:
	alembic downgrade base

# Combine la génération et l'application de la migration
migrate-full: check-message
	alembic revision --autogenerate -m "$(m)" && alembic upgrade head

# Aide
.PHONY: help
help:
	@echo "Commandes disponibles:"
	@echo "  make setup      - Crée l'environnement virtuel et installe les dépendances"
	@echo "  make install    - Alias pour setup"
	@echo "  make clean      - Nettoie les fichiers Python compilés et les caches"
	@echo "  make clean-venv - Nettoie tout, y compris l'environnement virtuel"
	@echo "  make test       - Lance les tests avec couverture"
	@echo "  make lint       - Vérifie le style du code"
	@echo "  make format     - Formate le code avec black"
	@echo "  make run        - Lance le crawler"
	@echo "  make security   - Lance les vérifications de sécurité"
	@echo "  make freeze     - Met à jour requirements.txt"
	@echo "  make docs       - Génère la documentation"
	@echo "  make migration m='description'  - Génère une nouvelle migration"
	@echo "  make migrate                   - Applique toutes les migrations"
	@echo "  make downgrade                 - Revient en arrière d'une migration"
	@echo "  make downgrade-to revision=id  - Revient à une migration spécifique"
	@echo "  make migration-status          - Affiche l'état des migrations"
	@echo "  make migration-history         - Affiche l'historique des migrations"
	@echo "  make migration-reset           - Réinitialise la base de données"
	@echo "  make migrate-full m='desc'     - Génère et applique une migration"

# Par défaut
.DEFAULT_GOAL := help
