FROM alpine:latest

COPY ./add_user_group.sh /var/
RUN /var/add_user_group.sh \
    && rm /var/add_user_group.sh

USER dockerapp

ENTRYPOINT [ "/bin/sh" ]

