
set -e

hugo 

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
git commit -m "Commit message"

# Push source and build repos.
git push origin master

#hugo new posts/my-first-post.md