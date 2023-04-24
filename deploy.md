## Deployment Notes ##

### Login ###
To login to the NIA account as ad administrator from CLI:

```
aws sts assume-role --role-arn arn:aws:iam::{deployment account}:role/{deployment role} --role-session-name  admin@nia --serial arn:aws:iam::{identity account}:mfa/{username} --token-code {mfa code}
export AWS_ACCESS_KEY_ID=RoleAccessKeyID
export AWS_SECRET_ACCESS_KEY=RoleSecretKey
export AWS_SESSION_TOKEN=RoleSessionToken
```

This is implemented in [get_aws_key.sh]. As this script sets environment variables you'll need to `source get_aws_key.sh` to persist these in your session. 

Duration is set to the default for this role. If this times out you will need to unset the environment variables to request a new session:

```
unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
```

This is implemented in [unset_aws_key.sh].

### Adapting Docker Compose into ECS tasks ###

A list of the variables in the task can be created with:

```
grep -o '${[^}]*' ecs_tasks/gp2gp_ps.tpl.json | sed -e 's/\${//' | sort -u
```

But this needs to differentiate between secrets and environment variables so we use jq to get the secrets in a format which can be put into terraform:
```
jq '.taskDefinition.containerDefinitions[].secrets[]|{(.name): .valueFrom} | to_entries[] ' ecs_tasks/gp2gp_ps.tpl.json | \
jq -s '. | unique_by(.key)[] | [.key, .value] | @sh '  | \
 sed -e "s/' '/ = /" -e s/\"//g -e s/\'//g
```

And for environment:
```
jq '.taskDefinition.containerDefinitions[].environment[]|{(.name): .value} | to_entries[] ' ecs_tasks/gp2gp_ps.tpl.json | \
jq -s '. | unique_by(.key)[] | [.key, .value] | @sh '  | \
sed -e "s/' '/ = /" -e s/\"//g -e s/\'//g
```

We can turn these into tf variables using:
```
jq '.containerDefinitions[].secrets[]|{(.name): .valueFrom} | to_entries[] ' ecs_tasks/gp2gp_ps.tpl.json | \
 jq -s '. | unique_by(.key)[] | [.key, .value] | @sh '  | \
  sed -e "s/' '/ = /" -e s/\"//g -e s/\'//g  | \
  sed -e 's/ = .*$//' -e 's/.*/variable "\0" {\n\ttype=string\n\tsensitive=true\n}/'
```

While for environments:
```
jq '.containerDefinitions[].environment[]' ecs_tasks/gp2gp_ps.tpl.json | \
jq -s '. | unique_by(.value)[]| [.value] | @sh' | \
sed -e "s/[$\{\}\'\"]//g" | \
sed -e 's/^.*$/variable "\0" {\n\ttype=string\n}/'
```

existing batch files can be adapted to set tf variables which are prefixed using `TF_VAR_`:
```
sed -e 's/export /\0TF_VAR_/' ps_daisy_chaining_vars.sh > tf_ps_daisy_chaining_vars.sh
```
you can then `source <(cat ../tf_*.sh)` to make these environment variables available to terraform. 

Do these steps for each .sh file.

