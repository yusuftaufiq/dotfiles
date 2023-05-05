#!/bin/bash

chezmoiSourceDir=$(chezmoi source-path)
tempDir="$chezmoiSourceDir/temp"
tempGitconfigFile="$tempDir/.gitconfig"
baseGitconfigFile="$chezmoiSourceDir/.chezmoitemplates/.gitconfig"

readarray -t configs < <(git config --file "$baseGitconfigFile" --list)

mkdir -p "$tempDir"
cp <(echo "$1") "$tempGitconfigFile"

for config in "${configs[@]}"; do
  key="$(echo "$config" | cut -d '=' -f 1)"
  value="$(echo "$config" | cut -d '=' -f 2-)"

  git config --file "$tempGitconfigFile" "$key" "$value"
done

cat $tempGitconfigFile
