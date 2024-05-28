# ngIRCd Kubernetes Deployment

> Level up your small IRC network: Deploy it on Kubernetes.

This is a [Kubernetes](https://kubernetes.io/) deployment repository for [ngIRCd](https://github.com/ngircd/ngircd) server.

## Description

This repository provides a Kubernetes deployment for running a scalable and secure ngIRCd server, ideal for hobbyists and businesses. ngIRCd is a popular Open Source [IRC](https://en.wikipedia.org/wiki/IRC) server daemon know for its stability and modular design.

This repository caters to users who want to:

- Set up a private IRC server for their community or group.
- Explore ngIRCd administration in a Kubernetes environment.
- Learn about deploying applications on Kubernetes.

## Requirements

To install this software into your Kubernetes cluster, you need the following:

- Any Linux or compatible operating system such as [FreeBSD](https://www.freebsd.org/).
- [kubectl](https://kubernetes.io/docs/reference/kubectl/).

To install the server locally, you need a local Kubernetes cluster such as [Minikube](https://minikube.sigs.k8s.io/docs/start/). Otherwise, you can use any remote context you may have at your disposal.

For development purposes, you need container orchestration tool such as [Podman](https://podman.io/) or Docker.

## Installation

First, download the repository:

```bash
git clone https://github.com/jremes-foss/kube-ngIRCd.git
```

Then, browse into cloned folder. Manifests are in `kube` sub-folder. In this folder, you should apply the Kubernetes manifests in the following order:

* Namespace
* Service
* Deployment

For namespace, please use following syntax below:

```bash
kubectl -n namespace-here apply -f ngircd-namespace.yml
```

For service:

```bash
kubectl -n namespace-here apply -f ngircd-service.yml
```

For deployment:

```bash
kubectl -n namespace-here apply -f ngircd-deployment.yml
```

`Dockerfile` is provided in case you wish to provide your own image. Please tag and upload the image to remote repository and change the URL. Link to default ngIRCd image is [here](https://hub.docker.com/r/jremesfoss/ngircd). This ngIRCd image is maintained as part of the repository.

## Technical specifications

This stack is powered by the following software.

- Operating System: [Alpine Linux 3.18](https://www.alpinelinux.org/)
- IRC server: [ngIRCd 26.1](https://github.com/ngircd/ngircd)

## Configuration

Main configuration is in `ngircd.conf` which sets the default parameters. This file is part of the `Dockerfile`. Initially the deployment is configured to use ClusterPort, with `6667/tcp` as a default setting.

### Operator Configuration

Operators (IRC server administrators) must be configured manually. I have automated this process with `makeoperator.sh` shell script. This script takes the operator nick as first positional argument and then automatically generates a password with `uuidgen` binary. Example below:

```bash
./makeoperator.sh administrator
```

### Elevate Privileges to Operator

If you want to log in as operator, read the password from `ngircd.conf` configuration file and then type in your IRC client after logging to server:

```
/oper nick password
```

This elevates your privileges to operator.

## Connecting from Localhost

Currently, the way to access the IRC server via client is through port-forwarding. Ingress to access the server directly via ingress will be added in later iteration.

### Port Forwarding

In order to gain access to port forwarding, use the following kubectl syntax:

```bash
kubectl port-forward pods/pod-here local-port:target-port
```

Alternatively, you may let kubectl to choose and allocate the local port:

```bash
kubectl port-forward pods/pod-here :target-port
```

### Acess from Outside Cluster

In order to connect to the server from outside the cluster, you need to expose the service.

```bash
kubectl -n ngircd expose deployment ngircd --port=6667 --target-port=6667 --type=NodePort --name=ngircd-svc
```

## License

This project is licensed under the [MIT License](https://opensource.org/license/mit), please see the LICENSE file for details.

The MIT License is a permissive open-source license that allows for for-profit and non-profit use, redistribution, and modification of the software. By contributing to this project, you agree to the terms of the MIT License.
