FROM debian:jessie-slim
WORKDIR /opt/app
ENV SPHINX_VERSION=2.3.2-beta-1
ADD http://sphinxsearch.com/files/sphinxsearch_${SPHINX_VERSION}~jessie_amd64.deb ./sphinx.deb
RUN apt-get update && apt-get install -y libexpat1 libmysqlclient18 libodbc1 libpq5 && \
    dpkg -i ./sphinx.deb && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/*. *.deb && \
    ln -sv /dev/stdout /var/log/query.log && \
    ln -sv /dev/stdout /var/log/searchd.log

CMD ['searchd', '--nodetach', '-c', '/etc/sphinxsearch/sphinx.conf']