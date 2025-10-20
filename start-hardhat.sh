#!/bin/bash

echo "🚀 Starting Hardhat Local Network for Dark Pool Trading..."

# Check if we're in the hardhat directory
if [ ! -f "hardhat.config.js" ]; then
    echo "❌ Error: hardhat.config.js not found. Please run this from the hardhat directory."
    exit 1
fi

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing Hardhat dependencies..."
    npm install
fi

# Check if contract is already deployed
if [ ! -f "../dark-pool-frontend/src/contracts/DarkPool.json" ]; then
    echo "🔨 Deploying DarkPool contract..."
    npx hardhat run scripts/deploy.js --network localhost
else
    echo "✅ DarkPool contract already deployed"
fi

echo "🌐 Starting Hardhat local node..."
echo "📍 Network: http://127.0.0.1:8545"
echo "🔗 Chain ID: 31337"
echo ""
echo "💡 MetaMask Setup Instructions:"
echo "   1. Open MetaMask"
echo "   2. Click on network dropdown"
echo "   3. Select 'Add Network'"
echo "   4. Enter these details:"
echo "      - Network Name: Hardhat Local"
echo "      - New RPC URL: http://127.0.0.1:8545"
echo "      - Chain ID: 31337"
echo "      - Currency Symbol: ETH"
echo ""
echo "🎯 Starting node in 3 seconds..."
sleep 3

# Start the Hardhat node
npx hardhat node