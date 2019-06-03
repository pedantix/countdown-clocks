#!/usr/bin/env bash

psql -h localhost -tc "SELECT 1 FROM pg_user WHERE usename = 'vapor'" | grep -q 1 || psql -h localhost -c "CREATE ROLE vapor LOGIN PASSWORD 'vapor';"
psql -h localhost -c "DROP DATABASE IF EXISTS countdownclocks;"
psql -h localhost -c "CREATE DATABASE countdownclocks OWNER vapor;"
