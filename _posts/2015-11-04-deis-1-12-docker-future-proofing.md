---
layout: post
title: "Deis v1.12 - Docker Future-Proofing"
author: mboersma
meta:
  - name: description
    content: Deis release v1.12
  - name: keywords
    content: deis, release, v1.12, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise, kubernetes, mesos
---

The Deis project is happy to announce [v1.12.0](https://github.com/deis/deis/releases/tag/v1.12.0), featuring changes to **deis-builder** and **deis-controller** to ensure future compatibility with Docker. `deis pull` finally works with current Docker images, and the new `deisctl list-machines` command helps you survey your Deis cluster.

**NOTE:** Docker Hub will disable access for `docker` versions 1.5 and earlier [on December 7, 2015](http://blog.docker.com/2015/10/docker-hub-deprecation-1-5/). Releases of Deis prior to v1.12.0 relied on `docker` 1.5.0 and will experience problems after that date. As a result, all users are encouraged to provision a new v1.12.0 cluster which does not rely on a specific `docker` version.

Join the fun: new contributors to Deis can get [free DigitalOcean credits](http://deis.io/code-for-credit-digitalocean/)!

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.12.0 Summary

### New Features

- **deis-controller** uses the host's Docker engine for app config, no longer requiring Docker 1.5.0
- `deis pull` now works with images built by Docker 1.6.2 and later
- `deisctl list-machines` shows details of the nodes in your cluster
- **deis-logger** has new drains that are more performant and resilient
- **deis-builder** makes `$SOURCE_VERSION` available to buildpacks for Heroku compatibility
- **deis-controller** disables swap usage when a memory limit is set
- **deis-registry** logs more information during its startup process

### Improvements

- `deis pull` can use a Procfile provided on the command line
- **deis-builder** will continue to update etcd after transient errors
- **deis-builder** updated its Docker-in-Docker wrapper to work with upcoming versions
- DigitalOcean provisioning workflow is smoother and simpler when using [`rigger`](https://github.com/deis/rigger)
- Provisioning on Azure, GCE, and Linode handles discovery URL replacement better
- AWS AutoScaling Groups won't be replaced thanks to CloudFormation template changes
- Azure provisioning uses premium storage for `etcd` reliability
- Linode provisioning benefits from network and DHCP configuration tweaks
- Documentation has been updated to mention stateless graceful upgrade, Deis release criteria, and dev pre-requisites
- **deis-database** and **deis-registry** don't require "ListAllMyBuckets" permissions for S3 storage
- **deis-builder** increased its timeout to fetch third-party buildpacks

### Under the Hood

- **deis-builder** uses Docker 1.8.3 internally for future compatibility
- Deis CI systems use Docker 1.8.3 for building and testing
- Heroku-compatible buildpacks were updated to current release versions
- `deisctl` revised its `fleet` API code to v0.10.2
- Ceph was updated to [Hammer v0.94.5](http://docs.ceph.com/docs/master/release-notes/#v0-94-5-hammer)
- Azure and Vagrant source their CoreOS version from one location: utils.sh
- Most components updated their Docker base image to `alpine:3.2`
- **deis-router** updated `nginx` to 1.9.6, including HTTP/2 support

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues, providing support to others, and working on various Deis branches:

- @aespinosa: stale discovery URL when adding hosts
- @arkkanoid: Deis omits tag environment when a limit is set, Error pulling image deis/slugbuilder
- @clayzermk1: panic while getting logs for an app
- @CloudSide: Could not find some docker images (tag: v1.11.1)
- @crigor: New nodes should be members, not proxies, on the etcd cluster
- @croemmich: fix(contrib/linode): fix discovery url issues in deployment scripts, fix(contrib/linode): fix issues with DHCP on Linode
- @dmcnaught: Running without Ceph: deis-registry create_bucket looks for keys that aren't set:
- @dustinrc: feat(contrib): vagrantfile sources utils.sh
- @foxycoder: Deis controller flipping
- @gahissy: deis/contrib/gce/gce-user-data generates an invalid cloud-config
- @geeksoul-me: Logger is not draining logs in 1.11.1, Coreos user-data file uses public ip for fleet, firewall script brings fleet down
- @gred7: Issue with stateless setup, how long  deis-store-gateway@1.service: activating/start-post  should take?, getting application logs out of containers, disable adding of users
- @helloravi: Cluster Provisioning question(~azure)
- @jacobo: Increase timeout for fetching buildpacks
- @jannispl: custom-firewall.sh: jump to firewall is appended rather than prepended
- @jeff-lee: Improving ability to work with multiple deis clusters, Cross zone load balancing disabled, Units failing to start with overlay errors v1.11.0
- @jgmize: Non-zero-downtime deploys with healthcheck enabled, ref(aws): prevent replacement of ASG in CF update, add flocks to additional services
- @Joshua-Anderson: Ceph Build GPG Verification Error, feat(deisctl): bump fleet api to v0.10.2, fix(client): read procfile from PWD when pulling, fix(client): add newline for usage message
- @karthequian: Common spelling error fixes
- @kenaniah: deis client breaks when enforceHTTPS is enabled
- @landonclark: Integrate letsencrypt into the app provisioning / installation process
- @leshik: DO provider isn't working with latest terraform
- @LoicMahieu: docs(upgrading-deis): graceful upgrade in stateless mode
- @myyk: Feature request - HTTP/2 support, docs(contributing): update where build instructions are, docs(contributing): add optional pre-reqs, Cleanup dead config
- @nathansamson: Disk cleaning does not remove all old images..., Investigate floating IPs for DigitalOcean, missing install instructions for deis client for windows, ceph warns about clock skew on DO, contrib/util/firewall.sh breaks cluster
- @ngauthier: Panic on `deis create` following tutorial, fix(client): catch and propagate client errors
- @olalonde: HTTP 413 (entity too large) error after setting bodySize to "10000M", feat(client) support pipes with deis config:push and deis:config pull, Proxying some apps through mashape/kong API gateway, bug(client/controller): deis logs replaces " with \", feat(builder): make SOURCE_VERSION env variable
- @pdaniel-frk: problems running deis installer azure
- @philippwiendl: app container failed to start
- @pmclanahan: Deis should send host header with health checks.
- @ritazh: Bug (contrib/azure) - unable to add new discovery URL to azure-user-data, fix(contrib/azure)-replace discovery url
- @robeferre: Deis is losing a node every time., Cant  start the platform in 1.11.1, Cannot perform, deis info, deis create
- @rvaralda: Deis Registry miss /deis/store/gateway key while use S3 as storage, ref(registry/database): change the create_bucket script to avoid allow 'ListAllMyBuckets' on S3 Policy
- @rvm2015: etcd2 setup fails on 2 of 3 nodes, expand installation docs on DNS setup, expand installation docs on public/private ip space, bare-metal docs, move the hostname 'known issue' above the installation, deisctl install platform hangs on deis-router/router mesh
- @sbuss: Encrypt the router<->container link, bug(client): New deis go client does not read `Procfiles` from current directory during `deis pull`
- @shingara: add pre/post deploy hook
- @stuszynski: Admin can't see application certificates added by another admin.
- @synaptics: Urgent help! deis-controller not starting, seems caught in a loop, HELP! deis-store-daemon high memory utilisation
- @taxido: deis builder doesn't start because of deis registry gunicorn worker restart Error:  100: Key not found (/deis/registry/masterLock)
- @thiver: heroku buildpack fails, but commits gets accepted
- @vinilios: custom-firewall.sh with k8s scheduler issues

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Voice your opinion on the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) by attending the monthly [Release Planning Meeting](http://docs.deis.io/en/latest/roadmap/planning/#release-planning-meetings)
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
