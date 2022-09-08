FROM ghcr.io/homalg-project/gap-docker-base:latest

ENV GAP_VERSION 4.12.0

RUN    mkdir -p /home/gap/inst/ \
    && cd /home/gap/inst/ \
    && wget -q https://github.com/gap-system/gap/releases/download/v${GAP_VERSION}/gap-${GAP_VERSION}.tar.gz \
    && tar xzf gap-${GAP_VERSION}.tar.gz \
    && rm gap-${GAP_VERSION}.tar.gz \
    && cd gap-${GAP_VERSION} \
    && ./configure \
    && make \
    && cp bin/gap.sh bin/gap \
    && cd pkg \
    && rm normalizinterface/build-normaliz.sh \
    && ../bin/BuildPackages.sh
    #&& test='JupyterKernel-*' \
    #&& mv ${test} JupyterKernel \
    #&& cd JupyterKernel \
    #&& python3 setup.py install --user

#RUN jupyter serverextension enable --py jupyterlab --user

#ENV PATH /home/gap/inst/gap-${GAP_VERSION}/pkg/JupyterKernel/bin:${PATH}
#ENV JUPYTER_GAP_EXECUTABLE /home/gap/inst/gap-${GAP_VERSION}/bin/gap.sh

ENV GAP_HOME /home/gap/inst/gap-${GAP_VERSION}
ENV PATH ${GAP_HOME}/bin:${PATH}
