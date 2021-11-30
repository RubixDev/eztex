# eztex
A CLI for quickly starting new LaTeX projects with templates

## Installation
```bash
sudo bash -c "$(curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/install.sh')"
```
or for fish users:
```bash
set -l IFS; sudo bash -c (curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/install.sh')
```
> **Note:** `curl -fsSL` can be replaced with `wget -O-` if necessary

## Deletion
```bash
sudo bash -c "$(curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/uninstall.sh')"
```
or for fish users:
```bash
set -l IFS; sudo bash -c (curl -fsSL 'https://raw.githubusercontent.com/RubixDev/eztex/main/uninstall.sh')
```
> **Note:** `curl -fsSL` can be replaced with `wget -O-` if necessary

## Usage
`eztex COMMAND ...ARGS`

Available commands:
| Name    | Shorthand | Arguments          | Description                                                                      |
| ------- | --------- | ------------------ | -------------------------------------------------------------------------------- |
| `init`  | `i`       | `TEMPLATE`         | Initializes a new LaTeX project based on `TEMPLATE` in the current directory     |
| `clear` | `c`       |                    | Clears the current LaTeX project of cache files                                  |
| `new`   | `n`       | `TEMPLATE`, `NAME` | Creates a new LaTeX project in a new directory called `NAME` based on `TEMPLATE` |
| `help`  | `h`       |                    | Shows a help message containing this info                                        |
