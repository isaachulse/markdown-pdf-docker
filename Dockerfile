FROM haskell:8.6

LABEL Isaac Hulse

# Latest Pandoc version, from https://github.com/jgm/pandoc/releases
ENV PANDOC_VERSION "2.7.2"

# Install TeX Utilities
RUN apt-get update -y \
  && apt-get install -y \
  --no-install-recommends \
  apt-utils \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-math-extra \
  texlive-xetex latex-xcolor \
  texlive-fonts-extra \
  texlive-bibtex-extra \
  fontconfig \
  lmodern

# Install Pandoc
RUN cabal new-update && cabal new-install pandoc-${PANDOC_VERSION}

# Set Work Directory
WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--version"]
