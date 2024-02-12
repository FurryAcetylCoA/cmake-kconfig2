# cmake-kconfig2

适用于cmake的最简化Kconfig集成。部分代码来自Zephyr 和 [cmake-kconfig](https://github.com/dlebed/cmake-kconfig/)

含有以下更改：
* 激进地移除任何不相关的东西
* 使用原版kconfig而不是kconfiglib （整个项目的唯一目的)
* 不再支持从cmake命令行导入kconfig设置
* 更多的bug更少的功能
