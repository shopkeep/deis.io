---
layout: post
title: "Deis v1.1 - CoreOS Stable Channel"
author: mboersma
meta:
  - name: description
    content: Deis releases 1.1, the first update in our new monthly release cycle.
  - name: keywords
    content: deis, release, 1.1, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, opdemand, enterprise
---

The Deis project is fired up to announce [v1.1.0](https://github.com/deis/deis/releases/tag/v1.1.0), the first update in our new [monthly release cycle](http://docs.deis.io/en/latest/contributing/schedule/). The CoreOS stable channel is now used to provision Deis.  Process type management has been improved for all Docker, Procfile and Docker-plus-Procfile workflows.

<!--more-->

If you are coming from an earlier version of Deis, read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.1.0 Summary

### New Features

- Deis now follows CoreOS' [Stable channel](https://coreos.com/releases/) for updates
- Process type management has been significantly improved!
  * See [Process Types and the Procfile](http://docs.deis.io/en/latest/using_deis/process-types/) for more information
- `deisctl` respects the `--ssh-timeout` option flag
- Integration test suite uploads more verbose logs to S3 for future reference
- Nginx routers have a NAXSI firewall installed, but disabled by default
  * See [Customizing router](http://docs.deis.io/en/latest/customizing_deis/router_settings/) to enable the firewall
- `deis` CLI checks against the API version instead of the platform version
- `registry` is now scalable. Try `deisctl scale registry=3` for added redundancy!

### Under the Hood

- [CoreOS](https://coreos.com/) updated to v494.4.0
- [wal-e](https://github.com/wal-e/wal-e) updated to [dbf9783](https://github.com/wal-e/wal-e/commits/dbf9783)
- [controller](https://github.com/deis/deis/blob/master/controller) API bumped to v1.1.0
- [controller](https://github.com/deis/deis/blob/master/controller) updated docker-py to v0.6.0
- [builder](https://github.com/deis/deis/blob/master/builder) has begun initial refactoring to a pure Go component
- [registry](https://github.com/deis/deis/blob/master/registry) updated to v0.9.0

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## What's Next

### Application SSL Support

Thanks to the efforts of @jparkerCAA [per-application SSL support](https://github.com/deis/deis/pull/2570) should land in Deis very soon.  Once merged, users will be able to install custom private keys and SSL certificates to expose HTTPS applications using the Deis router.

### Improved Test Infrastructure

We are in the process of planning another round of improvements to our test infrastructure.  The goals are to speed our test suites, eliminate the build queue and increase coverage to include operational aspects like upgrades and HA.

### Mesos Integration

We have an alpha version of Deis + Mesos running.  We are polishing it with help from our friends at [Mesosphere](http://mesosphere.io/) and hope to announce a production-ready version soon.  If you are interested in helping test Deis on Mesos, please find us in IRC!

## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @aledbf: ceph gateway does not provides HA with the current configuration, Workflow difference accessing registry, deisctl user-data installation, Incorrect deis-store-gateway service status, deis-logger dependency question, Is posible to synchronize the clocks before deisctl install platform?, Add documentation why deis is not going to work with less than 3 nodes, fix(database): update wal-e, feat(database): disable copy on write to improve performance, feat(router): improve log output., feat(security): add custom firewall in platforms without security, ref(deisctl): use docker exec
- @arkadijs: `deis pull` cannot pull private registry reliably (via https://)
- @babarinde: App not serving http request, Re-installing deis platform maintains old user, App (git push deis master) hanging on launching ...
- @boymaas: Problem forwarding logs using logspout (by adding a route)
- @brianclements: deisctl installer fails to extract
- @clarenceb: Buildpack is being detected when Dockerfile is present
- @clayzermk1: config:set runs as the app owner instead of issuing user
- @cmshetty: Start platform stuck  on bringing up store-volume service.
- @dalekurt: berks command failed to execute
- @glogiotatidis: Change prerequisites to 4GB droplets.
- @gmeans: `deis help` doesn't list 'sharing' commands, Can Deis cache docker images?, Set multiple env vars at once, docs: SSH keys when using vagrant
- @hanxy: Discovery encountered an error: 501: All the given peers are not reachable
- @HLcosmos: Can not register a user
- @Imdsm: Deis app hangs on launch, app sits as (created)
- @jannispl: Web interface: Method 'GET' not allowed
- @jensb1: etcd frequent failure with 3-node cluster
- @jimmychu0807: Deis in-place upgrade & cloud config file conflict?, Ceph enters degraded state and never recover
- @johanneswuerbach: feat(*): Scalable registry, chore(registry): Upgraded registry to 0.9, fix(*): Handling of unavailable services, fix(gateway): Removed unrecoverable state, chore(*): Added editorconfig, fix(router): Increased connect timeout
- @Joshua-Anderson: Vagrant takes too long to shut down, Issue with API to Controller Version Checking, fix(client): _logger doesn't exist for settings
- @jparkerCAA: Can't build deisctl from source, Trouble running tests locally Ubuntu 14.04
- @kingyueyang: Can't build deis by go get
- @knservis: Logspout output format
- @lsnyder: Add --ssh-timeout cli flag
- @martinffx: Installing Deis on Vagrant
- @mattapperson: docs(manage-application): fixed bad example command
- @misfo: Add omitted word in docs
- @ngpestelos: Client and Server versions mismatch, docs: Clarify Rackspace load balancer usage with wildcard SSL certificates, deis-builder fails to restart
- @nornagon: No such container: deis-store-daemon, Pulling from docker image stackexchange/bosun hangs
- @paulczar: git push method fails when config item has space in it, 500 error on key add/remove
- @paweloczadly: docs(hacking_on_dies): deisctl link fixed
- @renegare: feat(registry): Poor mans push to and deploy from private deis registry, `deis ps` prints list of processes twice, Login with SSL controller is does not work (however it works with non ssl), 500 error response when attempting to execute a command on a running app/container
- @rjocoleman: docs: connecting to the cluster
- @robertschultz: Configuring platform with sshPrivateKey on OSX and Vagrant has ssh error
- @rochacon: Client: add pull shortcut to global help
- @sarkis: deisctl start platform stuck in loop on digitalocean: deis-store-monitor.service: activating/auto-restart
- @sirwolfgang: Rollback fails to rollback to v1, deis run fails with "No space left on device", deis cli application context, [Bug] deis register fails due to version mismatch, ref(contrib/coreos): remove fleet.socket from user-data
- @stefanfoulis: deis register fails with https, docs(database): add BUCKET_NAME Environment Var
- @teamon: Added missing ".sh" in digitalocean docs
- @timfpark: 'deis start platform' failing repeatedly on deis-store-monitor.service
- @Vad1mo: destorying apps result in internal server error, destorying apps result in internal server error, 504 Gateway Time-out when trying to pull, Can not stop platform "Config check failed: exit status 1", deisctl start platform needs 1-2hrs to start, 404 NOT FOUND when creating from public docker registry, Can not push Dockerfile application
- @wiselyman: Docker Image app scale up, Spring Boot Jar App , Documentation about details configuration of DNS and Load Balancers , All services in one node are dead
- @Xe: deisctl config command confusion with sshPrivateKey, fix(gce): update to new path for example userdata
- @yoeluk: starting a unit with fleetctl hangs without results, Impossible to register an administrator deis/vagrant/OSX
- @zyxia: I have "make discovery-url" in the root of deis source,but "All the given peers are not reachable"

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/opdemand/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix issue](https://github.com/deis/deis/issues?labels=easy-fix&state=open) and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
