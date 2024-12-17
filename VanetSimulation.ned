network VanetSimulation
{
    submodules:
        // Define vehicles as mobile nodes (AdhocHosts)
        vehicle[10]: AdhocHost {
            @display("p=200+50*i;is=rcu");
        }
        // Define Access Point (RSU or Edge Computing Node)
        accessPoint: WirelessAccessPoint {
            @display("p=100,100");
        }
    connections:
        // Connections between vehicles and access point (RSU)
        for i=0..9 {
            vehicle[i].wlanRadio <--> wlan { accessPoint.wlanRadio; }
        }
}
