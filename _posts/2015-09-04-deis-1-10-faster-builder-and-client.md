---
layout: post
title: "Deis v1.10 - Faster Builder and Client"
author: mboersma
meta:
  - name: description
    content: Deis release v1.10
  - name: keywords
    content: deis, release, v1.10, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise, kubernetes, mesos
---

The Deis project is proud to announce [v1.10.0](https://github.com/deis/deis/releases/tag/v1.10.0), which speeds up the `deis` command-line client and **deis-builder**.

Join the fun: new contributors to Deis can get [free DigitalOcean credits](http://deis.io/code-for-credit-digitalocean/)!

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.10.0 Summary

### New Features

- The `deis` command-line tool has been rewritten in Go and is much faster
- The **deis-builder** component has been rewritten in Go and is faster and more reliable
- All buildpacks in **deis-builder** have been updated to the most recent versions tagged by Heroku
- **deis-logspout** can optionally deliver logs via TCP
- **deis-router** gained an informative [traffic status page](https://github.com/deis/deis/pull/4290)
- `deis` respects the `--limit=` flag for commands which list results
- Automated provision and upgrade acceptance tests now live under `tests/bin/accept`

### Improvements

- Various fixes to AWS, Azure, bare metal, Linode, and OpenStack provisioning
- Optional swarm scheduler components aren't built by default now; use `make -C swarm/ build`
- NewRelic contrib docs updated now that container CPU and memory usage are available
- **deis-logger** logs a unique id for each app name, helping Kubernetes scheduler usage
- **deis-logger** now allows underscores in container names
- **deis-logspout** fixes a potential deadlock when attaching to containers
- Integration tests fail if `deis` prints any warning
- Collaborators on apps can no longer manage others' permissions without being admins
- Users can revoke their own app access, and some permissions checks were fixed
- `deisctl install` and similar commands group k8s, mesos, and swarm components logically
- `deisctl dock` and `deisctl ssh` show help and handle arguments more consistently

### Under the Hood

- All components and clients are built with Go 1.5, which speeds garbage collection and enables concurrent execution
- nginx is updated to 1.9.4
- deis-store components are updated to [Ceph 0.94.3](http://ceph.com/docs/hammer/release-notes/)

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## What's Next

### Docker Engine Upgrade

Due to critical bugs in recent Docker engines related to parallel layer pulls and v1/v2 registry compatibility, we've been forced to pin Deis clusters to Docker 1.5.0.  We now believe these issues have been resolved and are eager to move to the newer version of Docker that ships with the latest CoreOS stable release.

### Docker v2 Registry

The Deis registry must be [upgraded to the new v2 API](https://github.com/deis/deis/issues/3814) to ensure forward-compatibility with Docker.  This has a number of added benefits including performance and trust.  However, this will be a tricky migration given the v1 registry data we currently store, as well as the `deis pull` hooks in our fork of the Docker registry.

### Rigger

[Rigger](https://github.com/deis/rigger) is a new tool designed to make it easier to provision and test Deis clusters.  With `rigger`, you can stand up and test a Deis cluster on any provider with just a handful of simple commands.  The Deis core team is already using `rigger` internally, but we are looking for feedback.  Please provide your thoughts and requirements on the [design document](https://github.com/deis/deis/issues/4345).

## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues, providing support to others, and working on various Deis branches:

- @adrianmoya: Error trying to install
- @aendrew: Builder not coming up after 1.9 upgrade
- @afterthought: Restore from backup: expected state of services, Fleet failover fail
- @alex: style(contrib/aws): Ensure that files are closed and use yaml.safe_load, chore(docs): Fixed rendering of a few code snippets
- @anissrelicum: run commande "play evolutions --%prod" [ play framework 1.3.1]
- @apps4u: AWS Elastic File System
- @arkkanoid: Use cache in deployed Apps
- @bf4: logging issues and etcd failures on Deis 1.7.3, getting OpenSSL.SSL.ZeroReturnError in failure set env variable
- @cchamilt: natdnshostresolver1 in Vagrantfile needs to be "on" for VirtualBox on OSX now?
- @cheshirecatalyst: config push / set 500's
- @cimnine: Freshly set up deis cluster does not work [bare-metal]
- @clayzermk1: fix(builder): always configure SSH key
- @clescot: documentation does not mention incompatibility between deis and coreos shipping buggy docker versions
- @Crispy1975: Fresh AWS Install: Docs should say to install deisctl first
- @croemmich: feat(router): enable ssl caching and expose ssl_protocols for configuration, fix(contrib/linode): Install CoreOS from the stable channel
- @daanemanz: Builder fails to start in stateless platform
- @geeksoul-me: Deis publisher throwing error after 1.8 to 1.9 upgrade of stateless-platform
- @glogiotatidis: fix(docs): update NewRelic section.
- @gvilarino: Google: configuring DNS managed outside of Google DNS service? , Azure: unable to create apps on newly created cluster
- @ineu: Cluster recreation: git push gives weird errors, Better error message when registration is disabled, OSD doesn't join cluster after node reboot, Deploys stop to work, /deis/platform/version missing in new installation, Log size limit settings?, Docker won't start in new cluster, deis-controller fails with CannotSendRequest
- @JeanMertz: Deis using existing Kubernetes cluster
- @kalbasit: Confd is sub-matching applications leading to non-existing application, Kubernetes leaving behind old releases running, docs(managing_deis): remove a space from a bash substitution
- @klaussilveira: "Global" environment variables for all applications
- @laurrentt: Request feat(controller): Specify custom user in `docker run`, feat(logspout): support sending log via tcp, docs(isolating-etcd): add link to user-data.example, feat(Makefile): option to disable store components
- @LoicMahieu: Stateless install: deis-builder don't start
- @MaxenceAdnot: Mesos fails to start, Controller error : 'remaining connection slots are reserved for non-replication superuser connections'
- @mdolian: Problems cloning a public repository using NPM in builder, Azure nodes should be launched into an availability set
- @nathansamson: can not bootstrap v1.9.0 cluster
- @olalonde: Error pulling image ... ApplyLayer fork/exec ... /usr/bin/docker: cannot allocate memory, Atomically switch over DNS for blue-green deployment
- @paulczar: fix(contrib/openstack/provision-openstack-cluster.sh): fix openstack …
- @rimusz: deis 1.9.0 does not “decorate” the Fleet units, Proposal isolating etcd/planes/router mesh
- @rvadim: Failed to pull logspout image from docker hub
- @sbuss: Provide SHA256 hashes of deis and deisctl binaries, fix(contrib) AWS instances may only have a private IP
- @sitya: Question about Kubernetes, Deis and etcd
- @SomeoneWeird: Issue pulling docker images from local registry.
- @sstarcher: Restrict Router application set, Router ERROR Missing template , AWS Deis Cluster - Flannel on ASG Event
- @szymonpk: is cloud formation template is on the edge of size?
- @vesmi: Healthcheck problem
- @Xowap: Insecure etcd by default, Attach volume to app
- @yebyen: contrib/util/custom-firewall.sh throws increasingly disconcerting messages
- @zapient: Add ability to define separate cluster network

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Voice your opinion on the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) by attending the monthly [Release Planning Meeting](http://docs.deis.io/en/latest/roadmap/planning/#release-planning-meetings)
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
