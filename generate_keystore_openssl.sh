#!/bin/bash
set -e

echo "Generating Keystore using OpenSSL (No Java required)..."

# 1. Generate Private Key
openssl genrsa -out key.pem 2048

# 2. Generate Self-Signed Certificate
openssl req -new -x509 -key key.pem -out cert.pem -days 10000 \
  -subj "/C=US/ST=State/L=City/O=Personal/OU=Dev/CN=User"

# 3. Export to PKCS12 Keystore (Android compatible)
# We use the name 'release.keystore'
openssl pkcs12 -export -in cert.pem -inkey key.pem -out release.keystore \
  -name v2rayng_key \
  -passout pass:password123

# Cleanup intermediate files
rm key.pem cert.pem

echo ""
echo "========================================================"
echo "KEYSTORE GENERATED SUCCESSFULLY (PKCS12 format)"
echo "========================================================"
echo ""
echo "Please go to your GitHub Repository -> Settings -> Secrets and variables -> Actions"
echo "Click 'New repository secret' for each of the following:"
echo ""
echo "1. Name: KEYSTORE"
echo "   Value: (Copy the block below)"
base64 < release.keystore
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
