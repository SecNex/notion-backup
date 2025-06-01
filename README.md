# Notion Backup

This docker image is used to backup your notion workspace to a local directory.

## Installation

### Quick installation via script

```bash
curl -sSL https://raw.githubusercontent.com/SecNex/notion-backup/main/install.sh | bash
```

### Manual installation

1. Clone this repository:

```bash
git clone https://github.com/secnex/notion-backup.git
cd notion-backup
```

2. Run the check script to set up your configuration:

```bash
./check.sh
```

3. Build and run the docker container:

```bash
docker-compose -f docker-compose.build.yaml up --build
```
