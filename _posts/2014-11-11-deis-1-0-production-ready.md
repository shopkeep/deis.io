---
layout: post
title: "Deis v1.0 - Production Ready"
author: gabrtv
meta:
  - name: description
    content: Deis releases 1.0, the first stable release signifying production-readiness
  - name: keywords
    content: deis, release, 1.0, stable, production, production-ready, paas, private pass
---

The Deis project is proud to announce [v1.0.0](https://github.com/deis/deis/releases/tag/v1.0.0), our first stable release.  Deis is now suitable for production workloads.  This makes Deis the first production-ready PaaS built from the ground up to leverage Docker.

The 1.0 milestone signifies Deis has a stable API, broad feature set and solid component architecture.  The Deis 1.0 feature set includes:

 * **Platform Quality** - Deis has been battle-tested by the open source community to handle production enterprise workloads
 * **Streamlined Installation** - Deis can now be installed on a CoreOS cluster in under 30 minutes using a simple command-line utility
 * **High Availability** - The entire Deis platform is highly-available and can tolerate failure of any host in the cluster
 * **Proven Workflows** - Deis ships with three deployment workflows: Heroku Buildpacks, Dockerfiles and native Docker Images
 * **Comprehensive Documentation** - Docs for developers and operators have been expanded, improved and consolidated into a single documentation site
 * **Run Anywhere** – Deis runs on public cloud, private cloud and bare metal with certified support for Amazon Web Services, Google Compute Engine, Digital Ocean, Rackspace, OpenStack and VMware

We want to thank the extended community of Deis users and contributors, whose willingness to put early versions of Deis into production has allowed us to resolve issues that can only be found when running real-world production workloads.  We are grateful for your patience and persistence.

During the past 16 months of development, Deis has incorporated best-of-breed technologies from Docker, CoreOS, Ceph, Heroku and others.  We want to thank these projects/vendors and the wonderful people behind them.  Your ongoing assistance has been critical to the success of Deis as an open source PaaS.

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.0.0 Summary

### New Features

- http://docs.deis.io/ has been substantially improved and better organized
- Documentation in README files has been moved to the docs site
- New DigitalOcean guide added to documentation
- `make` targets for Docker images and documentation are strict about errors
- test suite handles Docker 1.3.1 TLS authentication
- stale app release containers can't be published to the router
- `deisctl help <command>` always prints a helpful usage message
- `deis` CLI honors the `$DEIS_DRINK_OF_CHOICE` environment variable

### Under the Hood

- Updated to [CoreOS 494.0.0](https://coreos.com/releases/#494.0.0)
- Updated to [Ceph 0.87 "giant"](http://ceph.com/docs/master/release-notes/#v0-87-giant)
- **builder**, **controller**, and `deis` CLI updated python requests to 2.4.3
- **controller** updated Django REST framework to 2.4.4
- **controller** updated python-etcd to 0.3.2
- **controller** updated South to 1.0.1

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @abonas: missing instruction to generate ssh key when working with vagrant setup
- @achannarasappa: deis components stuck in auto-restart/failed state, The requested URL / was not found on this server
- @adrianmoya: deis-store-metadata inactive/dead, Fresh install 0.15.1 fails on database/builder component, deisctl update fails
- @aledbf: The registry is going to switch to https?, deis-store-volume mount error, deis client error, Change "make discovery-url" validation order, help to configure s3cmd to access the data store, fix(router): remove store gateway body limit, feat(coreos): use custom image in toolbox, feat(publisher): use godep, feat(logspout): use godep, ref(builder): remove dockerfile parser from builder
- @bilts: controller and builder services fail to start after node reboot
- @EvanK: store-volume stuck in start-pre/auto-restart loop on `deisctl start platform`
- @gahissy: deis logs error
- @gebrits: Deis for apps + Smartstack for backend services. Good combination?
- @grengojbo: deis push not work
- @hugo-zheng: failed to push some refs to git
- @Imdsm: feat(provision-rackspace): added optional parameter to specify environment, docs(installing_deis): fixed formatting issue
- @jamespacileo: PHP projects fail, "deisctl start platform" stuck at deis-store-monitor
- @jannispl: deis-store-volume fails to start after upgrade from 0.14.1
- @johanneswuerbach: Switch deis installation and testing to beta channel, Nightly testing against coreos alpha channel, Proposal: Use in-house mirroring for slow internet connections, Building does not stop on compilation errors, Log which keys are missing, Allow to use any S3 compatible store, Add store troubleshooting documentation, Document steps required to update coreos, feat(*): Do not commit a local vagrant settings, fix(*): Corrected required cores version, fix(tests): Allow TLS
- @jorihardman: nginx X-Forwarded-Proto breaks https endpoint forwarding
- @Joshua-Anderson: feat(client): Add error message when writing settings fails.
- @justinhennessy: New cluster register call failing ..., router: waiting for confd
- @kingcody: client: removal of git remote from current repo, intended behavior?, platform: moving a deis-* container causes confd error, client: Exception.message is deprecated for >= python2.7, docs: broken link for install_deisctl, fix(deis/client): `Exception.message` is deprecated for >= python2.7
- @laczoka: deisctl start platform gets stuck starting deis-store-gateway.service
- @loungerider: Deploying helloworld dockerfile example not working on digitalocean cluster
- @lsnyder: deisctl --request-timeout option not applying desired timeout
- @lukedemi: Fleet crashing intermittently
- @matiasdecarli: Units not restarting after a VM reboot
- @ngpestelos: Deis CLI commands time out, deis-store-volume fails to restart, `deisctl start platform` timed out, docs(deisctl): reword comment, docs: clarify tags_set usage
- @Paperback: docs(README.md): replace moved DNS link
- @rpaladugu1: deisctl config platform set domain=<your-domain>
- @viztor: Does deis support multi-location deployment?
- @Xe: LICENSE needs updating for 2014, client: auth:logout and auth:clear appear redundant, Confd loop of death in deis-builder, Exception on any username being registered when using CentOS 6, fix(contrib/userdata): nse uses `docker exec`

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## Known Issues

### Docker 1.3.1

Starting in Docker 1.3.1, TLS is now required for all registry communication (public or private).  While we are proponents of this in principle, the way it was rolled out has caused a range of issues for anyone using a private registry -- including Deis.  We are working hard to address this issue, but for now Deis only works with Docker 1.3.0.

### Logs on Upgrade

When upgrading from earlier Deis releases to v1.0+, it is possible to lose platform log data due to upgrading of Ceph components.  We are exploring workarounds, but for now we recommend following our [backup and restore process](http://docs.deis.io/en/latest/managing_deis/backing_up_data/) to ensure you do not lose log data on upgrade.

## Future Plans

### Interactive Admin Commands

Although `deis run` executes individual admin commands inside containers, Deis doesn't yet support long-running interactions, such as `deis run bash`. Once this infrastructure is in place, Deis can implement log tailing and other real-time features.

### Service Gateway

Deis must make it simple for ops folks to publish a set of reusable backing services (databases, queues, storage, etc.) and to allow developers to attach those services to applications. This will be done in a loosely coupled way, following Twelve Factor best practices. You can review the initial implementation and follow progress [on this GitHub issue](https://github.com/opdemand/deis/issues/231).


## How can you help?

* Star our [GitHub repository](https://github.com/opdemand/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix issue](https://github.com/deis/deis/issues?labels=easy-fix&state=open) and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
