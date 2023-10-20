# Build an "image": docker build -t roman-sn-pipeline .
# Build (and enter) container: docker run -it roman-sn-pipeline
FROM condaforge/mambaforge:23.3.1-1 as conda

WORKDIR /pipeline

COPY env.yaml .
RUN mamba env create -n pipeline --file env.yaml

COPY program.py startup.bash ./

RUN echo "conda activate pipeline" >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

#oh, these are used with "docker run" not "docker build"
# ENTRYPOINT ["./startup.bash"]
# CMD ["bash", "./startup.bash"]
