#include <ros/ros.h>
#include <reactor_control/reactorTelemetry.h>
#include <reactor_control/armCmd.h> 
 
//// current position callback ////
// for subscribing to telemetry
ros::Publisher telem_pub;
reactor_control::reactorTelemetry telem_echo;
void cmdCallback(const reactor_control::armCmd::ConstPtr &msg){
 
    for(int i=0; i<msg->angle.size(); i++){
        telem_echo.angle[i]=msg->angle[i]; 
    }

    telem_pub.publish(telem_echo);
}

 


//// main ////
int main(int argc, char **argv) {
    ros::init(argc, argv, "reactor_sim_echo");

    // prep for ROS communcation
    ros::NodeHandle n; 

    ros::Subscriber cmd_sub = n.subscribe("/arbotixM/armCmd", 10, cmdCallback); // robot feedback

    telem_pub = n.advertise<reactor_control::reactorTelemetry>("/arbotixM/reactorTelemetry", 10);
 
 
    ros::spin();
 

} // end main