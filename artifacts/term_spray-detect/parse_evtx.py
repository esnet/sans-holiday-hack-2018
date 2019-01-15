from xml.dom import minidom

event_names = {'4624': 'Success', '4625': 'Failure'}

# Parse the file
xmldoc = minidom.parse('ho-ho-no.xml')

# Top-node: <Event>
events = xmldoc.getElementsByTagName('Event')

for event in events:
    # Each Event has <System> and <EventData>
    system = event.getElementsByTagName('System')[0]
    eventdata = event.getElementsByTagName('EventData')[0]

    # EventID: <EventID Qualifiers="">4624</EventID>
    eventid = system.getElementsByTagName('EventID')[0].firstChild.nodeValue

    if eventid not in event_names.keys():
        # We don't care about other events
        continue

    # Example: <TimeCreated SystemTime="2018-09-10 12:18:26.972103"></TimeCreated>
    timecreated = system.getElementsByTagName('TimeCreated')[0]
    systemtime = timecreated.attributes['SystemTime'].nodeValue

    # EventData has one ore more <Data> elements
    data_nodes = eventdata.getElementsByTagName('Data')
    for data in data_nodes:
        if data.attributes['Name'].nodeValue == 'TargetUserName':
            username = data.firstChild.nodeValue
        elif data.attributes['Name'].nodeValue == 'IpAddress':
            ipaddress = data.firstChild.nodeValue

    print systemtime, event_names[eventid], username, ipaddress
            
