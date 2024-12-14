Class dc.HL7v2Gen Extends %SwizzleObject
{

// Function to generate HL7 message

ClassMethod GenMessages(ver, mtype) [ Language = python ]
{
    #; from hl7apy.core import Message
    #; m = Message(mtype,version=ver)
    #; return m.to_er7()
from hl7apy.parser import parse_message

msh = "MSH|^~\&|GHH_ADT||||20080115153000||ADT^A01^ADT_A01|0123456789|P|2.5||||AL\r"
evn = "EVN||20080115153000||AAA|AAA|20080114003000\r"
pid = "PID|1||566-554-3423^^^GHH^MR||EVERYMAN^ADAM^A|||M|||2222 HOME STREET^^ANN ARBOR^MI^^USA||555-555-2004~444-333-222|||M\r"
nk1 = "NK1|1|NUCLEAR^NELDA^W|SPO|2222 HOME STREET^^ANN ARBOR^MI^^USA\r"
pv1 = "PV1|1|I|GHH PATIENT WARD|U||||^SENDER^SAM^^MD|^PUMP^PATRICK^P|CAR||||2|A0|||||||||||||||||||||||||||||2008\r"
in1 = "IN1|1|HCID-GL^GLOBAL|HCID-23432|HC PAYOR, INC.|5555 INSURERS CIRCLE^^ANN ARBOR^MI^99999^USA||||||||||||||||||||||||||||||||||||||||||||444-33-3333"

s = msh + evn + pid + nk1 + pv1 + in1
message = parse_message(s)

return(message.to_er7())
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
    if 'ACK' in message_types:
        message_types.remove('ACK')  # Remove 'ACK' from its current position
        message_types.append('ACK')  # Append 'ACK' to the end
    
    for message in message_types:
        description = hl7_message_types.get(message, "Description not found")  # Get description from dictionary
        message_with_descriptions.append(f"{message}-{description}")
    
    result = '|'.join(message_with_descriptions)
    return result
else:
    return ver
}

}
