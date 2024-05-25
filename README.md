# Code Context Extractor Scripts

This repository contains two PowerShell scripts designed to extract and consolidate the content of backend and frontend code files from specified directories. These scripts are useful for creating a comprehensive snapshot of your codebase for review, analysis, or sharing.
Will work flawlessly for any framework/ Library/ Projectsl. Just modify the files/folders from include/exclude Arrays

## Scripts

### Backend Code Context Extractor [`get_backend_code_context.ps1`](https://github.com/bghub-c/GPT_CodeAssist/blob/main/get_backend_code_context.ps1)


#### Description:

The `get_backend_code_context.ps1` script extracts the content of backend code files from specified directories in a Node.js/Express project and consolidates them into a single file named `backend_code_context.txt`.

#### Features:

- **Directories Processed:** Reads files from controllers, models, routes, middleware, config, and utils directories.
- **File Inclusion:** Includes `index.js` files found in the root directory and subdirectories.
- **File Ignoring:** Ignores files with extensions such as `.env`, `.sh`, `.json`, `.ps1` and `.md`.
- **Recursive Processing:** Recursively processes all subdirectories and files within the specified directories.
- **Output:** Consolidates all file contents into `backend_code_context.txt` with comments indicating file paths.

 **Modifications** - You can add or remove files extensions or folders as per your needs

#### Usage Instructions:

1. Save the script as `get_backend_code_context.ps1` in the root directory of your backend project.
2. Open the terminal in VS Code.
3. Ensure you are in the root directory of your project.
4. Run the script using:

    ```powershell
    .\get_backend_code_context.ps1
    ```

### Frontend Code Context Extractor [`get_frontend_code_context.ps1`](https://github.com/bghub-c/GPT_CodeAssist/blob/main/get_frontend_code_context.ps1)

#### Description:

The `get_frontend_code_context.ps1` script extracts the content of frontend code files from specified directories in a React project and consolidates them into a single file named `frontend_code_context.txt`.

#### Features:

- **Directories Processed:** Reads files from components, contexts, services, and styles directories.
- **File Inclusion:** Specifically includes files like `App.js`, `index.js`, `.env`, and `package.json`.
- **File Ignoring:** Ignores files with extensions such as `.json`, `.ps1`, `.sp`, and `.jpeg`.
- **Recursive Processing:** Recursively processes all subdirectories and files within the specified directories.
- **Output:** Consolidates all file contents into `frontend_code_context.txt` with comments indicating file paths.

 **Modifications** - You can add or remove files extensions or folders as per your needs

#### Usage Instructions:

1. Save the script as `get_frontend_code_context.ps1` in the root directory of your frontend project.
2. Open the terminal in VS Code.
3. Ensure you are in the root directory of your project.
4. Run the script using:

    ```powershell
    .\get_frontend_code_context.ps1
    ```

# Contributing

If you have any suggestions or improvements, feel free to submit a pull request or open an issue.
