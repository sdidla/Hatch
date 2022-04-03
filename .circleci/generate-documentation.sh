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

npm install -g --silent gh-pages@2.0.1
git config user.email "ci@circleci.com"
git config user.name "ci"

