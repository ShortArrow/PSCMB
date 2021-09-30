```bash
mkdir BurntToast
git init BurntToast
git config core.sparsecheckout true
git remote add origin https://github.com/Windos/BurntToast.git
echo BurntToast > .git/info/sparse-checkout
git pull origin main 
```