# Linux-Automation
Linux Automation is a repository that brings together all the tools I created to set up my development environment.

- [common.sh](#commonsh)
- [.zshrc](#zshrc)

# common.sh
This script is under development

# .zshrc
This script allows you to automatically configure `zsh` and add the most convenient plugins to work more efficiently.
This script uses [Antigen](https://github.com/zsh-users/antigen/) as plugins manager for zsh, so you can add all compatible plugins in your `.zshrc` file.

## Introduction
Two themes are available. Themes change automatically if you are logged in as root.
- User theme

![user-theme](images/user-theme.png)

- Root theme

![root-theme](images/root_theme.png)

## Installation

- Install all the necessary tools (zsh, curl):

> You need privileges to install necessary tools

```bash
apt-get install -y git zsh curl apt-transport-https
```

- Download the `.zshrc` file

```
curl -sL -o ~/.zshrc https://raw.githubusercontent.com/flomSStaar/Linux-Automation/master/zsh/.zshrc
```

- Configure zsh as default shell

```bash
chsh -s /usr/bin/zsh
```

- Restart your terminal

## Configuration

- In `.zshrc` file

  You can directly add other configurations like aliases or other bundles but it is recommended to create a local .zshrc file in `~/.perso/.zshrc` to avoid re-configuring your .zshrc file when updating this script.

- In `~/.perso/.zshrc` file
  
  It is recommended to add other configurations in `~/.perso/.zshrc` file to avoid re-configuring your .zshrc file when updating this script.

- Adding antigen bundles:
  
  In `~/.perso/.zshrc`, you can add antigen bundle/theme with the following line

  ```
  antigen bundle <git repository> <path to bundle file>
  antigen theme <git repository> <path to theme file>
  ```

  Example:

  ```
  antigen theme flomSStaar/Linux-Automation zsh/flomSStaar
  ```

# Contributing

You can participate in this project by creating a pull request. I will study the proposal to see if it is relevant to the project. 

# Bugs and issues

You can report bugs and issues on Github [here](https://github.com/flomSStaar/Linux-Automation/issues)


# Contributors

- [Florent MARQUES](https://github.com/flomSStaar) - Creator 
