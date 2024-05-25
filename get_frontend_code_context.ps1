# PowerShell Script to Extract Frontend Code Context
# This script reads the content of specified frontend directories and appends it to a single file.
# It also includes index.js files in the root directory and subdirectories.

# Instructions:
# 1. Save this script as `get_frontend_code_context.ps1` in the root directory of your frontend project.
# 2. Open the terminal in VS Code.
# 3. Ensure you are in the root directory of your project.
# 4. Run the script using:
#    .\get_frontend_code_context.ps1

# Use the current directory as the project directory
$project_dir = Get-Location

# Use a fixed name for the output file in the current directory
$output_file = "$project_dir\frontend_code_context.txt"

# Check if the output file exists and remove it if it does
if (Test-Path $output_file) {
    Remove-Item $output_file
}

# List of directories to look for in the frontend (You can manually add folders to read)
$directories = @("components", "contexts", "services", "styles", "src")

# List of specific files to include (You can manually add files to read)
$include_files = @("App.jsx", "index.jsx")

# List of file types to ignore (You can manually add files extensions)
$ignore_files = @("*.json", "*.ps1", "*.sp", "*.jpeg", ".svg")

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
            if (-not $should_ignore -or $_.Name -in $include_files -or $_.Name -eq "index.js") {
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

# Also process the specified files in the root directory
foreach ($file in $include_files) {
    $full_path = "$project_dir\$file"
    if (Test-Path $full_path) {
        Add-Content -Path $output_file -Value "// File: $file"
        Get-Content -Path $full_path | Add-Content -Path $output_file
        Add-Content -Path $output_file -Value ""
    }
}

# Add a string at the end of the .txt file
Add-Content -Path $output_file -Value "Read the code and wait for my instructions"
