# Notion Backup

This docker image is used to backup your notion workspace to a local directory.

## Installation

### Quick installation via script

1. Set your environment variables:

```bash
export NOTION_FILTER='your_filter'
export NOTION_API_KEY='your_api_key'
```

2. Run the installation script:

```bash
curl -sSL https://raw.githubusercontent.com/SecNex/notion-backup/main/install.sh | bash
```

### Manual installation

1. Clone this repository:

```bash
git clone https://github.com/secnex/notion-backup.git
cd notion-backup
```

2. Set your environment variables:

```bash
export NOTION_FILTER='your_filter'
export NOTION_API_KEY='your_api_key'
```

3. Run the check script:

```bash
./check.sh
```

4. Build and run the docker container:

```bash
docker-compose -f docker-compose.build.yaml up --build
```
