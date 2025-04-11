# Generate Manifest Script

## Overview
`generate_manifest.ps1` is a PowerShell script that creates a `manifest.json` file containing SHA-256 checksums of all files in the project directory. This manifest is used for verifying file integrity during updates and is specifically formatted to be compatible with Tera-Proxy/Toolbox expectations.

## Ignored Files
When scanning the directory, the script automatically ignores the following:

- `manifest.json` (the output file itself)
- `generate_manifest.ps1` (the script itself)
- Any files with `package-lock` in the name
- Files named `.gitignore`
- Any file with a `.log` extension
- Any file with a path containing `/.' (files that begin with a period)

## Usage
Simply place the script in the root directory of your project and run it with PowerShell. It will recursively scan all files, excluding the ones mentioned above, and generate a `manifest.json` file with their SHA-256 checksums.