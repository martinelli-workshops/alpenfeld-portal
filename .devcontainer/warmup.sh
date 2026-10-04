#!/bin/bash
set -e
# Maven-Abhängigkeiten und Vaadin-Frontend vorab laden
./mvnw -q -B dependency:go-offline