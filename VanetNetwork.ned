
import inet.node.inet.Router;
import inet.node.inet.WirelessHost;
import inet.mobility.single.BonnMotionMobility;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

network VanetNetwork
{
    parameters:
        @display("bgb=800,600");
    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,50;i=block/cogwheel");
        }
        vehicle[10]: WirelessHost {
            @display("p=200,100;i=block/vehicle");
            mobility.typename = "BonnMotionMobility";
        }
        rsu[3]: Router {
            @display("p=400,200;i=block/wifiap");
        }
        gateway: Router {
            @display("p=500,300;i=block/router");
        }
    connections allowunconnected:
        for i=0.9, j=0.2 {
            Vehicle[i].wlan[0] <--> RSU[j].wlan[0];
        }
        for j=0.2 {
            RSU[j].wlan[0] <--> Gateway.wlan[0];
        }
}
