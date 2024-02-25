# ngIRCd Kubernetes Deployment

This is a Kubernetes deployment repository for [ngIRCd](https://github.com/ngircd/ngircd) server.

## Requirements

To install this software into your Kubernetes cluster, you need the following:

- Any Linux or compatible operating system
- [kubectl](https://kubernetes.io/docs/reference/kubectl/)

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

Syntax below:

```bash
kubectl -n namespace-here apply -f namespace.yml
```

For service:

```bash
kubectl -n namespace-here apply -f ircd-service.yml
```

For deployment:

```bash
kubectl -n namespace-here apply -f ircd-deployment.yml
```

`Dockerfile` is provided in case you wish to provide your own image. Please tag and upload the image to remote repository and change the URL. Link to default ngIRCd image is [here](https://hub.docker.com/r/jremesfoss/ngircd).

## Technical specifications

This stack is powered by the following software.

- Operating System: [Alpine Linux 3.18](https://www.alpinelinux.org/)
- IRC server: [ngIRCd 26.1](https://github.com/ngircd/ngircd)

## Configuration

### Operator Configuration

Operators (IRC server administrators) must be configured manually. I have automated this process with `makeoperator.sh` shell script. This script takes the operator nick as first positional argument and then automatically generates a password with `uuidgen` binary. Example below:

```bash
./makeoperator.sh administrator
```

### Elevate Privileges to Operator

If you want to log in as operator, read the password from `ngircd.conf` file and then type in your IRC client after logging to server:

```
/oper nick password
```

This elevates your privileges to operator.
