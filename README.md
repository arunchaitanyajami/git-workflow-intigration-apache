# Git WorkFlow for Phpcs, Eslint, Style Lint.
Following Repo will be useful for you project to define your coding standards.

This has 3 parts
- Circle CI
- Git Workflow
- Pre-commit

This will use docker PHP7.4 ( Latest as per today's date )

If you want only Circle Ci please use ``.circleci`` folder.
If you want only git workflow please use ``.github`` folder.
If you want only pre-commit please remove ``.github and .circleci`` folder.
If you want all please dont remove anything.


Heart of this project is ``composer.json``,`` Package.json`` and `bin` Folders.
Please dont remove.

## Circle Ci Integration.
Circle Integration for ES linting, Phpcs and Style linting and provide Review on each commit.

Will work when you push a commit to origin repo either to branch or PR.


## Git WorkFlow Integration.
- Define `GH_BOT_TOKEN` using [GitHub Action's Secret](https://developer.github.com/actions/creating-workflows/storing-secrets). See [GitHub Token Creation](#github-token-creation) section for more details.

Will work when you rise a PR.


## Pre-commit Integration.
Will work when you try to commit anything to your origin repo.