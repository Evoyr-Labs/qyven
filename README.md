# QYVEN — Final Launchpad Starter

QYVEN is a minimal Web3 memecoin launchpad starter configured for Robinhood Chain testnet.

## Project structure

- `web/index.html` — frontend launchpad
- `contracts/QyvenFactory.sol` — factory + fixed-supply token contract
- `scripts/deploy.js` — deploy factory
- `hardhat.config.js` — testnet/mainnet network config
- `.env.example` — deployer key template
- `.github/workflows/pages.yml` — GitHub Pages deployment
- `CNAME` — replace with your real custom domain
- `DOMAIN-GUIDE.md` — custom `.com` setup

## 1. Install

Requires Node.js and npm.

```bash
npm install
```

## 2. Compile

```bash
npm run compile
```

## 3. Configure deployer

Copy `.env.example` to `.env` and put a dedicated deployment wallet private key in it.

NEVER commit `.env`, seed phrases, or private keys.

## 4. Deploy QyvenFactory to testnet

```bash
npm run deploy:testnet
```

Copy the printed factory address into:

`web/index.html`

Replace:

```js
const FACTORY_ADDRESS = "";
```

with your deployed address.

## 5. Test frontend locally

From the repository root:

```bash
python3 -m http.server 8080 --directory web
```

Open `http://localhost:8080`.

Connect an EVM wallet, switch to Robinhood Chain testnet, and test token creation.

## 6. GitHub Pages

Push the repository to GitHub with the default branch named `main`.

In GitHub:
Settings → Pages → Build and deployment → Source: GitHub Actions.

The included workflow publishes the `web/` folder.

## 7. Custom .com domain

Read `DOMAIN-GUIDE.md`.

Important:
- You must own the domain.
- Do not put private keys in the website.
- GitHub Pages custom-domain DNS records must be configured at your registrar.
- HTTPS may take time to become available after DNS propagation.

## Mainnet warning

This repository is a starter/MVP. The contracts are NOT audited. Do not deploy with real funds or present the software as audited. Before mainnet, review the contract, wallet flow, domain security, dependencies, and operational controls.
