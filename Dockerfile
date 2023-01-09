FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
#FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu16.04

WORKDIR /research
RUN apt-get update



RUN apt install -y  build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
RUN wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz && \
    tar -xf Python-3.8.0.tgz && \
    cd Python-3.8.0 && \
    ./configure --enable-optimizations && \
    make -j 8 && \
    make altinstall

ENV HOME /research
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

#RUN apt-get install -y python-setuptools
RUN apt-get install -y  virtualenv htop

RUN pip3.8 install virtualenv
RUN pip3.8 install virtualenvwrapper
RUN python3.8 -m pip install pip==22.3.1
RUN pip3.8 install numpy scipy sklearn tf-nightly-gpu

#Mount data into the docker
ADD . /research/reinforcement
WORKDIR /research/reinforcement
# RUN /bin/bash env_setup.sh

#RUN pip3 install "tensorflow-gpu>=1.5,<1.6"

ENTRYPOINT ["/bin/bash"]
