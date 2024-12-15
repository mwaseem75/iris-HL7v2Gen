ARG IMAGE=intersystemsdc/iris-community
#ARG IMAGE=store/intersystems/irishealth-community:2021.2.0.649.0
#ARG IMAGE=intersystemsdc/irishealth-community:2020.3.0.221.0-zpm
#ARG IMAGE=containers.intersystems.com/intersystems/irishealth-community:2021.2.0.651.0
FROM $IMAGE

USER root   
        
WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}

#COPY  Installer.cls .
COPY  python python
COPY  src src
COPY module.xml module.xml
COPY iris.script iris.script

RUN pip3 install fhirpy
RUN pip3 install tabulate

RUN iris start IRIS \
	&& iris session IRIS < iris.script \
    && iris stop IRIS quietly