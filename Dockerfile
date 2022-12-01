FROM ucsdets/datascience-notebook:2022.3-stable

USER root

COPY r-psych.yaml /tmp

RUN conda env create --file "/tmp/r-psych.yaml"

RUN rm -rf /opt/conda/bin/R /opt/conda/lib/R && \
    ln -s /opt/conda/envs/r-psych/bin/R /opt/conda/bin/R && \
    ln -s /opt/conda/envs/r-psyc/lib /opt/conda/lib

RUN pip install nbconvert==5.6.1
RUN R -e "install.packages('fivethirtyeightdata', repos ='https://fivethirtyeightdata.github.io/drat/', type = 'source')" && \
    R -e "install.packages(c('dslabs', 'mosaic', 'raster', 'pbapply', 'here', 'palmerpenguins', 'lme4'), repos='http://cran.r-project.org')"

COPY test.R /tmp

USER $NB_USER
