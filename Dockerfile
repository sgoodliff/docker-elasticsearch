FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.3

MAINTAINER sgoodliff@gmail.com

# Export HTTP & Transport
EXPOSE 9200 9300

ENV ES_VERSION 6.5.3

# Override config, otherwise plug-in install will fail
ADD config /elasticsearch/config

CMD chown elasticsearch:elasticsearch /usr/share/elasticsearch/config

ENV PATH /elasticsearch/bin:$PATH

WORKDIR /elasticsearch

# Copy configuration
COPY config /elasticsearch/config

# Copy run script
COPY run.sh /

# Set environment variables defaults
ENV ES_JAVA_OPTS "-Xms512m -Xmx512m"
ENV CLUSTER_NAME elasticsearch-default
ENV NODE_MASTER true
ENV NODE_DATA true
ENV NODE_INGEST true
ENV HTTP_ENABLE true
ENV NETWORK_HOST _site_
ENV HTTP_CORS_ENABLE true
ENV HTTP_CORS_ALLOW_ORIGIN *
ENV NUMBER_OF_MASTERS 1
ENV MAX_LOCAL_STORAGE_NODES 1
ENV SHARD_ALLOCATION_AWARENESS ""
ENV SHARD_ALLOCATION_AWARENESS_ATTR ""
ENV MEMORY_LOCK true
ENV REPO_LOCATIONS ""
ENV DISCOVERY_SERVICE elasticsearch-discovery
ENV MEMORY_LOCK false

# Volume for Elasticsearch data
VOLUME ["/data"]

CMD ["/run.sh"]