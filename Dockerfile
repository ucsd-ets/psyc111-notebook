FROM ghcr.io/ucsd-ets/datascience-notebook:2023.4-stable

USER root

RUN apt-get update -y && \
    apt-get install libfontconfig1-dev -y
 
COPY r-psych.yaml /tmp

RUN conda env create --file "/tmp/r-psych.yaml"

RUN rm -rf /opt/conda/bin/R /opt/conda/lib/R && \
    ln -s /opt/conda/envs/r-psych/bin/R /opt/conda/bin/R && \
    ln -s /opt/conda/envs/r-psyc/lib /opt/conda/lib

#RUN pip install nbconvert==5.6.1
RUN R -e "install.packages('fivethirtyeightdata', repos ='https://fivethirtyeightdata.github.io/drat/', type = 'source')" && \
    R -e "install.packages(c('systemfonts'), repos='http://cran.r-project.org')" && \
    R -e "install.packages(c('dslabs', 'mosaic', 'raster', 'pbapply', 'here', 'palmerpenguins'), repos='http://cran.r-project.org')"

COPY test.R /tmp

USER $NB_USER
