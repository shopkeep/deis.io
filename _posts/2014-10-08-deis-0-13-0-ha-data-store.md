---
layout: post
title: "Deis v0.13 - High Availability Backed by Ceph"
author: carmstrong
meta:
  - name: description
    content: Deis' data is now stored safely with Ceph
  - name: keywords
    content: deis, release, 0.13, ceph, highly-available
---

The Deis project is happy to bring you the [v0.13.0 release](https://github.com/deis/deis/releases/tag/v0.13.0).  Deis now ships with [Ceph](http://ceph.com/) providing a highly-available platform control plane.  Additionally, new microservices for service registration and log shipping increase the efficiency and reliability of Deis at scale.

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/installing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 0.13.0 Summary

### New Features

- **store** is a new [Ceph](http://ceph.com)-backed component used to store persistent data for the platform
- **database** now streams WAL logs to **store** with automatic restore on host failure
- **registry** now stores layers in **store** using an S3-compatible gateway
- The **logspout** service on each host removes the need for sidecar logging containers
- The **publisher** service on each host removes the need for sidecar announce containers
- `deis` command-line client can be installed with `curl -sSL http://deis.io/deis-cli/install.sh | sh`
- A specific version of `deis` can now be installed with `curl -sSL http://deis.io/deis-cli/install.sh | sh -s 0.13.0`
- A specific version of `deisctl` can now be installed with 'curl -sSL http://deis.io/deisctl/install.sh | sh -s 0.13.0`

### Under the Hood

- Updated to [CoreOS 459.0.0](https://coreos.com/releases/#459.0.0)
- Updated to [fleet v0.8.3](https://github.com/coreos/fleet/releases/tag/v0.8.3)
- All Dockerfiles are now based on Ubuntu 14.04
- All components have been updated to include fixes for the [Bash Shellshock bug](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-6271)
- All data containers except logger-data have been removed
- The `deisctl` utility comes pre-installed on all CoreOS hosts provisioned with Deis
- Moved the `deisctl` project to deis/deis

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @achannarasappa: Build hook error: Server Error (500)
- @aledbf: Restrict published containers, logspout message too long error, Router restarts, Add git commit to image env, Change to controller scheduler for fleet v0.8.3, Retry Fleet scheduling operations, feat(controller): restart the app if there is a failure., feat(router): image without development libraries to reduce the size.
- @chuenlye: Ownership of /usr/local/bin was changed when installing deisctl
- @cmshetty: Fleetctl shows old dead and failed units., Web process fails to start - "ruby: command not found", Config set for integer gives internal error.
- @cn28h: deisctl platform start requires several runs to succeed
- @gust1n: Deis publisher improvements
- @ianblenke: Feature request: deis users:list
- @intellix: builder: issue with check-repos script removing an active repository
- @jaystewart: Vagrant - deisctl start platform - deis-router@1.service: failed
- @johanneswuerbach: deis run is printing the output of the previously executed command, deisctl installation shouldn't use sudo, deisctl unit lookup should be the same for scheduling and refresh, deisctl should warn about outdated unit files, Feature: deis restart, controller is not reloaded when template changes, App containers are not waiting for the registry , docker hub images are containing the wrong version, make discovery-url fails silently, Build status badge, feat(router): Changed store hostname to deis-store, fix(router): Use official javascript content type, fix(tests): Increased test timeout for smoke tests, fix(router): Set default values in /deis/router, feat(tests): Show all etcd keys on error, fix(controller): Use correct entrypoint for run, fix(builder): Non-root slugrunner and slugbuilder, fix(*): Announce the published port to etcd, fix(tests): data containers should not be shared, fix(router): gzip content types syntax fixed
- @Joshua-Anderson: `deisctl install platform` throws logger-data template not found, docs(standards): remove [skip ci] instructions, docs(client readme): remove travis build status icon
- @kingcody: Builder and Controller "hang" on fresh install
- @lpickerson86: some admin services wake up after run command on app
- @nathansamson: Running 2 web processes in one application, Use Real CoreOS on DigitalOcean
- @ngpestelos: Failed to install deisctl, Multiple publishers running on the same node, X-Deis-Builder-Auth not checked?
- @peterrosell: Missing instruction in "Get Deis" section 02 , solved: local DNS not resolving for local.deisapp.com
- @pgrm: Update the documentation on how to deploy on DigitalOcean
- @PierreKircher: doc > baremetal, deis-store > database, restart behavior of deisctl, master > builder in endless loop on GCE, (DOC) upstream new builds with privatregistry on boot2docker + ngrok
- @scottrobertson: Few issues with Digital Ocean
- @sstarcher: Fleet scheduler to not get memory/cpu scheduling
- @tobyhede: Deploy of example app fails with 'invalid compressed data--format violated', Error on install: Failed getting response from http://127.0.0.1:4001, ==> deis-1: No etcd discovery URL set in /tmp/vagrantfile-user-data
- @tombell: Installation of deisctl results in 404 error
- @vincentpaca: deisctl start platform keeps timing out.
- @Xe: deisctl causes the cluster to implode, Basic user operations, Metadata tagging for deis unit installs, Installing deis client on OSX causes failure in cleanup process, install fails, pgbouncer in buildpack fails due to missing system library, Feature request: ability to see who you are logged in as, deisctl doesn't follow versioning for default installs, deisctl refresh-units defaultly tries to write to non-user-owned space, Suggestion: setting where administrator needs to confirm new registrations, docs(deisctl): document DEISCTL_UNITS better, feat(userdata): add deisctl to the coreos install

Special thanks to [@progrium](http://twitter.com/progrium) for his work on [progrium/logspout](https://github.com/progrium/logspout).

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know.

## Known Issues

### Problems with etcd leader failure

During the course of simulating cluster failures and testing platform HA, we came across a serious bug in etcd.  If the current etcd leader is killed, sometimes a new leader election does not take place leaving etcd, fleet and Deis in a badly broken state.  This issue is tracked in the [etcd project](https://github.com/coreos/etcd/issues/863).  We are working with the CoreOS team to identify the root cause, and will update to a new CoreOS release once the issue is fixed.

### Log Data Availability

While the critical components in the Deis control plane are now highly available, we have not yet addressed availability of our **logger** component, used to store aggregated logs.  We are waiting for Ceph to support [volume mounts from within containers](https://github.com/deis/deis/issues/2041).  Once this lands, we can store aggregated logs in Ceph and allow _all_ control plane components to float across the cluster for complete platform HA.

## What's Next?

### Deis Upgrades

We will soon announce simple in-place upgrade instructions for Deis clusters.  Beyond that, this release also lays the groundwork for a Deis update engine based on [CoreUpdate](https://coreos.com/products/coreupdate/) which will ultimately provide fast, painless, zero-downtime upgrades of the platform control plane.

### Production Ready

Deis is being used in production at companies of all sizes.  We are committed to delivering our first stable release in the next few weeks.  Once **logger** HA and updates are behind us, we will focus on API versioning, bug fixes and a comprehensive documentation update with a focus on how to operate Deis in production.

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
