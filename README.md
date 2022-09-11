# Multi Version Book

This repository demonstrates how to create a book with multiple versions. We
have a `base` book as well as a `pro` version of the book. This makes use of the new [Project Profiles](https://quarto.org/docs/projects/profiles.html) feature introduced in [Quarto v1.2](https://quarto.org/docs/download/prerelease.html).

## Profiles

There are two [profiles](https://quarto.org/docs/projects/profiles.html) (`base` and `pro`) defined for this project, each of which yields a different version of the book. 

To render or preview the book using a profile, pass the `--profile` command line argument:

```bash
quarto render --profile base
quarto preview --profile pro
```

Note that you can also use the `QUARTO_PROFILE` environment variable to define which profile is active:

```bash
export QUARTO_PROFILE=base
quarto render
```

The default profile when none is specified is `pro` (you can change using the `profile: default:` key within `_quarto.yml`).


## Configuration

Here are the profile specific configuraiton files:

**_quarto.base.yml**

```yaml
book:
  title: "multi-version"
  chapters:
    - index.qmd
    - intro.qmd
    - basics.qmd
```

**_quarto.pro.yml**

```yaml
project:
  output-dir: _book-pro

book:
  title: "multi-version-book (pro)"
  chapters:
    - index.qmd
    - intro.qmd
    - basics.qmd
    - advanced.qmd
``` 
  
This results in each version of the book including its own list of chapters, and in book output being written into two different directories:

- `_book` for the base version
- `_book-pro` for the pro version


## Pro-Only Content

There are two ways to create pro-only content:

1. Each profile has its own list of `chapters`. To create a pro-only
chapter just list it within `config/pro.yml` while excluding it from
`config/base.yml`.

2. Include pro-only content within a markdown div or span with the `when-profile` attribute. For example:

    ```
    ::: {when-profile="pro"}
    Content only for Pro.
    :::
    
    Content for both. [Content only for Pro]{when-profile="pro"}
    ```

You can see the use of `when-profile="pro"` further demonstrated in
[intro.qmd](intro.qmd).

## Workflow

You will probably want to do most of your work in the `pro` profile so that 
you can see all of your content (note that the project uses the `pro` profile by default):

```bash
quarto preview
```

If you want to test out `base` mode, either pass that as the profile on the command line: 
```bash
quarto preview --profile base
```

Or change the default profile within `_quarto.yml` as follows:

```yaml
profile:
  default: base
```

For final builds you'll likely just create a CI script with:

```bash
quarto render --profile pro
quarto render --profile base
```

The book content will be written to the `_book` and `_book-pro` directories.


## Profile Group

Note that the `group` field of `profile` indicates that one of the profiles in the group must always be defined in order for the project to be successfully rendered:

```yaml
profile:
  group: [pro, base]
```

This is important to specify because if an external caller defines `QUARTO_PROFILE` (e.g. RStudio Connect might automatically set it to `connect`) you want to make sure that at least one of your required profiles is automatically included in the list of profiles. In that case the first profile in the list (here `pro`) will be activated.

More typically though if you are rendering on a remote server you'll arrange to have `QUARTO_PROFILE` defined as you need it to be. The `group` specification is really a failsafe to make sure the project can always render.









