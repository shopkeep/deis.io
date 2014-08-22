---
layout: post
title: "Deis v0.11.0 - Memory/CPU Limits and Tag-Based Scheduling"
author: gabrtv
meta:
  - name: description
    content: Deis beefs up Docker container management `deis limits` and `deis tags`
  - name: keywords
    content: deis, release, 0.11.0, limits, tags
---

The Deis project is happy to bring you the [v0.11.0 release](https://github.com/deis/deis/releases/tag/v0.11.0). Deis can now [limit](http://docs.deis.io/en/latest/reference/client/#deis-limits) your app containers' resources by memory or CPU share, and can [tag](http://docs.deis.io/en/latest/reference/client/#deis-tags) apps with metadata for scheduling. New documentation and scripts help with setting up Deis on [GCE](https://github.com/deis/deis/tree/master/contrib/gce) or [OpenStack](https://github.com/deis/deis/tree/master/contrib/openstack).

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/operations/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 0.11.0 Summary

### New Features

- `deis limits` constrains app containers by memory and CPU share
- `deis tags` attaches scheduling metadata to app containers
- OpenStack scripts and documentation added to [`contrib/openstack/`](https://github.com/deis/deis/tree/master/contrib/openstack)
- Google Compute Engine scripts and documentation added to [`contrib/gce/`](https://github.com/deis/deis/tree/master/contrib/gce)
- Storage backend is configurable for **deis-registry**
- The `deis` client respects `http_proxy` and `https_proxy` environment variables
- **deis-builder** runs `git gc` for housekeeping when deploying an app
- **deis-builder** allows custom **slugbuilder** and **slugrunner** images
- `-a` works as well as `--app=` in the `deis` client, for Heroku compatibility
- **deis-router** now proxies WebSockets for app containers
- `deis pull` allows tags when importing existing Docker images directly into Deis
- Rename a cluster: `deis clusters:update oldname --id=newname`
- Many additions and improvements to http://docs.deis.io/


### Under the Hood

- Updated to [CoreOS](https://coreos.com/) 402.2.0
- Updated to [Docker](http://docker.io/) v1.1.2
- Updated to [fleet](https://github.com/coreos/fleet) v0.6.2
- Updated [progrium/cedarish](https://github.com/progrium/cedarish) in **deis-builder** to 08/14/2014 snapshot
- Updated nginx to stable v1.6.1 for **deis-router**
- Updated requests, docopt, PyYAML for the `deis` client
- Updated celery and djangorestframework in **deis-controller**
- Updated **deis-registry** code from upstream
- A growing suite of [tests](http://ci.deis.io/view/pull-requests/) run on every code submission


### Bug Fixes

- **slugbuilder** no longer pipes `git archive`, avoiding intermittent `tar` errors
- **deis-logger** removes the app log directory when the app is deleted
- **deis-controller** better validates app and cluster fields
- `deis run` no longer requires a `git` remote entry
- **deis-builder** disallows SSH password authentication
- Clean up temp systemd unit files for apps from filesystem
- Fixed two `deis sharing` permissions issues in **deis-controller**
- Fixed region-checking code for DigitalOcean
- Allocate 30GB to `/var/lib/docker` on DigitalOcean
- Made `--auth=` optional for `deis clusters:update`
- Continue with `deis logout` if controller connection fails
- Restore `--cluster=dev` as the default for `deis apps:create`
- Submit **deis-router** unit file templates to `fleet` without file copying

For details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).


### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

* @aledbf - custom builder/runner, major testing & bug reports
* @andyshinn -  GCE scripts/docs!, config suggestions, lots of testing & help
* @bcwaldon - help with several CoreOS issues
* @btrepp - `make pull` behind corp proxy report
* @clayzermk1 - testing & default nginx discussion, t1.micro, cloudformation issues
* @cmshetty - clusters terminology, registry auth discussions
* @cpswan - "bad gateway" on fat-fingered image bug report
* @davidpelaez - testing & "Get Deis" instructions updates
* @ddollar - `deis push` PR, testing and mucho help
* @developerinlondon - tons of testing and issue reports
* @dreamcodez - wildcard submdomain request
* @dw33z1lP - `deis pull` and `make pull` testing and questions
* @ebergonzi - deis-registry / fedora 20 issue
* @ianblenke - removed proctypes scaling issue, mountains of testing & help
* @ibuildthecloud - alternate DO suggestion
* @joiggama - `ps:list` permissions error report
* @jonashuckestein - intermittent scaling failure issue
* @kernel8liang - testing & bug reports
* @kerwin - fleetctl version "state" error report
* @kikicarbonell - deis-builder / vagrant error report
* @krancour - service scheduling, cloud-config & other issues, lots of GitHub help
* @lucasrhb - ec2 & app domain problem report
* @michaelmior - cookies.txt security suggestion
* @michaelshobbs - testing & app push, nodejs, ec2 recovery issues
* @nathansamson - controller web UI, install docs issues
* @PierreKircher - testing & limits bug report
* @pvencill - REST API docs & CSRF issue reports
* @sirwolfgang - installation issue report, docker-backed services discussion
* @spurdy - deis CLI behind proxy bug report
* @themasterchef - nightly vagrant build suggestion
* @tiagoboldt - tutorial suggestions
* @tphyahoo - wildcard subdomain bounty!
* @wbean1 - fleet suggestion, deis-builder http-proxy issue
* @wiwengweng - "ssh init fail", windows gzip bug reports
* @xmwang76 - phantom app report
* @yieme - setup details doc suggestion


## Known Issues

### Unversioned Docker Images

There are still a few Docker images in the Deis control plane that are [not being versioned with a Docker tag](https://github.com/deis/deis/issues/1174).  Though we are always careful to avoid backwards-incompatible changes, we recognize using `:latest` is not ideal.  In the next release, **every Deis component** will be versioned before being published to DockerHub for distribution.

## What's Next?

### Deis Upgrades

In our push toward a stable release, our most important priority is making sure Deis upgrades are fast, painless and backwards compatible. We are devoting significant resources to this effort, and are working closely with the CoreOS team who has a great deal of experience with rolling upgrades. We recently [showed off](http://gabrtv.github.io/deis-coreos-meetup-2014/#/) the update system at the CoreOS meetup in SF--coming soon!

### Platform Security & HA

With Deis being used for more and more real-world deployments, we need to address remaining [security](https://github.com/deis/deis/issues?labels=security&state=open) issues as well as [high-availability](https://github.com/deis/deis/issues/984) of the platform itself. Deis components and hosted apps are now fronted by a user-defined number of routers, and other HA features will be a prerequisite for our stable release.

### Automated Testing

Distributed systems are notoriously difficult to test, but we know automated testing is critical for Deis. We have significantly expanded our test suites and continuous integration system. And the Deis project will continue to invest in quality and to push the limits of what is possible with Docker and automated testing. Watch Deis get even better at http://ci.deis.io/.

## Future

### Service Gateway

Deis must make it simple for ops folks to publish a set of reusable backing services (databases, queues, storage, etc) and to allow developers to attach those services to applications. This will be done in a loosely coupled way, following Twelve Factor best practices. You can review the initial implementation and follow progress [on this GitHub issue](https://github.com/opdemand/deis/issues/231).

### Interactive `deis run`
Though we provide the ability to run admin commands inside containers, Deis doesn't yet support truly interactive shells into containers, such as `deis run bash`. Once this infrastructure is in place, Deis can implement log tailing and other real-time features.

## How can you help?

* Star our [GitHub repository](https://github.com/opdemand/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix issue](https://github.com/deis/deis/issues?labels=easy-fix&state=open) and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
