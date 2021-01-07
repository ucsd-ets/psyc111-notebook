FROM ucsdets/datascience-notebook:2021.1-stable

USER root

COPY r-psych.yaml /tmp

RUN conda env create --file "/tmp/r-psych.yaml"

RUN rm -rf /opt/conda/bin/R /opt/conda/lib/R && \
    ln -s /opt/conda/envs/r-psych/bin/R /opt/conda/bin/R 

RUN R -e "install.packages('fivethirtyeightdata', repos ='https://fivethirtyeightdata.github.io/drat/', type = 'source')"