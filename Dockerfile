FROM continuumio/miniconda3
RUN conda create -n work python=3.6.6 -y
RUN echo "source activate work " > ~/.bashrc
ENV PATH /opt/conda/envs/work/bin:$PATH

RUN mkdir /app
#COPY ./requirements.txt /app/
WORKDIR /app

RUN pip --version
RUN . /opt/conda/etc/profile.d/conda.sh && \
 conda activate work && \
 #conda install -c dansondergaard tmhmm.py  -y && \
 conda install -c bioconda hmmer -y && \
 conda install -c bioconda  wkhtmltopdf -y && \
 conda install -c plotly plotly=3.10.0   -y && \
 conda install -c conda-forge zip -y && \
 conda install -c bioconda cd-hit -y && \
 conda install -c anaconda psutil -y && \
 conda install -c plotly plotly-orca -y && \
 conda install -c conda-forge poppler -y && \
 pip install numpy && \
 pip install django && \
 pip install django-chartjs && \
 pip install biopython && \
 pip install selenium && \
 pip install bs4 && \
 pip install pdfkit && \
 pip install matplotlib && \
 pip install scipy && \
 pip install imgkit && \
 pip install psutil && \
 pip install pandas && \
 pip install Celery


#RUN  apt-get install -y wkhtmltopdf  
RUN apt-get install -y  poppler-utils
# Setup the webdriver
RUN apt-get update && apt-get install -y firefox-esr 
RUN cd /usr/local/bin && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz && \
    tar -xzf geckodriver-v0.24.0-linux64.tar.gz


# Plotly depedencies
RUN apt-get install -y --no-install-recommends \
        wget \
        xvfb \
        libgtk2.0-0 \
        libxtst6 \
        libxss1 \
        libgconf-2-4 \
        libnss3 \
        libasound2 
     #mkdir -p /home/orca && \
     #cd /home/orca && \
     #wget https://github.com/plotly/orca/releases/download/v1.2.1/orca-1.2.1-x86_64.AppImage && \
     #chmod +x orca-1.2.1-x86_64.AppImage && \
     #./orca-1.2.1-x86_64.AppImage --appimage-extract && \
     #printf '#!/bin/bash \nxvfb-run --auto-servernum --server-args "-screen 0 640x480x24" /home/orca/squashfs-root/app/orca "$@"' > /usr/bin/orca && \
     #chmod +x /usr/bin/orca


EXPOSE 8000

COPY ./  /app
COPY ./start.sh /app/start.sh
RUN chmod +x /app/geckodriver
RUN chmod +x /app/start.sh

ENTRYPOINT "/app/start.sh"
