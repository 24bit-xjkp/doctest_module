# 模块化doctest

Doctest测试框架作为一个header only库，含有约10k行代码，同时包含了大量c++标准库文件。
直接通过`#include`使用会导致在 不同翻译单元间反复处理这些代码，进而导致编译速度下降。
C++ 20标准引入了模块，同时C++ 23标准引入了标准库模块`std`和`std.compat`，这使得加速header only库编译成为可能。

## 用法

首先编译`doctest`模块，然后在源文件中引入头文件`doctest_macros.hpp`和`doctest`模块即可。

```cpp
// 包含doctest提供的宏定义
#include <doctest_macros.hpp>
// 包含doctest提供的声明
import doctest;
// import std; // 按需导入标准库模块

// 下面即可正常使用doctest框架
TEST_CAST("test")
{
    CHECK(true);
}
```

## 与xmake集成

在[该文件](script/package.lua)中提供了xmake包描述，可在xmake中直接使用。

```lua
-- 通过该文件获得包描述
includes("package.lua")
-- 引入包依赖
add_requires("doctest_module")
set_policy("build.c++.modules", true)

target("test")
    -- doctest单元测试文件，不包含main函数定义
    add_files("test.cpp")
    -- 添加doctest_module包的main组件，包含默认的main函数定义
    add_packages("doctest_module", { components = "main" })

target("test_with_custom_main")
    -- custom_main.cpp中包含自定义的main函数
    add_files("test.cpp", "custom_main.cpp")
    -- 添加doctest_module包的core组件，不包含main函数定义
    add_packages("doctest_module", { components = "core" })
```

`doctest_module`包包含的组件如下表所示。

| 组件 | 说明                                  |
| ---- | ------------------------------------- |
| core | 包含doctest模块的声明、定义以及宏定义 |
| main | 依赖core组件，提供默认的main函数定义  |

`doctest_module`包除xmake默认选项外包含的额外选项如下表所示。

| 选项       | 说明                      |
| ---------- | ------------------------- |
| main       | 启用main组件支持          |
| std_harden | 构建包时启用C++标准库加固 |

## 项目结构

| 文件                   | 说明                                                                             |
| ---------------------- | -------------------------------------------------------------------------------- |
| script/option.lua      | 提供项目所需的构建选项定义                                                       |
| script/package.lua     | 提供xmake包描述                                                                  |
| script/task.lua        | 提供xmake插件用于测试xmake包描述                                                 |
| src/doctest_fwd.hpp    | 内部头文件，提供doctest所需的系统头，并通过宏定义取消对所有C++标准库头文件的导入 |
| src/doctest_impl.cpp   | 提供doctest函数定义，编译成静态库或动态库                                        |
| src/doctest_macros.hpp | 提供doctest宏定义                                                                |
| src/doctest.cppm       | 提供doctest模块定义，导出doctest框架所需的函数声明                               |
| src/main.cpp           | 提供默认的main函数定义，编译成静态库                                             |
| test/*.cpp             | 来源于doctest的example文件，用于测试doctest_module实现的兼容性                   |
| test/package/*         | 一个子工程，用于测试xmake包描述                                                  |

## 依赖库

| 仓库                                                                                                         | 说明                                 |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------ |
| [doctest](https://github.com/doctest/doctest)                                                                | doctest测试框架                      |
| [convert-cpp-std-headers-to-std-module](https://github.com/YexuanXiao/convert-cpp-std-headers-to-std-module) | 提供一种简单的方式将头文件转化为模块 |
