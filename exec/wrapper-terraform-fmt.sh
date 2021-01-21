#!/bin/bash +e

terraform fmt -recursive -check > _TERRAFORM_LIST

while IFS= read -r FILE; do
  DIFF=$(terraform fmt -check -diff "$FILE")

  echo "diff $DIFF" >> _TERRAFORM_DIFF
done < _TERRAFORM_LIST

cat _TERRAFORM_DIFF

reviewdog -f=diff -reporter=github-pr-review < _TERRAFORM_DIFF
