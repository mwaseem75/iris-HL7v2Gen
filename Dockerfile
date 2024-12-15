ARG IMAGE=intersystemsdc/irishealth-community:preview
FROM $IMAGE 

#WORKDIR /home/irisowner/irisdev
WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp


COPY src src
COPY python python
COPY module.xml module.xml

# run iris and initial 
RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    iris stop IRIS quietly
