---
layout: post
title: "Deis v1.2 - Happy New Year!"
author: carmstrong
meta:
  - name: description
    content: Deis releases v1.2 with security and performance improvements and added tests.
  - name: keywords
    content: deis, release, v1.2, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, opdemand, enterprise
---

Happy New Year! The Deis project is proud to announce [v1.2.0](https://github.com/deis/deis/releases/tag/v1.2.0), which includes security fixes for applications, numerous bug fixes, and significant performance and stability improvements for AWS clusters.

**Important:** This release includes several bug fixes involving app permissions, fixing an issue where users could perform actions on applications without having been granted permission. All Deis users are strongly encouraged to upgrade to this release.

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.2.0 Summary

### New Features

- An `etcd` debug systemd unit helps with troubleshooting
- `/var/lib/docker` and etcd data are mounted as separate volumes on AWS, improving reliablity and performance of Deis clusters
- `progrium/cedarish` was compressed to improve builder start times
- Vagrant VMs default to 1GB, allowing testing on lower-memory machines
- Testing uses the smaller, faster example-dockerfile-http app

### Under the Hood

- [cache](https://github.com/deis/deis/blob/master/cache) updated Redis to 2.8.19
- [client](https://github.com/deis/deis/blob/master/client) updated python requests to 2.5.1
- [client](https://github.com/deis/deis/blob/master/client) updated PyInstaller to fix X509_load_cert_crl_file error
- [controller](https://github.com/deis/deis/blob/master/controller) updated django-cors-headers to 1.0.0
- [slugbuilder](https://github.com/deis/deis/tree/master/builder/image/slugbuilder) updated all buildpacks for current Heroku compatibility
- All vendored code for Go packages is consolidated into the root `Godeps`

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## What's Next

### Application SSL Support

Thanks to community discussion and the efforts of @jparkerCAA in [pull request 2570](https://github.com/deis/deis/pull/2570), application SSL support should land in Deis soon. What remains is a formal specification following Heroku and an updated implementation. Once merged, users will be able to install custom private keys and SSL certificates to expose HTTPS applications using the Deis router.

### Improved Test Infrastructure

We are in the process of planning another round of improvements to our test infrastructure.  The goals are to speed our test suites, eliminate the build queue and increase coverage to include operational aspects like upgrades and HA.

### Mesos Integration

We have an alpha version of Deis + Mesos running.  We are polishing it with help from our friends at [Mesosphere](http://mesosphere.io/) and hope to announce a production-ready version soon.  If you are interested in helping test Deis on Mesos, please find us in IRC!

### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @adamkdean: Deis appears to have ran out of space
- @aledbf: REST errors question, Additional checks for go code, bug(database): the backup should not interfere the etcd publication, Proposal: scale deis-store-gateway, ApplyLayer exit status 1 unexpected EOF, feat(security): allow access to new nodes using the custom firewall, ref(router): change structure to allow the update of go dependencies, feat(builder): do not lookup the remote host in ssh connections, fix(builder): the value of a variable could be a number, fix(gateway): wait until radosgw is accessible, feat(vagrant): check if discovery url is defined
- @armandomeeuwenoord: Apps offline (http) after activating https
- @avthart: deis-builder.service hangs on activating/start-post
- @babarinde: [docs] Add multiple config values.
- @bfosberry: builder error - unexpected eof in archive
- @Blystad: Apps should be published with an descriptive hostname
- @btrepp: Build builds deis/slugbuilder rather than use whats in etcd, Deisctl refresh units and proxy
- @Fandekasp: Deis integration with Kubernetes
- @glogiotatidis: Docker image pull hangs if latest tag does not exist, Deis pull does not respect permissions.
- @hanxy: deis pull failure, Error: ceph -s , deis-store-volume.service start-pre operation timed out. Terminating.
- @jimmychu0807: After machine reboot (or Docker daemon restart), deis-store-monitors get stuck in `/usr/bin/ceph mon getmap -o /etc/ceph/monmap`
- @johanneswuerbach: feat(registry): deis-cache for saving meta data, ref(*): Manage test dependencies using godeps, chore(*): Allow testing against other CoreOS channels
- @jorihardman: Dead control plane units not rescheduled
- @Joshua-Anderson: feat(Makefile): add dev-cluster command, docs(contrib): Clarify source of DEV_REGISTRY IP Address
- @jparkerCAA: fix(client): avoid git remote deletion when app specified by -a
- @justinhennessy: Ceph production cluster in failing state ...
- @krancour: bug: slugbuilder behavior not consistent with documentation
- @mattapperson: Apps should communicate over local network, make -C router deploy leaves router un-started
- @mgartner: Make store component optional by allowing external database, registry, and log collector, CPU limits not working, deisctl start platform hangs on starting builder, services die, Don't store app state in the database - query it fresh on a `deis ps`, Deis does not always spread out applications across machines, Vagrant cluster fails on 8GB RAM, deisctl fails to initialize ssh client with Vagrant 1.7
- @ngpestelos: chore(controller): Fix typo on README.md, fix(Makefile): remove CLIENTS from release task, chore(store): remove redundant Makefile task
- @oren: Fail to create a zone with the gcloud utility, Google Cloud Engine - error when running 'addtargetpool'
- @phuonglm: ceph-osd and ceph-mon take high disk usage all the time
- @phuongnd08: How to setup a complete web server box with deis, Unsecured iptables rules
- @PierreKircher: [WIP] - Deis-Skydns - an Opera in 3 acts
- @rjocoleman: deis apps:run can't handle unicode output?
- @romansergey: Controller is missing migration for empty/false Dockerfile values, fix(controller): adds migration to get rid of dockerfile's u'False' valu...
- @sopel: feat(contrib/ec2): add optional support for IAM instance profiles
- @sunqi0928: How to autoscale apps when i add new instances in the Deis cluster  ?
- @timlesallen: Following platform logging instructions has not resulted in all logs being transferred, docs(docs/managing_deis/platform_logging): change example to prefer tcp
- @vincentpaca: Metadata Service seems to be stuck in a loop (GCE)
- @wiselyman: How to restart an app in deis, deis scale always show 404 error, Offline using java buildpack
- @Xe: fix(deisctl): prevent build on windows
- @zyxia: I want to install deis with three machines,

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/opdemand/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
