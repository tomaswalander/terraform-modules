## About the latest version

This is the absolutely most up-to-date (latest) version of the terraform modules. I.e., it corresponds to what is on the master branch in the [terraform-modules repository](https://github.com/tomaswalander/terraform-modules). 

> **<span style="background-color: #c7c400; border-radius: 3px; color: black; padding:2px;">WARN</span>:** The modules in the latest version are subject to change without notice and with no guaranteed backwards compatibility.

It is _ALWAYS_ recommened to use a specific version (e.g., `?ref=vX.X.X`) rather than the latest version. However, it is of course also recommended to continuously ensure that you are keeping up-to-date with improvements to these modules by updating to the LTS version. 

## Versioning

To use a specific version simply add `?ref=vX.X.X` to the source argument of your module usage. E.g., 

```
module "rg" {
  source   = "<git-base-url>//modules/lib/azure-resource-group?ref=v1.0.0"

  // more arguments
}
```

#### LTS versions

- TBA...
