# Building WCELIBCEX library
This is imported code from https://sourceforge.net/p/wcelibcex/code/HEAD/tree/trunk/

*IMPORTANT*
Remember to build WCELIBCEX as a static library, not DLL.

```
mkdir build
cd build
cmake -G "Visual Studio 12 2013" -A "YOUR WEC SDK" -DCMAKE_TOOLCHAIN_FILE:FILEPATH=..\cmake\arm-wec2013.cmake ..
cmake --build . -- /p:CharacterSet=Unicode
```

# Linking

```
find_package(WinCeEx REQUIRED)
target_link_libraries(${PROJECT_NAME} WinCeEx::WinCeEx)
```
