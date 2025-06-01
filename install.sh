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

# Clone the repository
git clone https://github.com/secnex/notion-backup.git

if grep -q "<FILTER>" docker-compose.build.yaml; then
    echo "FILTER is not set in the docker-compose.build.yaml file"
    # Ask the user to set the FILTER
    read -p "Enter the FILTER: " FILTER
    if [ -z "$FILTER" ]; then
        echo "FILTER is not set"
        exit 1
    fi
    sed -i '' "s/<FILTER>/${FILTER}/g" docker-compose.build.yaml
fi

if grep -q "<NOTION_API_KEY>" docker-compose.build.yaml; then
    echo "NOTION_API_KEY is not set in the docker-compose.build.yaml file"
    # Ask the user to set the NOTION_API_KEY
    read -p "Enter the NOTION_API_KEY: " NOTION_API_KEY
    if [ -z "$NOTION_API_KEY" ]; then
        echo "NOTION_API_KEY is not set"
        exit 1
    fi
    sed -i '' "s/<NOTION_API_KEY>/${NOTION_API_KEY}/g" docker-compose.build.yaml
fi

# Run docker compose build
docker compose -f docker-compose.build.yaml up -d --build --force-recreate --remove-orphans

docker compose -f docker-compose.build.yaml logs -f