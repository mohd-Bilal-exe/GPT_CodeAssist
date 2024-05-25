# PowerShell Script to Extract Backend Code Context
# This script reads the content of specified backend directories and appends it to a single file.
# It also includes index.js files in the root directory and subdirectories.

# Instructions:
# 1. Save this script as `get_backend_code_context.ps1` in the root directory of your backend project.
# 2. Open the terminal in VS Code.
# 3. Ensure you are in the root directory of your project.
# 4. Run the script using:
#    .\get_backend_code_context.ps1

# Use the current directory as the project directory
$project_dir = Get-Location

# Use a fixed name for the output file in the current directory
$output_file = "$project_dir\backend_code_context.txt"

# Check if the output file exists and remove it if it does
if (Test-Path $output_file) {
    Remove-Item $output_file
}

# List of directories to look for in the backend
$directories = @("controllers", "models", "routes", "middleware", "config", "utils")

# List of file types to ignore
$ignore_files = @("*.env", "*.sh", "*.json", "*.md")

# Recursive function to read files and append their content
function Read-Files {
    param (
        [string]$directory
    )

    Get-ChildItem -Path $directory -Recurse | ForEach-Object {
        if ($_.PSIsContainer) {
            Read-Files -directory $_.FullName
        } else {
            # Check if the file type should be ignored
            $should_ignore = $false
            foreach ($ignore_pattern in $ignore_files) {
                if ($_.Name -like $ignore_pattern) {
                    $should_ignore = $true
                    break
                }
            }

            # If the file type should not be ignored, append its relative path and content to the output file
            if (-not $should_ignore -or $_.Name -eq "index.js") {
                $relative_path = $_.FullName.Substring($project_dir.Length + 1)
                Add-Content -Path $output_file -Value "// File: $relative_path"
                Get-Content -Path $_.FullName | Add-Content -Path $output_file
                Add-Content -Path $output_file -Value ""
            }
        }
    }
}

# Call the recursive function for each specified directory in the project directory
foreach ($dir in $directories) {
    $full_path = "$project_dir\$dir"
    if (Test-Path $full_path) {
        Read-Files -directory $full_path
    }
}

# Also process the root directory for index.js
if (Test-Path "$project_dir\index.js") {
    Add-Content -Path $output_file -Value "// File: index.js"
    Get-Content -Path "$project_dir\index.js" | Add-Content -Path $output_file
    Add-Content -Path $output_file -Value ""
}
