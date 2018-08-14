FROM archlinux/base

RUN useradd -m builduser
RUN passwd -d builduser

RUN rm -fr /etc/pacman.d/gnupg

RUN pacman-key --init
RUN pacman-key --populate archlinux

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm sudo

RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers

RUN pacman -S --noconfirm git make fakeroot gcc binutils gettext ttf-bitstream-vera which libva-mesa-driver libva-intel-driver awk file

RUN sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/qt5-webengine-widevine.git qt5-webengine-widevine && cd qt5-webengine-widevine && makepkg -si --noconfirm'
RUN sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/qtwebflix-git.git qtwebflix-git && cd qtwebflix-git && makepkg -si --noconfirm'
