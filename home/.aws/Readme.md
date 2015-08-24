# home/.aws

Configuration for AWS tools.

At minimum, this directory will usually contain two files:

## `.aws/credentials`

```
[default]
aws_access_key_id = <access_key>
aws_secret_access_key = <secret_key>
```

## `.aws/config`

```
[default]
region = <region>
```

Completion configuration:

- [home/.bashrc.d/awscli.bash](../.bashrc.d/awscli.bash)
- [home/.zshrc.d/awscli.zsh](../.zshrc.d/awscli.zsh)

More information:

https://github.com/aws/aws-cli

See also:

https://github.com/achiku/jungle
