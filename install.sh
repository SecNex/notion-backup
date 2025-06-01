# Check if git, docker and docker compose are installed
if ! command -v git &> /dev/null; then
    echo "git could not be found"
    exit 1
fi

if ! command -v docker &> /dev/null; then
    echo "docker could not be found"
    exit 1
fi

if ! command -v docker compose &> /dev/null; then
    echo "docker compose could not be found"
    exit 1
fi

# Check if the notion-backup directory exists
if [ -d "notion-backup" ]; then
    echo "notion-backup directory already exists"
    exit 1
fi

echo "Cloning the repository..."
# Clone the repository
git clone https://github.com/secnex/notion-backup.git

cd notion-backup

read -p "Enter the NOTION_BACKUP_FILTER: " NOTION_BACKUP_FILTER

read -p "Enter the NOTION_BACKUP_API_KEY: " NOTION_BACKUP_API_KEY

# Check if environment variables are set
if [ -z "$NOTION_BACKUP_FILTER" ]; then
    echo "Error: NOTION_BACKUP_FILTER environment variable is not set"
    echo "Please set it before running the script:"
    echo "export NOTION_BACKUP_FILTER='your_filter'"
    exit 1
fi

if [ -z "$NOTION_BACKUP_API_KEY" ]; then
    echo "Error: NOTION_BACKUP_API_KEY environment variable is not set"
    echo "Please set it before running the script:"
    echo "export NOTION_BACKUP_API_KEY='your_api_key'"
    exit 1
fi

echo "Checking if the docker-compose.build.yaml file is exists..."
if [ ! -f docker-compose.build.yaml ]; then
    echo "docker-compose.build.yaml file does not exist"
    exit 1
fi

echo "Updating configuration..."
sed -i '' "s/<FILTER>/${NOTION_BACKUP_FILTER}/g" docker-compose.build.yaml
sed -i '' "s/<NOTION_API_KEY>/${NOTION_BACKUP_API_KEY}/g" docker-compose.build.yaml

echo "Running docker compose build..."
# Run docker compose build
docker compose -f docker-compose.build.yaml up -d --build --force-recreate --remove-orphans

docker compose -f docker-compose.build.yaml logs -f