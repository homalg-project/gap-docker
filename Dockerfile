FROM ghcr.io/homalg-project/gap-docker-base:latest

ENV GAP_VERSION 4.13.1

# NormalizInterface: switch to C++14 to work around https://github.com/gap-packages/NormalizInterface/issues/110

RUN    mkdir -p /home/gap/inst/ \
    && cd /home/gap/inst/ \
    && wget -q https://github.com/gap-system/gap/releases/download/v${GAP_VERSION}/gap-${GAP_VERSION}.tar.gz \
    && tar xzf gap-${GAP_VERSION}.tar.gz \
    && rm gap-${GAP_VERSION}.tar.gz \
    && cd gap-${GAP_VERSION} \
    && ./configure \
    && make \
    && cd pkg \
    && rm normalizinterface/prerequisites.sh \
    && sed -i 's/AX_CXX_COMPILE_STDCXX(11, ,mandatory)/AX_CXX_COMPILE_STDCXX(14, ,mandatory)/' normalizinterface/configure.ac \
    && sed -i 's/-std=gnu++11/-std=gnu++14/' normalizinterface/Makefile.in \
    && (cd normalizinterface && ./autogen.sh) \
    && ../bin/BuildPackages.sh
    #&& test='JupyterKernel-*' \
    #&& mv ${test} JupyterKernel \
    #&& cd JupyterKernel \
    #&& python3 setup.py install --user

#RUN jupyter serverextension enable --py jupyterlab --user

#ENV PATH /home/gap/inst/gap-${GAP_VERSION}/pkg/JupyterKernel/bin:${PATH}
#ENV JUPYTER_GAP_EXECUTABLE /home/gap/inst/gap-${GAP_VERSION}/bin/gap.sh

ENV GAP_HOME /home/gap/inst/gap-${GAP_VERSION}
ENV PATH ${GAP_HOME}:${PATH}
