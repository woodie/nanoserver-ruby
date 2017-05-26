# nanoserver-ruby

Ruby on nano server is a dynamic, reflective, object-oriented, general-purpose, open-source programming language.

The `microsoft/nanoserver` base image has a small footprint, but does not include graphics libraries or the .NET Framework. The 7-Zip utility and Chocolatey package manager don't currently work on Nano because they require .NET. Further, most EXE installers and all MSI installers don't work on Nano. The `microsoft/windowscoreserver` has none of these issues, but the footprint is ten times larger.

    REPOSITORY                        SIZE
    microsoft/nanoserver           1.02 GB
    microsoft/windowsservercore   10.20 GB

Fortunately, multi-stage build is the perfect solution. We can install everyting into a `microsoft/windowscoreserver` container, and then copy the bits we need into a `microsoft/nanoserver` container. The `nanoserver-ruby` image is small and should work fine for most applications, but we can always fall back to using the `windowscoreserver-ruby` image as long as we have ample resources. 

    REPOSITORY                        SIZE
    nanoserver-ruby                1.52 GB
    windowsservercore-ruby        10.80 GB

Docker for Window Community Edition has no support for sharing host volumes, so using multi-stage build to copy files between containers is the obvious solution.

    +------------------------------------+
    |  FROM microsoft/nanoserver as nano |--+
    +------------------------------------+  |
                                            |
    +----------------------------------+    |
    | FROM microsoft/windowsservercore |    |
    +----------------------------------+    |
    | Install rb to C:\Ruby22_x64      |    |
    | Install dk to C:\DevKit  |       |    |
    +----------------------|---|-------+    |
                           |   |            |
    +----------------------|---|-------+    |
    | FROM nano            |   |       | <--+
    +----------------------|---|-------+
    | Copy files           |   |       |
    | C:\DevKit         <--+   |       |
    | C:\Ruby22_x64     <------+       |
    | Setup the environment            |
    +----------------------------------+
