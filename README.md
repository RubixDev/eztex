# eztex
A CLI for quickly starting new LaTeX projects with templates

## Installation
### Arch Linux
Simply install the `eztex` or `eztex-git` package from the AUR

### Other Distributions
```bash
sudo bash -c "$(curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/install.sh')"
```
or for fish users:
```bash
set -l IFS; sudo bash -c (curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/install.sh')
```
> **Note:** `curl -fsSL` can be replaced with `wget -O-` if necessary

## Removal
```bash
sudo bash -c "$(curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/uninstall.sh')"
```
or for fish users:
```bash
set -l IFS; sudo bash -c (curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/uninstall.sh')
```
> **Note:** `curl -fsSL` can be replaced with `wget -O-` if necessary

## Usage
`eztex [OPTIONS] COMMAND ...ARGS`

Available options:
| Short | Long     | Argument | Description                                                                         |
| ----- | -------- | -------- | ----------------------------------------------------------------------------------- |
| `-n`  | `--name` | `NAME`   | A name used to directly replace the name placeholder on initialization of a project |
| `-d`  | `--date` | `DATE`   | A date to use instead of \today                                                     |

Available commands:
| Name     | Shorthand | Arguments          | Description                                                                      |
| -------- | --------- | ------------------ | -------------------------------------------------------------------------------- |
| `init`   | `i`       | `TEMPLATE`         | Initializes a new LaTeX project based on `TEMPLATE` in the current directory     |
| `clear`  | `c`       |                    | Clears the current LaTeX project of cache files                                  |
| `new`    | `n`       | `TEMPLATE`, `NAME` | Creates a new LaTeX project in a new directory called `NAME` based on `TEMPLATE` |
| `save`   | `s`       |                    | Copies the main.pdf to a PDF with the name of the current directory              |
| `update` | `u`       |                    | Try to update eztex to the newest version from GitHub                            |
| `remove` | `r`       |                    | Try to remove eztex from the system                                              |
| `help`   | `h`       |                    | Shows a help message containing this info                                        |
