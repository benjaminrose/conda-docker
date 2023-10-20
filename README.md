# Conda/Mamba Docker


## Usage 

Build an "image": 
```
docker build -t roman-sn-pipeline .
```
Note any name ( currently `roman-sn-pipeline` is used) can be given to the image.

Build (and enter) container: 
```
docker run -it roman-sn-pipeline
```
You need to use the same name (this example uses `roman-sn-pipeline`) as the image you want to run. This sample does not name the container, but you may want to.


## Dockerfile

Here is some documentation around the `Dockerfile`.

- Build off of the conda-forge container that has both `conda` and `mamba`.
- Set up the docker to work from `/pipeline` rather then `/`.
- The next two lines (COPY & RUN) set up the `conda` environment defined in `env.yaml`.
- The next two lines (RUN & SHELL), modify the login scripts to automatically activate the previously created `conda` environment.
- The COPY line moves all other files to the container. If the program gets more files, it might be worth changing this to `COPY . .`, or adding a volume attachment.
- The final two lines (commented out ENTRYPOINT & CMD) are two possible (untested) ways of running the startup.bash script that can further set up the environment upon login. This would be a place to handle content similar to SNANA's `sourceme` files.


## Other files

Here is a basic description of the other files in this folder.

- `env.yaml` - A `conda` environment file for this project. Note that the environment is named in the `Dockerfile` and this name is not being used by `mamba`.
- `setup.bash` - A blank bash script that could be used like SNANA `sourceme`s to hold group level terminal setup information.
- `program.py` - A basic `python` program that proves you can import external packages that were installed via conda-forge.


# Pushing a new image to Docker Hub

```
❯ docker login
...

❯ docker build -t roman-sn-pipeline .
[+] Building 0.3s (11/11) FINISHED                                                                             docker:orbstack
 => [internal] load build definition from Dockerfile                                                                      0.0s
 => => transferring dockerfile: 531B                                                                                      0.0s
 => [internal] load .dockerignore                                                                                         0.0s
 => => transferring context: 2B                                                                                           0.0s
 => [internal] load metadata for docker.io/condaforge/mambaforge:23.3.1-1                                                 0.3s
 => [1/6] FROM docker.io/condaforge/mambaforge:23.3.1-1@sha256:061c34feaa4cbc7cd3ec0ed922b403e4fb17e89481622a0c55f278142  0.0s
 => [internal] load build context                                                                                         0.0s
 => => transferring context: 126B                                                                                         0.0s
 => CACHED [2/6] WORKDIR /pipeline                                                                                        0.0s
 => CACHED [3/6] COPY env.yaml .                                                                                          0.0s
 => CACHED [4/6] RUN mamba env create -n pipeline --file env.yaml                                                         0.0s
 => CACHED [5/6] RUN echo "conda activate pipeline" >> ~/.bashrc                                                          0.0s
 => CACHED [6/6] COPY program.py startup.bash ./                                                                          0.0s
 => exporting to image                                                                                                    0.0s
 => => exporting layers                                                                                                   0.0s
 => => writing image sha256:a268c390405f9bdb7ff6288e131d597cda8a9fbd96ae0a913b006a242fd40c2c                              0.0s
 => => naming to docker.io/library/conda-docker                                                                           0.0s

❯ docker images
REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
roman-sn-pipeline   latest    a268c390405f   10 minutes ago   897MB
conda-docker        latest    a268c390405f   10 minutes ago   897MB

mambaforge on  main [!] via 🐳 orbstack via 🐍 v3.10.12
❯ docker tag conda-docker:latest benjaminrose/conda-docker:latest

mambaforge on  main [!] via 🐳 orbstack via 🐍 v3.10.12
❯ docker images
REPOSITORY                  TAG       IMAGE ID       CREATED          SIZE
roman-sn-pipeline           latest    a268c390405f   11 minutes ago   897MB
benjaminrose/conda-docker   latest    a268c390405f   11 minutes ago   897MB
conda-docker                latest    a268c390405f   11 minutes ago   897MB

mambaforge on  main [!] via 🐳 orbstack via 🐍 v3.10.12
❯ docker push benjaminrose/conda-docker
Using default tag: latest
The push refers to repository [docker.io/benjaminrose/conda-docker]
a0968d8f6491: Pushed
fe4a4d213726: Pushed
d5ebdb18e2c8: Pushed
c152647787ab: Pushed
9d67dbb3fb55: Pushed
68d51f9a0898: Pushed
701ccb11c052: Pushed
latest: digest: sha256:e6da0e43fb36ddd7a226203c74d0cf6d8f20ce8fb7df744da6077f736ee8fc0f size: 1783
```
