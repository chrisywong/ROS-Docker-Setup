# syntax=docker/dockerfile:1

FROM osrf/ros:humble-desktop-full

RUN apt update && apt install -y --no-install-recommends \
    python3-colcon-common-extensions python3-vcstool python3-rosdep \
    && export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# RUN sudo rosdep init
RUN sudo rosdep fix-permissions
RUN rosdep update

# Install Kinova Gen3 packages
RUN apt install -y \
    ros-$ROS_DISTRO-position-controllers \
    ros-$ROS_DISTRO-ign-ros2-control
RUN apt install -y ros-$ROS_DISTRO-kortex-bringup
RUN apt install -y ros-$ROS_DISTRO-kinova-gen3-7dof-robotiq-2f-85-moveit-config
RUN apt install -y ros-$ROS_DISTRO-kinova-gen3-6dof-robotiq-2f-85-moveit-config
RUN apt install -y ros-$ROS_DISTRO-rmw-cyclonedds-cpp

RUN export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

#RUN export COLCON_WS=/home/$USER/workspace/ros2_kortex_ws
#RUN mkdir -p $COLCON_WS/src

#RUN cd $COLCON_WS \
#    git clone https://github.com/Kinovarobotics/ros2_kortex.git src/ros2_kortex \
#    vcs import src --skip-existing --input src/ros2_kortex/ros2_kortex.$ROS_DISTRO.repos \
#    vcs import src --skip-existing --input src/ros2_kortex/ros2_kortex-not-released.$ROS_DISTRO.repos \
#    vcs import src --skip-existing --input src/ros2_kortex/simulation.humble.repos

# Install MoveIt
RUN apt-get install -y --no-install-recommends \
    ros-$ROS_DISTRO-moveit

RUN rm -rf /var/lib/apt/lists/*
