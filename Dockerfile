FROM microsoft/nanoserver

RUN mkdir C:\\tmp
RUN mkdir C:\\DevKit

WORKDIR C:\\DevKit

SHELL ["powershell"]

RUN $global:VerbosePreference = 'SilentlyContinue' ; \
    Install-Module -Name NuGet ; \
    Install-Module -Name 7Zip4PowerShell

ADD https://dl.bintray.com/oneclick/rubyinstaller/ruby-2.2.4-x64-mingw32.7z C:\\tmp
RUN Expand-7Zip -ArchiveFileName C:\\tmp\\ruby-2.2.4-x64-mingw32.7z -TargetPath C:\\Ruby224-x64

# ADD https://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe C:\\tmp
# RUN Expand-7Zip -ArchiveFileName C:\\tmp\\DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe -TargetPath C:\\DevKit

# SHELL ["cmd"]

# RUN rmdir /S /Q c:\\tmp

# RUN echo - C:/Ruby224-x64 > config.yml
# RUN ruby dk.rb install

CMD ["ruby","-v"]
