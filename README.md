# 皮皮虾（纯净版）

## 目录结构

本项目参考 [AFNetworking](https://github.com/AFNetworking/AFNetworking) 的目录结构组织代码：

```
ppxtweak/
├── QTPPXHeader.h              # 头文件定义
├── QTSettingViewController.h  # 设置视图控制器头文件
├── QTSettingViewController.m  # 设置视图控制器实现
├── QTSettingsViewModel.h      # 设置视图模型头文件
├── QTSettingsViewModel.m      # 设置视图模型实现
├── Tweak.xm                   # 主要 Hook 代码
├── Makefile                   # Theos 构建文件
├── control                    # Debian 包控制文件
├── ppxtweak.plist             # 插件配置文件
└── ...
```

所有源代码文件直接放在 `ppxtweak/` 根目录下，与 AFNetworking 的目录结构保持一致。

## 更新日志

```
2022-07-08 第一个版本，去除启动广告，视频列表广告
2022-07-10 去除视频详情中评论区的广告
2022-09-02 下载无水印视频
2022-09-03 下载评论区无水印图片和视频
2022-09-05 更新版本信息，上架第三个版本
2022-11-09 修复启动页广告未去除问题
2022-11-10 更新版本信息，上架第四个版本
2023-04-13 新增插件设置界面
2023-11-21 新增视频倍数播放功能
```