# Summary
IRIS-HL7v2Gen is a web application designed to generate HL7 test messages, validate them against HL7 specifications, display the message structure hierarchy, and transmit the messages to production via TCP/IP

[![one](https://img.shields.io/badge/Platform-InterSystems%20IRIS-blue)](https://www.intersystems.com/data-platform/) [![one](https://img.shields.io/badge/WebFrameWork-CSP-Orange)](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GCSP) [![one](https://img.shields.io/badge/Interoperability-HL7%20V2-yellow)](https://v2.hl7.org/conformance/HL7v2_Conformance_Methodology_R1_O1_Ballot_Revised_D9_-_September_2019_Introduction.html) [![one](https://img.shields.io/badge/Python%20Library-HL7apy-Maroon)](https://crs4.github.io/hl7apy/index.html) [![OEX](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)]() [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/mwaseem75/iris-HL7v2Gen/blob/main/LICENSE)

## Application Layout
![image](https://github.com/user-attachments/assets/1d18bb0c-bf27-4090-85e8-de0d309442b8)

## Features
* Generate HL7 Test Messages
* Validate HL7 Messages
* Construct HL7 Message Type Structures
* Send Messages via TCP/IP
* Currently Supports HL7 Version 2.5


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
![image](https://github.com/user-attachments/assets/8cbc32cf-9cf5-467f-842b-ad5672aeeffe)

### Generate HL7 Message
Select a message type from the dropdown list and click the "Generate Test Message" button
![image](https://github.com/user-attachments/assets/14ba8436-4f66-4d7b-a1b1-bd1013498e19)

The application will generate a test message
![image](https://github.com/user-attachments/assets/ff8ab828-176d-467d-af7c-d235dc66338f)

### Validate HL7 Message
Click the "Validate Message" button
![image](https://github.com/user-attachments/assets/201d2696-d673-422e-b1ed-2a8e2205a735)

### Explore the Structure of the Message
The application will construct the message structure based on HL7 specifications
![image](https://github.com/user-attachments/assets/c11dfc90-f4ab-40e4-ab61-f204c1ca43c4)

### Send Message to Production
Click on "View Production" to open the production page. Make sure the production is started
![image](https://github.com/user-attachments/assets/2531a108-09bc-4e41-8139-15d88069b611)
Click on "Send message to production" button from the application
![image](https://github.com/user-attachments/assets/592f9a5c-002a-4d18-b0df-129c3451c728)
Select business service "HL7TcpService" and Open message viewer 
![image](https://github.com/user-attachments/assets/b1c6c8bc-c6cd-4697-9e80-4b046081a214)
![image](https://github.com/user-attachments/assets/e9894c82-c3e4-46a0-b7e5-15c50ad3714b)


Thanks
