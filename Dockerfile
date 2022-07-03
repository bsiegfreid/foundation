FROM registry.access.redhat.com/ubi9/ubi:9.0.0

ENV PYTHON_VERSION=3.10.4
ENV POSTGRESQL_VERSION=14.4
ENV PSYCOPG_VERSION=3.0.15


# Install Python dependencies
RUN yum --disableplugin=subscription-manager -y install wget yum-utils make gcc openssl-devel bzip2-devel libffi-devel zlib-devel \
  && yum --disableplugin=subscription-manager -y install libedit \
  && yum --disableplugin=subscription-manager clean all


# Install Python
RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz \
  && tar xzf Python-$PYTHON_VERSION.tgz \
  && pushd Python-$PYTHON_VERSION \
  && ./configure --with-system-ffi --with-computed-gotos --enable-loadable-sqlite-extensions \
  && make \
  && make install \
  && popd \
  && rm -rf Python-$PYTHON_VERSION \
  && rm Python-$PYTHON_VERSION.tgz


# Install PostgreSQL but do not configure a runnable environment
RUN wget https://ftp.postgresql.org/pub/source/v$POSTGRESQL_VERSION/postgresql-$POSTGRESQL_VERSION.tar.gz \
  && tar xzf postgresql-$POSTGRESQL_VERSION.tar.gz \
  && pushd postgresql-$POSTGRESQL_VERSION \
  && ./configure  --with-openssl --with-libedit-preferred --without-readline \
  && make world-bin \
  && make install \
  && eval ./configure `pg_config --configure` --with-libedit-preferred --without-readline \
  && popd \
  && rm -rf postgresql-$POSTGRESQL_VERSION \
  && rm postgresql-$POSTGRESQL_VERSION.tar.gz 

ENV PATH="$PATH:/usr/local/pgsql/bin"
ENV DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/pgsql/lib"
ENV C_INCLUDE_PATH="$C_INCLUDE_PATH:/usr/local/pgsql/include"

# Install base Python libraries
RUN python3 -m pip install setuptools cython numpy scipy astropy \
  && python3 -m pip install psycopg[binary,pool]==$PSYCOPG_VERSION

