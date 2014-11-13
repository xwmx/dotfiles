# Dotfiles

## Instructions for use

Clone the repository to `~/.dot` and symlink all of the files that are
in the `~/.dot/files` directory.

## Additional Information

Because there are housekeeping files in the root level of the
repository, particularly git files with the name name as git config
dot files, all of the dot files live in a `files` directory.

This `files` directory has the same structure as the files are intended
to be placed in the home directory, which makes it easy to symlink them
without needing to determine which files should be symlinked or not.

This structure also makes it possible to keep the original filenames, which
should help avoid confusion.

