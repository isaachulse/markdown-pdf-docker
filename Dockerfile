FROM haskell:8.6

LABEL Isaac Hulse

# Latest Pandoc version, from https://github.com/jgm/pandoc/releases
ENV PANDOC_VERSION "2.7.2"

# Install TeX Utilities
RUN apt-get update -y \
  && apt-get install -y -o --no-install-recommends \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-xetex \
  texlive-fonts-extra \
  lmodern

# Install Pandoc
RUN cabal update && cabal new-install pandoc-${PANDOC_VERSION}

# Set Work Directory
WORKDIR /source

# Copies across input markdown file
COPY input.md input.md

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["-o output.pdf input.md"]
