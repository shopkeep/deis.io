---
layout: post
title: "Deis v1.8 - Optional Ceph"
author: mboersma
meta:
  - name: description
    content: Deis release v1.8
  - name: keywords
    content: deis, release, v1.8, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise
---

The Deis project is proud to announce [v1.8.0](https://github.com/deis/deis/releases/tag/v1.8.0), which makes installation of store, database, and logger [optional](http://docs.deis.io/en/latest/managing_deis/running-deis-without-ceph/) when running external backing stores, adds `deisctl ssh` and `deis auth:regenerate` commands, and unleashes Deis onto Linode.

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.8.0 Summary

### New Features

- Deis can be provisioned [without Ceph](http://docs.deis.io/en/latest/managing_deis/running-deis-without-ceph/) by using an external backing store
- deis-router uses new nginx `reuseport` [socket sharding](https://www.nginx.com/blog/socket-sharding-nginx-release-1-9-1/)
- Deis can be provisioned [on Linode](http://docs.deis.io/en/latest/installing_deis/linode/), thanks to community support!
- `deisctl ssh <component>` opens a shell directly to the node running the specified Deis component
- deis-router features security configuration for [DHE ciphersuites](https://github.com/deis/deis/pull/3872), [SSL ciphers](https://github.com/deis/deis/pull/3873), and [HSTS](https://github.com/deis/deis/pull/3866)
- `deis auth:regenerate` creates a new authentication token
- deis-controller will properly roll back a release if some containers weren't created

### Improvements

- Source code for `deisctl` is substantially refactored, with beefier, parallelized test coverage
- Numerous enhancements to API reference documentation and generated code docs
- Fixed "invalid tar magic" error when pushing without a Procfile
- Fixed JSON decoding errors in test suite due to premature SSH close
- deis-builder generates SSH keys on boot when needed
- Doc updates to upgrade procedure, EC2 PROXY protocol, and cluster sizing for etcd
- Contrib README.md mentions new community tools for monitoring and backup/restore
- Added Engine Yard provisioning and Deis Pro to docs
- `deisctl` won't hang forever waiting for a missing service
- deis-builder only builds slugrunner/slugbuilder if they're missing
- Amazon EC2 m4 instance types are now supported in provisioning
- DigitalOcean support added a couple of eligible regions
- `DEIS_DRINK_OF_CHOICE=slurm` won't break integration tests now
- deis-registry will SIGHUP its processes correctly on restart
- deis-builder won't log `etcdctl watch` output periodically
- integration tests will retry `docker push` on Docker Hub errors

### Under the Hood

- deis-router updated nginx to [1.9.2](http://nginx.org/en/CHANGES)
- deis-registry incorporates some upstream fixes to the "classic" V1 registry
- deis-database updated wal-e to 0.8.1
- deis-controller updated psycopg2 to 2.6.1
- Several components updated to confd 0.10.0

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## What's Next

### Configurable Healthchecks

To enable publishing of new app releases with zero downtime, Deis needs a more strict, configurable HTTP healthcheck facility. Substantial progress has been made, but more coding and testing remains. Look forward to true zero-downtime deploys in the next release!

### TTY Broker

Today Deis cannot provide bi-directional streams needed for log tailing and interactive batch processes. By having the Controller drive a TTY Broker component, Deis can securely open WebSockets through the routing mesh.

See [TTY Broker](http://docs.deis.io/en/latest/roadmap/roadmap/#tty-broker) at the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) for more detail.

### Scheduling and Orchestration

Today Deis uses Fleet for scheduling. Unfortunately, Fleet does not support resource-based scheduling, which results in poor cluster utilization at scale.

Fortunately, Deis is composable and can easily hot-swap orchestration APIs. Because the most promising container orchestration solutions are under heavy development, the Deis project is focused on releasing "technology previews".

These technology previews will help the community try different orchestration solutions easily, report their findings and help guide the future direction of Deis.

See [Scheduling and Orchestration](http://docs.deis.io/en/latest/roadmap/roadmap/#scheduling-and-orchestration) at the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) for more detail.

### Etcd 2

A CP database like `etcd` is central to Deis, which requires a distributed lock service and key/value store. As problems with etcd directly impact platform stability, Deis must move to the more stable etcd2.

See [Etcd 2](http://docs.deis.io/en/latest/roadmap/roadmap/#etcd-2) at the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) for more detail.

## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues, providing support to others, and working on various Deis branches:

- @adrianandreias: Feature: rkt (rocket) support
- @aendrew: 404 after upgrading to 1.7.0
- @ainux4mrvce: deis create issue, dockerfile, not able to push on deis master , deis login error
- @bastilian: deisctl seems to ignore options
- @crigor: Don't exclude .git on the slug, Update Installing SSL on a Load Balancer Doc, Admins should be able to delete users
- @Crispy1975: Vagrant: error: failed to push some refs, Cannot deploy using Heroku buildpack and private repositories.
- @croemmich: Can't start builder on 1.7.2., docs(backing_up_data): Add community tools for reference, docs(contrib): add link to Deis Backup and Restore, feat(contrib/linode): add Linode provision scripts and docs
- @dpanelli: Deploy of a new version fails with: "tar: invalid tar magic " after Deis update 1.5 to 1.7
- @etcinit: Client may break if enforceHTTPS=true and the client config points to http
- @fabiob: AffinityArg hangs router on 1.7.3, docs(*): update references to the new base image, alpine
- @glenwong: Multiple clusters for dev, staging, and production?
- @glogiotatidis: App users should be able to add/edit/delete domains for app
- @ineu: deisctl installation script output is not colorized in bash or zsh, Pull new versions of deis in advance?
- @kalbasit: fix(deisctl): avoid blocking if output is empty
- @krancour: API / controller logging should be via logspout, bug(docs): Inaccurate description of builder responsibilities, fix(docs): Correct and clarify description of builder component, fix(tests): fix assertions on default beverage
- @linki: fix(router): fix markdown table rendering
- @liuyang1204: Gateway  Key not found (/deis/store/gateway/masterLock) [8462114]
- @lorieri: deis domains doesn't check for existing apps, restarting builder requires app destroy
- @megastef: docs(manage_deis) - add SPM Performance Monitoring
- @mikepack: already don't -> don't already, ot -> to
- @nathansamson: Use flocker to replace Ceph for database & builder & ..., fix(client): Fix attribute errors on windows
- @ngerakines: Errors in logs, possibly from store.
- @olalonde: deis-builder won't start after 1.6.1 -> 1.7.3 upgrade, `deis config:push -a someappname` doesn't work, "Welcome to nginx!" page after git push, journalctl shows "[WARNING] - 501: All the given peers are not reachable (Tried to connect to each peer twice and failed) [0]" on a machine, Auto restart app when it crashes?, Can't push to deis after `deisctl restart builder`, `deis logs` doesn't show log with Procfile based deployment, Weird `deis ps` output after running `deis config:set ...` and `git push` at the "same" time, "Welcome to NGINX" after switching from Dockerfile based deployment to Procfile, HTTPS 504 GATEWAY_TIMEOUT after setting AWS ELB https
- @phspagiari: Deis scale isnt respecting the cluster.
- @s20691033: store daemon is giving errors, `deis run` writes output to logs, and not to the client, noise in logs on non-ipv6 hosts
- @sbuss: Starting platform hangs on the builder, can't find an image
- @scottrobertson: deis run throws 500 error, /home/git/repo.git/build not being cleaned up, Idea: Deployment Keys, After upgrade to 1.7, sites are 404'ing and cannot push
- @sockeye44: Go build failed, Play framework build failed
- @sstarcher: Connection Draining, deisctl --version returns exit code of 1
- @szymonpk: Sanitize/filter config variables from client, no output from deis run while using ruby's puts or pp, create_bucket should use secure transport if external s3 is used and it should respect s3 region, proposal feat(client) allow for custom git hostname, deis client can't setup ssl connection via cloudflare, deis-logger is eating whole cpu
- @wenzowski: HPKP Public-Key-Pins Header, feat(router): add Diffie-Hellman parameter for DHE ciphersuites, feat(router): read list of preferred ciphers, feat(router): enable HSTS when enforceHTTPS is set, fix(router): set_random belongs in a `location` block
- @wgrrrr: chore(contrib/ec2): add m4 instance types
- @woopstar: Installator hanged, but platform is up and running
- @zag2art: Builder can't start after upgrade 1.5.2 -> 1.7.3

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Voice your opinion on the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) by attending the monthly [Release Planning Meeting](http://docs.deis.io/en/latest/roadmap/planning/#release-planning-meetings)
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
