# vimrc
使用前请先安装[Vundle](https://github.com/VundleVim/Vundle.vim)插件, 之后仅需执行:PluginInstall即可\
需要[git](https://git-scm.com/downloads)和[ctags](https://github.com/universal-ctags/ctags-win32/releases)支持\
注意: ctags使用[universal-ctags](https://github.com/universal-ctags/ctags-win32/releases)而不是ctags58\
如果要使用全部功能需要[python3](https://www.python.org/)支持\
airline需要使用特殊的字体, [单机这里](https://github.com/powerline/fonts/tree/master/NotoMono)下载配套的字体\
你也可以从[这里](https://github.com/powerline/fonts)获取到其它支持的字体

# 关于YouCompleteMe
YCM插件的安装请[参考这里](https://github.com/ycm-core/YouCompleteMe#windows)\
补全C/C++需要[MinGW](https://sourceforge.net/projects/mingw-w64/files/)的支持\
将.ycm_extra_conf.py复制到$VIM\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp\ycm下并将下列代码添加进去
```python
def Settings( **kwargs ):
  return {
    'flags': [
        '-x',
        'c++',
        '-Wall',
        '-Wextra',
        # Use gcc header file
        '--target=i686-pc-mingw32',
        '-Wno-long-long',
        '-Wno-variadic-macros',
        '-fexceptions',
        '-DNDEBUG',
        # You 100% do NOT need -DUSE_CLANG_COMPLETER in your flags; only the YCM
        # source code needs it.
        '-DUSE_CLANG_COMPLETER',
        ],
    }
 ```
