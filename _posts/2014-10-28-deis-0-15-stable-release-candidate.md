---
layout: post
title: "Deis v0.15 - Stable Release Candidate"
author: bacongobbler
meta:
  - name: description
    content: CephFS and the v1 REST API have landed; this is a release candidate for our stable version
  - name: keywords
    content: deis, release, 0.15, stable, release candidate
---

The Deis project is thrilled to announce [v0.15.0](https://github.com/deis/deis/releases/tag/v0.15.0), our first release candidate for stable. With [CephFS](http://ceph.com/docs/master/cephfs/) and our [v1 REST API](http://docs.deis.io/en/latest/reference/server/rest-api/) in place, we are now in a feature freeze.  We will only enhance documentation and fix bugs until our first **stable release** in November.

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 0.15.0 Summary

### New Features

- **store-metadata** and **store-volume** expose a distributed filesystem powered by CephFS
- **controller** and **logger** share data over CephFS for high availability
- CORS headers were added to the v1 Deis REST API
- `deis passwd` allows changing the password for an account
- **routers** are published to the `/deis/router/hosts` etcd key
- Added a CoreOS debug log generator

### Under the Hood

- **controller** updated to Django 1.6.8 bugfix release
- **controller** updated to Django REST Framework 2.4.3
- **builder** switched to a pre-receive hook allowing for re-push on failed deploys
- **builder** properly compresses tarballs
- **store** and **router** image sizes continue to shrink
- `git` ignores local changes to *contrib/coreos/user-data*
- `make discovery-url` copies from *contrib/coreos/user-data.example*
- functional tests updated to use [Docker 1.3.0](https://www.docker.com/) code

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @adrianmoya: Order steps for deis installation (vagrant)
- @aledbf: Proposal: refactor units in Go, Some component information page in registry.hub.docker.com are outdated, time difference causes problems with database, ref(router): just use go. remove bash script, ref(store): reduce image size, fix(registry): use docker cache
- @babarinde: deis keys:add error, deis start platform hanging on builder service
- @bilts: App availability problems when stopping a node
- @builtdock: ontroller
- @calvinmorrow: Fix for line continuation breaks Dockerfiles with quotes immediately following a space
- @grengojbo: bug(controller): deis domains:remove deletes the key in etcd, deis-builder not work
- @jannispl: add instructions for using AWS S3 as data store, deisctl installer loads unit files from master, docs(README.md): remove instructions for placing apps on a different cluster
- @johnstontrav: AWS EC2 question?
- @jorihardman: v0.14.0 Builder Start Failure: No such id: deis/builder:v0.14.0
- @Joshua-Anderson: Jenkins: Enable Concurrency for Integration Test, Add CORS headers to api
- @marvell: Some issue with `deis-builder.service: activating/start-post`
- @ngpestelos: deis client stuck in `deis config:set`, `deis run` returns HTTP 500 error, deis-builder fails to start on Digital Ocean, How to set SSH_PRIVATE_KEY
- @PierreKircher: deis run env
- @zackp30: Oct 25 13:15:37 deis0 sh[6563]: 2014-10-25T13:15:37Z efa24648711d confd[292]: ERROR 100: Key not found (/deis/store/gateway) [7281]

Special thanks--once again!--this release to @alebdf for (among other things) his tireless work to shrink Deis image sizes and to rewrite our container init scripts in Go.

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## What's Next?

### API Documentation

With this release candidate, Deis has frozen its v1 API. Token authentication is behind us. All our endpoints are now prefixed with `/v1`. We added CORS support and an endpoint for changing passwords. What remains is improved API documentation.

### Production Ready

Deis is being used in production at companies of all sizes. We are committed to delivering our first stable release in the next few weeks. What remains is a comprehensive documentation update with a focus on how to operate Deis in production.

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
