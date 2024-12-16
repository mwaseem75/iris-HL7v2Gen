Class dc.HL7v2Gen Extends %SwizzleObject
{

// Function to generate HL7 message

ClassMethod GenMessage(mtype, ver = "2.5", send = 0, host = "None", port = "None") [ Language = python ]
{

from hl7apy.parser import parse_message
import textwrap,random
from hl7apy.core import Message
import datetime,string
import importlib
import hl7apy as cr
import socket
from hl7apy.exceptions import HL7apyException
from faker import Faker


# Initialize Faker instance
fake = Faker()

mtype = mtype
version = ver
#Crrently only support Ver 2.5  
if version != '2.5':
    return "Crrently only support Ver 2.5"
if version in cr.SUPPORTED_LIBRARIES:      
    message_with_descriptions = []
    module_name = cr.SUPPORTED_LIBRARIES[version]
    lib = importlib.import_module(module_name)
    #get tables reference
    try:
        TABLES = lib.tables.TABLES
    except:
        TABLES = {}    

m = Message(mtype,version=ver)
sequence_type, segmentsM = m.reference
#html_string = textwrap.dedent('''''')
html_string = ''
segments = []
fs = '|'
##########################################
# Function to generate random values for different HL7 data types
def get_val(data_type=None,table=None):
    if table:
        # Get the values for the key 'HL70002'
        table_values = TABLES[table][1]
        return random.choice(table_values)
               

    if data_type == "ST":
        # ST - String, usually a simple text field
        return ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))  # Random alphanumeric string of length 8
    elif data_type == "SI":
        # SI - Sequence ID, typically a numeric value
        return str(random.randint(1, 100))  # Generates a random integer as string
    elif data_type == "CX":
        # SI - Sequence ID, typically a numeric value
        return str(random.randint(100000, 999999))  # Generates a random integer as string
    elif data_type == "TS":
        return datetime.datetime.now().strftime('%Y%m%d%H%M%S')
    elif data_type == "DT":
        # DT - Date, in the format YYYYMMDD
        return datetime.now().strftime("%Y%m%d")  # Current date in YYYYMMDD
    elif data_type == "TM":
        # TM - Time, in the format HHMMSS.sss
        return datetime.now().strftime("%H%M%S")  # Current time in HHMMSS
    elif data_type == "NM":
        # NM - Numeric, can be used for numbers like price or quantity
        return str(round(random.uniform(1, 1000), 2))  # Generates a random float
    elif data_type == "XCN":
        # XCN - Extended Composite Name, which has multiple components
        first_name = fake.first_name()
        last_name = fake.last_name()
        return f"{first_name}^{last_name}^{random.randint(100000, 999999)}"  # Format as Composite Name with ID
    elif data_type == "XCN":
        # XCN - Extended Composite Name, which has multiple components
        first_name = fake.first_name()
        last_name = fake.last_name()
        return f"{first_name}^{last_name}^{random.randint(100000, 999999)}"  # Format as Composite Name with ID
    elif data_type == "XPN":
        # XCN - Extended Composite Name, which has multiple components       
        first_name = fake.first_name()
        given_name = fake.first_name()
        last_name =  fake.last_name()
        return f"{first_name}^{given_name}^{last_name}"
    elif data_type == "XAD":
        # XAD - Extended Address, typically contains multiple parts (street, city, etc.)
        street = fake.street_address()
        city = fake.city() 
        state = fake.state() 
        #zip_code = fake.zipcode()
        return f"{street}^{city}^{state}"
    elif data_type == "CE":
        # CE - Coded Element, typically a code with description
        code = str(random.randint(100, 999))  # Random 3-digit code
        description = ''.join(random.choices(string.ascii_uppercase, k=5))  # Random description
        return f"{code}^{description}"
    elif data_type == "DTM":
        # DTM - Date/Time, in the format YYYYMMDDHHMMSS
        return datetime.now().strftime("%Y%m%d%H%M%S")  # Current date and time in YYYYMMDDHHMMSS
    elif data_type == "PT":
        # PT - Period (Time period), expressed as <number><unit>        
        unit = random.choice(['P']) 
        return f"{unit}" 
    else:
        # Default case for unsupported datatypes
        return "UNKNOWN"

#get all the segments first
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
                                html_string += f'{fs}'+str(get_val(table=segment_definition[4]))
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
                                    html_string += f'{fs}'+str(get_val(segment_definition[2]))              
                                elif cardinality[0] == 0:
                                    html_string += f'{fs}'
                                elif cardinality[0] == 1:                                    
                                    html_string += f'{fs}'+str(get_val(segment_definition[2]))                                                                                          
                        else: 
                            if segment_definition[3] == 'EVENT_TYPE_CODE':
                                html_string += f'{fs}'+mtype.split('_')[1]
                            elif segment_nameM != "MdSH" and segment_definition[4] and segment_definition[4] in TABLES:
                                    html_string += f'{fs}'+str(get_val(table=segment_definition[4]))
                            else:        
                                if cardinality[0] == 1:    
                                    if segment_definition[3] == 'FIELD_SEPARATOR':
                                        html_string += f'{fs}'
                                    elif segment_definition[3] == 'ENCODING_CHARACTERS':    
                                        html_string += f'^~\\&'
                                    elif segment_definition[3] == "VERSION_ID":    
                                        html_string += f'{fs}{ver}'                                          
                                    elif segment_definition[2] == "ST":
                                        html_string += f'{fs}'+str(get_val(segment_definition[2]))                                        
                                elif cardinality[0] == 0:  
                                    if segment_definition[2] == "XAD":
                                        html_string += f'{fs}'+str(get_val(segment_definition[2]))                                                 
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
                                                html_string += f'{fs}'+str(get_val(table=segment_definition[4]))
                                            else:
                                                if segment_definition[2] == "XAD":
                                                    html_string += f'{fs}'+str(get_val(segment_definition[2]))           
                                                elif cardinality[0] == 0:
                                                    html_string += f'{fs}'
                                                elif cardinality[0] == 1:                                                
                                                    html_string += f'{fs}'+str(get_val(segment_definition[2]))                                                           
                                        else:    
                                            if segment_nameM != "MdSH" and segment_definition[4] and segment_definition[4] in TABLES:
                                                    html_string += f'{fs}'+str(get_val(table=segment_definition[4]))
                                            else:        
                                                if cardinality[0] == 1:                                                                                         
                                                    if segment_definition[2] == "ST":
                                                        html_string += f'{fs}'+str(get_val(segment_definition[2]))    
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
                                                            html_string += f'{fs}'+str(get_val(table=segment_definition[4]))
                                                        else:
                                                            if segment_definition[2] == "XAD":
                                                                html_string += f'{fs}'+str(get_val(segment_definition[2]))           
                                                            elif cardinality[0] == 0:
                                                                html_string += f'{fs}'
                                                            elif cardinality[0] == 1:                                                
                                                                html_string += f'{fs}'+str(get_val(segment_definition[2]))                                                           
                                                    else:    
                                                        if segment_nameM != "MdSH" and segment_definition[4] and segment_definition[4] in TABLES:
                                                                html_string += f'{fs}'+str(get_val(table=segment_definition[4]))
                                                        else:        
                                                            if cardinality[0] == 1:                                                                                         
                                                                if segment_definition[2] == "ST":
                                                                    html_string += f'{fs}'+str(get_val(segment_definition[2]))    
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

ClassMethod GetHL7Structure(messgeType) [ Language = python ]
{
import textwrap
from hl7apy.core import Message
from HL7v2Gen import hl7_segment_names
m = Message(messgeType)
sequence_type, segmentsM = m.reference
html_string = textwrap.dedent('''<ul>
''')
for elementM in segmentsM:  
    segment_name, segment_definition, cardinality, segment_type = elementM
    #SEGMENT
    if segment_type == "SEG":
        #get segment name
        description = hl7_segment_names.get(segment_name, "(SEG)")  # Get description from dictionary
        seg_name = f"{segment_name} - {description}"
        if cardinality[0] == 1:
            html_string += f'<li><span class="caret">{seg_name}</span>\n'
        else:
            html_string += f'<li><span class="caret dis">{seg_name}</span>\n'    
        sequence_type, segmentsS = segment_definition
        #FIELD
        if len(segmentsS) > 0:
            html_string += f'<ul class="nested">\n'            
            for elementS in segmentsS: 
                    segment_name, segment_definition, cardinality, segment_type = elementS   
                    sname = segment_name+" - "+segment_definition[3].replace("_", " ").title()+" ("+segment_definition[2]+")"
                    #COMPONENT
                    if segment_definition[0] == "sequence":
                        if cardinality[0] == 1:
                            html_string += f'<li><span class="caret">{sname}</span>\n'
                        else:    
                            html_string += f'<li><span class="caret dis">{sname}</span>\n'
                        html_string += f'<ul class="nested">\n'    
                        segmentsC = segment_definition[1]       
                        for counter,elementC in enumerate(segmentsC, start=1):
                            segment_nameC, segment_definition, cardinalitySC, segment_type = elementC
                            sname = segment_name+"_"+str(counter)+" - "+segment_definition[3].replace("_", " ").title()+" ("+segment_definition[2]+")"
                            if cardinality[0] == 1:
                                html_string += f'<li><span class="caret-box">{sname}</li>\n'
                            else:
                                html_string += f'<li><span class="caret-box dis">{sname}</li>\n'
                        html_string += '</ul></li>'                                            
                    else:
                        if cardinality[0] == 1:    
                            html_string += f'<li><span class="caret-box">{sname}</li>\n'      
                        else:
                            html_string += f'<li><span class="caret-box dis">{sname}</li>\n'      
            html_string += '</ul></li>'                                    
html_string += '</ul>'        


return html_string
}

// Funtion to return all the message types against the HL7 Version

ClassMethod GetMessageTypes(ver) [ Language = python ]
{
from hl7apy.v2_5.messages import MESSAGES
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
    print(message_types)
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

}
