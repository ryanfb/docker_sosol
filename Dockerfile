FROM ubuntu:trusty
MAINTAINER Ryan Baumann <ryan.baumann@gmail.com>

# Install the Ubuntu packages.
# The Duke mirror is just added here as backup for occasional main flakiness.
RUN echo deb http://archive.linux.duke.edu/ubuntu/ trusty main >> /etc/apt/sources.list 
RUN echo deb-src http://archive.linux.duke.edu/ubuntu/ trusty main >> /etc/apt/sources.list
RUN apt-get update

# Install Ruby, RubyGems, Bundler, MySQL, Git, wget, svn, java
RUN apt-get install -y mysql-server git wget subversion openjdk-7-jre
# Install ruby-build build deps
RUN apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# Set the locale.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
WORKDIR /root

# Install rbenv/ruby-build
RUN git clone git://github.com/sstephenson/rbenv.git .rbenv
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
RUN echo 'eval "$(rbenv init -)"' > /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh
RUN git clone git://github.com/sstephenson/ruby-build.git #.rbenv/plugins/ruby-build
RUN cd ruby-build; ./install.sh

# Clone the repository
RUN git clone https://github.com/sosol/sosol.git
RUN cd sosol; git branch --track rails-3 origin/rails-3
RUN cd sosol; git checkout rails-3

# Copy in secret files
ADD development_secret.rb /root/sosol/config/environments/development_secret.rb
ADD test_secret.rb /root/sosol/config/environments/test_secret.rb
ADD production_secret.rb /root/sosol/config/environments/production_secret.rb

# Configure MySQL
RUN service mysql restart; cd sosol; ./script/setup

# Finally, start the application
EXPOSE 3000
CMD service mysql restart; cd sosol; ./script/server
