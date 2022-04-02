mkdir -p "docs"

echo "Hello docs"

swift package \
    --allow-writing-to-directory "docs" \
    generate-documentation \
    --target HatchParser \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path docs \
    --output-path "docs"

ls -laR
