FROM pretix/standalone:stable

USER root
#### Installation of Pretix Plugins ####
RUN pip3 install pretix-passbook
RUN pip install pretix-pages
########################################

USER pretixuser
RUN cd /pretix/src && make production