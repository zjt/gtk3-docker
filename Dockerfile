FROM pritunl/archlinux:latest

EXPOSE 8085

RUN pacman --noconfirm -S gtk3 xfce4 midori mypaint gedit nautilus gnome-mines htop gcc pkg-config
RUN pacman --noconfirm -S base-devel
RUN perl -MCPAN -e 'force install Test::Block'
RUN perl -MCPAN -e 'force install Eval::Context'
RUN perl -MCPAN -e 'install App::Asciio'

ADD dock/dock.c /opt/dock.c
RUN cd /opt/ && \
    gcc `pkg-config --cflags gtk+-3.0` -o dock dock.c `pkg-config --libs gtk+-3.0`

ENV GDK_BACKEND broadway
ENV BROADWAY_DISPLAY :5

ADD init.sh /init.sh
CMD ["/init.sh"]
