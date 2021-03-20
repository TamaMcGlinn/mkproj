# Mkproj

Work in progress! Even the basic functionality isn't working yet.
Come back later.

Make a project from a prewritten template,
replacing __PROJECTNAME__ in filenames and their contents.
The intent is to use this for quickly creating small projects.
You can create your own, separate repository containing templates.

## Usage

Clone this repository. Place a 'project_templates' directory beside it.
For example, [github.com/TamaMcGlinn/project_templates](project templates).
It should look like this:

```bash
├── mkproj
│   ├── Makefile
│   ├── mkproj.gpr
│   ├── README.md
│   └── src
│       └── mkproj.adb
└── project_templates
    └── ada_makefile
        ├── Makefile
        └── src
```

Build mkproj either using the makefile (needs gcc), or by executing gprbuild.
This produces the mkproj/bin/mkproj binary. Call it directly and answer the questions.

```bash
mkproj/bin/mkproj
The project will be created in: /home/you/somewhere
TODO ask which template to use: template_name
Enter a name for the project: thingy
```

