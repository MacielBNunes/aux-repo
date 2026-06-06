# Running example: `py open-devcontainer-cmd.py /home/mnn/mg-ctrlr` ====================

import sys

wsl_abs_project_dir = sys.argv[1]
wsl_abs_project_dir_win = wsl_abs_project_dir.replace('/', '\\')
win_project_dir_hex = f"\\\\wsl.localhost\\Ubuntu-22.04{wsl_abs_project_dir_win}".encode().hex()
project_folder = wsl_abs_project_dir_win.split('\\')[-1]
cmd = f"code --folder-uri vscode-remote://dev-container+{win_project_dir_hex}/workspaces/{project_folder}"
print(cmd)