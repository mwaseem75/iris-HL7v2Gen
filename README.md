# Summary
IRIS-HL7v2Gen is a CSP application designed to dynamically generate HL7 test messages, validate them against HL7 specifications, display their message structure hierarchy, and transmit the messages to production via TCP/IP.

[![one](https://img.shields.io/badge/Platform-InterSystems%20IRIS-blue)](https://www.intersystems.com/data-platform/) [![one](https://img.shields.io/badge/WebFrameWork-CSP-Orange)](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GCSP) [![one](https://img.shields.io/badge/Interoperability-HL7%20V2-yellow)](https://v2.hl7.org/conformance/HL7v2_Conformance_Methodology_R1_O1_Ballot_Revised_D9_-_September_2019_Introduction.html) [![one](https://img.shields.io/badge/Python%20Library-HL7apy-Maroon)](https://crs4.github.io/hl7apy/index.html) [![OEX](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)]() [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/mwaseem75/iris-HL7v2Gen/blob/main/LICENSE)

## Application Layout
![image](https://github.com/user-attachments/assets/4eaa718f-88d6-4afd-8673-1e70f88a633f)


## Features
* **Dynamic HL7 Message Generation:** Instantly create HL7 messages for a range of message types, facilitating comprehensive testing.
* **Message Structure Exploration:** Visualize the structure of generated messages based on HL7 specifications.
* **Message Validation:** Validate messages against HL7 standards to ensure compliance.
* **TCP/IP Communication:** Easily transmit messages to production using TCP/IP settings.
* **Broad Message Type Support:** Supports 184 different HL7 message types, ensuring versatility for various healthcare integration needs.
* **ClassMethod:** Generate a Test Message by Invoking a Class Method
* **Version Support:** Currently Supports HL7 Version 2.5


## Online Demo
https://irishl7v2gen.demo.community.intersystems.com/csp/hl7v2gen/index.csp by using SuperUser | SYS


## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.


## Installation 
### Docker (e.g. for dev purposes)

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/mwaseem75/iris-HL7v2Gen.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d
```

### IPM

Open IRIS for Health installation with IPM client installed. Call in any namespace:

```
USER>zpm "install iris-HL7v2Gen"
```

## Run the Application
Navigate to [http://localhost:32783/csp/HL7v2Gen/index.csp](http://localhost:32783/csp/HL7v2Gen/index.csp) to run the application
![image](https://github.com/user-attachments/assets/372a5428-63ac-4e02-9761-6983040dc934)


### Generate HL7 Message
Select a message type from the dropdown list and click the "Generate Test Message" button
![image](https://github.com/user-attachments/assets/16180f09-6431-4ce9-a0cf-be5b0a9ab120)


The application will generate a test message
![image](https://github.com/user-attachments/assets/bac805cb-4962-4f41-bd70-ec30ce54b98f)


### Explore the Structure of the Message
The application will construct the message structure based on HL7 specifications
![image](https://github.com/user-attachments/assets/e167c659-abb7-4d5a-adc8-482af6e74e4a)


### Validate HL7 Message
Click the "Validate Message" button
![image](https://github.com/user-attachments/assets/490798e7-b35e-4c13-b5af-55843d5a348c)


### Send Message to Production
Click on "View Production" to open the production page. Make sure the production is started
![image](https://github.com/user-attachments/assets/2531a108-09bc-4e41-8139-15d88069b611)
Click on "Send message to production" button from the application
![image](https://github.com/user-attachments/assets/39efeee4-ee72-4082-8aad-2a38bf920add)
Select business service "HL7TcpService" and Open message viewer 
![image](https://github.com/user-attachments/assets/b1c6c8bc-c6cd-4697-9e80-4b046081a214)
![image](https://github.com/user-attachments/assets/980b79ba-76a0-47c5-b0ee-53b80103bd0e)

### TCP/IP connection settings
Click on 'Connection Settings' to open the connection settings dialog, where you can define and test the connection
![image](https://github.com/user-attachments/assets/810da1d7-55d4-490a-bed0-94efd9cb38ef)
 

### Generate a Test Message by Invoking a Class Method
Connect to the IRIS Terminal, execute the GenMessage function of the dc.HL7v2Gen class, and pass the desired HL7 message type
```
set mes = ##class(dc.HL7v2Gen).GenMessage("ADT_A01")
write mes
```
![image](https://github.com/user-attachments/assets/997c239e-618c-4a94-8e09-aa91306dd334)


Thanks
