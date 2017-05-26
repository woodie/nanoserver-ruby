# nanoserver-ruby

Ruby on nano server is a dynamic, reflective, object-oriented, general-purpose, open-source programming language.

The `windowscoreserver` image does everything we need, but it's a behemoth. The `nanoserver` image is a fraction of the size, but installers and package managers fail. Docker for Window Community Edition has no support for sharing host volumes, so getting installed files out of a `windowscoreserver` container is not obvious. Fortunately, using a multi-stage build is the perfect solution.

Note: This will only build on a Windows machine with ample memory and disk space.

    +------------------------------------+
    |  FROM microsoft/nanoserver as base |--+
    +------------------------------------+  |
                                            |
    +----------------------------------+    |
    | FROM microsoft/windowsservercore |    |
    +----------------------------------+    |
    | Install rd to C:\Ruby22_x64      |    |
    | Install dk to C:\DevKit  |       |    |
    +----------------------|---|-------+    |
                           |   |            |
    +----------------------|---|-------+    |
    | FROM base            |   |       | <--+
    +----------------------|---|-------+
    | Copy files           |   |       |
    | C:\DevKit         <--+   |       |
    | C:\Ruby22_x64     <------+       |
    | Setup the environment            |
    +----------------------------------+
