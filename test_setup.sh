#!/bin/bash

# Test script to verify C9 IDE and PostgreSQL setup
# This script should be run inside the deployed container

echo "🧪 C9 IDE & PostgreSQL Setup Test"
echo "=================================="

# Test 1: Check if C9 IDE processes are running
echo "1. Checking C9 IDE processes..."
if pgrep -f "c9sdk" > /dev/null; then
    echo "   ✅ C9 IDE server is running"
else
    echo "   ❌ C9 IDE server is not running"
fi

# Test 2: Check nginx proxy
echo "2. Checking nginx proxy..."
if pgrep nginx > /dev/null; then
    echo "   ✅ Nginx proxy is running"
else
    echo "   ❌ Nginx proxy is not running"
fi

# Test 3: Check PostgreSQL client installation
echo "3. Checking PostgreSQL client..."
if command -v psql > /dev/null; then
    echo "   ✅ PostgreSQL client is installed"
    psql --version
else
    echo "   ❌ PostgreSQL client is not installed"
fi

# Test 4: Check environment variables
echo "4. Checking environment variables..."
if [ -n "$C9SDK_PASSWORD" ]; then
    echo "   ✅ C9SDK_PASSWORD is set"
else
    echo "   ❌ C9SDK_PASSWORD is not set"
fi

if [ -n "$DATABASE_URL" ]; then
    echo "   ✅ DATABASE_URL is set"
else
    echo "   ⚠️  DATABASE_URL is not set (check Railway Postgres service)"
fi

# Test 5: Check database aliases
echo "5. Checking database aliases..."
if alias db > /dev/null 2>&1; then
    echo "   ✅ Database alias 'db' is available"
else
    echo "   ❌ Database alias 'db' is not available"
fi

# Test 6: Test database connection (if available)
echo "6. Testing database connection..."
if [ -n "$DATABASE_URL" ]; then
    if psql "$DATABASE_URL" -c "SELECT 1;" > /dev/null 2>&1; then
        echo "   ✅ Database connection successful"
        psql "$DATABASE_URL" -c "SELECT version();"
    else
        echo "   ❌ Database connection failed"
    fi
elif [ -n "$PGURL" ]; then
    if psql "$PGURL" -c "SELECT 1;" > /dev/null 2>&1; then
        echo "   ✅ Database connection successful"
    else
        echo "   ❌ Database connection failed"
    fi
else
    echo "   ⚠️  No database URL available for testing"
fi

echo ""
echo "🏁 Test completed!"
echo "If all tests pass, your C9 IDE setup is ready for GaryOcean!"