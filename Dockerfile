FROM haskell:8.6.5

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# reference: https://github.com/dalibo/pandocker/blob/56a2928a1da06cf3f5adf9d05b442cccbdd59dd2/Dockerfile
#
# texlive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes
RUN apt-get -qq update && \
    apt-get -qy install --no-install-recommends \
        git \
        ssh \
        lmodern \
        texlive \
        texlive-luatex \
        texlive-pstricks \
        texlive-xetex \
        wget \
        xzdec \
        fonts-lato \
        fonts-liberation \
        fonts-ipaexfont-mincho \
        latexmk \
        biber \
        texlive-bibtex-extra \
        texlive-science \
        texlive-lang-english \
        texlive-fonts-extra \
        texlive-generic-extra \
        texlive-pictures \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# hack to make xetex see texmf-dist fonts
COPY 09-texlive.conf /etc/fonts/conf.d/
RUN fc-cache

## misc tl packages
# we are building on top of Debian stretch, which ships a very old texlive
#ARG TEXLIVE_VERSION=2016
#RUN tlmgr init-usertree && \
#    tlmgr option repository \
#        http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${TEXLIVE_VERSION}/tlnet-final && \
#    tlmgr install

COPY stack.yaml /root/.stack/global-project/stack.yaml
RUN stack install hakyll
EXPOSE 8000

# eisvogel template
ARG TEMPLATES_DIR=/root/.pandoc/templates
ARG EISVOGEL_VERSION=v1.3.1
RUN mkdir -p ${TEMPLATES_DIR} && \
    curl -L -o ${TEMPLATES_DIR}/eisvogel.latex \
        https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/${EISVOGEL_VERSION}/eisvogel.tex

COPY latexmkrc /root/.latexmkrc

VOLUME /site
WORKDIR /site

COPY entrypoint.sh /opt/
ENTRYPOINT ["/opt/entrypoint.sh"]
