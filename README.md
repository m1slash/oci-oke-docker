## oci-oke-docker

OKE - Oracle Cloud Infrastructure CLI and Kubernetes CLI in a Container

Docker container with [OCI CLI](https://github.com/oracle/oci-cli) and Kubernetes CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)  pre-installed to run the CLIs in an isolated environment.

### Usage

```
$ docker run \
	-it --name oci-oke-cli \
	-v ${HOME}/.oci:/root/.oci \
	-v ${HOME}/.kube:/root/.kube \
	mislas87/oci-oke-cli:0.1.0 -h
```

or, override the entrypoint and run Bash in the container

```
$ docker run \
	--rm -it --name oci-oke-cli \
	-v ${HOME}/.oci:/root/.oci \
	-v ${HOME}/.kube:/root/.kube \
	--entrypoint bash mislas87/oci-oke-cli:0.1.0
```

I use [this prject](https://github.com/jpoon/oci-cli-docker) as base.
