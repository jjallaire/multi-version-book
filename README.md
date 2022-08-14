# Multi Version Book

This repo demonstrates how to create a book with multiple versions.  We
have a base book as well as a "pro" version of the book. 

## Configurations

Execute the  `./configure` script to switch between configurations:

```bash
# work with the 'base' book
./configure base
quarto preview

# work with the 'pro' book
./configure pro
quarto render
```

Book output is written into two different directories:

- `_book` for the base version
- `_book-pro` for the pro version


Each configuration has its own YAML file that is **merged** with 
the `_quarto.yml` file via this directive in `_quarto.yml`:

```yaml
metadata-files: 
  - config/config.yml
```

Configuration specific YAML is included in the following two files

- `config/config-base.yml`
- `config/config-pro.yml`

The `.configure` script simply copies these files over `config/config.yml`.

> **IMPORTANT NOTE:** Because configuration changes are made by copying the
`-base` and `-pro` files over the `config.yml` file, you need to re-run
the `.configure` script whenever you edit these files. So for example:
> 1. Save changes to `config-base.yml`
> 2. Run `./configure base` to copy changes over to `config.yml`

## Pro-Only Content

There are two ways to create pro-only content:

1. Each configuration has its own list of `chapters`. To create a pro-only
chapter just list it within `config-pro.yml` while excluding it from
`config-base.yml`.

2. Include pro-only content within a markdown div or span with class
`.pro-only`. For example:

    ```
    ::: {.pro-only}
    Content only for Pro.
    :::
    
    Content for both. [Content only for Pro]{.pro-only}
    ```
    
The `.pro-only` spans and divs are removed by the `pro-only.lua` filter,
which is run for the `base` configuration but not the `pro` configuration.

You can see the use of `.pro-only` further demonstrated in
[intro.qmd](intro.qmd).

## Workflow

You will probably want to do most of your work in `pro` mode so that 
you can see all of your content:

```bash
./configure pro
quarto preview
```

If you want to test out non-pro mode, interrupt preview and then:

```bash
./configure base
quarto preview
```

For final builds you'll likely just create a CI script with:

```bash
./configure pro && quarto render
./configure base && quarto render
```

The book content will be written to the `_book` and `_book-pro` directories.









