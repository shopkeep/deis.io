---
layout: post
title: "Deis Sponsors Dokku"
author: gabrtv
meta:
  - name: description
    content: Deis is now the exclusive sponsor of the Dokku project
  - name: keywords
    content: deis, dokku, sponsorship, heroku, docker
---

Deis is proud to announce we are now the exclusive sponsor of the [Dokku](https://github.com/progrium/dokku) project.  [OpDemand](http://opdemand.com/), the company behind Deis, is now funding the ongoing development of Dokku and its open source components.

[Learn More](/deis-sponsors-dokku/)

<!--more-->

## What is Dokku?

Dokku provides developers a simple "mini-Heroku" that runs on a single host.  Dokku [pioneered](http://progrium.com/blog/2013/06/19/dokku-the-smallest-paas-implementation-youve-ever-seen/) the Heroku-like experience on top of Docker.  The project remains incredibly popular in the open source community.

## Dokku and Deis

Early versions of Deis were deeply influenced by Dokku.  Both projects have much in common including the [build stage](http://12factor.net/build-release-run) of the PaaS workflow and overall developer experience.

However, while Dokku is a single-host PaaS, Deis is a multi-host PaaS designed to run enterprise workloads.  This distinction has become even more evident recently, as Deis now requires a minimum of 3 hosts to facilitate a "highly-available by default" configuration.

When the system requirements of Deis are too much for a prospective user, we have always said:

> If you want a simple, single-host PaaS, use Dokku.

Our sponsorship of Dokku makes this recommendation official!

## Sponsorship Details

In keeping with the Deis philosophy of integrating with best-of-breed projects and technologies, we are thrilled to be sponsoring Dokku.  Here is what we can accomplish together.

### Shared Components

[Jeff Lindsay](https://github.com/progrium), the creator of Dokku, has demonstrated a unique ability to solve problems with reusable components.  As the next round of Dokku development takes shape, we expect that some of the improvements to Dokku will be incorporated into Deis and vice versa.

Specifically, we hope to collaborate on:

 * Improvements to the build system and the corresponding runtime environment
 * Co-maintaining a Heroku-compatible stack for Buildpack applications
 * Adding Dokku support for native `Dockerfile` builds (something Deis already supports)

### Shared Test Infrastructure

Deis has made a large investment in test infrastructure that ensures every supported Buildpack is tested regularly against example applications we maintain.  We believe this infrastructure can ensure test coverage applies to both projects.  This will allow us to determine which problems are due to Buildpacks and which are due to the shared build system.

### Migration Path

Over the last few months we've had many successful Deis users come to us from Dokku.  Likewise, we continuously send prospective Deis users to Dokku.  We want to ensure the migration path between projects is as smooth as possible.  Sharing components and test infrastructure will help ensure applications are portable without modification.

## Go Dokku!

We want to see Dokku succeed in its charter as a single-host mini-Heroku.  We hope our sponsorship breathes new life into the project to the benefit of Dokku users, Deis users and the wider open source community.
