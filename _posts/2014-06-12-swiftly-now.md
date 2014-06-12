---
layout: post
title: Swiftly Now! - Taking on the Swift Storage Backend
author: bacongobbler
meta:
  - name: description
    content: The Deis team is helping maintain the Openstack Swift backend driver for the docker registry.
  - name: keywords
    content: deis, openstack, swift, python, docker, registry
---

Earlier this month, I was contacted by Docker's Registry maintainers that they were breaking out
the backend storage drivers for the [dotcloud/docker-registry][1] project on GitHub. They were
asking for volunteers to help maintain the individual storage drivers. Since I was the original
contributor who [added the Swift backend][2] to the registry, I was more than happy to take it by
the horns and start maintaining it. You can find [the project on GitHub][3].

<!--more-->

## What can we do with it?

The Swift backend is simply a storage driver for saving your docker images. The registry has a
concept of storage backends, whether this may be the local filesystem or a file storage solution
In The Cloud:tm: like Amazon S3, Openstack Swift or Google Cloud Storage.

Deis' registry component that we use today defaults to the local filesystem, which is actually
[a bind-mounted Docker container][4] that we are using strictly for storing the registry's data.
However, this poses a question in terms of scalability: What if we wanted to have two registries on
separate hosts that share the same storage backend, so that we could remove the risk of a potential
bottleneck of the platform?

We could try to "mirror" the docker image across hosts, but that is not The Deis Way:tm:. We
believe in using off-the-shelf solutions that have already been battle-tested and have already
solved this problem domain so that we can stay focused on the one thing that matters most to us...
the Deis Platform. We could potentially spin up a mini-cluster of Swift containers inside Deis,
each of them with leader election and full redundancy. We could then point the registry to use the
Swift mini-cluster as its storage backend. With this implementation, we could spin up even more
registries so that we could balance the load between each registry, and they'd all be reading and
writing to the same backend! Sounds pretty cool, huh?

## Want to help?

If you have any question or are just getting started with setting up a docker registry and you want
to ask questions on how to hook up Swift to your registry, or you want to try taking a stab at the
vague implementation I gave above for Deis, feel free to ping me. I'm bacongobbler on IRC, and you
can typically find me lurking in #deis, #coreos or #confd on freenode. Cheers!

[1]: https://github.com/dotcloud/docker-registry
[2]: https://github.com/dotcloud/docker-registry/pull/160
[3]: https://github.com/bacongobbler/docker-registry-driver-swift
[4]: https://github.com/deis/deis/blob/master/registry/systemd/deis-registry.service#L10
