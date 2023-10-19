Terraform modules
=================

## Run locally

> The examples below uses the `azurerm-3.75` test. But you can swap that for any of the available tests

**init**
```bash
terraform -chdir=./.tests/azurerm-3.75 init
```

**validate**
```bash
terraform -chdir=./.tests/azurerm-3.75 validate
```

**plan**
```bash
TF_VAR_modules_version="$(git rev-parse HEAD)" TF_VAR_alpha_only_module_version="$(git rev-parse HEAD | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1)" TF_VAR_tf_version="1.5.7" terraform -chdir=./.tests/azurerm-3.75 plan
```