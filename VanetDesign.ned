package vanetdesign;

import inet.node.inet.StandardHost;
import inet.mobility.single.RandomWaypointMobility;
import inet.mobility.group.MassMobility;
import inet.networklayer.autorouting.flat.FlatNetworkConfigurator;
import inet.visualizer.integrated.IntegratedVisualizer;

network VANETDesign
{
    parameters:
        int numVehicles = default(10);                // Number of vehicles
        double communicationRange = default(300m);    // Communication range
        double maxSpeed = default(20mps);             // Maximum speed of vehicles
        string mobilityType = default("RandomWaypointMobility"); // Mobility model
        double areaX = default(1000m);                // X-axis constraint area
        double areaY = default(1000m);                // Y-axis constraint area
    submodules:
        visualizer: IntegratedVisualizer {
            @display("p=100,50"); // Visualizer to see movement and communication links
        }
        configurator: FlatNetworkConfigurator {
            @display("p=300,50"); // Auto-assign IP addresses
        }
        vehicle[numVehicles]: StandardHost {
            @display("i=device/car, p=rand"); // Icon representing vehicles
            mobility: <mobilityType> {
                initialX = uniform(0, areaX);         // Random initial X position
                initialY = uniform(0, areaY);         // Random initial Y position
                speed = uniform(10mps, maxSpeed);     // Vehicle speed between min and max
                constraintAreaX = areaX;              // X boundary for movement
                constraintAreaY = areaY;              // Y boundary for movement
            }
            wlan[0].radio.transmitter.communicationRange = communicationRange; // Communication range
            wlan[0].radio.transmitter.datarate = 6Mbps;  // Bandwidth setting
            wlan[0].radio.receiver.sensitivity = -85dBm; // Sensitivity threshold for wireless signals
        }
}
