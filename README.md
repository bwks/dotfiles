# dotfiles
My dotfiles

Dotfiles are managed with `stow`

Create a managed dotfile
```
# <path/to/dotfiles>
# Create directories in the following format
# <app_name>/<path_in_homedir>
mkdir -p someapp/.config/
```

Move the dotfile to the dotfiles git repo
```
mv ~/.config/someapp someapp/.config/
```

Install a dotfiles in homedir
```
stow someapp
```

Example layout
```
├── starship
│   └── .config
│       └── starship.toml
├── stow
│   └── .stowrc
├── .stowrc
├── zed
│   └── .config
│       └── zed
│           ├── keymap.json
│           ├── settings.json
│           └── themes
```
