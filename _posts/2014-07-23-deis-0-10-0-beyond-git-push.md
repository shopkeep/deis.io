---
layout: post
title: "Deis v0.10.0 - Beyond Git Push: The Docker Native Workflow"
author: bacongobbler
meta:
  - name: description
    content: Deis further improves its Docker-native experience with `deis pull` for importing existing Docker images.
  - name: keywords
    content: deis, release, 0.10.0
---

The Deis project is proud to bring you the v0.10.0 release. Deis further improves
its Docker-native experience with `deis pull`, an alternative to `git push` that
imports existing Docker images directly into Deis for deployment. DigitalOcean 
support is back, we've added VPC and ELB support to Deis on Amazon EC2, and we
finally fixed that one bug that was bothering you.

<!--more-->

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications
on your own servers. Deis builds upon [Docker](http://docker.io/) and
[CoreOS](https://coreos.com/) to provide a lightweight PaaS with a
Heroku-inspired workflow.

## 0.10.0 Summary

### New Features

- **`deis pull`** promotes an existing Docker image directly to your Deis cluster,
  from the [Docker Hub](https://registry.hub.docker.com/) or your private registry
- Added DigitalOcean provisioner, booting CoreOS via kexec
- Deis checks for a valid etcd discovery URL before provisioning to multiple nodes
- Data containers are now locked to specific machines, so data persists properly
- Deis' own containers validate config files consistently before reloading
- Heroku-compatible buildpacks are now pinned to specific revisions
- Only announce "web" and "cmd" process types to router
- Reorganized http://docs.deis.io/ Table of Contents and navigation links
- Added documentation for SSL, RAM requirements, xip.io addressing examples

### Under the Hood

- Updated to current alpha CoreOS, 379.3.0
- Updated to Docker 1.1.1
- Updated docker-registry from upstream
- Updated to fleet 0.5.0
- Updates to Django, South, etcdctl
- Disabled controller web UI by default
- Added [functional tests](http://ci.deis.io/view/pull-requests/) for each component
- Added [integration tests](http://ci.deis.io/view/example-apps/) for a running system


### Bug Fixes

- Remove git repository from builder on `deis destroy`
- Turn off verbosity in logger `tar` command
- Fixed "We have no port..." issue by upgrading to Docker 1.1.1
- Don't attempt to route to non-web processes in an app
- Clear `deis` client cookies on login, logout, and register
- Add "Referer" header to CLI requests
- Remove `arping` Docker networking hack from systemd unit files
- Fixed Deis' systemd services from reporting "failed" status after stopping
- Exit the Makefile status loop when a service enters "failed" status
- Changed several timeout values to accommodate real-world usage
- Fixed `deis auth:cancel` error immediately after creating a user
- Remove references to obsolete CoreOS update-engine-reboot-manager
- Make Dockerfile builds more robust by unifying `apt-get update` and `install`s

For details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).


### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

* @aaronfay - EC2 VPC testing
* @adrienbrault - EC2 VPC testing
* @aledbf - HA database advice, linux sched question, tons of feedback and help
* @azurewraith - CoreOS update testing & feedback
* @bfallik - Docs fix in upgrading-deis.rst
* @btrepp - Disable vagrant-cachier if present PR
* @colegleason - CoreOS device update, testing discussion
* @daanemanz - ELB setup for AWS
* @dansowter - `deis pull` discussion
* @developerinlondon - Far too many fixes, helpful comments, and diligent testing
  to enumerate. Thanks Nayeem!
* @ddollar - CloudFormation update and pull deis/base PRs, testing and help on IRC
  and GitHub
* @duanhongyi - Deis on OpenStack PR
* @gust1n - AWS T2 instances discussion
* @ianblenke - EC2 and buildpack testing, feedback, and help
* @Imdsm - DO support discussion, "no active controller" client fix, xip.io docs & more
* @itsmeduncan - ELB setup for AWS
* @jadsonlourenco - New CoreOS testing on vagrant & GCE
* @jeffbaier - New CoreOS testing on EC2, coreos/user-data discussion
* @johanneswuerbach - confd template issue and review, cache ip/port access PR,
  service templates discussion
* @mvanduijker - Fixed example-apps references
* @mvanholsteijn - `deis destroy` testing & feedback
* @ogeagla - xip.io address for EC2 PR
* @public - ECDSA keys support in `deis keys:add`, and tests
* @softr8 - TimeoutStartSec PR, gunicorn timeout PR
* @sthulb - VMware / vagrant CPU and memory tweaks
* @sttts - DigitalOcean kexec workaround, CoreOS net device names PR, testing



## Known Issues

### AWS ELBs

Amazon’s Elastic Load Balancer has a hardcoded [60-second connection timeout](https://forums.aws.amazon.com/thread.jspa?threadID=33427). These timeouts
result in strange behavior while using Deis on EC2.  For example, `git push` connections
can be [interrupted with strange errors](https://github.com/deis/deis/issues/1330). CLI commands like `deis pull` can be interrupted with `504 Gateway Timeout` errors.

While it is possible to request an ELB timeout increase from the AWS support team, it’s not an ideal solution. We are currently researching a better load-balancing solution for
Deis on EC2.

## What's Next?

### Deis Upgrades

In our push toward a stable release, our most important priority is making sure Deis upgrades are fast, painless and backwards compatible. We are devoting significant resources to this effort, and are working closely with the CoreOS team who has a great deal of experience with rolling upgrades.

### Platform Security & HA

With Deis being used for more and more real-world deployments, we need to address remaining [security](https://github.com/deis/deis/issues?labels=security&state=open)
issues as well as [high-availability](https://github.com/deis/deis/issues/984) of the platform itself. Deis components and hosted apps are now fronted by a user-defined number of routers, and other HA features will be a prerequisite for our stable release.

### Automated Testing

Distributed systems are notoriously difficult to test.  Yet, we believe automated testing is critical to the success of Deis.  We will continue to invest in comprehensive test suites that include: unit tests, functional tests, smoke tests, integration tests, acceptance tests, load tests and chaos tests that simulate failure modes.  We intend to push the limits of what is possible with Docker and the automated testing of distributed systems.  Though a work-in-progress, our test infrastructure is visible at http://ci.deis.io/.

## Future

### Service Gateway
We need to make it as easy as possible for ops folks to publish a set of reusable backing services (databases, queues, storage, etc) and allow developers to attach those services to applications. This will be done in a loosely coupled way, following Twelve Factor best practices. You can review the initial implementation and follow progress [on this GitHub issue](https://github.com/opdemand/deis/issues/231).

### Interactive `deis run`
Though we provide the ability to run admin commands inside containers, we don't currently support interactive shells into containers (i.e. `deis run bash`). Once this infrastructure is in place, this will also allow us to implement log tailing and other real-time features.

## How can you help?

* Star our [GitHub repository](https://github.com/opdemand/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix issue](https://github.com/deis/deis/issues?labels=easy-fix&state=open) and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.

