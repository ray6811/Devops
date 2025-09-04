#!/bin/bash
set -e

# Navigate to project root
cd "$(dirname "$0")"

echo "📦 Installing dependencies..."
npm install

echo "🏗️ Building React app..."
npm run build



