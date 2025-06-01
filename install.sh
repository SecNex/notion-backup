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

echo "Cloning the repository..."
# Clone the repository
git clone https://github.com/secnex/notion-backup.git

cd notion-backup

echo "Checking if the docker-compose.build.yaml file is exists..."
if [ ! -f docker-compose.build.yaml ]; then
    echo "docker-compose.build.yaml file does not exist"
    exit 1
fi

echo "Checking if the FILTER is set in the docker-compose.build.yaml file..."
if grep -q "<FILTER>" docker-compose.build.yaml; then
    echo "FILTER is not set in the docker-compose.build.yaml file"
    # Ask the user to set the FILTER
    while true; do
        echo -n "Enter the FILTER: "
        read FILTER
        if [ ! -z "$FILTER" ]; then
            break
        fi
        echo "FILTER cannot be empty. Please try again."
    done
    sed -i '' "s/<FILTER>/${FILTER}/g" docker-compose.build.yaml
fi

if grep -q "<NOTION_API_KEY>" docker-compose.build.yaml; then
    echo "NOTION_API_KEY is not set in the docker-compose.build.yaml file"
    # Ask the user to set the NOTION_API_KEY
    while true; do
        echo -n "Enter the NOTION_API_KEY: "
        read NOTION_API_KEY
        if [ ! -z "$NOTION_API_KEY" ]; then
            break
        fi
        echo "NOTION_API_KEY cannot be empty. Please try again."
    done
    sed -i '' "s/<NOTION_API_KEY>/${NOTION_API_KEY}/g" docker-compose.build.yaml
fi

echo "Running docker compose build..."
# Run docker compose build
docker compose -f docker-compose.build.yaml up -d --build --force-recreate --remove-orphans

docker compose -f docker-compose.build.yaml logs -f