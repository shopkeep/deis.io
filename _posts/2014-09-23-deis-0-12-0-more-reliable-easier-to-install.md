---
layout: post
title: "Deis v0.12 - More Reliable, Easier to Install"
author: mboersma
meta:
  - name: description
    content: Deis install and management is easier to install and more reliable with "deisctl"
  - name: keywords
    content: deis, release, 0.12, deisctl, fleet, fault-tolerant
---

The Deis project is proud to bring you the [v0.12.0 release](https://github.com/deis/deis/releases/tag/v0.12.0). Deis is now dramatically simpler to install and manage thanks to [`deisctl`](https://github.com/deis/deisctl#deis-control-utility). If you have a CoreOS cluster, go [**get deisctl**](https://github.com/deis/deisctl#installation) and run:

```console
$ deisctl install platform && deisctl start platform
```

Under the hood, Deis now uses the [Fleet](https://github.com/coreos/fleet) HTTP API directly, which greatly increases the speed and reliability of container scheduling operations.

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/operations/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 0.12.0 Summary

### New Features

- [`deisctl`](https://github.com/deis/deisctl#deis-control-utility) replaces the Makefile and `fleetctl` for installing and managing Deis itself
- Deis' default scheduler implementation is more fault-tolerant and Deis is more reliable
- `deis` client logs are color-coded by process for easier navigation
- `make discovery-url` updates user-data with a new etcd discovery endpoint
- **deis-router** allows setting timeout values for builder and controller
- **deis-router** allows a custom max request size
- `DEIS_APP` and `DEIS_TAG` added to application environment
- `deis logs` includes application life cycle information
- `deis config:set` allows UTF-8 character data
- testing and developing Deis itself now uses a docker-registry
- New "[Using Docker Images](http://docs.deis.io/en/latest/using_deis/using-docker-images/)" and "[Hacking on Deis](http://docs.deis.io/en/latest/contributing/hacking/)" documentation


### Under the Hood

- Updated to [CoreOS](https://coreos.com/) 440.0.0
- Updated to [Docker](http://docker.io/) v1.2.0
- Updated to [fleet](https://github.com/coreos/fleet) v0.8.1
- Deis' default scheduler uses the fleet HTTP API directly
- systemd unit file templates moved to [deisctl](https://github.com/deis/deisctl)
- Updated nginx to stable v1.6.2 for **deis-router**
- **deis-builder** pins its Heroku-compatibility layer to "cedar"
- **deis-builder** versions **slugrunner** and **slugbuilder** directly from the same repository
- **deis-controller** uses Python threads, not the celery library
- **deis-controller** updated to Django 1.6.7 bug fix release
- **deis-controller** updated django-guardian to 1.2.4
- **deis-registry** bumped to v0.8.1 of docker-registry
- `deis` CLI no longer uses PyYAML, for simplicity
- refactored functional and acceptance tests with scripts for local or CI usage


### Bug Fixes

- Removed deprecated `X-Condition` prefix from fleet unit files
- Set new Heroku buildpack variable STACK to "cedar" for compatibility
- Fixed GCE typo and docker storage being reset on reboot
- Handle /dev/sda vs. /dev/xvda on EC2 for each virtualization type
- **deis-controller** properly purges etcd domain keys when an app is deleted
- **deis-controller** added a gunicorn timeout for long-running methods
- **deis-controller** fixed empty username in log on first `git push`
- bumped etcd peer heartbeat to 500ms
- updated default DigitalOcean network interface to eth1
- corrected documentation and URLs for included buildpacks
- removed erroneous in-place upgrade documentation
- **deis-router** keeps etcd keys ordered
- port 443 opened in Amazon EC2 security group

For details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).


### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

* @achannarasappa - announce container failed issue
* @aledbf - numerous PRs, major testing & feedback & issues, deisctl QA team
* @alex-sherwin - yaml public-ip correction
* @bcarpio - scaling / key issue
* @bdemers - remove unused Travis CI badge PR
* @bfosberry - controller start, tie docker images to tags issues, lots of testing, help and questions on irc
* @boffbowsh - config:set common vars request
* @btrepp - SSL certs for builder, CLI recommended version issues
* @charlesmarshall - housekeeping & domain on destroy issues, UTF-8 testing
* @cmshetty - logger failed, in-place upgrade instructions issues
* @coen-hyde - router localization request, logger start issue
* @crazy6995 - LRU cache disabled issue
* @damacus - `DEIS_ENV` request and irc
* @ddollar - EC2 subnets, root device PRs
* @dfar2008 - manual install issue
* @digitalsadhu - Rackspace cluster provisioning issue
* @dolanor - config:set issue, testing and vagrant port forwarding report
* @fgrehm - git push, unsupported locale issues
* @fmd - README.md typo fix
* @hippich - load balancer ip question
* @ianblenke - flatten Dockerfiles, EC2 README PRs, lots of testing and help on IRC and GitHub
* @intellix - DO eth1 PR, PHP bug, tons of support and testing and issue finds
* @itsmeduncan - default to 3 nodes, finally!
* @johanneswuerbach - many excellent PRs, lots of GitHub and IRC help, Deis Contributor of the Month
* @jonashuckestein - CoreOS username doc fix
* @kernel8liang - controller/router location issue, manual install question
* @kerwin - hooks for Docker Hub or gitlab, Deis UI requests
* @kikicarbonell - ruby buildpack problem, port register doc request
* @mefellows - fleetctl ssh issue
* @Mistobaan - install python CLI PR
* @nathansamson - DigitalOcean warrior, tons of help and comments
* @ndbroadbent - `deisctl` global units dir permission issue
* @ngbinh - `ssh-add` doc fix
* @ngpestelos - don't prepend app name twice fix
* @nickho - slugbuilder behind proxy issue
* @pguelpa - pyyaml issue
* @PierreKircher - PRs and issues and nonstop help on IRC, Deis Support of the Month
* @piotrb - build failed still pushes issue
* @protomouse - EC2 block device mappings issue
* @romansergey - missing Procfile issue
* @scottrobertson - DigitalOcean request
* @smokku - cluster bootstrap error report
* @Telvary - image parent error
* @temujin9 - CloudFormation always in vpc issue
* @vincentpaca - apps fail after controller reboot, git push perms, deis run issues
* @Xe - lots of IRC help, big fix for GCE storage on reboot & GCE typo
* @zubairov - Deis on VMware issue report

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.


## Known Issues

### DigitalOcean in Transition

[DigitalOcean](https://www.digitalocean.com/) now supports CoreOS natively! The Deis community has been working overtime to shift our *contrib/* DigitalOcean scripts to use their native support, but there is still [work to do](https://github.com/deis/deis/pull/1776). You may encounter [issue #1900](https://github.com/deis/deis/issues/1900) until we have this resolved.


## What's Next?

### Deis Upgrades

As Deis nears a stable release, our first priority is making sure Deis upgrades are fast, painless, and backwards compatible. We are devoting significant resources to this effort, and are working closely with the CoreOS team who has a great deal of experience with rolling upgrades. We recently [showed off](http://gabrtv.github.io/deis-coreos-meetup-2014/#/) the update system at the CoreOS meetup in SF--coming soon!

### Platform Security & HA

With Deis being used in a growing number of real-world deployments, we need to address remaining [security](https://github.com/deis/deis/issues?labels=security&state=open) issues as well as the [high-availability](https://github.com/deis/deis/issues/984) of the platform itself. Deis components and hosted apps are now fronted by a user-defined number of routers, and other HA features are prerequisites for our impending stable release.

### Automated Testing

Distributed systems are notoriously difficult to test, but automated testing is critical for Deis. The Deis project will continue to invest in quality and to push the limits of what is possible with Docker and automated testing. Watch Deis get even better at http://ci.deis.io/.

## Future

### Service Gateway

Deis must make it simple for ops folks to publish a set of reusable backing services (databases, queues, storage, etc) and to allow developers to attach those services to applications. This will be done in a loosely coupled way, following Twelve Factor best practices. You can review the initial implementation and follow progress [on this GitHub issue](https://github.com/opdemand/deis/issues/231).

### Interactive `deis run`
Although `deis run` executes individual admin commands inside containers, Deis doesn't yet support long-running interactions, such as `deis run bash`. Once this infrastructure is in place, Deis can implement log tailing and other real-time features.

## How can you help?

* Star our [GitHub repository](https://github.com/opdemand/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix issue](https://github.com/deis/deis/issues?labels=easy-fix&state=open) and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
