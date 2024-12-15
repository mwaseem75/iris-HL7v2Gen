hl7_message_types = {
    'ACK': 'Acknowledgement',
    'ADR_A19': 'Adverse Event Reporting',
    'ADT_A01': 'Admit/Visit Notification',
    'ADT_A02': 'Transfer Patient',
    'ADT_A03': 'Discharge/End Visit',
    'ADT_A05': 'Pre-admission',
    'ADT_A06': 'Change of Patient ID',
    'ADT_A09': 'Patient Departed',
    'ADT_A12': 'Merge Patient Information',
    'ADT_A15': 'Pending transfer',
    'ADT_A16': 'Change of Patient Information',
    'ADT_A17': 'Patient Admission',
    'ADT_A18': 'Patient Information',
    'ADT_A20': 'Patient Merge',
    'ADT_A21': 'Merge person information',
    'ADT_A24': 'Find Patient',
    'ADT_A30': 'Patient Information Update',
    'ADT_A37': 'Admit Patient',
    'ADT_A38': 'Transfer Patient',
    'ADT_A39': 'Discharge Patient',
    'ADT_A43': 'Update Discharge Information',
    'ADT_A45': 'Patient Information',
    'ADT_A50': 'Pre-Admission',
    'ADT_A52': 'Admit Patient',
    'ADT_A54': 'Discharge Patient',
    'ADT_A60': 'Merge Patient Information',
    'ADT_A61': 'Merge Patient Data',
    'BAR_P01': 'Bar Code',
    'BAR_P02': 'Bar Code Payment',
    'BAR_P05': 'Bar Code Status Update',
    'BAR_P06': 'Bar Code Status Change',
    'BAR_P10': 'Bar Code Charge',
    'BAR_P12': 'Bar Code Payment Reversal',
    'BPS_O29': 'Blood Pressure Summary',
    'BRP_O30': 'Blood Pressure Report',
    'BRT_O32': 'Blood Pressure Result',
    'BTS_O31': 'Blood Test Summary',
    'CRM_C01': 'Clinical Report Message',
    'CSU_C09': 'Clinical Study Update',
    'DFT_P03': 'Detail Financial Transactions',
    'DFT_P11': 'Financial Details Report',
    'DOC_T12': 'Document Transmission',
    'DSR_Q01': 'Data Status Report Query',
    'DSR_Q03': 'Data Status Query',
    'EAC_U07': 'Electronic Administrative Report',
    'EAN_U09': 'Electronic Administrative Notice',
    'EAR_U08': 'Electronic Administrative Report',
    'EDR_R07': 'Electronic Document Request',
    'EQQ_Q04': 'Electronic Query Request',
    'ERP_R09': 'Electronic Reporting',
    'ESR_U02': 'Electronic Status Report',
    'ESU_U01': 'Electronic Status Update',
    'INR_U06': 'Inpatient Report',
    'INU_U05': 'Inpatient Update',
    'LSU_U12': 'Laboratory Status Update',
    'MDM_T01': 'Medical Document Management',
    'MDM_T02': 'Medical Document Update',
    'MFK_M01': 'Master File Management',
    'MFN_M01': 'Master File Notification',
    'MFN_M02': 'Master File Update',
    'MFN_M03': 'Master File Deletion',
    'MFN_M04': 'Master File Addition',
    'MFN_M05': 'Master File Query',
    'MFN_M06': 'Master File Report',
    'MFN_M07': 'Master File Synchronization',
    'MFN_M08': 'Master File Archive',
    'MFN_M09': 'Master File Transaction',
    'MFN_M10': 'Master File Activation',
    'MFN_M11': 'Master File Inactivation',
    'MFN_M12': 'Master File Update Query',
    'MFN_M13': 'Master File Deletion Request',
    'MFN_M15': 'Master File Synchronization Report',
    'MFN_Znn': 'Master File Custom',
    'MFQ_M01': 'Master File Query',
    'MFR_M01': 'Master File Request',
    'MFR_M04': 'Master File Report Query',
    'MFR_M05': 'Master File Report Update',
    'MFR_M06': 'Master File Report Synchronization',
    'MFR_M07': 'Master File Report Deletion',
    'NMD_N02': 'New Message Delivery',
    'NMQ_N01': 'New Message Query',
    'NMR_N01': 'New Message Response',
    'OMB_O27': 'Order Message Bank',
    'OMD_O03': 'Order Message Document',
    'OMG_O19': 'Order Message Generation',
    'OMI_O23': 'Order Message Inquiry',
    'OML_O21': 'Order Message Laboratory',
    'OML_O33': 'Order Message Laboratory Query',
    'OML_O35': 'Order Message Lab Result',
    'OMN_O07': 'Order Message Notification',
    'OMP_O09': 'Order Message Patient',
    'OMS_O05': 'Order Message Summary',
    'ORB_O28': 'Order Message Request',
    'ORD_O04': 'Order Request Data',
    'ORF_R04': 'Order Result Data',
    'ORG_O20': 'Order Group Data',
    'ORI_O24': 'Order Inquiry Response',
    'ORL_O22': 'Order List Request',
    'ORL_O34': 'Order List Summary',
    'ORL_O36': 'Order List Data',
    'ORM_O01': 'Order Message',
    'ORN_O08': 'Order Notification',
    'ORP_O10': 'Order Processing',
    'ORR_O02': 'Order Response',
    'ORS_O06': 'Order Summary',
    'ORU_R01': 'Order Result',
    'ORU_R30': 'Order Result Summary',
    'OSQ_Q06': 'Order Status Query',
    'OSR_Q06': 'Order Status Response',
    'OUL_R21': 'Order Update List',
    'OUL_R22': 'Order Update Report',
    'OUL_R23': 'Order Update Notification',
    'OUL_R24': 'Order Update Status',
    'PEX_P07': 'Procedure Order Event',
    'PGL_PC6': 'Procedure Event List',
    'PMU_B01': 'Patient Management Update',
    'PMU_B03': 'Patient Management Revoke',
    'PMU_B04': 'Patient Management Notification',
    'PMU_B07': 'Patient Management Response',
    'PMU_B08': 'Patient Management Alert',
    'PPG_PCG': 'Patient Profile Group',
    'PPP_PCB': 'Patient Profile Case',
    'PPR_PC1': 'Patient Profile Report',
    'PPT_PCL': 'Patient Profile List',
    'PPV_PCA': 'Patient Profile Alert',
    'PRR_PC5': 'Patient Request Report',
    'PTR_PCF': 'Patient Transport Report',
    'QBP_K13': 'Query Batch Report',
    'QBP_Q11': 'Query Request',
    'QBP_Q13': 'Query Update Request',
    'QBP_Q15': 'Query Response',
    'QBP_Q21': 'Query Result',
    'QBP_Qnn': 'Query Custom',
    'QBP_Z73': 'Query Z73',
    'QCK_Q02': 'Quick Query',
    'QCN_J01': 'Query Notification',
    'QRY': 'Query Message',
    'QRY_A19': 'Query A19',
    'QRY_PC4': 'Query Patient Check',
    'QRY_Q01': 'Query Request',
    'QRY_Q02': 'Query Response',
    'QRY_R02': 'Query Result Update',
    'QSB_Q16': 'Query Status Report',
    'QVR_Q17': 'Query Verification Response',
    'RAR_RAR': 'Report Acknowledgement',
    'RAS_O17': 'Status Request Report',
    'RCI_I05': 'Response Query Input',
    'RCL_I06': 'Response Query Output',
    'RDE_O11': 'Report Data Entry',
    'RDR_RDR': 'Data Request Response',
    'RDS_O13': 'Data Status Report',
    'RDY_K15': 'Report Data Request',
    'REF_I12': 'Reference Information',
    'RER_RER': 'Response Error Report',
    'RGR_RGR': 'Group Report Response',
    'RGV_O15': 'Group Value Report',
    'ROR_ROR': 'Results of Operation Report',
    'RPA_I08': 'Patient Admission Report',
    'RPI_I01': 'Patient Information Inquiry',
    'RPI_I04': 'Patient Information Update',
    'RPL_I02': 'Patient List Report',
    'RPR_I03': 'Patient Report Summary',
    'RQA_I08': 'Report Query Answer',
    'RQC_I05': 'Report Query Confirm',
    'RQI_I01': 'Report Query Information',
    'RQP_I04': 'Report Query Process',
    'RQQ_Q09': 'Request Query',
    'RRA_O18': 'Request Acknowledgement',
    'RRD_O14': 'Request Report Data',
    'RRE_O12': 'Request Report Error',
    'RRG_O16': 'Request Group Report',
    'RRI_I12': 'Request Response Input',
    'RSP_K11': 'Report Status Processing',
    'RSP_K21': 'Report Query Status',
    'RSP_K23': 'Report Processing Status',
    'RSP_K25': 'Request Processing Status',
    'RSP_K31': 'Report Confirmation',
    'RSP_Q11': 'Response Query Report',
    'RSP_Z82': 'Report Custom',
    'RSP_Z86': 'Report Query Summary',
    'RSP_Z88': 'Report Result Summary',
    'RSP_Z90': 'Report Processing Result',
    'RTB_K13': 'Result Table Batch Report',
    'RTB_Knn': 'Result Table Custom',
    'RTB_Z74': 'Result Table Z74',
    'SIU_S12': 'Service Information Update',
    'SIU_S13': 'Service Information Request',
    'SIU_S14': 'Service Update Response',
    'SIU_S15': 'Service Change Report',
    'SIU_S16': 'Service Query',
    'SIU_S17': 'Service Status Update',
    'SIU_S18': 'Service Request Response',
    'SIU_S19': 'Service Status Report',
    'SIU_S20': 'Service Request Status',
    'SIU_S21': 'Service Report Status',
    'SIU_S22': 'Service Service Query',
    'SIU_S23': 'Service Service Request',
    'SIU_S24': 'Service Service Report',
    'SIU_S26': 'Service Status Request',
    'SPQ_Q08': 'Special Procedure Query',
    'SQM_S25': 'Scheduled Query Message',
    'SQR_S25': 'Scheduled Query Report',
    'SRM_S01': 'Service Request Message',
    'SRR_S01': 'Service Response Message',
    'SSR_U04': 'Service Status Report',
    'SSU_U03': 'Service Summary Update',
    'SUR_P09': 'Surgical Request',
    'TBR_R08': 'Treatment Report Request',
    'TCU_U10': 'Treatment Update',
    'UDM_Q05': 'User Data Message',
    'VQQ_Q07': 'Verification Query Request',
    'VXQ_V01': 'Vaccination Query',
    'VXR_V03': 'Vaccination Request',
    'VXU_V04': 'Vaccination Update',
    'VXX_V02': 'Vaccination Update'
}


hl7_segment_names = {
    'MSH': 'Message Header',
    'SFT': 'Software Segment',
    'UAC': 'User Authentication',
    'MSA': 'Message Acknowledgment',
    'ERR': 'Error',
    'EVN': 'Event Type',
    'PID': 'Patient Identification',
    'PD1': 'Patient Demographics',
    'ARV': 'Authorization Information',
    'ROL': 'Role',
    'NK1': 'Next of Kin',
    'PV1': 'Patient Visit',
    'PV2': 'Additional Patient Visit Information',
    'DB1': 'Disability Information',
    'OBX': 'Observation Result',
    'AL1': 'Allergy Information',
    'DG1': 'Diagnosis',
    'DRG': 'Diagnosis Related Group',
    'GT1': 'Guarantor Information',
    'ACC': 'Accident Information',
    'UB1': 'Uniform Billing',
    'UB2': 'Uniform Billing Additional',
    'PDA': 'Patient Death',
    'MRG': 'Merge Patient',
    'NPU': 'Nursing Unit',
    'ADT': 'Admit/Discharge/Transfer',
    'ARQ': 'Appointment Request',
    'ARP': 'Appointment Response',
    'PPR': 'Pharmacy Prescription',
    'PPA': 'Pharmacy Administration',
    'RSP': 'Response',
    'SRM': 'Scheduling Request Message',
    'SPM': 'Scheduling Response Message',
    'EAC': 'Equipment Account',
    'EAP': 'Equipment Profile',
    'FAC': 'Facility',
    'GTS': 'General Timing Specifications',
    'LOC': 'Location',
    'MLL': 'Medical/Legal Information',
    'NTE': 'Notes and Comments',
    'ODT': 'Order Detail',
    'OMG': 'Order Message',
    'ORD': 'Order',
    'ORDR': 'Order Detail Response',
    'ORG': 'Order Group',
    'PMU': 'Pharmacy Medication Unit',
    'PRB': 'Problem',
    'PRD': 'Problem Detail',
    'PTR': 'Patient Treatment Request',
    'PV1-1': 'Patient Visit ID',
    'PV1-2': 'Patient Visit Type',
    'PV1-3': 'Attending Doctor',
    'RSB': 'Resource Batch',
    'SSM': 'Scheduling Status Message',
    'SSF': 'Scheduled Status Follow-up',
    'SSM': 'Service Scheduling Message',
    'TQ1': 'Timing/Quantity Information',
    'TQ2': 'Additional Timing/Quantity Information',
    'ZDS': 'Device Segment',
    'ZDG': 'Device Group',
    'ZXX': 'General Segment',
    'ZRI': 'Requested Information',
    'ZRS': 'Requested Service'
}
