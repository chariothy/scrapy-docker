# For Tencent DDNS
# @version 1.0

ARG PYVER
FROM python:${PYVER} AS compile-env

# Update pip
RUN pip install --no-cache-dir --user scrapy
# 本地编译时需要加国内代理
#RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir --user -r ./requirements.txt

FROM python:${PYVER}
LABEL maintainer="chariothy@gmail.com"

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ARG TARGETPLATFORM
ARG BUILDPLATFORM

LABEL maintainer="chariothy" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.url="https://github.com/chariothy/scrapy-docker.git" \
  org.opencontainers.image.source="https://github.com/chariothy/scrapy-docker.git" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$VCS_REF \
  org.opencontainers.image.vendor="chariothy" \
  org.opencontainers.image.title="scrapy" \
  org.opencontainers.image.description="Docker for python with scrapy" \
  org.opencontainers.image.licenses="MIT"

COPY --from=compile-env /root/.local /root/.local

WORKDIR /app

ENV PATH=/root/.local/bin:$PATH
CMD [ "python" ]