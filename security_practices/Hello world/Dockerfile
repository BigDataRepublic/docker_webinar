FROM alpine:latest

# Create Docker user and group
COPY ./add_user_group.sh /var/
RUN /var/add_user_group.sh \
    && rm /var/add_user_group.sh

# Copy source files and directories.
COPY --chown=dockerapp:dockerapp ./src /opt/my_model/
USER dockerapp

ENTRYPOINT [ "/opt/my_model/my_script.sh" ]
CMD [ "Docker FTW!" ]