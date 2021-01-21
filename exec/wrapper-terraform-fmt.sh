#!/bin/bash +e

terraform fmt -recursive -check > _TERRAFORM_LIST

while IFS= read -r FILE; do
  DIFF=$(terraform fmt -check -diff "$FILE")

  echo "diff $DIFF" >> _TERRAFORM_DIFF
done < _TERRAFORM_LIST

if [[ -f "_TERRAFORM_DIFF" ]]; then
  reviewdog -f=diff -reporter=github-pr-review < _TERRAFORM_DIFF
  exit 1
fi
