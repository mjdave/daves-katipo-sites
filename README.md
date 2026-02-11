# daves-katipo-sites
This will be a collection of sites that can be hosted over katipo.

For now, the only app here is Waraki. Waraki is an MP3 player app and hosting service, allowing you to keep playlists in sync automatically over a network with a home server.

You can clone this repository, install a couple of dependencies, and run it on any server or desktop that has a music library in a directory.

Then you can install the Katipo browser app on various devices, phones, desktops, and use it to sync your playlists wirelessly and play music anywhere offline.

The general idea is that it is playlist based, so it only synchronizes the actual music songs that are in one or more playlists. You can then currently only shuffle play playlists by clicking/tapping them. It supports bluetooth control and displays the song title and image in iOS. Currently .m4a files are only supported on Apple platforms, not Windows or Linux, and there are some problems with files that contain non-ascii characters, with a fair few other issues that will be resolved in time.

# Instructions using cmake
WarakiServer has been tested on macOS, Raspberry Pi OS and Ubuntu, and it will work on Windows, just use the Visual Studio solutions to build the Katipo apps.

For cmake:
Install basic dependencies if needed, clone this repository
```
sudo apt install git
sudo apt-get install build-essential cmake
git clone https://github.com/mjdave/daves-katipo-sites
```

Clone the submodules katipo, tui and glm
```
cd daves-katipo-sites/
git submodule update --init --recursive
```

Edit the config.tui file to point to your music directory. The music directory can contain nested directories filled with mp3s, m4As, oggs, flac files, but not all formats will be supported on all platforms, YMMV. It will also read in .m3u playlist files, though it will not support every different type of .m3u file either. Feel free to edit warakiServer/libraryCrawler to parse your specific files, it's pretty simple code, or file an issue on github. But ultimately this will be a one step thing to bring in old playlists. In the future they will be exported out to .tuib files or to a database.

```
nano warakiServer/config.tui
```

Build and start the tracker and then the host
```
./startTracker.sh
./startWarakiServer.sh
```

# If libsodium isn't found

If this doesn't work due to libsodium issues, you are probably not running on one of the platforms where that library is supplied with katipo. Here's an example that compiles for the raspberry pi:
```
wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.21-stable.tar.gz
tar -xzf libsodium-1.0.21-stable.tar.gz libsodium-stable
cd libsodium-stable/
./configure --prefix=$HOME/daves-katipo-sites/katipo/thirdParty/libsodium/pi
make
make install
```
And then you can edit this section of CmakeLists.txt in katipo/katipoHost and katipo/katipoTracker to use this (thirdParty/libsodium/pi in the example) instead of the prebuilt Ubuntu version. All a bit clunky, but it works.
```
if(APPLE)
    include_directories(../../thirdParty/libsodium/macos/include)
    target_link_libraries(katipoTracker ${CMAKE_SOURCE_DIR}/../../thirdParty/libsodium/macos/lib/libsodium.a)
elseif(WIN32)
    include_directories(../../thirdParty/libsodium/windows/include)
    #target_link_libraries(katipoTracker ${CMAKE_SOURCE_DIR}/../../thirdParty/libsodium/windows/lib/libsodium.a) #hmm
else()
    include_directories(../../thirdParty/libsodium/pi/include)
    target_link_libraries(katipoTracker ${CMAKE_SOURCE_DIR}/../../thirdParty/libsodium/pi/lib/libsodium.a)
endif()
```