---
layout: post
title: "Deis v0.14 - Easy Platform Upgrades"
author: gabrtv
meta:
  - name: description
    content: Deis clusters can now be upgraded in-place with minimal downtime
  - name: keywords
    content: deis, release, 0.14, upgrades, in-place upgrades
---

The Deis project brings you our [v0.14.0 release](https://github.com/deis/deis/releases/tag/v0.14.0).  Deis now supports easy, in-place upgrades using `deisctl`.  It's only been 13 days since [v0.13](https://github.com/deis/deis/releases/tag/v0.13.0) -- the project is moving fast!

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/installing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 0.14.0 Summary

### New Features

- `deisctl` now supports [in-place upgrades](http://docs.deis.io/en/latest/installing_deis/upgrading-deis/) of the platform!
- Most `deisctl` commands are now asynchronous resulting in better UX for operators
- `deis auth:whoami` command added to list currently logged in user
- The **controller** now uses Token authentication for easy REST API integration

### Under the Hood

- Updated to [CoreOS 472.0.0](https://coreos.com/releases/#472.0.0)
- Updated to [Docker 1.3.0](https://github.com/docker/docker/releases/tag/1.3.0)
- Added local data containers to speed component restarts on in-place upgrades
- Time entries in `deis logs` and in the API are now ISO8601-compliant
- Numerous fixes to our automated test suites

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @achannarasappa: Could not create deis remote
- @adrianmoya: Launching an app from dockerfile fails
- @aledbf: time difference causes problems with database, Add DEIS_RELEASE to deis images, Error in deis-database, fix(registry): use docker cache, ref(database): reduce image size, fix(builder): escape \ to avoid errors in serialization of Dockerfile, ref(test): close the response body and indicate the status code., fix(controller): use docker cache, ref(cache): just use go. remove bash script, ref(builder): remove all locales. just generate one., feat(registry): image without development libraries to reduce the size.
- @amrnt: can't get deis installed, Got weird error when I try to push
- @babarinde: deisctl config platform set domain issue
- @benmccann: Use crypt for storing application credentials?
- @calvinmorrow: deis domains:remove deletes etcd key even if other domains still exist on an app
- @charlesmarshall: custom domains not being picked up (0.13.1)
- @glomium: Retry downloading deisctl, Typo
- @johanneswuerbach: Slow controller rebuilds after code changes, Disable "welcome to nginx" page, Use confd watch
- @kingcody: Should deis/client specify python version?
- @mave: deisctl installer loads unit files from master
- @ngpestelos: `deisctl install platform` stuck in controller, deis-database fails to start, Deis reports "no active controller" but a controller is running, deis apps:create returns a 404 when controller was restarted, How does `deis pull` work?, Unable to provision DO cluster, Builder script stuck in "Launching...", fix typo
- @rbucker: install latest does not work
- @schnipseljagd: install.sh fails with "Extraction failed."
- @Xe: Dependencies are present in the repository

Special thanks this release to @alebdf for (among other things) his tireless work to shrink Deis image sizes and help rewriting our container init scripts in Go.

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## Known Issues

### Database Provisioning

We have identified a condition where `store-gateway` will fail to start due to hung Ceph OSDs.  This causes the database to hang while starting.  The problem can manifest during platform provisioning with `deisctl start platform`.  As we research the right long-term solution, the workaround for now is to `deisctl restart store-daemon`.

### Log Data Availability

While the critical components in the Deis control plane are now highly available, we have not yet addressed availability of our **logger** component, used to store aggregated logs.  We are waiting for Ceph to support [volume mounts from within containers](https://github.com/deis/deis/issues/2041).  Once this lands, we can store aggregated logs in Ceph and allow _all_ control plane components to float across the cluster for complete platform HA.

## What's Next?

### API Freeze

We are close to announcing our v1 API freeze.  Token authentication is behind us.  All our endpoints are now prefixed with `/v1`.   Before we freeze it, we'd like to add [CORS Support](https://github.com/deis/deis/pull/2202) and then update a handful of minor endpoints.  Once the freeze is announced, we will begin work on comprehensive API documentation.

### Production Ready

Deis is being used in production at companies of all sizes.  We are committed to delivering our first stable release in the next few weeks.  Once **logger** HA is behind us, we will focus on a comprehensive documentation update with a focus on how to operate Deis in production.

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
