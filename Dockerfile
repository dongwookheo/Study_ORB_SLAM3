FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Install related build tools
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y vim && \
    apt-get install -y cmake && \
    apt-get install -y git && \
    apt-get install -y sudo && \
    apt-get install -y wget && \
    apt-get install -y ninja-build && \
    apt-get install -y software-properties-common && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install CLion dependencies
RUN apt-get update && \
    apt-get install -y ssh && \
    apt-get install -y gcc && \
    apt-get install -y g++ && \
    apt-get install -y gdb && \
    apt-get install -y clang && \
    apt-get install -y rsync && \
    apt-get install -y tar && \
    apt-get install -y mesa-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install X11 related packages
RUN apt-get update && \
    apt-get install -y libgl1-mesa-glx && \
    apt-get install -y libglu1-mesa-dev && \
    apt-get install -y mesa-common-dev && \
    apt-get install -y x11-utils && \
    apt-get install -y x11-apps && \
    apt-get install -y zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ORB-SLAM3 dependencies
RUN apt-get update && \
    apt-get install -y pkg-config && \
    apt-get install -y libgtk-3-dev && \
    apt-get install -y libavcodec-dev && \
    apt-get install -y libavformat-dev && \
    apt-get install -y libswscale-dev && \
    apt-get install -y libv4l-dev && \
    apt-get install -y libxvidcore-dev && \
    apt-get install -y libx264-dev && \
    apt-get install -y libjpeg-dev && \
    apt-get install -y libpng-dev && \
    apt-get install -y libtiff-dev && \
    apt-get install -y gfortran && \
    apt-get install -y openexr && \
    apt-get install -y libatlas-base-dev && \
    apt-get install -y python3-dev && \
    apt-get install -y python3-numpy && \
    apt-get install -y libpython2.7-dev && \
    apt-get install -y libtbb2 && \
    apt-get install -y libtbb-dev && \
    apt-get install -y libdc1394-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install OpenCV & OpenCV_contrib
RUN apt-get update && \
    apt-get install -y libgtk2.0-dev && \
    apt-get clean
RUN cd / && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/refs/tags/4.5.4.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/refs/tags/4.5.4.zip && \
    unzip opencv.zip && \
    unzip opencv_contrib.zip && \
    cd opencv-4.5.4 && \
    mkdir build && cd build && \
    cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXTRA_MODULES_PATH=../../opencv_contrib-4.5.4/modules .. && \
    ninja && ninja install

# Install Pangolin
RUN apt-get update && \
    apt-get install -y libgl1-mesa-dev && \
    apt-get install -y libwayland-dev && \
    apt-get install -y libxkbcommon-dev && \
    apt-get install -y wayland-protocols && \
    apt-get install -y libegl1-mesa-dev && \
    apt-get install -y libc++-dev && \
    apt-get install -y libglew-dev && \
    apt-get install -y libeigen3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN cd / && \
    wget -O pangolin.zip https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.zip && \
    unzip pangolin.zip && \
    cd Pangolin-0.6 && \
    mkdir build && cd build && \
    cmake -GNinja .. -DCMAKE_BUILD_TYPE=Release && \
    ninja && ninja install

# Install Eigen
RUN cd / && \
    wget -O eigen.zip https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.zip && \
    unzip eigen.zip && \
    cd eigen-3.3.9 && \
    mkdir build && cd build && \
    cmake -GNinja .. -DCMAKE_BUILD_TYPE=Release && \
    ninja install

# Install easy_profiler
RUN cd / && \
    wget -O easy_profiler.zip https://github.com/yse/easy_profiler/archive/refs/tags/v2.1.0.zip && \
    unzip easy_profiler.zip && \
    cd easy_profiler-2.1.0 && \
    mkdir build && cd build && \
    cmake -GNinja .. -DCMAKE_BUILD_TYPE=Release && \
    ninja && ninja install

# Install spdlog
RUN cd / && \
    wget -O spdlog.zip https://github.com/gabime/spdlog/archive/refs/tags/v1.14.1.zip && \
    unzip spdlog.zip && \
    cd spdlog-1.14.1 && \
    mkdir build && cd build && \
    cmake -GNinja .. -DCMAKE_BUILD_TYPE=Release && \
    ninja && ninja install

RUN apt-get clean

# Install ORB-SLAM3
RUN apt-get update && \
    apt-get install libboost-all-dev -y && \
    apt-get install libboost-serialization-dev -y && \
    apt-get install libssl-dev -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN cd / && \
    git clone https://github.com/UZ-SLAMLab/ORB_SLAM3.git && \
    cd ORB_SLAM3 && \
    sed -i "s/++11/++14/g" CMakeLists.txt && \
    chmod +x build.sh && \
    ./build.sh
