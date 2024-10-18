FROM ubuntu:20.04

RUN apt update && apt install -yqq wget perl &&  rm -rf /var/lib/apt/lists/*

RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \ 
    tar xzf install-tl-unx.tar.gz && rm install-tl-unx.tar.gz && \ 
    cd install-tl* && \ 
    echo "selected_scheme scheme-full" > install.profile && \ 
    echo "tlpdbopt_install_docfiles 0" >> install.profile && \ 
    echo "tlpdbopt_install_srcfiles 0" >> install.profile && \
    echo "tlpdbopt_autobackup 0" >> install.profile && \ 
    echo "tlpdbopt_sys_bin /usr/bin" >> install.profile && \
    ./install-tl --profile=install.profile && cd .. && rm -rf install-tl*



RUN /usr/local/texlive/2024/bin/x86_64-linux/tlmgr path add && \
    luaotfload-tool --update && \
    apt update && DEBIAN_FRONTEND=noninteractive apt install -yqq python3-pip python3-pygments libncurses6 make ghostscript graphviz && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip && \
    cpan PDF::API2 Path::Class



ENV PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH" 
