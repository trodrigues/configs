#!/bin/bash

# Script to approve and merge all open Dependabot PRs

set -e  # Exit on error

echo "Fetching open PRs..."

# Get all open PRs in JSON format and filter for dependabot branches
prs=$(gh pr list --state open --json number,headRefName,title)

# Parse JSON and filter for dependabot PRs
dependabot_prs=$(echo "$prs" | jq -r '.[] | select(.headRefName | startswith("dependabot")) | .number')

if [ -z "$dependabot_prs" ]; then
  echo "No Dependabot PRs found."
  exit 0
fi

echo "Found Dependabot PRs:"
echo "$dependabot_prs"
echo ""

# Loop through each PR and approve + merge
for pr_number in $dependabot_prs; do
  echo "Processing PR #$pr_number..."

  # Get PR details for display
  pr_title=$(gh pr view "$pr_number" --json title --jq '.title')
  echo "  Title: $pr_title"

  # Approve the PR
  echo "  Approving PR #$pr_number..."
  gh pr review "$pr_number" --approve

  # Merge the PR
  echo "  Merging PR #$pr_number..."
  gh pr merge "$pr_number" --auto --squash

  echo "  ✓ PR #$pr_number processed successfully"
  echo ""
done

echo "All Dependabot PRs have been approved and merged!"
