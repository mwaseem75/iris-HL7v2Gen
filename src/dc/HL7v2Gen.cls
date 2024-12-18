Class dc.HL7v2Gen Extends %SwizzleObject
{

// 

ClassMethod GetTestVal(dataType = "", table = "", ver = "2.5") [ Language = python ]
{
    """
    Function to generate HL7 message based on data type 
    
    Parms
    dataType: Data Type
    table: If field is linked to the table
    
    """
    import textwrap,random,importlib
    from faker import Faker
    import datetime,string    
    import hl7apy as cr
    #Get HL7 version related library
    if ver in cr.SUPPORTED_LIBRARIES:      
        message_with_descriptions = []
        module_name = cr.SUPPORTED_LIBRARIES[ver]
        lib = importlib.import_module(module_name)
        #get tables reference
        try:
            TABLES = lib.tables.TABLES
        except:
            TABLES = {}    

    # Initialize Faker instance
    fake = Faker()
    #Get the value from table values
    if table:
        # Get the values for the key 'HL70002'
        table_values = TABLES[table][1]
        return random.choice(table_values)            

    if dataType == "ST":
        # ST - String, usually a simple text field
        return ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))  # Random alphanumeric string of length 8
    elif dataType == "SI":
        # SI - Sequence ID, typically a numeric value
        return str(random.randint(1, 100))  # Generates a random integer as string
    elif dataType == "CX":
        # SI - Sequence ID, typically a numeric value
        return str(random.randint(100000, 999999))  # Generates a random integer as string
    elif dataType == "TS":
        return datetime.datetime.now().strftime('%Y%m%d%H%M%S')
    elif dataType == "DT":
        # DT - Date, in the format YYYYMMDD
        return datetime.now().strftime("%Y%m%d")  # Current date in YYYYMMDD
    elif dataType == "TM":
        # TM - Time, in the format HHMMSS.sss
        return datetime.now().strftime("%H%M%S")  # Current time in HHMMSS
    elif dataType == "NM":
        # NM - Numeric, can be used for numbers like price or quantity
        return str(round(random.uniform(1, 1000), 2))  # Generates a random float
    elif dataType == "XCN":
        # XCN - Extended Composite Name, which has multiple components
        first_name = fake.first_name()
        last_name = fake.last_name()
        return f"{first_name}^{last_name}^{random.randint(100000, 999999)}"  # Format as Composite Name with ID
    elif dataType == "XCN":
        # XCN - Extended Composite Name, which has multiple components
        first_name = fake.first_name()
        last_name = fake.last_name()
        return f"{first_name}^{last_name}^{random.randint(100000, 999999)}"  # Format as Composite Name with ID
    elif dataType == "XPN":
        # XCN - Extended Composite Name, which has multiple components       
        first_name = fake.first_name()
        given_name = fake.first_name()
        last_name =  fake.last_name()
        return f"{first_name}^{given_name}^{last_name}"
    elif dataType == "XAD":
        # XAD - Extended Address, typically contains multiple parts (street, city, etc.)
        street = fake.street_address()
        city = fake.city() 
        state = fake.state() 
        #zip_code = fake.zipcode()
        return f"{street}^{city}^{state}"
    elif dataType == "CE":
        # CE - Coded Element, typically a code with description
        code = str(random.randint(100, 999))  # Random 3-digit code
        description = ''.join(random.choices(string.ascii_uppercase, k=5))  # Random description
        return f"{code}^{description}"
    elif dataType == "DTM":
        # DTM - Date/Time, in the format YYYYMMDDHHMMSS
        return datetime.now().strftime("%Y%m%d%H%M%S")  # Current date and time in YYYYMMDDHHMMSS
    elif dataType == "PT":
        # PT - Period (Time period), expressed as <number><unit>        
        unit = random.choice(['P']) 
        return f"{unit}" 
    else:
        # Default case for unsupported datatypes
        return "UNKNOWN"
}

ClassMethod GenMessage(mtype, ver = "2.5", send = 0, host = "None", port = "None") [ Language = python ]
{
"""
    Core class to generate HL7 Message
    
    Parms
    mtype: the HL7 name of the message (e.g. ADT_A01)
    ver: HL7 version, defualt is "2.5"
    send : 0 do not send, 1 send to production or TCP/IP client
    host: TCP/IP Host Name
    port: TCP/IP Port

"""
from hl7apy.parser import parse_message
from hl7apy.core import Message
import socket,iris
from hl7apy.exceptions import HL7apyException
import hl7apy as cr
import importlib

#Get HL7 version related library
if ver in cr.SUPPORTED_LIBRARIES:      
    message_with_descriptions = []
    module_name = cr.SUPPORTED_LIBRARIES[ver]
    lib = importlib.import_module(module_name)
    #get tables reference
    try:
        TABLES = lib.tables.TABLES
    except:
        TABLES = {}    

mtype = mtype
#Crrently only support Ver 2.5  
if ver != '2.5':
    return "Currently only support Ver 2.5"

m = Message(mtype,version=ver)
sequence_type, segmentsM = m.reference
#html_string = textwrap.dedent('''''')
html_string = ''
segments = []
#field seprator
fs = '|'

#Get all the segments first
for index, elementM in enumerate(segmentsM, start=1):
    segment_nameM, segment_definition, cardinality, segment_type = elementM
    #SEGMENT
    if segment_type == "SEG":
        if cardinality[0] == 1:
            if segment_nameM != 'MSH':
                html_string += f'{segment_nameM}'
            else:
                html_string += f'{segment_nameM}'     
            sequence_type, segmentsS = segment_definition
            #FIELD
            if len(segmentsS) > 0:                           
                for elementS in segmentsS: 
                        segment_name, segment_definition, cardinality, segment_type = elementS   
                        sname = segment_name+" - "+segment_definition[3].replace("_", " ").title()+" ("+segment_definition[2]+")"
                        #COMPONENT
                        if segment_nameM == "MSH" and int(segment_name.split('_')[1]) > 15:                        
                            html_string += f'{fs}'
                        elif segment_definition[0] == "sequence":
                            if segment_definition[4] and segment_definition[4] in TABLES:
                                html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal("",segment_definition[4]))
                            else:
                                if segment_definition[3] == "SENDING_APPLICATION":
                                    html_string += f'{fs}SendingApp'
                                elif segment_definition[3] == "RECEIVING_APPLICATION":
                                    html_string += f'{fs}ReceivingApp'
                                elif segment_definition[3] == "MESSAGE_TYPE":    
                                    html_string += f'{fs}{mtype.replace("_", "^")}'
                                elif segment_definition[3] == "VERSION_ID":    
                                    html_string += f'{fs}{ver}'                                      
                                elif segment_definition[2] == "XAD":
                                    html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))              
                                elif cardinality[0] == 0:
                                    html_string += f'{fs}'
                                elif cardinality[0] == 1:                                    
                                    html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))                                                                                          
                        else: 
                            if segment_definition[3] == 'EVENT_TYPE_CODE':
                                html_string += f'{fs}'+mtype.split('_')[1]
                            elif segment_nameM != "MdSH" and segment_definition[4] and segment_definition[4] in TABLES:
                                    html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(table=segment_definition[4]))
                            else:        
                                if cardinality[0] == 1:    
                                    if segment_definition[3] == 'FIELD_SEPARATOR':
                                        html_string += f'{fs}'
                                    elif segment_definition[3] == 'ENCODING_CHARACTERS':    
                                        html_string += f'^~\\&'
                                    elif segment_definition[3] == "VERSION_ID":    
                                        html_string += f'{fs}{ver}'                                          
                                    elif segment_definition[2] == "ST":
                                        html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))                                        
                                elif cardinality[0] == 0:  
                                    if segment_definition[2] == "XAD":
                                        html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))                                                 
                                    else:
                                        html_string += f'{fs}'
    #IF segment type is Group then again iterate
    elif segment_type == "GRP":
        if cardinality[0] == 1:
            sequence_type, segmentsG = segment_definition           
            for elementG in segmentsG:
                #sequence_type, segmentsG1 = elementG
                segment_name, segment_definition, cardinality, segment_type = elementG
                if segment_type == "SEG":
                    if cardinality[0] == 1:
                            html_string += f'{segment_name}'
                            sequence_type, segmentsS = segment_definition                
                            #FIELD
                            if len(segmentsS) > 0:                           
                                for elementS in segmentsS: 
                                        segment_name, segment_definition, cardinality, segment_type = elementS   
                                        sname = segment_name+" - "+segment_definition[3].replace("_", " ").title()+" ("+segment_definition[2]+")"
                                        #COMPONENT
                                        if segment_definition[0] == "sequence":
                                            if  segment_definition[4] and segment_definition[4] in TABLES:
                                                html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(table=segment_definition[4]))
                                            else:
                                                if segment_definition[2] == "XAD":
                                                    html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))           
                                                elif cardinality[0] == 0:
                                                    html_string += f'{fs}'
                                                elif cardinality[0] == 1:                                                
                                                    html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))                                                           
                                        else:    
                                            if segment_nameM != "MdSH" and segment_definition[4] and segment_definition[4] in TABLES:
                                                    html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(table=segment_definition[4]))
                                            else:        
                                                if cardinality[0] == 1:                                                                                         
                                                    if segment_definition[2] == "ST":
                                                        html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))    
                                                elif cardinality[0] == 0:                                                                                                                   
                                                    html_string += f'{fs}'
                #IF segment type is Group then again iterate
                elif segment_type == "GRP":
                    if cardinality[0] == 1:
                        sequence_type, segmentsG = segment_definition           
                        for elementG in segmentsG:
                            #sequence_type, segmentsG1 = elementG
                            segment_name, segment_definition, cardinality, segment_type = elementG
                            if segment_type == "SEG":
                                if cardinality[0] == 1:
                                        html_string += f'{segment_name}'
                                        sequence_type, segmentsS = segment_definition                
                                        #FIELD
                                        if len(segmentsS) > 0:                           
                                            for elementS in segmentsS: 
                                                    segment_name, segment_definition, cardinality, segment_type = elementS   
                                                    sname = segment_name+" - "+segment_definition[3].replace("_", " ").title()+" ("+segment_definition[2]+")"
                                                    #COMPONENT
                                                    if segment_definition[0] == "sequence":
                                                        if  segment_definition[4] and segment_definition[4] in TABLES:
                                                            html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(table=segment_definition[4]))
                                                        else:
                                                            if segment_definition[2] == "XAD":
                                                                html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))           
                                                            elif cardinality[0] == 0:
                                                                html_string += f'{fs}'
                                                            elif cardinality[0] == 1:                                                
                                                                html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))                                                           
                                                    else:    
                                                        if segment_nameM != "MdSH" and segment_definition[4] and segment_definition[4] in TABLES:
                                                                html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(table=segment_definition[4]))
                                                        else:        
                                                            if cardinality[0] == 1:                                                                                         
                                                                if segment_definition[2] == "ST":
                                                                    html_string += f'{fs}'+str(iris.cls(__name__).GetTestVal(segment_definition[2]))    
                                                            elif cardinality[0] == 0:                                                                                                                   
                                                                html_string += f'{fs}'            
    html_string += '\r'            
    segments.append(html_string)
    html_string=''                          
                
#html_string += '</ul>'        
finalMessage = ''
for seg in segments:
  finalMessage += seg

message = parse_message(finalMessage)

#Same function is used in generation and send to production. Return in case of Generation only
if send == 0:
    return(message.to_er7())

#Send message to production
hl7_message = message.to_er7()

# TCP server address and port
server_address = (host, int(port))  # Example IP and port

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    # Connect to the server
    sock.connect(server_address)

    # Send the HL7 message
    sock.sendall(hl7_message.encode('utf-8'))
         
    hl7_message = hl7_message + "RETVAL HL7 message sent successfully!"
except socket.error as e:
    hl7_message = hl7_message + "RETVAL"+ f"Socket error occurred: {e}"
except socket.timeout as e:
    hl7_message = hl7_message + "RETVAL"+ f"Socket timeout: {e}"
except AttributeError as e:
    hl7_message = hl7_message + "RETVAL"+ f"Error in HL7 message construction: {e}"
except Exception as e:
    hl7_message = hl7_message + "RETVAL"+ f"An unexpected error occurred: {e}"

finally:
    # Close the connection
    sock.close()
return hl7_message
}

// Function to validate HL7 Message

ClassMethod ValidateMessage(msg) [ Language = python ]
{
"""
    Class to validate generated HL7 Message
    
    Parms
    msg: Message to validate    
"""    
from hl7apy import parser
import html

decoded_string = html.unescape(msg)
# Try to parse and validate the HL7 message
try:
    message = parser.parse_message(decoded_string)
    #message.validate()
    return "HL7 Message is valid!"
except Exception as e:
    return f"Invalid HL7 message: {e}"
}

ClassMethod GetSegmentDetails(htmlString, segName, cardinality, segmentDefinition, ver = "2.5") [ Language = python ]
{

    """
    Class to Get Segment details which is used in generation of HL7 Structure
    
    Parms
    htmlString: A main string used to construct the strcture in List form
    segName: Segment name
    cardinality: (0 / 1)
    segmentDefinition: Containing related elements
    ver: HL7 message version, defalut value "2.5"

    """
    import importlib
    import hl7apy as cr
    #Get reference of TABLES   
    if ver in cr.SUPPORTED_LIBRARIES:          
        module_name = cr.SUPPORTED_LIBRARIES[ver]
        lib = importlib.import_module(module_name)
        #get tables reference
        try:
            TABLES = lib.tables.TABLES
        except:
            TABLES = {}    

    if cardinality[0] == 1:
        htmlString += f'<li><span class="caret">{segName}</span>\n'
    else:
        htmlString += f'<li><span class="caret dis">{segName}</span>\n'    
    sequence_type, segmentsS = segmentDefinition
    #FIELD
    if len(segmentsS) > 0:
        htmlString += f'<ul class="nested">\n'            
        for elementS in segmentsS: 
                segment_name, segment_definition, cardinality, segment_type = elementS   
                sname = segment_name+" - "+segment_definition[3].replace("_", " ").title()+" ("+segment_definition[2]+")"
                #COMPONENT
                if segment_definition[0] == "sequence":
                    if cardinality[0] == 1:
                        htmlString += f'<li><span class="caret">{sname}</span>\n'
                    else:    
                        htmlString += f'<li><span class="caret dis">{sname}</span>\n'
                    htmlString += f'<ul class="nested">\n'    
                    segmentsC = segment_definition[1]       
                    for counter,elementC in enumerate(segmentsC, start=1):
                        segment_nameC, segment_definition, cardinalitySC, segment_type = elementC
                        sname = segment_name+"_"+str(counter)+" - "+segment_definition[3].replace("_", " ").title()+" ("+segment_definition[2]+")"                        
                        if segment_definition[4] and segment_definition[4] in TABLES:
                            #sname += segment_definition[4]
                            if cardinality[0] == 1:
                                htmlString += f'<li><span class="caret-box" >{sname} <i class="bi bi-table" data-value={segment_definition[4]}></i></li>\n'
                            else:
                                htmlString += f'<li><span class="caret-box dis">{sname} <i class="bi bi-table" data-value={segment_definition[4]}></i></li>\n'
                        else:   
                            if cardinality[0] == 1:
                                htmlString += f'<li><span class="caret-box">{sname}</i></li>\n'
                            else:
                                htmlString += f'<li><span class="caret-box dis">{sname}</li>\n'
                    htmlString += '</ul></li>'      
                else:
                    if segment_definition[4] and segment_definition[4] in TABLES:
                        #sname += segment_definition[4]
                        if cardinality[0] == 1:    
                            htmlString += f'<li><span class="caret-box">{sname} <i class="bi bi-table" data-value={segment_definition[4]}></i></li>\n'      
                        else:
                            htmlString += f'<li><span class="caret-box dis">{sname} <i class="bi bi-table" data-value={segment_definition[4]}></i></li>\n'  
                    else:
                        if cardinality[0] == 1:    
                            htmlString += f'<li><span class="caret-box">{sname}</li>\n'      
                        else:
                            htmlString += f'<li><span class="caret-box dis">{sname}</li>\n'                  
        htmlString += '</ul></li>'
    
    return htmlString
}

ClassMethod GetHL7Structure(messgeType) [ Language = python ]
{
"""
    Cor class to be used to construct the HL7 strcuture
    
    Parms
    messageType: message type e.g ADT_A01, ORM_O01    

"""
import textwrap,iris
from hl7apy.core import Message
from HL7v2Gen import hl7_segment_names

m = Message(messgeType)
sequence_type, segmentsM = m.reference
#init list 
html_string = textwrap.dedent('''<ul>
''')

for elementM in segmentsM:  
    segment_name, segment_definition, cardinality, segment_type = elementM
    #SEGMENT
    if segment_type == "SEG":
        #get segment name
        description = hl7_segment_names.get(segment_name, "(SEG)")  # Get description from dictionary
        seg_name = f"{segment_name} - {description}"
        html_string = iris.cls(__name__).GetSegmentDetails(html_string,seg_name,cardinality,segment_definition)
    elif segment_type == "GRP":
        description = segment_name.replace(messgeType, "").lstrip('_') + " (GROUP)"
        if cardinality[0] == 1:
            html_string += f'<li><span class="caret">{description}</span>\n'
        else:    
            html_string += f'<li><span class="caret dis">{description}</span>\n'        
        html_string += f'<ul class="nested">\n'
        sequence_type, segmentsG = segment_definition
        for elementG in segmentsG: 
        #get segment name
            segment_name, segment_definition, cardinality, segment_type = elementG            
            if segment_type == "SEG":
                #get segment name
                description = hl7_segment_names.get(segment_name, "(SEG)")  # Get description from dictionary
                seg_name = f"{segment_name} - {description}"
                html_string = iris.cls(__name__).GetSegmentDetails(html_string,seg_name,cardinality,segment_definition) 
            elif segment_type == "GRP":
                description = segment_name.replace(messgeType, "").lstrip('_') + " (GROUP)"                
                if cardinality[0] == 1:
                    html_string += f'<li><span class="caret">{description}</span>\n'
                else:    
                    html_string += f'<li><span class="caret dis">{description}</span>\n'        
                html_string += f'<ul class="nested">\n'
                sequence_type, segmentsG2 = segment_definition
                for elementG2 in segmentsG2: 
                #get segment name
                    segment_name, segment_definition, cardinality, segment_type = elementG2            
                    if segment_type == "SEG":
                        #get segment name
                        description = hl7_segment_names.get(segment_name, "(SEG)")  # Get description from dictionary
                        seg_name = f"{segment_name} - {description}"
                        html_string = iris.cls(__name__).GetSegmentDetails(html_string,seg_name,cardinality,segment_definition)  
                    elif segment_type == "GRP":
                        description = segment_name.replace(messgeType, "").lstrip('_') + " (GROUP)"                
                        if cardinality[0] == 1:
                            html_string += f'<li><span class="caret">{description}</span>\n'
                        else:    
                            html_string += f'<li><span class="caret dis">{description}</span>\n'        
                        html_string += f'<ul class="nested">\n'
                        sequence_type, segmentsG3 = segment_definition
                        for elementG3 in segmentsG3: 
                        #get segment name
                            segment_name, segment_definition, cardinality, segment_type = elementG3            
                            if segment_type == "SEG":
                                #get segment name
                                description = hl7_segment_names.get(segment_name, "(SEG)")  # Get description from dictionary
                                seg_name = f"{segment_name} - {description}"
                                html_string = iris.cls(__name__).GetSegmentDetails(html_string,seg_name,cardinality,segment_definition)   
                        html_string += '</ul></li>' #closing segment list                                            
                html_string += '</ul></li>' #closing segment list                  
        html_string += '</ul></li>' #closing segment list   
html_string += '</ul>' #closing main list       

return html_string
}

// Funtion to return all the message types against the HL7 Version

ClassMethod GetMessageTypes(ver) [ Language = python ]
{
"""
    Function to return all the Message Types against HL7 version

    Parms
    ver: HL7 version
"""
from HL7v2Gen import hl7_message_types 
import hl7apy as cr
import importlib

version = ver  
if version in cr.SUPPORTED_LIBRARIES:      
    message_with_descriptions = []
    module_name = cr.SUPPORTED_LIBRARIES[version]
    lib = importlib.import_module(module_name)
    MESSAGES = lib.MESSAGES
    message_types = list(MESSAGES.keys())    
    if 'ACK' in message_types:
        #Move ACK message at the end
        message_types.remove('ACK')  # Remove 'ACK' from its current position
        message_types.append('ACK')  # Append 'ACK' to the end
    
    for message in message_types:
        description = hl7_message_types.get(message, "Description not found")  # Get description from dictionary
        if description != "Description not found":
            message_with_descriptions.append(f"{message}-{description}")
    
    result = '|'.join(message_with_descriptions)
    return result
else:
    return ver
}

ClassMethod SendMessage(msgg, ipadd, port) [ Language = python ]
{
"""
    Class used to send message to TCP/IP client

    params
    msgg : HL7 message 
    ipadd : Host IP address
    port : Host Port
"""
import socket

# TCP server address and port
server_address = (ipadd, int(port))  # Example IP and port

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    # Connect to the server
    sock.connect(server_address)

    # Send the HL7 message
    msggg = msgg.encode('utf-8')
    sock.sendall(msggg)
    ack = sock.recv(1024).decode()
    return ack
    #print(msggg)    
    ret = "HL7 message sent successfully!"
except socket.error as e:
    ret = f"Socket error occurred: {e}"
except socket.timeout as e:
    ret = f"Socket timeout: {e}"
except AttributeError as e:
    ret = f"Error in HL7 message construction: {e}"
except Exception as e:
    ret = f"An unexpected error occurred: {e}"

finally:
    # Close the connection
    sock.close()
    
return ret
}

/// Description
ClassMethod TestConnection(host, port) [ Language = python ]
{
"""    
    Class used to test TCP/IP connection

    params
    host : Host IP address
    port : Host Port

"""
import socket

# Create a socket object
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    
# Set a timeout for the connection (optional)
sock.settimeout(10)  # Timeout in seconds
    
try:
    # Attempt to connect to the specified host and port
    sock.connect((host, int(port)))
    return f"Successfully connected to {host} on port {port}"
    return True
except socket.error as e:
    return f"Failed to connect to {host} on port {port}: {e}"
    return False
finally:
        # Always close the socket after the test
    sock.close()
}

ClassMethod GetTablesData(table, ver = "2.5") [ Language = python ]
{
    """    
    Class used to get HL7 tables data (HL7 coding system)

    params
    table : Table ID
    ver : HL7 version

    """
    import importlib
    import hl7apy as cr
    from HL7v2Gen import TABLES
    tbl = '<table class="table table-striped"><thead class="bg-secondary"><tr><th>ID</th><th>Description</th></td></tr></tr></thead><tbody>'
    #If table is defined in HL7v2Gen tables dictionary then table values
    if table in TABLES:
        table_values = TABLES[table][1]

        # Iterate over the dictionary
        for code, description in table_values.items():
            tbl += '<tr>'
            tbl += f'<td>{code}</td><td>{description}</td>'
            tbl += '</tr>'    
    #Take values from library itself    
    else:
        #Get reference of TABLES   
        if ver in cr.SUPPORTED_LIBRARIES:          
            module_name = cr.SUPPORTED_LIBRARIES[ver]
            lib = importlib.import_module(module_name)
            #get tables reference
            try:
                LibTABLES = lib.tables.TABLES
            except:
                LibTABLES = {}    
        # Get the values for the key 
        table_values = LibTABLES[table][1]
        for code in table_values:
            tbl += '<tr>'
            tbl += f'<td>{code}</td><td>{code}</td>'
            tbl += '</tr>'    
    tbl += "</tbody></table>"
    
    return tbl
}

/// Description
ClassMethod ListMessageTypes(ver = "2.5") [ Language = python ]
{
   
"""
    Function to print message types

    Parms
    ver: HL7 version
"""
from HL7v2Gen import hl7_message_types 
import hl7apy as cr
import importlib

version = ver  
if version in cr.SUPPORTED_LIBRARIES:      
    message_with_descriptions = []
    module_name = cr.SUPPORTED_LIBRARIES[version]
    lib = importlib.import_module(module_name)
    MESSAGES = lib.MESSAGES
    message_types = list(MESSAGES.keys())    
    if 'ACK' in message_types:
        #Move ACK message at the end
        message_types.remove('ACK')  # Remove 'ACK' from its current position
        message_types.append('ACK')  # Append 'ACK' to the end
    
    for message in message_types:
        description = hl7_message_types.get(message, "Description not found")  # Get description from dictionary
        if description != "Description not found":
            message_with_descriptions.append(f"{message}-{description}")
    
    # Print header for the table
    print(f"{'HL7 Message Types':<60}{'HL7 Message Types':<49}Total = {len(hl7_message_types):<40}")
    print("="*120)  # A line to separate header from data

    # Iterate through the list and print two values per row
    for i in range(0, len(message_with_descriptions), 2):  # Iterate in steps of 2
        # Select two values per iteration
        row = message_with_descriptions[i:i+2]  # Extract two values

        print(f"{row[0]:<60}{row[1] if len(row) > 1 else '':<60}")
    print("="*120)  # Line to separate the total row
    print(f"{'Total Message Types = '}{len(message_with_descriptions)}")
}

}
