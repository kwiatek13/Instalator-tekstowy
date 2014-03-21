#!/usr/bin/env ruby
#Domyślna tabulacja dokumentu - 4 spacje

	system "locale-gen"
	system "export LANG=pl_PL.UTF-8"
	system "loadkeys pl"
	system "setfont Lat2-Terminus16"
	system "ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime"
	system "hwclock --systohc --utc"

	puts "Prosze podac nazwe komputera:"
	$Hostname = gets.chomp!
	system "echo #{$Hostname} > /etc/hostname"
	puts ""
	puts ""

	puts "Prosze wybrac sterownik pod posiadana karte graficzna: (1 - Nvidia, 2 - Nvidia, modele starszej serii od 8000, 3 - Ati, 4 - Intel, 5 - Vesa, 6 - Virtualbox)"
	$VideoDriver = gets.chomp!
	puts ""
	puts ""

	$ListaPaczek = ""

	puts "Czy chcesz dodac menedzer logowania (t), lub ustawic autologowanie dla utworzonego uzytkownika (n)?"
	$LoginManager = gets.chomp!
	if $LoginManager == "t"
		$ListaPaczek << "lxdm "
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac usprawnienie obslugi touchpada ? t/n"
	$TouchPad = gets.chomp!
	if $TouchPad == "t"
		$ListaPaczek << "xf86-input-synaptics "
	elsif $TouchPad == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac pakiet biurowy Libre Office ? t/n"
	$OfficeSet = gets.chomp!
	if $OfficeSet == "t"
		$ListaPaczek << "libreoffice libreoffice-pl "
	elsif $OfficeSet == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac program Dropbox ? t/n"
	$CloudDisk = gets.chomp!
	if $CloudDisk == "t"
		$ListaPaczek << "dropbox "
	elsif $CloudDisk == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac notyfikacje o aktualizacjach i menedzer pakietow ? t/n"
	$PackageSet = gets.chomp!
	if $PackageSet == "t"
		$ListaPaczek << "pyalpm-manjaro pamac-aur "
	elsif $PackageSet == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac odtwarzacz muzyki Audacious ? t/n"
	$MusicPlayer = gets.chomp!
	if $MusicPlayer == "t"
		$ListaPaczek << "audacious "
	elsif $MusicPlayer == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac odtwarzacz wideo VLC Player ? t/n"
	$VideoPlayer = gets.chomp!
	if $VideoPlayer == "t"
		$ListaPaczek << "vlc "
	elsif $VideoPlayer == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac komunikator Pidgin (Obsluga Gadu-gadu i Facebook) ? t/n"
	$Communicator = gets.chomp!
	if $Communicator == "t"
		$ListaPaczek << "pidgin "
	elsif $Communicator == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac Steam ? t/n"
	$GamesPlatform = gets.chomp!
	if $GamesPlatform == "t"
		$ListaPaczek << "steam "
	elsif $GamesPlatform == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac komunikator Skype ? t/n"
	$VoiceChat = gets.chomp!
	if $VoiceChat == "t"
		$ListaPaczek << "skype "
	elsif $VoiceChat == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac program Wine ? t/n"
	$Wine = gets.chomp!
	if $Wine == "t"
		$ListaPaczek << "wine wine-mono wine_gecko "
	elsif $Wine == "n"
		print "Zrezygnowano z instalacji programu."
	end
	puts ""
	puts ""

	puts "Czy chcesz zainstalowac program graficzny Gimp ? t/n"
	$RasterGraphicEditor = gets.chomp!
	if $RasterGraphicEditor == "t"
		$ListaPaczek << "gimp "
	elsif $RasterGraphicEditor == "n"
		print "Zrezygnowano z instalacji programu."
	end

	system "pacman -S grub-bios os-prober --noconfirm"
	system "rm /etc/default/grub"
	system "mv /etc/nexia/grub /etc/default"
	system "grub-install --recheck /dev/sda"
	system "cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo"
	system "grub-mkconfig -o /boot/grub/grub.cfg"
	puts ""
	puts ""

	if $VideoDriver == "1"
		system "pacman -S nvidia nvidia-libgl --noconfirm"
	elsif $VideoDriver == "2"
		system "pacman -S nvidia-304xx nvidia-304xx-libgl --noconfirm"
	elsif $VideoDriver == "3"
		system "pacman -S xf86-video-ati --noconfirm"
	elsif $VideoDriver == "4"
		system "pacman -S xf86-video-intel --noconfirm"
	elsif $VideoDriver == "5"
		system "pacman -S xf86-video-vesa --noconfirm"
	elsif $VideoDriver == "6"
		system "pacman -S virtualbox-guest-utils --noconfirm"
	end

	system "( echo [repo32] ; echo SigLevel = Never ; echo Server = https://dl.dropboxusercontent.com/u/44000136/Repo32/) >> /etc/pacman.conf"
	system "pacman -Syy"
	system "pacman -S phonon-gstreamer bash-completion xorg-server xorg-xinit cinnamon cinnamon-control-center nemo gnome-terminal ntfs-3g conky xdg-user-dirs chromium chromium-pepper-flash  xterm alsa-utils gksu gedit p7zip wxgtk shotwell gnome-system-monitor gnome-keyring base-devel cinnamon-screensaver gnome-calculator evince gnome-screenshot nemo-fileroller #{$ListaPaczek} --noconfirm"
	puts ""
	puts ""

	system "rm /etc/skel/.xinitrc"
	system "mv /home/.xinitrc /etc/skel"

	puts "Prosze podac nazwe uzytkownika(bez duzych liter!):"
	$UserName = gets.chomp!
	system "useradd -m -G users,audio,lp,optical,storage,video,wheel,power -s /bin/bash #{$UserName}"
	system "passwd #{$UserName}"
	puts ""
	puts ""

	puts "Prosze podac haslo dla uzytkownika root:"
	system "passwd root"
	puts ""
	puts ""

	system "systemctl enable NetworkManager.service"
	system "systemctl disable dhcpcd.service"
	system "systemctl disable dhcpcd@.service"
	system "systemctl enable wpa_supplicant.service"
	system "gpasswd -a #{$UserName} network"

	system "mv /etc/Minty /usr/share/themes"
	system "mv /etc/Czcionki/'Prime Light.otf' /usr/share/fonts/TTF"
	system "mv /etc/Czcionki/'Prime Regular.otf' /usr/share/fonts/TTF"
	system "rm -R /etc/Czcionki"
	system "mv /etc/Skorki/'Teal Blue + Black/' /usr/share/themes"
	system "rm -R /etc/Skorki"
	system "mv /etc/NITRUX /usr/share/icons"
	system "mv /etc/NITRUX-Buttons /usr/share/icons"
	system "rm /etc/sudoers"
	system "mv /home/sudoers /etc"

	if $LoginManager == "t"
		system "rm /etc/lxdm/lxdm.conf"
		system "mv /home/lxdm.conf /etc/lxdm"
		system "systemctl enable lxdm"
	elsif $LoginManager == "n"
		system "( echo [Service] ; echo ExecStart= ; echo ExecStart=-/sbin/agetty --autologin #{u} --noclear %I 38400 linux) >> /etc/systemd/system/getty@tty1.service.d/autologin.conf"
		system "rm /home/lxdm.conf"
		system "rm /etc/nexia/lxbg.png"
	end
	puts ""
	puts ""

	puts "Instalacja zakonczona! Prosze nacisnac enter aby zakonczyc."
	wyjscie = gets.chomp!
	system "exit"
