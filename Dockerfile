FROM centos:8

RUN yum install -y net-tools nginx
COPY nginx.conf.template /
COPY docker-entrypoint.sh /
RUN mkdir -p /data/nginx/cache && chown -R 1001:1001 /data/nginx/cache
EXPOSE 8080

USER 1001

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-c", "/tmp/nginx.conf"]
