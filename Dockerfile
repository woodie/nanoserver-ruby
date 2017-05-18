FROM microsoft/nanoserver

RUN mkdir C:\\tmp
RUN mkdir C:\\DevKit

WORKDIR C:\\DevKit

SHELL ["powershell"]

RUN Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force ; \
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted ; \
    Install-Module -Name 7Zip4Powershell -Confirm:$false 

ADD https://dl.bintray.com/oneclick/rubyinstaller/ruby-2.2.4-x64-mingw32.7z C:\\tmp
# RUN Expand-7Zip -ArchiveFileName C:\\tmp\\ruby-2.2.4-x64-mingw32.7z -TargetPath C:\\Ruby224-x64

ADD https://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe C:\\tmp
# RUN Expand-7Zip -ArchiveFileName C:\\tmp\\DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe -TargetPath C:\\DevKit

# SHELL ["cmd"]

# RUN rmdir /S /Q c:\\tmp

# RUN echo - C:/Ruby224-x64 > config.yml
# RUN ruby dk.rb install

# CMD ["ruby","-v"]
