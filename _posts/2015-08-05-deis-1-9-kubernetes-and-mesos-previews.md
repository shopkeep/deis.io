---
layout: post
title: "Deis v1.9 - Kubernetes and Mesos Previews"
author: technosophos
meta:
  - name: description
    content: Deis release v1.9
  - name: keywords
    content: deis, release, v1.9, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise, kubernetes, mesos
---

The Deis project is happy to announce [v1.9.0](https://github.com/deis/deis/releases/tag/v1.9.0), which introduces [Kubernetes](http://kubernetes.io/) and [Mesos](https://mesos.apache.org/) tech preview schedulers, provides [custom health checks](http://docs.deis.io/en/latest/using_deis/config-application/#custom-health-checks) for your apps, and lays groundwork for the future with [graceful upgrade](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/#graceful-upgrade) tools.

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.9.0 Summary

### New Features

- [Kubernetes scheduler](http://docs.deis.io/en/latest/customizing_deis/choosing-a-scheduler/#k8s-scheduler) tech preview!
- [Mesos with Marathon scheduler](http://docs.deis.io/en/latest/customizing_deis/choosing-a-scheduler/#mesos-scheduler) tech preview!
- `deis config:set HEALTHCHECK_URL=/` enables liveness and readiness app [health checks](http://docs.deis.io/en/latest/using_deis/config-application/#custom-health-checks)
- Tools for a [graceful upgrade](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/#graceful-upgrade) to future versions of Deis are in place
- `deisctl dock` opens a shell or runs commands on a running container
- `deisctl ssh` can also run commands directly on a node
- `deisctl install` can specify the router mesh size (default is 3)
- A faster, more portable `deis` CLI written [in Go](https://github.com/deis/deis/tree/master/client-go) is ready for your testing and feedback!
- `make commit-hook` installs a helper to warn about git [commit style](http://docs.deis.io/en/latest/contributing/standards/#commit-style)

### Improvements

- `deisctl` exits with an error if `stop` or `start` fails
- deis-controller enforces correct types for CPU, mem, and tags config
- deis-controller allows non-superusers to manage their keys
- deis-controller ignores setting gunicorn workers < 1
- deis-database backs up the DB on unit stop
- deis-logger uses only one `Ticker` for time-related operations
- deis-publisher displays the HTTP error on connection failure
- deis-router builds the set-misc module for nginx `set_random`
- Makefiles install go tools from golang.org, not code.google.com

### Under the Hood

- Shell scripts throughout the project are validated with [shellcheck](http://www.shellcheck.net/)
- The [`flannel`](https://github.com/coreos/flannel) overlay network is active on newly provisioned clusters
- [`etcd`](https://github.com/coreos/etcd/releases/tag/v2.1.1) v2.1.1 runs in a container on newly provisioned clusters
- Updated vendored [`fleet`](https://github.com/coreos/fleet/) code for `deisctl` to 0.9.2
- Updated vendored [Docker](https://www.docker.com/) code for tests to 1.5.0
- deis-router verifies the downloaded [nginx](http://nginx.org/) archive

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).

## What's Next

### Builder in Go

The deis-builder component consists of a variety of shell scripts and binary tools which has proved difficult to maintain over time. Rewriting the builder as a set of Go packages will make it easier to test, improve, and extend this core component.

This work is nearly completed. See [PR 4010](https://github.com/deis/deis/pull/4010) for more detail.

### Deis CLI in Go

The `deis` CLI is a one-file python app that has served the project well, but its PyInstaller-based binary packaging is inefficient, and it sometimes runs into incompatibilities with specific platforms. Rewriting the `deis` CLI as a Go binary has already proved to be faster and more portable.

This work is nearly completed. See [PR 4015](https://github.com/deis/deis/issues/4015) for more detail.

### TTY Broker

Today Deis cannot provide bi-directional streams needed for log tailing and interactive batch processes. By having the Controller drive a TTY Broker component, Deis can securely open WebSockets through the routing mesh.

See [TTY Broker](http://docs.deis.io/en/latest/roadmap/roadmap/#tty-broker) at the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) for more detail.

### Teams / Fine-Grained Permissions

Deis uses a simple permissions model currently, involving only two roles: admin and user. Features such as sharing applications, modifying certs, and changing config could be implemented with more specific permissions.

Work is underway on gathering community feedback and implementing teams and more refined permissions. See [issue 4150](https://github.com/deis/deis/issues/4150) and [issue 4173](https://github.com/deis/deis/issues/4173) for details.

## Community Shout-Outs

The Deis project would like to extend our profound gratitude to 2015 interns Joshua Anderson (@Joshua-Anderson) and Keerthan Mala (@kmala). Joshua attacked the controller, client, and project infrastructure and made myriad improvements while rewriting our world in Go. Keerthan applied his domain expertise and owned Kubernetes (k8s), giving Deis a scheduler for the future. We have all enjoyed working with Joshua and Keerthan more than we can say, and the Deis project is much richer because of them. Thank you!

We want to thank the following Deis community members for creating GitHub issues, providing support to others, and working on various Deis branches:

- @altitude: [question] Why should I maintain an odd number of servers ?
- @arkkanoid: Logstash doesn't receive logs from Logspout
- @arv1989: Deis cluster on Microsoft Azure script fails
- @bladealslayer: Add verification of downloaded nginx archive.
- @clayzermk1: SSH_KEY is ignored when not specifying BUILDPACK_URL, deis pull registry returns error "Tag not found" on 1.8.0
- @Crispy1975: Vagrant: error: failed to push some refs
- @croemmich: SSL Session Ticket Rotation, fix(contrib/linode): Install CoreOS from the stable channel
- @fabiob: fix(router): add set-misc module to nginx build
- @gabeio: /docs/managing_deis/configure-dns.rst is in the middle of a merge conflict
- @ineu: deis config and releases are inconsistent, Containers are out of sync with releases
- @jacopofar: Let the admin delete a user from the CLI
- @JeanMertz: Deis on top of Mesosphere's DCOS
- @jeff-lee: deisctl should warn when unit files have errors
- @jorihardman: Non-admin users cannot remove ssh keys
- @jwaldrip: Feature Request: Cluster-Wide ENV vars
- @laurrentt: feat(deisctl): specify # of routers to install
- @LoicMahieu: deis logs not showing application logs when use of Dockerfile
- @mdolian: docs(managing_deis): add section for registrationMode
- @molisoft: can't run created linodes
- @msull92: deis run "interactive console"
- @mxk1235: Not sure how to kill run.N processes, Cannot execute 'deis run ls'
- @nasali: Deis in-place upgrade to 1.8.0 made my apps invisible , Deis Controller API
- @nathansamson: Running docker registry results in out of disk  space error, Virtualbox requirements are wrong
- @nilnullzip: Security concern: controller and app data paths mixed together
- @olalonde: 503 service unavailable when running `deis pull drone/drone:latest`, Possible to pass custom docker flags to Deis app?, deis-builder won't start after 1.6.1 -> 1.7.3 upgrade, `deis config:push -a someappname` doesn't work
- @paulczar: fix(contrib/openstack/provision-openstack-cluster.sh): fix openstack …
- @rochacon: fix(controller): allow non superusers to manage their keys
- @sstarcher: Connection Draining
- @szymonpk: aws elb instances ip addresses mismatch, Sanitize/filter config variables from client, no output from deis run while using ruby's puts or pp
- @tscheepers: fix(contrib/gce): updated GCE docs with new cloud dns config and commas
- @woopstar: stop-update-engine.service results in degraded status, Launching the sample app on a new deis cloud is failing, Wrong path to link deisctl into $PWD

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.

## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Voice your opinion on the [Deis Roadmap](http://docs.deis.io/en/latest/roadmap/roadmap/) by attending the monthly [Release Planning Meeting](http://docs.deis.io/en/latest/roadmap/planning/#release-planning-meetings)
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
