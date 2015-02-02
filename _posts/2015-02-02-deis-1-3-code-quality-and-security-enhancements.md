---
layout: post
title: "Deis v1.3 - Code Quality and Security Enhancements"
author: bacongobbler
meta:
  - name: description
    content: Deis releases v1.3 with code quality and security enhancements.
  - name: keywords
    content: deis, release, v1.3, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, opdemand, enterprise
---

The Deis project is proud to announce [v1.3.0](https://github.com/deis/deis/releases/tag/v1.3.0), which includes more ways to debug your cluster, code quality improvements to the controller and security enhancements to the builder.

**Important:** This release includes a CoreOS update for the [CVE-2015-0235](http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2015-0235) glibc fix. All Deis users are encouraged to upgrade their host machines to CoreOS 522.6.0 or later.

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.3.0 Summary

### New Features

- The optional `deis-store-admin` service helps with Ceph troubleshooting
- [builder](https://github.com/deis/deis/blob/master/builder) disallows simultaneous `git push` on one app
- [builder](https://github.com/deis/deis/blob/master/builder) runs application builds as a non-root user
- [controller](https://github.com/deis/deis/blob/master/controller) REST views are updated and simplified
- [controller](https://github.com/deis/deis/blob/master/controller) consistently returns errors as JSON
- [controller](https://github.com/deis/deis/blob/master/controller) consistently returns 403 for permission errors


### Improvements

- Vagrant VMs default to 2GB, since less can lead to docker mem alloc errors
- Dockerfiles include `ENV DEIS_RELEASE` to prevent overlap in `docker images`
- `etcd` discovery URL uses the right key on GCE
- a Procfile can override a buildpack's `default_process_types`
- [controller](https://github.com/deis/deis/blob/master/controller) tracks create and start separately for better error handling
- [controller](https://github.com/deis/deis/blob/master/controller) validates uploaded key material
- [logger](https://github.com/deis/deis/blob/master/logger) builds with `godep`, like other Go components
- [router](https://github.com/deis/deis/blob/master/router) has docs and `deisctl` fixes for installing SSL


### Under the Hood

- [CoreOS](https://coreos.com/releases/) updated to 522.6.0 stable
- [controller](https://github.com/deis/deis/blob/master/controller) bump API version to 1.1.2
- [controller](https://github.com/deis/deis/blob/master/controller) updated Django REST Framework to 3.0.3
- [controller](https://github.com/deis/deis/blob/master/controller) updated django-guardian to 1.2.5
- [controller](https://github.com/deis/deis/blob/master/controller) updated paramiko to 1.15.2
- [controller](https://github.com/deis/deis/blob/master/controller) updated python-dateutil to 2.4.0
- [controller](https://github.com/deis/deis/blob/master/controller) updated static wsgi library to 1.1.1
- [slugbuilder](https://github.com/deis/deis/tree/master/builder/image/slugbuilder) updated heroku-buildpack-php to v57

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## What's Next

### Application SSL Support

Thanks to community discussion and the efforts of @jparkerCAA in [pull request 2570](https://github.com/deis/deis/pull/2570), application SSL support should land in Deis soon. What remains is an agreement on [the formal specification](https://github.com/deis/deis/pull/2911) following Heroku and an updated implementation. Once merged, users will be able to install custom private keys and SSL certificates to expose HTTPS applications using the Deis router.

### Improved Test Infrastructure

We are in the process of planning another round of improvements to our test infrastructure.  The goals are to speed our test suites, eliminate the build queue and increase coverage to include operational aspects like upgrades and HA.

### New Container Scheduler

We are evaluating a new, resource-aware scheduler for application containers in the data plane to improve cluster efficiency at scale and to alleviate issues with [cluster balancing after the loss of a node](https://github.com/deis/deis/issues/2920). Prototyping is ongoing with Mesos, Kubernetes, and Docker Swarm.

Deis will continue to support Fleet for both control plane and data plane scheduling for the foreseeable future.

### Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @aledbf: user-data error in service debug-etcd.service, Proposal: publish master version every night to docker, Proposal: allow custom log level in components, REST errors question, feat(builder): disable simultaneous push in the same repository, fix(security): increase max conntrack connections, fix(builder): exit if an error occur compiling go, fix(database): update wal-e because error in python-daemon, feat(docker): add env DEIS_RELEASE, feat(slugbuilder): update nodejs buildpack to v64 (yoga release)
- @babarinde: Push Failure after Restoration of from Backup, CoreOS nodes not connected on GCE, fix (contrib/gce/create-gce-user-data): replace discovery_url with discovery
- @bfosberry: processes removed from Profile cannot be stopped, builder error - unexpected eof in archive
- @Blystad: request: Custom 502 error page on per-application basis, ref(builder): Remove use of root in gitreceive, feat(controller): add hostname exposing to units, feat(contrib/ec2): Set ELB timeout to 1200s
- @daemonza: Cannot pull image - tag not found
- @glogiotatidis: s3cmd fails to copy registry, docs(managing_deis): Typo fix., feat(client): Add controller to whoami command.
- @ianblenke: deis-controller generated fleet units should [X-Fleet] Conflicts with the others of the same app
- @iansmith: surprising effect of changing from go-buildpack to Dockerfile
- @jannispl: cluster is working, but filling logs with confd errors
- @jetole: deis blocks domain creation under improper circumstances
- @jgmize: docs(system-requirements): Fix broken link
- @Jim-Holmstroem: fix(contrib/coreos) etdcd_request_timeout value type
- @johanneswuerbach: aws: consider reverting to instance storage
- @karlo57: Waiting for ceph gateway
- @marzolfb: All the given peers are not reachable
- @mcano: feat(client): add flag to disable SSL certificate verification
- @mgartner: AWS instances being terminated by autoscaling group, ceph-osd using utilizing 20-50% CPU continuously, AWS autoscaler terminated then restarted node - how to get cluster back to normal?
- @mhahn: config value escaping
- @mvgijssel: Using deployment keys for private repositories with deis builder
- @nagliyvred: Unable to add a node to a cluster or restart an existing one (GCE)
- @nathansamson: Feature: Allow System & Application monitoring based on Graphite
- @ngpestelos: Key not found (/deis/logs), etcd: inconsistent value for /deis/registry/host, builder: unable to restart builder if cedarish fails to download, deis-controller too many clients, How to handle a host running out of space, git push is rejected after upgrading builder, fix(database): increases max_connections to 250, chore(controller): Fix typo on README.md
- @prateek121: Deis Registration failed
- @rjocoleman: Proposal: Self updating Deis CLI
- @romansergey: fix(controller): adds migration to get rid of dockerfile's u'False' valu...
- @SkyWriter: Adding process to the Procfile does not create it
- @suquant: Database service recognition failed (boto timeout)
- @synaptics: Custom HTTP request headers not being passed in to web app (v1.2.1)
- @theaboutbox: docs(ec2): Document update_ec2_cluster.sh
- @timfpark: No Procfile -> obscure failure error
- @withinboredom: Unable to perform deis push, deis builder service hung in activating/start-post (failure retrieving image), Uninstall Platform leaves deis-registry@2.service hanging around, Deis hangs in launching state though launced successfully, Unable to register
- @xishuixixia: Chinese Version of Deis Documentation

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/opdemand/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
