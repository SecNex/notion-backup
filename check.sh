if grep -q "<FILTER>" docker-compose.build.yaml; then
    echo "FILTER is not set in the docker-compose.build.yaml file"
    # Ask the user to set the FILTER
    read -p "Enter the FILTER: " FILTER
    sed -i '' "s/<FILTER>/${FILTER}/g" docker-compose.build.yaml
fi

if grep -q "<NOTION_API_KEY>" docker-compose.build.yaml; then
    echo "NOTION_API_KEY is not set in the docker-compose.build.yaml file"
    # Ask the user to set the NOTION_API_KEY
    read -p "Enter the NOTION_API_KEY: " NOTION_API_KEY
    sed -i '' "s/<NOTION_API_KEY>/${NOTION_API_KEY}/g" docker-compose.build.yaml
fi