# Temp Core Image
FROM microsoft/windowsservercore AS core

ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.4
ENV DEVKIT_VERSION 4.7.2
ENV DEVKIT_BUILD 20130224-1432

RUN mkdir C:\\tmp

ADD https://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-${RUBY_VERSION}-x64.exe C:\\tmp
RUN C:\\tmp\\rubyinstaller-%RUBY_VERSION%-x64.exe /silent /dir="C:\Ruby22_x64" /tasks="assocfiles,modpath"

ADD https://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-${DEVKIT_VERSION}-${DEVKIT_BUILD}-sfx.exe C:\\tmp
RUN C:\\tmp\\DevKit-mingw64-64-%DEVKIT_VERSION%-%DEVKIT_BUILD%-sfx.exe -o"C:\DevKit" -y

# Final Nano Image
FROM microsoft/nanoserver AS nano

ENV RUBYGEMS_VERSION 2.6.13
ENV BUNDLER_VERSION 1.15.4

COPY --from=core C:\\Ruby22_x64 C:\\Ruby22_x64
COPY --from=core C:\\DevKit C:\\DevKit

RUN setx PATH %PATH%;C:\DevKit\bin;C:\Ruby22_x64\bin -m
RUN echo - C:\\Ruby22_x64 > config.yml
RUN ruby C:\\DevKit\\dk.rb install

RUN mkdir C:\\tmp

ADD https://rubygems.org/gems/rubygems-update-${RUBYGEMS_VERSION}.gem C:\\tmp
RUN gem install --local C:\tmp\rubygems-update-%RUBYGEMS_VERSION%.gem

RUN update_rubygems
RUN gem install bundler --version %BUNDLER_VERSION%

CMD [ "irb" ]
