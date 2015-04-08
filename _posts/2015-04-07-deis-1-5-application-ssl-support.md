---
layout: post
title: "Deis v1.5 - Application SSL Support"
author: bacongobbler
meta:
  - name: description
    content: Deis releases v1.5 with app SSL support and many new features.
  - name: keywords
    content: deis, release, v1.5, stable, production, production-ready, paas, private paas, heroku, github, docker, coreos, enterprise
---

The Deis project is stoked to announce [v1.5.0](https://github.com/deis/deis/releases/tag/v1.5.0), with application SSL support, a platform-wide log drain, the ability to use buildpacks from private repositories, and more.

<!--more-->

If you are coming from an earlier version of Deis, please read the ["Upgrading Deis"](http://docs.deis.io/en/latest/managing_deis/upgrading-deis/) documentation for details.

## What is Deis?

Deis is an open source PaaS that makes it easy to deploy and manage applications on your own servers. Deis builds upon [Docker](http://docker.io/) and [CoreOS](https://coreos.com/) to provide a lightweight PaaS with a Heroku-inspired workflow.

## 1.5.0 Summary

### New Features

 - you can now [attach SSL certificates](http://docs.deis.io/en/latest/using_deis/app-ssl) to your applications!
 - the deis client now utilizes a [plugin architecture](https://github.com/deis/deis/pull/3177)
 - `deis config:push` has been added
 - `deis git:remote` has been added
 - the `--username`, `--password` and `--yes` flags have been added to `deis auth:cancel`
 - [private repository support](http://docs.deis.io/en/latest/using_deis/using-buildpacks/#using-private-repositories) has been added to the builder
 - a [platform-wide log drain](http://docs.deis.io/en/latest/managing_deis/platform_logging/#application-log-drain) has been added
 - [multiple profile support](https://github.com/deis/deis/pull/3367) has been added to the client
 - LDAP support has been added to the controller
 - `xip.io` domains are now allowed with `deis domains:add`

### Improvements

 - our test infrastructure now deploys on EC2, providing test functionality to EC2 changes
 - the integration tests can now run in parallel on https://ci.deis.io
 - the database now commences a recovery if it is started with stale data
 - cleaned up some errors in the builder
 - the client now properly reads the response from `deis auth:cancel`
 - the EC2 contrib scripts now loop until all instances have passed their health checks
 - CORS whitelisted headers have been updated
 - `btrfs` has been replaced with `overlayfs` in the latest version of CoreOS
 - the controller now ignores etcd "key missing" errors when deleting resources

### Under the Hood

 - bumped CoreOS to 607.0.0
 - bumped Docker to 1.5.0
 - bumped `confd` to v0.8.0 in components to use the new `--watch` flag
 - bumped heroku-buildpack-ruby to v134
 - bumped fleet to v0.9.2
 - bumped python requests lib to 2.5.1
 - bumped gunicorn to 19.3.0
 - bumped python-dateutil to 2.4.1
 - bumped Sphinx to 1.3.1
 - bumped Django to 1.6.11 security release

For more details, please see [CHANGELOG.md](https://github.com/deis/deis/blob/master/CHANGELOG.md).


## What's Next

### Improved Test Infrastructure

We need to speed up test suites, eliminate the PR build queue, and increase test coverage to include operational aspects such as upgrades and HA. Hard work behind the scenes and invaluable community support are steadily improving the Deis test infrastructure.

### New Container Scheduler

Application containers require a resource-aware scheduler to improve cluster efficiency at scale and to alleviate issues with [cluster balancing after the loss of a node](https://github.com/deis/deis/issues/2920). Prototyping is well underway with [Swarm](https://github.com/deis/deis/pull/3134) and [Kubernetes](https://github.com/deis/deis/issues/2744).

Deis will continue to support [fleet](https://github.com/coreos/fleet) for both control plane and data plane scheduling for the foreseeable future.


## Community Shout-Outs

We want to thank the following Deis community members for creating GitHub issues,
providing support to others, and working on various Deis branches:

- @a-saad: Command 'run' fails when using a non-standard SSH port, feat(client): Add multiple profile support to the client
- @aledbf: bug(controller): If is not possible to access etcd it should fail with an error, Proposal ref(builder): do not build slugbuilder and slugrunner locally, bug(test): during the test if the user app is stopped it continues running, Proposal chore(scripts): use shellcheck to verify shell scripts, Proposal feat(controller): allow deis pull from deis-registry, Proposal feat(controller): add fine-grain scheduling policy, bug(database): wal-e rewrote backup, Proposal ref(database): remove data container, bug(deisctl): list should not show apps with the pattern name ^deis-*, Proposal feat(cli): check the specified url before any command, Proposal ref(store): make ceph optional if the node is running in aws or azure, fix(publisher): use TTL in services application etcd directories, Proposal ref(Makefile): remove verbose golang compilation flag, fix(builder): return error message as string, feat(controller): disable swap usage if there is a memory limit, feat(test): remove hardcoded names. Extract journal logs from each app, feat(cloud-init): temporal fix for ntpd error and clock skew, Proposal ref(store): remove apache2 from ceph gateway, feat(setup-node.sh): remove user intervention setting up new nodes, feat(publisher): remove application when is stopped, feat(makefile): check that generated go binaries are statically linked, fix(router): allow customization of connection limits, fix(store): abort build in case of any error
- @apps4u: multi tenancy proposal
- @azurewraith: deis tags per process type, deis limits:set not persistent after upgrade
- @chrisgeo: Azure Deployment Script Error: "WindowsAzureMissingResourceError"
- @CptJason: Error response from daemon: No such container: deis-logspout
- @croemmich: (builder) Can't set task name /dev/mapper/docker-202:25-3667816-pool, feat(router): set additional X-Forwarded headers
- @daanemanz: feat(contrib/ec2/gen-json.py): split private and public subnets
- @diddeb: Private key file is encrypted
- @dylanz: Orphaned bridge interfaces w/ Docker, Customizing Controller domain, ELB healthchecks failing, Gateway & Builder restarts: All the given peers are not reachable, 503's from nginx
- @elepedus: Docs: revise deisctl installation instructions
- @gahissy: Domain name validation: w3.domain.com
- @ghostbar: Save into a different remote name when deis remote already exists
- @glogiotatidis: Controller Web: NoReverseMatch: u'rest_framework' is not a registered namespace, Controller: Domain remove, removes always the latest domain, fix(docs): Fix heroku-buildpack-php url, docs(contrib): Add deis-backup-service, fix(client): Older dates are incorrectly parsed as today and yesterday., fix(docs): Starting store-gateway needs @1.
- @gvilarino: bug(services) deis apps:destroy doesn't delete root directory, database silently failing, killing controller, fix(azure): add support for Azure affinity groups
- @haf: Failed retrieving config from controller (nodejs), Consider adding mono sample, How to handle large images?, Deis detects albacore as ruby app, Different behaviour between plain docker and git+Dockerfile, Deis cmd-line util: using SSL for self-signed certs --verify-ssl=false for all, Router: Serve content on example.com?, Security: open port for PostgreSQL with default script, Can't start a failed unit easily, Error from Etcd on full disk (crash and burn-mode), Docs on bootstrapping clusters?, Docs on using Deis to locally develop dockerfiles?, How to interact with the storage layer?, Can I extract time-series data easily from the platform?, Docs on etcd interaction?, How do I deploy a "resource" in 12-FA vocab?, Update docs' debugging of ceph in vagrant, fixes #3221 - service file surviving hard resets
- @hellojustin: deis-store-* stuck in auto-restart loop after EC2 AutoScaling (Deis 1.3.0)
- @hhff: Best Practices for Staging Environment
- @ianblenke: PV clock drift causes more ceph havok, Unresponsive CoreOS 607 instance, Spontaneous kernel reboot, btrfs panics on 557.2.0, Submodules support without .git, Request: `deis auth:passwd` takes --user argument for admins to change user passwords, ssh key issue when using travis-ci/dpl deis deploy
- @ineu: deis run should escape commands, deis run: Authentication failed, login and register hangs, ref(security): REJECT target uses port-unreachable
- @joshmackey: If buildpack crashes, deis-builder won't accept any new pushes.
- @Joshua-Anderson: deisctl not installing cache, fix(controller): Update CORS whitelisted request headers.
- @jwaldrip: Unable to Delete Application
- @kgk: change domain name and gateway fails to restart
- @klaussilveira: Add command to rebuild app
- @krancour: docs(logger): change incorrect ref to db component
- @lorieri: naxsi rules included twice
- @mikkoc: adding VMs to GCE cluster
- @nathansamson: Deis builder should do best effort to keep git checkout, Deis limits isn't as forgiving as it could be
- @Natsuke: deis-store-daemon: auto-restart, Builder: waiting for confd
- @ngerakines: Setting a configuration value prevents further application pushes
- @ngpestelos: deis-builder: git repositories persistence, chore(Makefile): bump dev-registry to use 0.9.1
- @olalonde: Follow logs with deis logs?, 'Container type {} does not exist in application'.format(container_type)), Deis: minimal installation to reduce AWS cost, Docs: comparison with Flynn?, EC2 install: what are the volumes used for?, "Convenience DNS" to SSH into CoreOS cluster?, "failed retrieving config from controller" when pushing new Node.js project, Failed getting response from http://127.0.0.1:4001/: ssh: rejected: connect failed (Connection refused), ec2 setup cluster error: ImportError: No module named yaml, Question: going from docker-compose (fig) to deis?
- @onbjerg: Cannot register (controller not found), Installing Deis on DigitalOcean prompts password
- @phspagiari: feat(controller): Adding LDAP/AD auth support, Docs: Missing note for Vagrant users
- @PierreKircher: proposal renaming of the clients, fix(contrib): preseed all images
- @pjvds: feat(controller): add deis ps:stop command
- @rjocoleman: Proposal: Platform-wide log drain
- @romansergey: fix(database): Commence recovery if database is started with stale data container
- @rvaralda: feat(builder): add ssh key variable to support private repositories, feat(deis client): add ssl-verify parameter to deis register command
- @sitya: Container cannot start if etcd does not listen on 127.0.0.1 address
- @wenzowski: should ssl endpoint docs explain how to get a signed cert?, Deis apps:destroy does not remove the git repo with the same name, redirect loop when enforceHTTPS is enabled on 1.4.1, feat(router): add optional query string affinity support, feat(docs): gcutil is deprecated; convert all calls to gcloud compute, feat(router): avoid regex-based taxing rewrites, fix(router) enforce HTTPS correctly when not behind an elb, fix(docker): wait for drive formatting to complete before mounting
- @zyxia:  All the given peers are not reachable (Tried to connect to each peer twice and failed)

The Deis community continues to grow, and Deis wouldn't be here without you! If we slighted your contribution to this release, please let us know so we can update.


## How can you help?

* Star our [GitHub repository](https://github.com/deis/deis)
* Help spread the word about [@opendeis](http://twitter.com/opendeis) on Twitter
* Join the conversation in the [#deis channel](https://botbot.me/freenode/deis/) on Freenode
* Pick an [easy-fix](https://github.com/deis/deis/labels/easy-fix) or [help wanted](https://github.com/deis/deis/labels/help%20wanted) issue and start contributing!

Learn about other ways to [get involved](http://deis.io/get-involved/) on our website.
