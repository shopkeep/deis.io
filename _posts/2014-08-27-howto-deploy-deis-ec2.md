---
layout: post
title: "HOWTO: Deploy Deis on EC2"
author: bacongobbler
meta:
  - name: description
    content: Matthew demonstrates how he deploys a Deis cluster on EC2
  - name: keywords
    content: deis, cluster, ec2, coreos, fleet, ssl
---

I recently deployed https://deis.fishworks.io on EC2, so I thought a blog post on how I
configured the cluster may be useful to some users. The process here is mostly to do with
EC2, but it can apply to any public/private cloud provider. Alternatively, you can roll
your own CoreOS cluster with VMWare, QEMU, or though some other supported platform in
[their documentation](https://coreos.com/docs/).

<!--more-->

There are some prerequisites to this blog post before deploying a cluster:

- you must have an account on EC2
- you must have a wildcard SSL certificate for your cluster

I purchased my RapidSSL wildcard cert through [Namecheap](https://www.namecheap.com/), but
feel free to use whatever means you prefer.

To get started, let's provision a new cluster on EC2. Following the [EC2 docs](https://github.com/deis/deis/blob/master/contrib/ec2/README.md):

    ><> aws configure
    AWS Access Key ID [None]: ***************
    AWS Secret Access Key [None]: ************************
    Default region name [None]: us-west-1
    Default output format [None]:

Next, we need to upload an SSH key so we can communicate with the CoreOS cluster though an
SSH tunnel. When I uploaded my SSH keypair, instead of generating a new key and uploading
that to EC2, I uploaded the key I already use on EC2 with the id "deis":

    aws ec2 import-key-pair --key-name deis --public-key-material file://~/.ssh/id_rsa.pub

Next up is to configure fleetctl, as well as some cluster configuration:

    ><> cat ~/.awsrc
    export DEIS_NUM_INSTANCES=3
    export DEIS_NUM_ROUTERS=3
    export DEIS_HOSTS="deis-1.fishworks.io deis-2.fishworks.io deis-3.fishworks.io"
    export FLEETCTL_TUNNEL="deis-1.fishworks.io"

To explain what these environment variables represent:

- DEIS_NUM_INSTANCES refers to how many nodes in the cluster you wish to provision.

- DEIS_NUM_ROUTERS refers to the number of routers to install in the cluster. 3 should be
  more than enough for our needs.

- DEIS_HOSTS refers to the hosts in the cluster. This environment variable is used for
  commands like `make pull` or `make build`. We will create the A records for these nodes
  once they come online.

- FLEETCTL_TUNNEL is the host you'll be connecting to communicate to the fleet cluster.
  More information can be found [here][fleetctl-remote].

Now that we have them all set, let's provision a CoreOS cluster:

    ><> cd contrib/ec2
    ><> # edit ../coreos/user-data and add a new discovery url
    ><> vim ../coreos/user-data
    ><> ./provision-ec2-cluster.sh
    {
        "StackId": "arn:aws:cloudformation:us-west-1:413516094235:stack/deis/9699ec20-c257-11e3-99eb-50fa01cd4496"
    }
    Your Deis cluster has successfully deployed.
    Please wait for all instances to come up as "running" before continuing.

Once we've finished provisioning the cluster, we can now add the DNS entries. For Deis, it
requires that you use a wildcard sumdomain for applications. When we provisioned the
cluster, we were also provided with an Elastic Load Balancer which points to the three
nodes in the cluster. Start by creating a CNAME record for the wildcard DNS:

    ><> dig asdf.fishworks.io
    ;; ANSWER SECTION:
    asdf.fishworks.io.  1799    IN  CNAME   deis-DeisWebELB-1AIX9O3SXCLR4-1138261946.us-west-1.elb.amazonaws.com.
    deis-DeisWebELB-1AIX9O3SXCLR4-1138261946.us-west-1.elb.amazonaws.com. 59 IN A 54.193.19.155
    deis-DeisWebELB-1AIX9O3SXCLR4-1138261946.us-west-1.elb.amazonaws.com. 59 IN A 54.183.181.125

Then, we can create A records for the CoreOS nodes:

    ><> dig deis-1.fishworks.io
    ;; ANSWER SECTION:
    deis-1.fishworks.io.    1799    IN  A   54.183.194.76

Once we're done with that, let's configure the load balancer to use SSL. We don't want to
be sending our login credentials in plain text! We'll tell the load balancer to forward
all HTTPS requests to port 80 on the routers. I kept the HTTP listener because I still
want my apps to be able to connect via HTTP.

![load balancer listener config](/assets/img/deis-on-ec2-listeners.png)

Then, you'll want to open up port 443 on the load balancer. This is done by editing the
security group settings for the load balancer:

![load balancer security group settings](/assets/img/deis-on-ec2-secgroup-settings.png)

Now we can deploy Deis.

    ><> source ~/.awsrc
    ><> cd ../..
    ><> make pull run

This will pull all of the Deis components onto the cluster and then start the components.
`make pull` is optional, but it is nice to pull the images first and make sure that they
are pulled into the cluster (in case of DockerHub downtime).

Once that's done, you can start by creating your first user!

    ><> deis register https://deis.fishworks.io
    username: bacongobbler
    password:
    password (confirm):
    email: matthewf@opdemand.com
    Registered bacongobbler
    Logged in as bacongobbler

Once you're finished with creating all the users that you wish, you can disable
registration. This will prevent others from registering new accounts:

    ><> ssh core@deis-1.fishworks.io
    core@ip-10-21-1-79 ~ $ etcdctl set /deis/controller/registrationEnabled 0
    0
    core@ip-10-21-1-79 ~ $ fleetctl stop deis-controller
    core@ip-10-21-1-79 ~ $ fleetctl start deis-controller

And there you have it! One Deis cluster on EC2, ready to go. If you have any more
questions or comments on this post, please feel free to contact me, or open a
[pull request](https://github.com/deis/deis.io)!


[fleetctl-remote]: https://github.com/coreos/fleet/blob/master/Documentation/using-the-client.md#from-an-external-host
