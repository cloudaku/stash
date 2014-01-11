# Install Atlassian Stash
# This is a trusted build, we need postgresql
FROM linux/postgres

MAINTAINER Tom Eklöf tom@linux-konsult.com

# Prepare all the files
ENV AppName stash
ENV AppVer 2.10.1
ENV STASH_HOME /data/stash-home
ENV STASHUSR stash
ADD http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-2.10.1.tar.gz /opt/atlassian/
ADD ./postgresql-9.2.1.tar.gz /opt/chef/embedded/
ADD ./chef/recipes/stash.rb /etc/chef/cookbooks/database/recipes/stash.rb
ADD ./install_cmds.sh /install_cmds.sh
ADD ./node.json /etc/chef/node.json
ADD ./postgres.sh /postgres.sh
ADD ./init.sh /init.sh
ADD ./install_cmds.sh /install_cmds.sh

# Uncomment to enable backup of files on host
# VOLUME ["/data"]

## Now Install Atlassian Jira
RUN /install_cmds.sh

# Start the service
CMD ["sh", "/init.sh"]
EXPOSE 7990
