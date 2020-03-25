# vimrc
使用前请先安装[Vundle](https://github.com/VundleVim/Vundle.vim)插件, 之后仅需执行:PluginInstall即可\
需要[git](https://git-scm.com/downloads)和[ctags](https://github.com/universal-ctags/)支持\
注意: ctags使用[universal-ctags](https://github.com/universal-ctags/)而不是ctags5.9\
如果要使用全部功能需要[python3](https://www.python.org/)支持\
airline需要使用特殊的字体, [单机这里](https://github.com/powerline/fonts/tree/master/NotoMono)下载配套的字体\
你也可以从[这里](https://github.com/powerline/fonts)获取到其它支持的字体

# 关于YouCompleteMe
YCM插件的安装请[参考这里](https://github.com/ycm-core/YouCompleteMe#linux-64-bit)\
将.ycm_extra_conf.py复制到~\.vim\bundle\YouCompleteMe\third_party\ycmd\cpp\ycm下并将下列代码添加进去
```python
def Settings( **kwargs ):
  return {
    'flags': [
        '-x',
        'c++',
        '-Wall',
        '-Wextra',
        '-Wno-long-long',
        '-Wno-variadic-macros',
        '-fexceptions',
        '-DNDEBUG',
        # You 100% do NOT need -DUSE_CLANG_COMPLETER in your flags; only the YCM
        # source code needs it.
        '-DUSE_CLANG_COMPLETER',
        '-I',
        '/usr/include',
        '-isystem',
        '/usr/lib/gcc/x86_64-linux-gnu/5/include',
        '-isystem',
        '/usr/include/x86_64-linux-gnu',
        '-isystem'
        '/usr/include/c++/5',
        '-isystem',
        '/usr/include/c++/5/bits'
        ],
  }
 ```
