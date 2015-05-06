---
layout: post
title: "Deis v1.6 - Docker Swarm Tech Preview"
author: smothiki
meta:
  - name: description
    content: Deis releases v1.6 with a Docker Swarm scheduler technology preview.
  - name: keywords
    content: deis, release, v1.6, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise
---

The Deis project is excited to announce [v1.6.0](https://github.com/deis/deis/releases/tag/v1.6.0)
with a technology preview of a Docker
[Swarm](http://docs.deis.io/en/latest/customizing_deis/choosing-a-scheduler/#swarm-scheduler)-based
app scheduler and new `deis ps:restart` and `deis users:list` commands.

Deis is now supported by [Engine Yard](http://deis.io/deis-meet-engine-yard/)!

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own
servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide
a lightweight PaaS with a Heroku-inspired workflow.

## 1.6.0 Summary

### New Features

- Docker [Swarm](http://docs.deis.io/en/latest/customizing_deis/choosing-a-scheduler/#swarm-scheduler)
  is available for preview as an alternative to
  [Fleet](http://docs.deis.io/en/latest/customizing_deis/choosing-a-scheduler/#fleet-scheduler) for
  scheduling application units
- EC2 provisioning supports the
  [Proxy Protocol](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/enable-proxy-protocol.html),
  allowing WebSocket support for apps through an Elastic Load Balancer
- SSL certificates in SAN format are now supported
- `deis users:list` allows an admin to see all registered Deis users
- `deis ps:restart` stops and starts all containers, all those of a process type,
  or a single container
- `deis config:push` allows a `--path` argument to the `.env` file
- `deis logs` accepts `-n` to limit the number of lines displayed
- user registration can be `enabled`, `disabled`, or set to `adminOnly`
- logging level in router can be customized
- the number of worker processes in controller can be scaled

### Improvements

- `deis register` checks for a valid controller URL before continuing
- logger exposes its config as feature flags, and is more extensible
- Azure provisioning creates a load-balanced HTTPS endpoint
- EC2 provisioning shows a countdown timer and reports any CloudFormation errors
- `git push` errors are handled and reported more reliably
- `deis keys:add` uses SSH fingerprints to determine uniqueness
- registry determines S3 bucket name dynamically from `etcd`
- moved route53-wildcard.py script to contrib/ec2 to help with DNS setup
- `make -C controller/ postgres` creates a DB container for running unit tests

### Under the Hood

- bumped CoreOS to 633.1.0
- updated Ceph to "Hammer" release
- bumped `confd` to v0.9.0 in all components
- builder now uses the official `heroku/cedar:14` image
- router updated to nginx 1.9 for stream module TCP support
- added new C4 instance types to EC2 provisioning
- added sfo1 and ams2 data centers to DigitalOcean provisioning

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).


## What's Next

### New Container Schedulers

Application containers require a resource-aware scheduler to improve cluster efficiency at scale
and to alleviate issues with [cluster balancing after the loss of a node](https://github.com/deis/deis/issues/2920).
In addition to the [Swarm](https://github.com/deis/deis/pull/3612) technology preview in this
release, prototyping is underway with [Kubernetes](https://github.com/deis/deis/issues/2744)
and [Mesos](https://github.com/deis/deis/issues/3538).

Deis will default to using [fleet](https://github.com/coreos/fleet) for both control plane and
data plane scheduling for the foreseeable future.

### Improved Test Infrastructure

We need to speed up test suites and increase test coverage to include operational aspects such as
upgrades and HA. Hard work behind the scenes and invaluable community support are steadily
improving the Deis test infrastructure.


## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @ainux4mrvce: deisctl install platform
- @aledbf: fix(test): obtain logs from deis-registry, ref(router): update confd to 0.90, feat(router): nginx 1.9.0. Remove third party tcp module, fix(store): change template to return ip address instead of :6789, fix(store): install lsb-release package
- @ashaffer: Affinity arg is not working correctly
- @azurewraith: enforceHTTPS=true causes client side issues
- @babarinde: Deis controller Crashing, Deis domains:remove removing all domains, Deis application access and error logs not showing in v1.5, fix(controller) : remove domain
- @bastilian: deisctl install platform hangs when < 3 nodes
- @Blystad: deis-router error_log should have etcd configurable error level, fix(router): Unify timeout values, feat(router): customize error_log level via etcd
- @chrisgeo: Azure: Investigate Router "[emerg] 16#0: bind() to 0.0.0.0:2222 failed (98: Address already in use)", Exception in logs on store-volume startup
- @cleblanc87: Add profile parameter to provision-ec2-cluster.sh
- @crigor: docs(troubleshooting_deis): use private key on ssh -i
- @croemmich: Request: no downtime for apps during Deis platform upgrade, docs(contrib): add link to Docker S3 Cleaner
- @daanemanz: chore(contrib/ec2): introducing c4 instance types
- @davidcelis: Deis no longer produces app logs after an in-place upgrade
- @davidlmorton: Expose nginx 'gunzip' configuration via etcd key (for Deis Router)
- @dshafik: fix(client): Fix spacing of releases list
- @econnell: bug(contrib): check for cloudfront errors on stack creation
- @ecylmz: docs(managing_deis): add upgrade Deis clients for in-place upgrade
- @eMxyzptlk: refactor(publisher): Refactor the publisher to be more idiomatic, The builder is leaving behind files.
- @FreakinaBox: is running without wildcard sub domain possible?, Feature request: customize controller host name
- @fretboarder: deis pull from local/private docker registry fails
- @glogiotatidis: Apps built on Docker 1.6 -- Cannot `deis pull`: Invalid image ID, Cannot deploy, registry timeout, Add http check in addition to the port open check
- @haf: Q: safe way to re-run cloud-init on existing machine?, config:set k=v with self-signed certs looks ugly, Errors from platform, Deis store - misc errors from prod, deis ps:scale cmd=3 spawns all on same node, motd error in my log, Pushing large app crashes host / platform
- @hivearts: 'deis logs' not catching all app logs from docker containers
- @ineu: masterLock and updating logic, CoreOS update docs are inexact, Add `deis whoami` to the help screen., deis:perms is not working in fresh installation, SSL is broken after upgrade to 1.5.1
- @jannispl: deis-logger log drain format, deis-publisher should be less verbose -- add log_level setting
- @johanneswuerbach: WebSockets on EC2, chore(router): update nginx to 1.8
- @joshrtay: Minimum install of deis consumes a lot of disk space
- @Joshua-Anderson: feat(Makefile): Add a command to start a local postgresql container for running unit tests, feat(controller): add a option to limit the number of log lines, feat(controller): Allow adminOnly registration, feat(controller): add users:list endpoint, feat(client): check controller before attempting to register. Fixes #3224
- @jwaldrip: Registry Should be URL based, not IP, ec2: Consider using EBS volume for etcd, Feature Request: tail output of `deis run`, Cannot get application SSL to function, Error with `deis certs:remove`, Client warning of wrong version with latest cluster, Unable to register with https, deis run is not attaching stdin
- @kingdonb: deis domains:add does not work and other problems "Welcome to nginx!"
- @krancour: Proposal: Make Deis compatible with large-scale, production cluster architecture, get_image script doesn't work properly when dependent upon remote etcd, bug(router): remote etcd hosts not properly configurable, Clarification: how scalable is deis-registry?, bug(deisctl): are some services started twice?, documentation(registry): dependency on certain etcd keys is undocumented, Request: do not store domains in etcd:/deis/domains, Request: do not store user keys in etcd:/deis/builder/users, fix(registry): retrieve bucket name from etcd, docs(logger): change incorrect ref to db component
- @nathansamson: Non existing app returns http 200, After upgrading to 1.5.1 deis uses lot more resources, Application SSL is not working when using multiple certs, Deis Builder resets key after upgrade / restart
- @ngpestelos: Unable to push a new app in vagrant, HOST_IPADDR: parameter null or not set, deis-database: create_bucket failed after upgrading platform, deis-store-metadata won't start (missing ceph-mds), logs.papertrailapp.com drain type is not implemented, Unable to login to controller after upgrading to 1.6.0-dev, Unable to build 1.6.0-dev
- @olalonde: /usr/bin/dock cannot allocate memory
- @onbjerg: Post http://*:8000/v1/hooks/build: EOF, /home/git/project.git/hooks/pre-receive: No such file or directory, feat(client): add optional path to config:push
- @payomdousti: Apache Aurora Support
- @pdhar-tibco: deisctl start platform stuck at deis-store-gateway@1.service: activating/start-post, INFO client.go:291: Failed getting response from http://localhost:4001/: unexpected EOF, fleet.service not starting on virtual box Non Vagrant Deis installation, Not able to run Deis::etcd on Amazon EC2, Error: 501: All the given peers are not reachable (Tried to connect to each peer twice and failed) [0]
- @pmelmon: fix(controller) : fix regex for deis limits
- @raphaelluchini: deis config:set numbers as string error
- @rogerleite: deisctl tries to destroy app named "registry" when uninstalling platform
- @sedouard: feat(contrib/azure/azure-coreos-cluster): add an https enddpoint on c… …reation, fix('contrib/azure/azure-coreos-cluster'): make this not found error more user friendly
- @simpsora: Deploying app hangs at "Launching..."
- @sitya: Deis elements should use etcd2's permission resources
- @szymonpk: all routers stopped responding, can't execute apps:run
- @tiaz: fix(contrib/ec2): improve timeout handling
- @wenzowski: upgrade-fleet-091.service does not run after reboot
- @zxcvbn97: Deis installation fails at deis-store-gateway@1.service

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your
contribution to this release, please let us know so we can update.


## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
