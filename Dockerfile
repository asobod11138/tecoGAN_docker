FROM nvidia/cudagl:10.0-runtime-ubuntu18.04

# meta data
LABEL Maintainer="Mano <mano@aisl.cs.tut.ac.jp>"
LABEL Base = "nvidia/cudagl:10.0-runtime-ubuntu16.04 \
              6buntu18.04, CUDA10.0, OpenGL(glvnd1.0) "
LABEL Description="Customized ROS melodic for koide3/monocular_person_following to use for Robocup2019 on Ubuntu 18.04"
LABEL Version="0.1"

################# Update system ##########################3
RUN apt update -y
RUN apt upgrade -y
RUN apt install git -y

############ git clone ##################3
WORKDIR /root
RUN git clone https://github.com/thunil/TecoGAN.git
WORKDIR TecoGAN

############## tenosorflow ###################################
RUN apt update -y
RUN apt install python3-pip -y
RUN pip3 install --ignore-installed --upgrade tensorflow-gpu
RUN pip3 install -r requirements.txt

RUN apt update\
    && apt install -y \
    wget \
    unzip
############### install cuDN ###################
COPY data /root/tmp
WORKDIR /root/tmp
RUN dpkg -i *deb

# vim setting(option for edit programs)
WORKDIR /root/
#COPY .vimrc /root/
#RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# git settings
RUN git config --global user.name "mano"
RUN git config --global user.email "mano@aisl.cs.tut.ac.jp"

####### rm TecoGAN ########3
WORKDIR /root
RUN rm -rf TecoGAN

############### install some tools ###################
RUN apt update\
    && apt install -y \
    curl \
    vim \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*


