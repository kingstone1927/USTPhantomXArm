/*********************************************************************
 * Software License Agreement (BSD License)
 *
 *  Copyright (c) 2015, University of Colorado, Boulder
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above
 *     copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided
 *     with the distribution.
 *   * Neither the name of the Univ of CO, Boulder nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 *  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 *  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 *  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *  POSSIBILITY OF SUCH DAMAGE.
 *********************************************************************/

/* Author: Dave Coleman
   Desc:   Example ros_control hardware interface that performs a perfect control loop for
   simulation
*/

#include <reactor_control/reactor_hw_interface.h>


namespace reactor_ns
{
ReactorHWInterface::ReactorHWInterface(ros::NodeHandle& nh, urdf::Model* urdf_model)
  : ros_control_boilerplate::GenericHWInterface(nh, urdf_model)
{
  telemetry_sub=nh.subscribe("/arbotixM/reactortelemetry",1,&ReactorHWInterface::telemetryCallback, this);
  cmd_pub=nh.advertise<reactor_control::armCmd>("/arbotixM/armCmd",1);
  ROS_INFO("reactorHWinterface contructed");
}
void ReactorHWInterface::telemetryCallback(const reactor_control::reactorTelemetry::ConstPtr &msg){
/*#Header header 
float32[6] angle # degrees
float32[6] vel # deg/s
float32[6] current # amps
#time armReadTimestamp 
time startSyncTime 
uint32 isrTicks # this would overflow if the robot is left on for 497 days straight at 100 hz 
uint8 bufferHealth

    // States
  std::vector<double> joint_position_;
  std::vector<double> joint_velocity_;
  std::vector<double> joint_effort_;
*/
  for (int i=0; i<num_joints_; i++){
    joint_position_[i]=msg->angle[i]*DEG_TO_RAD;
    joint_velocity_[i]=msg->vel[i]*DEG_TO_RAD;
  }

}

void ReactorHWInterface::init()
{
  // Call parent class version of this function
  GenericHWInterface::init();

  ROS_INFO_NAMED(name_, "ReactorHWInterface Ready.");
}

void ReactorHWInterface::read(ros::Duration& elapsed_time)
{
  // No need to read since our write() command populates our state for us
  ros::spinOnce();
}

void ReactorHWInterface::write(ros::Duration& elapsed_time)
{
  // Safety
  //enforceLimits(elapsed_time);
  /*
  float[6] current #amp
  float[6] accel #deg/s^2
  float[6] vel #deg/s
  float[6] angle #deg
  uint32 msg_ctr  # count number of messages to detect missed msgs


  // Commands
  std::vector<double> joint_position_command_;
  std::vector<double> joint_velocity_command_;
  std::vector<double> joint_effort_command_;
   */
  static reactor_control::armCmd arm_cmd;
  for(int i=0; i<num_joints_; i++) {
    arm_cmd.angle[i]  = joint_position_command_[i]*RAD_TO_DEG;
    arm_cmd.vel[i]  = joint_velocity_command_[i]*RAD_TO_DEG;
  }
  cmd_pub.publish(arm_cmd);
}

void ReactorHWInterface::enforceLimits(ros::Duration& period)
{
  // Enforces position and velocity
  //pos_jnt_sat_interface_.enforceLimits(period);
}


}  // namespace reactor_ns
