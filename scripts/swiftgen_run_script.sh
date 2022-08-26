#!/bin/sh

# Only run SwiftGen script locally, never on CI
if ! [ -z "$CI" ]; then
  echo "The SwiftGen Run Script does not run on CI."

  # Exit with success (since there's no error, we're just on CI)
  exit 0
fi

# Adds support for Apple Silicon homebrew directory
export PATH="$PATH:/opt/homebrew/bin"

# The workspace directory should be the git repo root
workspace_directory=$(git rev-parse --show-toplevel)

# Define the default swiftgen.yml file path
default_swiftgen_yml_path="${workspace_directory}/swiftgen.yml"

# Allow passing in a file path for swiftgen.yml, otherwise use the default path
swiftgen_yml_path=${1:-$default_swiftgen_yml_path}

# Set the command
# We run xcrun --sdk macosx before mint to ensure the macOS SDK is being used to build the command
# Without this, Mint can sometimes fall back on the last used SDK, which is typically iOS for us
# For more info, see https://github.com/yonaskolb/Mint/issues/179#issuecomment-732682750
command="xcrun --sdk macosx mint run swiftgen config run --config ${swiftgen_yml_path}"

# Call the command!
eval $command
