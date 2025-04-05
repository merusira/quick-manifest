##
## Written by Merusira. https://github.com/merusira
## This script generates a manifest.json file containing SHA-256 checksums of all files in the project directory.
## This manifest is used for verifying file integrity during updates.
## Specifically formatted to be compatible with what Tera-Proxy/Toolbox expects.
##

# Get list of files, excluding the current script
$files = Get-ChildItem -Path . -File -Recurse | Where-Object {$_.Name -ne "manifest.json" -and $_.Name -ne "generate_manifest.ps1"}

# Create an ordered dictionary to store the file paths and hashes
$manifest = [ordered]@{
    files = [ordered]@{}
}

# Calculate SHA256 hash for each file
foreach ($file in $files) {
    $filePath = $file.FullName
    $relativePath = $filePath.Substring($($PWD.Path.Length + 1)).Replace("\","/")
    $hash = Get-FileHash -Algorithm SHA256 -Path $filePath
    $manifest.files[$relativePath] = $hash.Hash
}

# Convert the manifest to JSON format
$jsonManifest = $manifest | ConvertTo-Json -Depth 10

# Write the JSON to manifest.json
$jsonManifest | Out-File -FilePath manifest.json

Write-Host "manifest.json file generated successfully."