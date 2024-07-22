![Run linters and tests workflow](https://github.com/islomar/typescript-kata-template/actions/workflows/run-linters-and-tests.yml/badge.svg)

# Typescript template for a kata

- This repository has been partially inspired by the great https://github.com/CodelyTV/typescript-basic-skeleton from [CodelyTV](https://github.com/CodelyTV) 
- Template repository for Typescript katas (Dockerized)
- The repository is created as a **GitHub repository template**, so that you can easily create your own GitHub repository from this one.
    - [Here](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template#creating-a-repository-from-a-template) you can find the instructions: easy peasy!
    - There is a **GH project** associated with this repo, with some pending improvements.
- Everything is **Dockerized**. If you run `make` from the root folder of the project, you can see all the actions that you can execute (e.g. running the tests, static analysis, code coverage, etc.)


## HOW to use it
1. Generate a repo using this one as a template, following [these instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template#creating-a-repository-from-a-template)
2. Replace the `python-kata-name` placeholder that appears in several files with your own name (e.g. `python-fizzbuzz`).
    - For example, you can easily do it running `make rename-project new-name=python-fizzbuzz`

## Prerequisites
- You need [Docker](https://docs.docker.com/get-docker/) installed.
- **IMPORTANT**: just the first time, run `make local-setup`.
    - This will set up things like configuring Git hooks. The `pre-commit` hook will automatically run the linters and tests, rejecting the commit in case any of them fail.


## Pending
- Move to pnpm
- Fix deprecated dependencies warning
- Include test coverage in GH Actions
  - https://about.codecov.io/blog/measuring-typescript-code-coverage-with-jest-and-github-actions/