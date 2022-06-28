# MendeleyDesktop-For-Ubuntu-22.04
Script to repackage Mendeley Desktop for compatibility with Ubuntu 22.04

## Why repackage?

If you use `dpkg` to install Mendeley's official installation package directly,
there is a high probability that the following errors will occur:

```
dpkg: dependency problems prevent configuration of mendeleydesktop:
 mendeleydesktop depends on python; however:
  Package python is not installed.
```

This is because starting with Debian 11 (bullseye) and Ubuntu 20.04 LTS (focal)
When published, all python packages use an explicit `python3` or `python2` interpreter, and do not use the unversioned `/usr/bin/python` at all.
(See also: https://ubuntuforums.org/showthread.php?t=2474380)

Therefore, here we change the dependency of mendeleydesktop from python to python3, convert the corresponding python script to python3 format, and repackage it.

## Usage
Make sure you have the `2to3` tool installed, if not, install it with `apt`:

```shell
sudo apt install 2to3
```

Then download and execute the script:

```shell
curl https://raw.githubusercontent.com/JezaChen/MendeleyDesktop-For-Ubuntu-22.04/main/repack.sh | bash -s
```

After waiting for a few minutes of repackaging, use `dpkg` to install the generated installation package:

```shell
sudo dpkg -i mendeleydesktop_1.19.8_for_ubuntu_22.04.deb
```

## Related Links
- [Can't install Mendeley desktop version 1.19.8 on Ubuntu 22.04, from Ubuntu Forum](https://ubuntuforums.org/showthread.php?t=2474380)

- [How to install Mendeley on Ubuntu 22.04, from AskUbuntu](https://askubuntu.com/questions/1405042/how-to-install-mendeley-on-ubuntu-22-04)
