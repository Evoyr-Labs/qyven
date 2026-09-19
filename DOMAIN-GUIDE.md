# QYVEN — Custom .COM Domain Guide

This guide assumes:
- your website is hosted on GitHub Pages;
- you own a `.com` domain from a registrar;
- your GitHub repository contains this project.

## A. Put the website on GitHub

1. Create a new GitHub repository, for example `qyven-launchpad`.
2. Upload the contents of this ZIP.
3. Commit to the `main` branch.
4. Go to **Settings → Pages**.
5. Under Build and deployment, select **GitHub Actions**.
6. The included `.github/workflows/pages.yml` will deploy the `web/` directory.

## B. Add your real domain

Replace the placeholder inside `CNAME`:

`YOUR-DOMAIN.com`

with your actual domain, for example:

`qyven.com`

Commit the change.

Then in GitHub:
**Settings → Pages → Custom domain**

Enter the same domain and save.

## C. Configure DNS at your registrar

Use the DNS records shown by the GitHub Pages custom-domain screen for your repository/account.

For an apex domain (`example.com`), GitHub Pages commonly uses A/AAAA records published in its current documentation. For a `www` subdomain, a CNAME record points to your GitHub Pages hostname.

Because GitHub's published IPs and recommended DNS configuration can change, use the current GitHub Pages documentation as the authoritative values rather than copying old IPs from a tutorial.

## D. HTTPS

After DNS has propagated and GitHub recognizes the domain, enable **Enforce HTTPS** in:
Settings → Pages.

DNS propagation can take time.

## E. Recommended setup

Use:

- `qyven.com` → apex/root domain
- `www.qyven.com` → redirect/alternate hostname as supported by GitHub Pages
- Keep the domain's registrar account protected with 2FA.
- Keep the GitHub account protected with 2FA.
- Never store wallet private keys in GitHub Actions or frontend JavaScript unless a carefully designed secret-based deployment workflow specifically requires it.

## F. Smart contract deployment is separate

GitHub Pages only hosts the frontend. The QYVEN Factory contract is deployed on-chain with Hardhat.

After deployment:

1. Copy the factory address.
2. Set `FACTORY_ADDRESS` in `web/index.html`.
3. Commit and push.
4. GitHub Pages redeploys the website.

## G. Before mainnet

Do not treat this starter as production-ready or audited. Perform contract/security review, dependency review, wallet-flow testing, domain/hosting hardening, and testnet testing before handling real funds.
