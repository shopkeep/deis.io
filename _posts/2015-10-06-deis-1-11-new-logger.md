---
layout: post
title: "Deis v1.11 - New Logger"
author: mboersma
meta:
  - name: description
    content: Deis release v1.11
  - name: keywords
    content: deis, release, v1.11, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise, kubernetes, mesos
---

The Deis project is proud to announce [v1.11.0](https://github.com/deis/deis/releases/tag/v1.11.0), featuring a rewritten **deis-logger** component with [settings](http://docs.deis.io/en/latest/customizing_deis/logger_settings/#settings-used-by-logger) that allow [in-memory storage](http://docs.deis.io/en/latest/managing_deis/running-deis-without-ceph/#configure-logger) and TCP forwarding. Stateless Deis clusters now include **deis-logger** and support the `deis logs` command.

Join the fun: new contributors to Deis can get [free DigitalOcean credits](http://deis.io/code-for-credit-digitalocean/)!

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.11.0 Summary

### New Features

- **deis-logger** is [rewritten](https://github.com/deis/deis/pull/4502) for stability and extensibility
- [**deis-registry**](http://docs.deis.io/en/latest/customizing_deis/registry_settings/#settings-used-by-registry) allows IAM role authentication for S3
- `deis apps:transfer` lets a user hand off ownership of an app to another user
- **deis-builder** checks out submodules in custom buildpacks as needed
- **deis-router** on AWS has improved [Kubernetes](http://kubernetes.io/)-aware ELB healthchecks
- **deis-router** can enforce [whitelisting of IP addresses](http://docs.deis.io/en/latest/managing_deis/security_considerations/#ip-whitelist) for apps or for **deis-controller**
- New AWS clusters prevent CloudFormation from replacing instances on AMI changes
- `$DEISCTL_TUNNEL` is automatically discovered on vagrant provisioning
- **deis-controller** can write app event logs via logspout

### Improvements

- Scripts in contrib/ support [`rigger`](https://github.com/deis/rigger), the new deployment tool for Deis
- **deis-controller** healthchecks properly ignore non-web processes
- Graceful upgrades fixed several issues found in the wild
- Documentation is more detailed about Azure provisioning and when `deisctl` is needed
- Docs have an architecture diagram and detail about the [**deis-router** mesh](http://docs.deis.io/en/latest/understanding_deis/architecture/#router-mesh)
- Docs give an example of backing **deis-registry** with OpenStack [Swift](http://docs.openstack.org/developer/swift/)
- `deis config:set` handles multi-line environment variables
- The `deis` client suggests help if `deis create` fails on the git remote
- `deis` correctly displays unexpected non-JSON error messages and malformed logs
- `deis` prints all error messages to stderr
- The `route53-wildcard` contrib script handles its `--zone` argument correctly
- `deis register` returns a better error if registration is disabled
- `deisctl status` is listed in the main help message
- **deis-controller** more thoroughly validates config keys
- contrib/ firewall scripts check that `etcd` is running

### Under the Hood

- [CoreOS][https://coreos.com/] is updated to 766.4.0, the current stable channel version
- New clusters use CoreOS' default [`etcd2`](https://github.com/coreos/etcd) and [`flannel`](https://github.com/coreos/flannel) services
- Azure provisioning uses new [ARM](https://azure.microsoft.com/en-us/documentation/articles/resource-manager-deployment-model/#) templates
- DigitalOcean provisioning uses [terraform](https://terraform.io/)
- The optional **deis-cache** component is removed, but **deis-registry** still uses it if it is present in an upgraded cluster
- The `shellcheck` script linter tool was updated to 0.4.1

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).


## What's Next

### Docker v2 Registry

The Deis registry must be [upgraded to the new v2 API](https://github.com/deis/deis/issues/3814) to ensure forward-compatibility with Docker.  This has a number of added benefits including performance and trust. Great progress has been made in detaching **deis-controller** from depending on a specific Docker version and in reimplementing `deis pull` to work with any standard registry container. Work remains to migrate existing v1 registry data to v2.

### Rigger

[Rigger](https://github.com/deis/rigger) is a new tool designed to make it easier to provision and test Deis clusters.  With `rigger`, you can stand up and test a Deis cluster on any provider with just a handful of simple commands.  The Deis core team is already using `rigger` internally, but we are looking for feedback.  Please provide your thoughts and requirements on the [design document](https://github.com/deis/deis/issues/4345).

## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues, providing support to others, and working on various Deis branches:

- @aj-may: Prototyping and discussion that led directly to the new **deis-logger** and its in-memory ringbuffer
- @benbarclay: Builder incorrectly sources proxy env vars
- @benwilber: bug(builder): Procfile should not be parsed as YAML, fix(deisctl): default stdout and stderr are reversed, fix(tests): binaries are installed in the wrong directories, fix(controller): validate config keys at the api level, fix(controller): state property can't be used in a list_filter in the Django web admin
- @clayzermk1: builder will not come up after updating CoreOS on a v1.10.1 cluster, logspout death looping on deis v1.8.0
- @CloudSide: How do I proxy the `deisctl` to Restful-API use https?
- @crigor: Graceful Upgrade: Restart the routers once
- @Crispy1975: enforceHTTPS causes unwanted redirect.
- @duanhongyi: deis-builder can't start, docs(managing_deis): add OpenStack Swift store example
- @dustinrc: fix(contrib): urlopen call hangs
- @eroubal: 'deis pull' gives me constant 404 NOT FOUND
- @Footjy: Support for self-signed certificates
- @franquis: deis-builder v1.10.1 stays in state Activating/start-post
- @geeksoul-me: Deisctl start stateless-platform hangs at builder after upgrade from 1.9.1 to 1.10.0
- @gred7: trying to provision a cluster on amazon aws
- @helloravi: Cluster Provisioning question(~azure)
- @iartem: Deis logs "panic: runtime error: index out of range"
- @ineu: Instructions on creating external database from scratch, All database contents is lost when database is rescheduled to another machine, Backup/restore documentation is not precise
- @jfchevrette: Fix awk field separator not working on non-GNU awk
- @jgmize: Proposal feat(k8s): docker-compose.yml syntax support via compose2kube
- @Joshua-Anderson: fix(client): accept multi line config vars., feat(client): print error messages to stderr, fix(Makefile): silence docker-machine warning when it isn't installed, feat(controller): allow users to transfer app ownership.
- @jwaldrip: Issues with Controller v1.6.1
- @laurrentt: feat(Registry): add support for IAM role authentication, feat(Router): IP whitelisting for apps and controller, fix(controller): healthcheck no longer check non-web processes
- @LoicMahieu: Can not use official nginx docker image on port 80, Stateless Install: deis-router continually logs `signal process started`, Stateless install: graceful upgrade re-install Deis in stateful mode, Can add multiple ssh keys with the same name and remove throws an exception
- @mariusmarais: Router and application tagging
- @msull92: Builder 400 error, Platform SSL certificate alongside application certificate, Issue removing ssl cert from application with spaces in common name
- @nasali: CoreOS Configuration
- @nathansamson: Protect pushes from wrong branch
- @nsmith: Add https log drain type
- @olalonde: fatal: 'somerepo.git' does not appear to be a git repository, Builder: Make git sha hash available during build, Router scheduled on machine with metadata routerMesh=false, docker: "pull" requires 1 argument. See 'docker pull --help', Stateless install: recommended RDS settings for database?
- @robeferre: Cannot perform, deis info, deis create
- @rvadim: Prototyping and discussion that led directly to the new **deis-logger** and its in-memory ringbuffer, Builder problem: ssh_exchange_identification: Connection closed by remote host.
- @rvaralda: Deis Registry miss /deis/store/gateway key while use S3 as storage
- @slash-: ceph mon down
- @sstarcher: Graceful Shutdown does not remove from Discovery URL, Graceful Shutdown requires Ceph, config:push with .env does not support multline, fix(contrib): Zone argument not supported for aws
- @szymonpk: proposal: atomic cert update

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Voice your opinion on the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) by attending the monthly [Release Planning Meeting](http://docs.deis.io/en/latest/roadmap/planning/#release-planning-meetings)
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
