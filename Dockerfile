FROM hub.cstcloud.cn/csst/python:3.8-dev

RUN pip install --no-deps ccdproc && pip install deepCR

RUN apt-get update && apt-get install -y vim

# 拷贝源码到镜像中
COPY instrument_effect_wrapper.py setup.py requirements.txt \ 
    /home/csstpipeline/code/csst-msc-instrument-effect/

COPY csst_msc_instrument_effect/* \ 
    /home/csstpipeline/code/csst-msc-instrument-effect/csst_msc_instrument_effect/

COPY MSC_crmask.ini /home/csstpipeline/msc-instrument-effect/

RUN cd /home/csstpipeline/code/csst-msc-instrument-effect/ \
    && python setup.py install

COPY cleanup.sh /app/bin/
COPY csst_msc_iec.sh /app/bin/run.sh
