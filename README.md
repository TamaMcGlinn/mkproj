# Mkproj

Language- and editor agnostic project creation tool.

Make a project from a prewritten template,
replacing `__PROJECTNAME__` in filenames and their contents.

You can create your own, separate repository containing templates.

## Prerequisites

An Ada compiler, such as GNAT, and gprbuild.
I recommend you install the free [GNAT Community Edition](https://www.adacore.com/download).

## Install

```
git clone https://github.com/TamaMcGlinn/mkproj.git
cd mkproj
gprbuild
```

Then make mkproj/bin/mkproj accessible in PATH with e.g.

```
ln -s ${PWD}/bin/mkproj ~/.local/bin/
```

To get bash completion, add `source /path/to/mkproj/mkproj-completion.bash`
to your `~/.bashrc` file.

Install some project template collections:

```
mkdir -p ~/.config/mkproj
cd ~/.config/mkproj
git clone https://github.com/TamaMcGlinn/project_templates.git
```

## Usage

mkproj takes two parameters. The first is the project template,
the second is the name for the new project.

Project templates are searched in subdirectories of `~/.config/mkproj`.
That means you can add your own custom project template collection there.
For example, if `~/.config/mkproj` looks like this:

```bash
├── your_custom_templates
│   ├── custom_project1
│   │   ├── Makefile
│   │   └── src
│   └── custom_project2
│       ├── Makefile
│       └── src
└── project_templates
    └── ada_makefile
        ├── Makefile
        └── src
```

Then you can do `mkproj cu[tab]` to cycle through your two custom_projects.
E.g. `mkproj custom_project1 foo` will create a foo directory
containing the files from that template dir, but with `__PROJECTNAME__`
substituted with foo.

Since the first parameter is the project template, you could also add aliases
for your favourite templates to your ~/.bash_aliases, e.g.:

```
alias mkada='mkproj project_templates/ada_gprbuild'
alias mkcpp='mkproj project_templates/cpp_makefile'
```

