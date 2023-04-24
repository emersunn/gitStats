#!/bin/bash

# Git Stats for macOS

# Configuration
repo_directory="$1"
output_file="git_stats.txt"

if [ -z "$repo_directory" ]; then
  echo "Usage: $0 <repo_directory>"
  exit 1
fi

if [ ! -d "$repo_directory" ]; then
  echo "Error: Directory not found"
  exit 1
fi

cd "$repo_directory" || exit

if [ ! -d ".git" ]; then
  echo "Error: Not a Git repository"
  exit 1
fi

# Generate Git statistics
commit_count=$(git rev-list --count HEAD)
contributors=$(git shortlog -s -n)
file_changes=$(git diff --shortstat HEAD)

# Save statistics to output file
echo "Git Stats for $(basename "$repo_directory")" > "$output_file"
echo "Generated on $(date)" >> "$output_file"
echo "" >> "$output_file"
echo "Commit count: $commit_count" >> "$output_file"
echo "" >> "$output_file"
echo "Contributors:" >> "$output_file"
echo "$contributors" >> "$output_file"
echo "" >> "$output_file"
echo "File changes:" >> "$output_file"
echo "$file_changes" >> "$output_file"

# Print statistics
cat "$output_file"

echo "Git stats saved to $output_file"
