#!/bin/bash

echo "Check of new tar versions...."
json_output=$(brew livecheck --tap alvaro-aguirre-cl/homebrew-esopipes --json)

echo "$json_output" | jq -c '.[] | select(.version.outdated == true)' | while read -r formula; do

    FORMULA_NAME=$(echo "$formula" | jq -r '.formula')
    CURRENT_VERSION_NUMBER=$(echo "$formula" | jq -r '.version.current')
    NEW_VERSION_NUMBER=$(echo "$formula" | jq -r '.version.latest')
    echo "Checking for new version of $FORMULA_NAME..."
    
    FORMULA_PATH="Formula/$FORMULA_NAME.rb" # Cambia este valor al path de tu fórmula
    FORMULA="alvaro-aguirre-cl/homebrew-esopipes/$FORMULA_NAME"

    CURRENT_URL=$(grep -E '^[[:space:]]*url ".*"' -m 1 $FORMULA_PATH | awk -F'"' '{print $2}')
    echo "Current tarball URL: $CURRENT_URL"

    TARBALL_URL=$(echo $CURRENT_URL | sed "s/$CURRENT_VERSION_NUMBER/$NEW_VERSION_NUMBER/")
    echo "New tarball URL: $TARBALL_URL"

    echo "Downloading new tarball from $TARBALL_URL..."
    curl -L $TARBALL_URL -o /tmp/source-$NEW_VERSION_NUMBER.tar.gz

    if [ ! -f /tmp/source-$NEW_VERSION_NUMBER.tar.gz ]; then
        echo "Error: Failed to download tarball."
        exit 1
    fi

    NEW_SHA256=$(shasum -a 256 /tmp/source-$NEW_VERSION_NUMBER.tar.gz | awk '{print $1}')
    echo "New version number: $NEW_VERSION_NUMBER"
    echo "New checksum: $NEW_SHA256"
    echo "Tarbal URL: $TARBALL_URL"

    echo "Updating the formula with brew bump-formula-pr..."
    brew bump-formula-pr \
    --sha256="$NEW_SHA256" \
    --url="$TARBALL_URL" \
    --force \
    --no-browse \
    $FORMULA

    if [ $? -eq 0 ]; then
        echo "Formula updated successfully!"
    else
        echo "Error updating formula with brew bump-formula-pr"
        exit 1
    fi
done

echo "Process completed..."