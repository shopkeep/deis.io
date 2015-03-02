---
layout: post
title: "Deis v1.4 - Now on Azure"
author: mboersma
meta:
  - name: description
    content: Deis releases v1.4 with community support for Microsoft Azure Cloud.
  - name: keywords
    content: deis, release, v1.4, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, opdemand, enterprise
---

The Deis project is proud to announce [v1.4.0](https://github.com/deis/deis/releases/tag/v1.4.0), with community-driven support for provisioning on Microsoft Azure, improvements to AWS provisioning, and a scalable Ceph store-gateway.

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.4.0 Summary

### New Features

- You can now provision Deis on [Azure](http://azure.microsoft.com/)! - [#2893](https://github.com/deis/deis/pull/2893)
- AWS provisioning scripts support internal Elastic Load Balancers - [#3074](https://github.com/deis/deis/pull/3074)
- New AWS clusters use SSD Elastic Block Storage by default - [#3065](https://github.com/deis/deis/pull/3065)
- Deis sends `SIGTERM` to shut down application processes gracefully - [#3091](https://github.com/deis/deis/pull/3091)
- **builder** honors proxy settings in `/etc/environment` - [#2825](https://github.com/deis/deis/pull/2825)
- **logspout** accepts custom date/time formats - [#3037](https://github.com/deis/deis/pull/3037)
- **router** now logs http_host, upstream and request times - [#2869](https://github.com/deis/deis/pull/2869)
- **router** allows optional HTTPS redirect - [#3075](https://github.com/deis/deis/pull/3075)
- **store-gateway** can be scaled with `deisctl scale` - [#2929](https://github.com/deis/deis/pull/2929)
- Any scalable component can be started or stopped with `deisctl start|stop component@` - [#3106](https://github.com/deis/deis/pull/3106)
- New documentation added about [disk usage](http://docs.deis.io/en/latest/managing_deis/disk_usage/) - [#3021](https://github.com/deis/deis/pull/3021)
- New links added to Deis [community projects](https://github.com/deis/deis/blob/master/contrib/README.md#community-contributions)! - [#3114](https://github.com/deis/deis/pull/3114)

### Improvements

- **builder** properly escapes backticks in environment variables - [#3129](https://github.com/deis/deis/pull/3129)
- **builder** lets Docker-in-Docker choose its storage driver - [#3039](https://github.com/deis/deis/pull/3039)
- **controller** queries fleet directly for app container state -[#2993](https://github.com/deis/deis/pull/2993)
- **controller** removes timed-out fleet units from `deis run` - [#3127](https://github.com/deis/deis/pull/3127)
- **controller** kills processes removed from a `Procfile` - [#3068](https://github.com/deis/deis/pull/3068)
- `deis domains` has improved validation per [RFC 1123](http://www.rfc-editor.org/rfc/rfc1123.txt) - [#2991](https://github.com/deis/deis/pull/2991)
- `deisctl journal|status` are more helpful about global units - [#3119](https://github.com/deis/deis/pull/3119)
- **router** disables SSLv3 (ref: CVE-2014-3566) if SSL is enabled - [#3136](https://github.com/deis/deis/pull/3136)

### Under the Hood

- [CoreOS](https://coreos.com/releases/) updated to 557.2.0 stable - [#3048](https://github.com/deis/deis/pull/3048)
- [`go`](http://golang.org/) updated to 1.4.1+ - [#3018](https://github.com/deis/deis/pull/3018)
- **builder** updated gradle and play buildpacks - [#2989](https://github.com/deis/deis/pull/2989)
- **controller** updated djangorestframework to 3.0.5 - [#3061](https://github.com/deis/deis/pull/3061)
- **controller** updated gunicorn to 19.2.1 - [#3024](https://github.com/deis/deis/pull/3024)
- **controller** updated PostgreSQL driver `psycopg2` to 2.6 - [#3050](https://github.com/deis/deis/pull/3050)
- `deisctl` updated vendored [fleet](https://github.com/coreos/fleet) code to 0.9.0 - [#3046](https://github.com/deis/deis/pull/3046)
- **registry** updated docker-registry code to v0.9.1 - [#3109](https://github.com/deis/deis/pull/3109)

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).


## What's Next

### Application SSL Support

Thanks to community discussion and effort, work on application SSL support has begun. What remains is an agreement on [the formal specification](https://github.com/deis/deis/pull/2911) following Heroku and an updated implementation. Once merged, users will be able to install custom private keys and SSL certificates to expose HTTPS applications using the Deis router.

### Improved Test Infrastructure

We need to speed up test suites, eliminate the PR build queue, and increase test coverage to include operational aspects such as upgrades and HA. Hard work behind the scenes and invaluable community support are steadily improving the Deis test infrastructure.

### New Container Scheduler

Application containers require a resource-aware scheduler to improve cluster efficiency at scale and to alleviate issues with [cluster balancing after the loss of a node](https://github.com/deis/deis/issues/2920). Prototyping is well underway with [Swarm](https://github.com/deis/deis/pull/3134) and [Kubernetes](https://github.com/deis/deis/issues/2744).

Deis will continue to support [fleet](https://github.com/coreos/fleet) for both control plane and data plane scheduling for the foreseeable future.


## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @achannarasappa: Invalid registry endpoint error
- @aledbf: Error in upgrading-deis.rst, question(builder): the published image uses the same ssh keys?, bug(go): some binaries are not static, fix(go): go 1.4 static binaries, docs(contrib): add link to new community project, feat(cloud-init): check if deisctl does not exists before install it
- @anoopknayak: Customized deis router times out at times, Deis logs not consistent
- @apps4u: unable to provision AWS ec2 , can not start
- @ashaffer: List environment variables in alphabetical order, Provide a way to install packages when using the buildpack workflow
- @Blystad: Proposal: Increase SSL Security in deis-router
- @cray0000: Out of disk space on machine running deis-builder
- @croemmich: builder - wrong filesystem?
- @daemonza: Logout REST api call for the controller feature request
- @dorkusprime: Getting inconsistent 403 errors from 'deis domains'
- @glogiotatidis: Deis should check if container's port is accepting connections before adding it to the pool, deis run cannot handle large output, Need a way to stop one-off stale commands
- @gpolyn: Failed to parse: proxyip:port at 'Register User' step (with Vagrant)
- @grengojbo: Deis builder is not start
- @gvilarino: (azure) builder doesn't start
- @ianblenke: Deis cannot build git submodules , New Dockerfile+Procfile behavior broken, 501: All the given peers are not reachable (Tried to connect to each peer twice and failed) [0]
- @ineu: Proposal: Bind deis containers to internal IPs, Questions on increase-nf_conntrack-connections.service, "Multipack app" cached?, deis-builder doesn't honor registry protocol, Vagrant problem: direct box file path
- @jasoncox: Consider datetime format to ISO8601
- @johanneswuerbach: CI: Docker networking issue?, feat(router): Removed X-Deis-Upstream, feat(deisctl): start / stop all installed units, feat(store): Scalable store-gateway, chore(controller): No sudo for deis, chore(builder): Updated gradle and play buildpack, feat(builder): Try shallow cloning buildpack repos
- @joshmackey: NPM lock issue.
- @jwarzech: Installing deis client on OSX 10.7.5
- @karlo57: fix(publisher): remove unnecessary BUILD_IMAGE variable from Makefile
- @kinessscu: deis-builder: server.go:110 HTTP Error: statusCode=500 Invalid registry endpoint
- @lorieri: Update README.md, feat(builder+docker+user-data): proxy settings, feat(router) nginx status; log http_host, upstream and request times
- @mhahn: Add root domain to an application, a way to pull configs into another application, feat(deis/config): remove "===" when listing configs with --oneline
- @mvanholsteijn: deis pull fails with No Tag Found
- @nekrox: How can isolate Control Plane and Router Mesh
- @ngpestelos: unable to start deis-builder , chore(builder, logger, logspout): remove unused references to BUILD_IMAGE
- @phspagiari: Proposal: LDAP/AD auth on controller, Problems with Deis in vagrant installation
- @rjocoleman: Proposal: deis cli discrete git remote command, Proposal: Self updating Deis CLI
- @simpsora: Unable to start arbitrary Procfile entries
- @theaboutbox: docs(logspout): Fix remote syslog example
- @timfpark: Builder is quitting after pushing image to private registry, Proxying web request causes timeout when target is another Deis application, Azure: Client hangs on "Launching app..." but app is successfully launched
- @wenzowski: Rolling restarts with deis ps:restart, SIGTERM on exceeded memory quota, pass env vars to buildpack, feat(store-admin): add gnu watch, builder re-generating SSH keys when jumping hosts, Nginx 5-tuple microflow affinity load balancing to enable arbitrary TCP, Graceful shutdown with SIGTERM, feat(scheduler): graceful shutdown with SIGTERM, fix(router): disable SSLv3 CVE-2014-3566
- @withinboredom: Failure in deis registry
- @yekeqiang: command fails: deisctl config platform set sshPrivateKey=~/.ssh/deis

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.


## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
