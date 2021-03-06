FROM rocker/verse:latest
LABEL maintainer="himaeda@umich.edu"

ENV DEBCONF_NOWARNINGS yes

# Using clang as compiler for stan
RUN apt-get update \
	&& apt-get install -y --no-install-recommends apt-utils ed libnlopt-dev clang \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# Install ipaexfont
# RUN apt-get install -y fonts-ipaexfont

RUN tlmgr update --self --all

# install libjpeg & V8 for "psycho"
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y libv8-dev

# install ImageMagick++ library for magick
RUN apt-get install -y libmagick++-dev

# Creates a makevars file and installs rstan from source(https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Linux)
COPY install_stan.r install_stan.r
RUN ["r", "install_stan.r"]

# install devtools & R package from github
RUN install2.r -s --error \
devtools

RUN Rscript -e "devtools::install_github('crsh/papaja')"
RUN Rscript -e "devtools::install_github('rstudio/rticles')"
RUN Rscript -e "devtools::install_github('benmarwick/wordcountaddin', type = 'source', dependencies = TRUE)"
RUN Rscript -e "devtools::install_github('ropenscilabs/gramr')"
RUN Rscript -e "devtools::install_github('sachaepskamp/parSim')"
RUN Rscript -e  "devtools::install_github('rstudio/renv')"
RUN Rscript -e  "devtools::install_github('karthik/holepunch')"
# RUN Rscript -e "devtools::install_github('easystats/easystats')"
RUN Rscript -e  "devtools::install_github('yihui/xaringan')"
RUN Rscript -e "tinytex::tlmgr_install('ipaex')"

# jsPsych
RUN Rscript -e  "devtools::install_github('CrumpLab/jsPsychR')"
RUN Rscript -e  "devtools::install_github('djnavarro/xprmntr')"
RUN Rscript -e  "devtools::install_github('Kohze/fireData')"

# vertical
# RUN Rscript -e  "devtools::install_github('CrumpLab/vertical')"

# Kunisato lab packages
RUN Rscript -e "devtools::install_github('ykunisato/senshuRmd')"
RUN Rscript -e  "devtools::install_github('ykunisato/jsPsychRmd')"
RUN Rscript -e  "devtools::install_github('ykunisato/openPsychData')"

# install other R packages
RUN install2.r -s --error \
memisc \
arm \
bayesplot \
brms \
C50 \
citr \
coda \
caret \
car \
e1071 \
Ecdat \
ensembleR \
elasticnet \ 
fitdistrplus \
Hmisc \
faraway \
fGarch \
forecast \
GGally \
ggmcmc \
ggsci \
gridExtra \
ggridges \
glmnet \
gam \
gamlss \
kernlab \
lme4 \
ltm \
loo \
MASS \
MLmetrics \
mboost \
pixiedust \
pROC \
projpred \
randomForest \ 
ranger \
rpart \
rstanarm \
rstantools \
shinystan \
sigr \
stargazer \
stringr \
survival \
tidybayes \
viridis \
psycho \
apaTables \
googleComputeEngineR \
googleCloudStorageR \
future \
checkpoint \
packrat \
VIM \
mice \
irr  \
DiagrammeR  \
magick  \
roxygen2md \
googledrive \
rdrop2 \
furrr \
leaflet \
osfr \
igraph
