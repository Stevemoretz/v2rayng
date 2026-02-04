#!/bin/bash
set -e

echo "Generating Keystore..."
keytool -genkeypair -v \
  -keystore release.jks \
  -alias v2rayng_key \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -storepass "password123" \
  -keypass "password123" \
  -dname "CN=User, OU=Dev, O=Personal, L=City, S=State, C=US"

echo ""
echo "========================================================"
echo "KEYSTORE GENERATED SUCCESSFULLY"
echo "========================================================"
echo ""
echo "Please go to your GitHub Repository -> Settings -> Secrets and variables -> Actions"
echo "Click 'New repository secret' for each of the following:"
echo ""
echo "1. Name: KEYSTORE"
echo "   Value: (Copy the block below)"
base64 < release.jks
echo ""
echo "2. Name: ALIAS"
echo "   Value: v2rayng_key"
echo ""
echo "3. Name: KEY_STORE_PASSWORD"
echo "   Value: password123"
echo ""
echo "4. Name: KEY_PASSWORD"
echo "   Value: password123"
echo ""
echo "========================================================"
