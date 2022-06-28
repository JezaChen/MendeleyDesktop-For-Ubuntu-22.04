# MendeleyDesktop-For-Ubuntu-22.04
重新打包 Mendeley Desktop 的脚本，使其兼容于Ubuntu 22.04

## 为什么需要重新包装？

如果使用`dpkg`直接安装Mendeley的官方安装包，
很大概率上会出现以下错误：

```
dpkg：依赖问题使得mendeleydesktop的配置工作不能继续：
 mendeleydesktop 依赖于 python；然而：
  未安装软件包 python。
```

这是因为从 Debian 11（bullseye）和 Ubuntu 20.04 LTS（focal）开始
发布时，所有 python 包都使用显式的 `python3` 或 `python2` 解释器，并且根本不使用未版本化的 `/usr/bin/python`。
（另见：https://ubuntuforums.org/showthread.php?t=2474380）

因此，这里我们将mendeleydesktop的依赖从python改为python3，将对应的python脚本转换为python3格式，重新打包。

## 用法
确保您已安装 `2to3` 工具，如果没有，请使用 `apt` 安装它：

```shell
sudo apt install 2to3
```

然后下载并执行脚本：

```shell
curl -s https://raw.githubusercontent.com/JezaChen/MendeleyDesktop-For-Ubuntu-22.04/main/repack.sh | bash -s
```

等待几分钟重新打包后，使用`dpkg`安装生成的安装包：

```shell
sudo dpkg -i mendeleydesktop_1.19.8_for_ubuntu_22.04.deb
```

## 相关链接
- [Can't install Mendeley desktop version 1.19.8 on Ubuntu 22.04, from Ubuntu Forum](https://ubuntuforums.org/showthread.php?t=2474380)

- [How to install Mendeley on Ubuntu 22.04, from AskUbuntu](https://askubuntu.com/questions/1405042/how-to-install-mendeley-on-ubuntu-22-04)

