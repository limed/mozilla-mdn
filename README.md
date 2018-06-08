# mozilla-mdn

What is this repo? This is the repo we are using to call the mozilla-mdn infrastructure modules

## Modules

There are 3 main modules in `maint.tf`
- `mdn_shared`: Deploys s3 buckets
- `mdn_cdn`: Deploys cdn
- `mdn_shared`: Deploys redis, memcached, efs and RDS

## Pre-requisites
We use a tool called `nubis-ctl`(https://github.com/nubisproject/nubis-ctl) to
deploy this. Installation instructions for this tool can be found
[here] (https://github.com/nubisproject/nubis-ctl#installation-instructions)

In order to run `nubis-ctl` you will need the following tools installed locally

- docker (https://docker.io)
- aws-vault (https://github.com/99designs/aws-vault)

## How to deploy

First things first variables and inputs that this module needs are documented
in the `variables.tf` file. And to override them you edit the `terraform.tfvars`
file

From the base directory run the following to do a terraform plan

```bash 
# nubis-ctl -a mozilla-mdn deploy plan
```

And if you want to deploy run the following

```bash
# nubis-ctl -a mozilla-mdn deploy apply
```

There is more information on how to use `nubis-ctl`
[here] (https://github.com/nubisproject/nubis-ctl#operational-instructions)
