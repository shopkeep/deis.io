---
layout: post
title: "Deis v1.7 - Open Roadmap"
author: carmstrong
meta:
  - name: description
    content: Deis releases v1.7
  - name: keywords
    content: deis, release, v1.7, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise
---

The Deis project is excited to announce [v1.7.0](https://github.com/deis/deis/releases/tag/v1.7.0), featuring automatic host removal, smaller Docker images, and fixes for platform hardening. The leading open source PaaS is now yours to steer: read the Deis [Open Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) and participate in [release planning](http://docs.deis.io/en/latest/roadmap/planning/#release-planning-meetings)!

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.7.0 Summary

### New Features

- Deis has adopted an [Open Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) and planning process
- Most components use [`alpine:3.1`](https://registry.hub.docker.com/_/alpine/) as a base, making Docker images smaller
- Optional scripts allow for [automatic host removal](http://docs.deis.io/en/latest/managing_deis/add_remove_host/#automatic-host-removal)
- All Heroku-compatible buildpacks were updated to recent versions
- Deis [example apps](https://github.com/deis?utf8=%E2%9C%93&query=example-) have been updated to current languages and frameworks
- Randomly-generated app names won't collide with existing ones, and the vocabulary is expanded
- `deisctl config rm` removes an existing deis configuration key
- deis-controller can be customized to appear [at a subdomain](http://docs.deis.io/en/latest/customizing_deis/controller_settings/#settings-used-by-controller) other than `deis.`
- `deis auth:passwd` accepts a `--username` flag to allow an admin to update a user's password
- deis-publisher can be profiled with Go's `pprof` package
- EC2 provisioning supports custom volume sizes
- deis-publisher exposes its config as flags
- deis-controller doesn't use deprecated HTTP X- headers
- Azure clusters automatically create a new discovery URL during provisioning

### Improvements

- deis-builder removes the `git` repo and related Docker images after `deis destroy`
- deis-router won't keep hashing on an empty string
- some `etcd` errors which were hidden are now properly raised at component start
- `deis logs -n` won't raise an IOError when piped to `head`
- `deis builds:create` requires an explicit Docker image tag
- EC2 clusters use an EBS volume to store `etcd` data
- docker.service now depends on its mount to exist before starting
- better documentation for Deis [backup/restore](http://docs.deis.io/en/latest/managing_deis/backing_up_data/) and for [CoreOS upgrades](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/#upgrading-coreos)
- `deisctl list` no longer lists an app named `deis-demo`, for example
- [deis-swarm](http://docs.deis.io/en/latest/customizing_deis/choosing-a-scheduler/#swarm-scheduler) unit files are now fetched with `deisctl refresh-units`
- [`deis config:push` and `config:pull`](http://docs.deis.io/en/latest/using_deis/config-application/#configure-the-application) validate the `.env` file syntax

### Under the Hood

- updated CoreOS to [647.2.0]()
- `deis` honors requests' environment variables such as `REQUESTS_CA_BUNDLE`
- Ceph uses a lower, more appropriate number of placement groups
- deis-logger won't query `etcd` for every log line
- deis-database runs backups in the background
- deis-builder was reorganized around Docker image best practices
- deis-controller's [`webEnabled` key](http://docs.deis.io/en/latest/customizing_deis/controller_settings/#settings-used-by-controller) uses a safer numeric default of `0`
- custom clock sync logic in `user-data` was unneeded and was removed
- `$PORT` logic was unused and removed from fleet
- deis-builder silenced some benign `pipefail` errors on boot
- deis-router returns a 404 for a non-existent app

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## What's Next

### Pluggable Storage Subsystem

Deis uses Ceph to provide a highly-available storage subsystem for stateful control plane components. While Ceph is the right default storage subsystem, it is tricky to operate and can result in control plane instability. Ceph should be optional, especially for users on AWS with direct access to services like S3.

See [Pluggable Storage Subsystem](http://docs.deis.io/en/latest/roadmap/roadmap/#pluggable-storage-subsystem) at the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) for more detail.

### TTY Broker

Today Deis cannot provide bi-directional streams needed for log tailing and interactive batch processes. By having the :ref:`Controller` drive a TTY Broker component, Deis can securely open WebSockets through the routing mesh.

See [TTY Broker](http://docs.deis.io/en/latest/roadmap/roadmap/#tty-broker) at the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) for more detail.

### Scheduling and Orchestration

Today Deis uses Fleet for scheduling. Unfortunately, Fleet does not support resource-based scheduling, which results in poor cluster utilization at scale.

Fortunately, Deis is composable and can easily hot-swap orchestration APIs. Because the most promising container orchestration solutions are under heavy development, the Deis project is focused on releasing "technology previews".

These technology previews will help the community try different orchestration solutions easily, report their findings and help guide the future direction of Deis.

See [Scheduling and Orchestration](http://docs.deis.io/en/latest/roadmap/roadmap/#scheduling-and-orchestration) at the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) for more detail.

## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues, providing support to others, and working on various Deis branches:

- @ainux4mrvce: deisctl start platform stuck at deis-store-gateway@1.service : activating/start-post, deisctl fail to start at control plane builder.service, not able to start deisctl platform , unable to set deisctl config platform sshPrivateKey, not able to install deisctl platform , fail to install deisctl
- @aledbf: Proposal ref(*): use alpine as replacement of ubuntu-debootstrap as base image, fix(builder): remove warning when docker uses the aufs driver, fix(database): remove postgres pid error from log, feat(publisher): add pprof to enable profiling, fix(router): check if there is certificates to generate, ref(test): update go version to 1.4.2
- @bfosberry: deis controller throws 500 with badly padded key
- @cddr: deisctl start platform takes very long time to complete
- @chrisgeo: Deis Database lost relations
- @cimnine: deis config:pull and config:push fail on empty lines
- @cleblanc87: feat(contrib): AWS cli profile param
- @colleen1: deis login - fix "bad request" message to be user readable
- @croemmich: Ceph Issues After Upgrade to 1.6.0
- @djmitche: fix(nonstring-default) numeric default for webEnabled, Suggest checking out a tag when getting the source
- @ghostbar: One container didn't got an update of the configuration
- @glenwong: config:push with .env doesn't handle export or double quotes
- @glogiotatidis: Discussion: app unit publishing timeouts between publisher and router, Fleet unit reports active/running but still pulls image from registry
- @haf: deis create fails on remote non-atomically, Installing swarm is taking too long/seems to fail, 'stateless plx' option
- @iancoffey: feat(contrib): optional graceful shutdown
- @ineu: Cached repo is not removed from builder when app is deleted, deis commands throw errors when being piped to head, Python errors unreadable in non-english locale, deis utility warnings should go to stderr
- @jarcas-cdmon: Error in Deis REgister
- @jbeard4: deis builder often leaves stale node modules for nodejs Heroku buildpack
- @josephwinston: ssh-cert.key and password on Azure, Using DNS and Azure, azure-coreos-cluster fails with "socket.error: [Errno 61] Connection refused", deisctl start platform hangs at `deis-store-monitor.service: activating/start-pre`
- @Joshua-Anderson: feat(deisctl): add config rm, feat(controller): Deprecate X prefixed headers, fix(controller): force uniqueness for default app name., docs(customizing_deis): clarify usage of registrationMode
- @jwaldrip: Feature Request: Configurable Upchecks, Feature Request: Maintenance Mode, Display Error Page when no containers are available., docker.service needs to depend on the mount.
- @kalbasit: Not able to install deis on Travis., fix(logger): gracefully handle a nil return from etcd watch, fix(logger): avoid hitting etcd for each log line, feat(publisher): expose config as flags, fix(deis): validate the syntax of the environment file
- @nathansamson: Deis should have a (pliggbable) deploy hooks config method per app, deis-logger stopped working
- @ngpestelos: deis-builder fails to set keys to etcd, fix(router): return 404 for non-existing app
- @olalonde: deisctl stop platform stops at "could not find unit: deis-cache.service", `deis run` doesn't output anything, git push hangs at `Launching...`, Fixes issue #3764. Dont throw IOError when pipe closes.
- @r4wr: Deis on Opennebula?
- @sbuss: fix(client): let requests read env vars, s/deis push/deis pull/
- @scottrobertson: Idea: update config on push, Are there any docs on how Deis handles servers going down?, Low disk space results in builder restart loop
- @sedouard: feat(contrib/azure/azure-coreos-cluster): automatically create discovery url, fix(contrib/azure/azure-coreos-cluster): extend load balancer timeout
- @simpsora: Provide container/unit name in journal, Unable to deploy when a config entry contains a space
- @slack: high load + logger causes excessive traffic to etcd
- @sstarcher: Ceph recovery slow, Unable to login to Deis Controller v1.6.0
- @szymonpk: Does deis have disk self-cleaning mechanism?, Controler couldn't connect to database after node crash
- @wenzowski: fix(router): avoid consistently hashing on empty string

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Voice your opinion on the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) by attending the monthly [Release Planning Meeting](http://docs.deis.io/en/latest/roadmap/planning/#release-planning-meetings)
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
