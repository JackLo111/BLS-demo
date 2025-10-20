# 区块链集成说明

## 概述

此项目现在支持将交易订单记录到本地Hardhat区块链上，实现真正的去中心化交易记录。

## 功能特性

### 🌐 区块链集成
- ✅ 订单记录到Hardhat本地链
- ✅ MetaMask钱包连接
- ✅ 智能合约交互
- ✅ 实时链上数据同步
- ✅ 可切换本地/区块链模式

### 🔒 隐私保护
- ✅ 匿名交易ID
- ✅ 价格范围模糊化
- ✅ 随机优先级匹配
- ✅ 延迟反馈防时序分析

## 快速开始

### 1. 启动本地Hardhat节点

```bash
# 在项目根目录
cd hardhat
../start-hardhat.sh
```

或者手动执行：

```bash
cd hardhat
npm install
npx hardhat run scripts/deploy.js --network localhost
npx hardhat node
```

### 2. 配置MetaMask

1. 打开MetaMask扩展
2. 点击网络下拉菜单
3. 选择"添加网络"
4. 输入以下信息：
   - **网络名称**: Hardhat Local
   - **新RPC URL**: http://127.0.0.1:8545
   - **链ID**: 31337
   - **货币符号**: ETH

### 3. 启动前端应用

```bash
# 在新终端窗口
cd dark-pool-frontend
npm run dev
```

### 4. 使用区块链功能

1. 打开浏览器访问 `http://localhost:5173`
2. 点击"Connect Wallet"连接MetaMask
3. 确保连接到Hardhat Local网络
4. 点击"Chain"按钮启用区块链模式
5. 创建身份并开始交易

## 技术架构

### 智能合约 (`hardhat/contracts/DarkPool.sol`)

```solidity
contract DarkPool {
    struct Order {
        bytes32 id;
        address trader;
        bool isBuy;
        uint256 amount;
        uint256 price;
        uint256 timestamp;
        bool executed;
    }

    function placeOrder(bool isBuy, uint256 amount, uint256 price) external returns (bytes32);
    function getAllOrders() external view returns (Order[] memory);
    // ...
}
```

### Web3服务 (`src/services/web3.ts`)

- MetaMask连接管理
- 合约交互封装
- 事件监听
- 网络检查

### 区块链引擎 (`src/services/blockEngineWithChain.ts`)

- 本地+链上数据同步
- 混合模式支持
- 实时状态更新

## 使用模式

### 🏠 本地模式 (默认)
- 订单仅存储在浏览器内存中
- 无需钱包连接
- 用于演示和测试

### ⛓️ 区块链模式
- 订单记录到Hardhat链上
- 需要MetaMask连接
- 真实的去中心化存储

## 切换模式

在应用右上角点击"Local"/"Chain"按钮切换模式：

- **Local**: 纯本地模拟
- **Chain**: 区块链集成

## 订单流程

### 本地模式
1. 用户提交订单
2. 订单添加到当前区块
3. 区块完成后进行匹配
4. 结果仅存储在内存中

### 区块链模式
1. 用户连接钱包
2. 提交订单到智能合约
3. 交易上链确认
4. 本地引擎同步链上数据
5. 执行隐私匹配算法

## 隐私特性

即使使用区块链，仍保持隐私保护：

- 🎭 **匿名ID**: 使用钱包地址的哈希而非明文
- 🌫️ **价格模糊**: 显示价格范围而非精确值
- 🎲 **随机匹配**: 防止基于时间顺序的攻击
- ⏱️ **延迟反馈**: 添加随机延迟防时序分析

## 故障排除

### 常见问题

**Q: MetaMask无法连接？**
A: 确保Hardhat节点正在运行，检查RPC URL是否正确。

**Q: 交易失败？**
A: 检查是否连接到正确的网络（Chain ID: 31337）。

**Q: 订单没有显示？**
A: 刷新页面，检查区块链同步状态。

**Q: 合约地址为空？**
A: 重新运行部署脚本：`npx hardhat run scripts/deploy.js --network localhost`

### 重置环境

```bash
# 清理Hardhat数据
cd hardhat
rm -rf cache/
rm -rf artifacts/
npx hardhat clean

# 重新部署
npx hardhat compile
npx hardhat run scripts/deploy.js --network localhost
npx hardhat node
```

## 开发说明

### 添加新功能

1. **智能合约**: 在 `hardhat/contracts/` 目录
2. **前端服务**: 在 `src/services/` 目录
3. **React组件**: 在 `src/components/` 目录
4. **数据类型**: 在 `src/types/` 目录

### 测试

```bash
# 测试智能合约
cd hardhat
npx hardhat test

# 测试前端
cd dark-pool-frontend
npm run test
```

## 安全注意事项

⚠️ **重要提醒**:
- 这是演示版本，请勿在主网使用
- 私钥安全由用户自己负责
- 本地节点仅用于开发测试
- 生产环境需要安全审计

## 下一步开发

- [ ] 添加更多资产支持
- [ ] 实现跨链功能
- [ ] 集成硬件钱包
- [ ] 添加高级ZK证明
- [ ] 优化Gas使用
- [ ] 添加治理机制

---

📧 如有问题，请查看代码注释或联系开发团队。