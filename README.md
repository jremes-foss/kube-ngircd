# ngIRCd Kubernetes Deployment

This is a Kubernetes deployment file for nIRCd server.

## Requirements

To install this software into your Kubernetes cluster, you need the following:

- Any Linux or compatible operating system
- [kubectl](https://kubernetes.io/docs/reference/kubectl/)

To install the server locally, you need a local Kubernetes cluster such as [Minikube](https://minikube.sigs.k8s.io/docs/start/).

## Installation

First, download the repository:

```bash
git clone https://github.com/jremes-foss/kube-nIRCd.git
```

Then, browse into cloned folder. Manifests are in `kube` sub-folder. In this folder, you should apply the Kubernetes manifests in the following order:

* Namespace
* Service

After that, deploy the Kubernetes manifests.

## Technical specifications

This stack is powered by the following software.

- Operating System: Alpine Linux 3.18
- IRC server: ngIRCd 26.1

## Configuration

Operators (IRC server administrators) must be configured manually. I have automated this process with `makeoperator.sh` shell script. This script takes the operator nick as first positional argument and then automatically generates a password with `uuidgen` binary. If you want to log in as operator, read the password from `ngircd.conf` file and then type in your IRC client after logging to server:

```
/oper nick password
```

This elevates your privileges to operator.
