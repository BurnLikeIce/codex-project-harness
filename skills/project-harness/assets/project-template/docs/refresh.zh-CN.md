# Harness 同步 / 刷新规则

当用户要求任何一个对话同步、刷新、更新或继续使用最新版 project-harness 规则时，使用这个文档。

典型短提示：

```text
同步最新 project-harness skill。
```

类似自然表达也有效。

## 两个层级

### 对话规则刷新

任何对话都可以执行。

当用户要求同步最新 project-harness skill 时：

- 先判断当前对话角色：主控、产品、前端、后端、Bugfix、实验或其他。
- 如果项目里有对应 `prompts/` 文件，读取或遵循对应角色提示词。
- 使用和当前角色相关的最新版流程文档：
  - `docs/intent.zh-CN.md`
  - `docs/dispatch.zh-CN.md`
  - `docs/triage.zh-CN.md`
  - `docs/completion.zh-CN.md`
  - `docs/acceptance.zh-CN.md`
  - `docs/migration.zh-CN.md`
- 后续工作按最新规则继续。

### 项目 Harness 文件刷新

由主控/集成对话负责。

当用户要求更新当前项目的 harness 文档时：

- 检查当前 `docs/`、`prompts/`、`HARNESS.md`、README 和 `.github`。
- 对比最新版 project-harness 模板。
- 不要覆盖已有文档。
- 如果改动不只是很小的补缺，先给更新计划。
- 对缺失模板进行补充；如果已有文档已覆盖内容，则创建索引/链接文件。

## 角色短提示

```text
同步最新 project-harness skill。
```

```text
同步最新 project-harness 主控规则。
```

```text
同步最新 project-harness 产品规则。
```

```text
同步最新 project-harness 前端规则。
```

```text
同步最新 project-harness 后端规则。
```

```text
同步最新 project-harness Bugfix 规则。
```

## 输出

刷新后简短说明：

- 已识别角色：
- 已启用的规则/文档：
- 当前项目缺失的 harness 文档：
- 建议下一步：
