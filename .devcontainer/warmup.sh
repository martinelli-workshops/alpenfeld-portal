#!/bin/bash
set -e
# Maven-Abhängigkeiten und Vaadin-Frontend vorab laden
./mvnw -q -B dependency:go-offline
# AIUP-Agent-Plugins vorinstallieren (in devcontainer.json via chat.pluginLocations eingebunden)
git clone --depth 1 https://github.com/ai-unified-process/marketplace.git "$HOME/.aiup/marketplace"
# Browser für das Playwright-MCP des aiup-vaadin-jooq-Plugins
npx -y playwright install --with-deps chromium
