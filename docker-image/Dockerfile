FROM ubuntu:16.04
MAINTAINER Harrys <xarhsasi@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV USER user
ENV HOME /home/$USER

# Create new user for jupyter authentication
RUN adduser $USER --disabled-password 

# Install dependencies
RUN apt-get update \
	&& apt-get install -y \
	locales \
	supervisor \
	software-properties-common \
	openssh-client openssh-server \
	net-tools \
	pwgen \
	apt-utils \
	curl \
	procps \
	less \
	vim \
	nano \
	wget \
	ca-certificates \
	apt-transport-https \
	gnupg2 \
	sshfs \
    unzip \
	autoconf automake make dnsutils bash \
	bash-completion coreutils nmap openssl passwd sudo \
	iproute2 iputils-ping \
	git-core python-setuptools \
	&& apt-get install -y -f apache2 \
	&& apt-get autoclean \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

# Configure default locale, see https://github.com/rocker-org/rocker/issues/19

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
        && locale-gen en_US.utf8 \
        && /usr/sbin/update-locale LANG=en_US.UTF-8


ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

#mkdir for user
RUN mkdir -p /home/user/project && chown -R user.user /home/user/project

#Add the dependencies in a different file called tensorflow.yml
ADD tensorflow.yml .
WORKDIR /

# Common, note that two updates are needed
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata software-properties-common git vim wget libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' >> /root/.bashrc && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

#Tensorflow and dependencies
RUN conda install pip jupyter ipyparallel && \
    conda env create -v -f tensorflow.yml && \ 
    conda init bash && \
    rm -rf /var/lib/apt/lists/*

RUN rm tensorflow.yml && \
    activate tensorflow  && \
    /opt/conda/envs/tensorflow/bin/python -m ipykernel install --user --name tensorflow --display-name "Python 3.7 (tensorflow)"  && \
    rm -rf /var/lib/apt/lists/*

# Reinforcement learning
RUN apt update  && \
    apt install -y xvfb ffmpeg  && \
    /opt/conda/envs/tensorflow/bin/pip install 'gym==0.10.11' 'imageio==2.4.0' PILLOW 'pyglet==1.3.2' pyvirtualdisplay && \
    /opt/conda/envs/tensorflow/bin/pip install --upgrade tensorflow-probability && \
    /opt/conda/envs/tensorflow/bin/pip install tf-agents  && \
    rm -rf /var/lib/apt/lists/* 


# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends fonts-dejavu gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# R
RUN apt-get update && \
    apt-get install -y r-base && \
    conda install -c r r-irkernel r-essentials -c conda-forge && \
    rm -rf /var/lib/apt/lists/*

COPY packages.r .

RUN ln -s /bin/tar /bin/gtar && \
    Rscript packages.r && \
    rm -rf packages.r 

# Java
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update || true

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk java-common && \
    apt-get install -y ant && \
    apt-get clean

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

RUN apt-get update && \
    conda install -c conda-forge openjdk && \
    rm -rf /var/lib/apt/lists/*

# Install and setup the required package for the java execution (Jupyter notebook requires it)
RUN wget https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip && \
    unzip ijava-1.3.0.zip && \
    python3 install.py --sys-prefix

# Remove installation files
RUN rm -rf ijava-1.3.0.zip && \
    rm -rf install.py && \
    rm -rf java

# Install PHP
RUN apt-get update && apt-get install -yq --no-install-recommends \
    php-cli php-dev php-pear \
    pkg-config \
    gcc \
    g++ \
    build-essential \
    && apt-get clean

# install php dependencies
RUN wget https://github.com/zeromq/zeromq4-1/releases/download/v4.1.5/zeromq-4.1.5.tar.gz && \
    tar -xvf zeromq-4.1.5.tar.gz && \
    cd zeromq-* && \
    ./configure && make && make install && \
    printf "\n" | pecl install zmq-beta && \
    echo "extension=zmq.so" > /etc/php/7.0/cli/conf.d/zmq.ini

# install PHP composer
RUN wget https://getcomposer.org/installer -O composer-setup.php && \
    wget https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.phar && \
    php composer-setup.php && \
    php ./jupyter-php-installer.phar -vvv install && \
    mv composer.phar /usr/local/bin/composer && \
    rm -rf zeromq-* jupyter-php* && \
    rm composer-setup.php


# install nodejs
WORKDIR /tmp
RUN wget https://nodejs.org/download/release/v0.12.9/node-v0.12.9-linux-x64.tar.gz
RUN tar xzf node-v0.12.9-linux-x64.tar.gz
RUN sudo cp -rp node-v0.12.9-linux-x64 /usr/local/
RUN sudo ln -s /usr/local/node-v0.12.9-linux-x64 /usr/local/node
ENV PATH /usr/local/node/bin:$PATH

RUN mkdir -p  $HOME/.ipython/kernels/nodejs
RUN wget https://github.com/notablemind/jupyter-nodejs/releases/download/v1.1.0/jupyter-nodejs-1.1.0.tgz
RUN tar xf jupyter-nodejs-1.1.0.tgz
WORKDIR /tmp/package
RUN npm install && node install.js  

#Install Matlab
RUN pip install matlab_kernel
RUN python -m matlab_kernel install

RUN ipcluster nbextension enable
RUN ipcluster start --profile=mycluster --n=4 --daemonize
RUN conda install -c conda-forge ipyparallel
WORKDIR /root

RUN pip install -U jupyter_console


#Exposed ports
EXPOSE 8888

#Start the jupyter notebook
CMD ["sh", "-c", "jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.quit_button=False --NotebookApp.allow_origin='*'"]
