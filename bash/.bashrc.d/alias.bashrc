alias c='clear'
alias cls='clear'
alias ll='ls -alhF'

# List all installed rpm
alias rpmlist="rpm --query --all --queryformat '%{NAME}.%{ARCH}: %{SUMMARY}\n'"

# Reboot to Windows if dual boot
reboot_to_windows ()
{
    windows = $(grep -i windows /boot/grub2/grub.cfg | cut -d "'" -f 2)
}
alias reboot-to-windows='reboot_to_windows'
