#!/bin/bash

set -e

echo "======================================"
echo "Database Reset Script"
echo "======================================"
echo ""

BACKEND_DIR="MinistryOutbuildingsSystem-BackEnd/MinistryOutbuildings.API"
DAL_DIR="MinistryOutbuildingsSystem-BackEnd/MinistryOutbuildings.DAL"
MIGRATIONS_DIR="$DAL_DIR/Migrations"

cd "$(dirname "$0")"

echo "[1/4] Dropping the database..."
dotnet ef database drop --project "$DAL_DIR" --startup-project "$BACKEND_DIR" --force
echo "✓ Database dropped successfully"
echo ""

echo "[2/4] Deleting all migrations..."
if [ -d "$MIGRATIONS_DIR" ]; then
    rm -rf "$MIGRATIONS_DIR"
    echo "✓ Migrations directory deleted"
else
    echo "✓ No migrations directory found"
fi
echo ""

echo "[3/4] Creating new initial migration..."
dotnet ef migrations add InitialMigration --project "$DAL_DIR" --startup-project "$BACKEND_DIR"
echo "✓ New migration created successfully"
echo ""

echo "[4/4] Updating database..."
dotnet ef database update --project "$DAL_DIR" --startup-project "$BACKEND_DIR"
echo "✓ Database updated successfully"
echo ""

echo "======================================"
echo "Database reset completed successfully!"
echo "======================================"
