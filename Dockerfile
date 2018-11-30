#FROM debian:latest
FROM ubuntu:18.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git gunicorn libgl1-mesa-glx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ADD . /myapp

WORKDIR /myapp
ADD requirements.txt /myapp/requirements.txt
ADD conda-requirements.txt /myapp/conda-requirements.txt

RUN conda install --file /myapp/conda-requirements.txt --yes --channel conda-forge
RUN pip install -r /myapp/requirements.txt


CMD ["gunicorn", "-b","0.0.0.0:8080", "app:server", "-t", "3600"]

# For Google compute engine
#CMD exec gunicorn -b :$PORT main:server --timeout 1800
