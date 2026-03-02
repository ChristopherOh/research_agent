# Runbook (Oracle 계정 생성 완료 이후)

## 1) 인프라 초기 설정 (OCI 인스턴스)
```bash
# 패키지 업데이트
sudo apt update && sudo apt upgrade -y

# 방화벽(예시: iptables)
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp -j DROP

# Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

# Docker
sudo apt install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER

# 자동 보안 업데이트
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
```

## 2) NanoClaw 설치
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
npm install -g @anthropic-ai/claude-code

git clone https://github.com/qwibitai/NanoClaw.git
cd NanoClaw
claude
```

## 3) Vault 동기화
```bash
mkdir -p /home/ubuntu/vault
cd /home/ubuntu/vault
git init
git remote add origin git@github.com:cheonseok/obsidian-vault.git
git pull origin main

mkdir -p /home/ubuntu/scripts
cp /path/to/this/workspace/scripts/vault-sync.sh /home/ubuntu/scripts/vault-sync.sh
chmod +x /home/ubuntu/scripts/vault-sync.sh
```

crontab:
```cron
0 * * * * /home/ubuntu/scripts/vault-sync.sh >> /var/log/vault-sync.log 2>&1
```

## 4) 로컬 검증
```bash
./scripts/validate-setup.sh
```
