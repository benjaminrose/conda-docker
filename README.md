# Conda/Mamba Docker


## Usage 

Build an "image": 
```
docker build -t roman-sn-pipeline.
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
