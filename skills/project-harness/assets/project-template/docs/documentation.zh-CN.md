# 文档地图

开始工作前使用这个文档，判断本次任务需要读取哪些项目文档，以及可能需要更新哪些文档。

不是每个项目都需要所有可选文档。但每个任务开始前，都应该先确认本任务依赖哪些事实来源文档。

## 核心必备文档

- `docs/product.md`：产品目标、用户、范围、用户故事，轻量 PRD。
- `docs/architecture.md`：技术架构、模块边界、数据流。
- `docs/api-contract.md`：接口约定、请求/响应结构、集成假设。
- `docs/tasks.md`：任务 ID、负责人、分支、状态、依赖、验收标准。
- `docs/decisions.md`：重要决策和原因。
- `docs/changelog.md`：已合并的重要变化和发布记录。

## Harness 流程文档

- `docs/sop.md`：项目协作流程。
- `docs/intent.md`：自然语言意图识别。
- `docs/migration.md`：旧项目迁移/接管。
- `docs/refresh.md`：同步最新 harness 规则。
- `docs/dispatch.md`：需求澄清和任务分发。
- `docs/triage.md`：问题分流和升级。
- `docs/completion.md`：实现对话任务交付格式。
- `docs/acceptance.md`：产品验收和返工格式。

中文项目优先读取对应的 `.zh-CN.md` 文件。

## 按项目需要的可选文档

- `docs/data-model.md`：数据库 schema、实体、关系、迁移。
- `docs/business-rules.md`：复杂业务规则和边界场景。
- `docs/deployment.md`：部署环境、命令、配置。
- `docs/testing.md`：测试策略、手工验收、fixtures、覆盖要求。
- `docs/design.md`：UI/UX 设计说明、交互规则、设计参考。
- `docs/security.md`：权限、鉴权、威胁模型、敏感数据处理。
- `docs/operations.md`：监控、运维手册、支持流程。

## 开始任务前

每个对话都应该先判断：

- 哪些文档定义了需求？
- 哪些文档定义了技术契约？
- 本任务会影响哪些文档？
- 本任务是否需要产品验收？
- 本任务是否需要主控 review/合并？

## 角色指南

主控/集成：

- 读取：`docs/sop.md`、`docs/documentation.md`、`docs/tasks.md`、`docs/decisions.md`、`docs/changelog.md`。
- 更新：`docs/tasks.md`、`docs/changelog.md`、`docs/decisions.md`；只有明确刷新项目 harness 文件时，才更新 harness 文档。

产品/架构：

- 读取：`docs/documentation.md`、`docs/product.md`、`docs/tasks.md`、`docs/decisions.md`。
- 如果需求影响系统行为，还要读取 `docs/api-contract.md` 和 `docs/architecture.md`。
- 更新：`docs/product.md`、`docs/tasks.md`、`docs/decisions.md`，以及相关接口/架构文档。

前端：

- 读取：`docs/documentation.md`、`docs/tasks.md`、`docs/product.md`、`docs/api-contract.md`。
- 如果涉及 UI/交互细节，读取 `docs/design.md`。
- 更新：`docs/tasks.md`，以及相关 UI/设计说明。

后端：

- 读取：`docs/documentation.md`、`docs/tasks.md`、`docs/architecture.md`、`docs/api-contract.md`。
- 如果相关，读取 `docs/data-model.md`、`docs/security.md` 或 `docs/business-rules.md`。
- 更新：`docs/api-contract.md`、`docs/tasks.md`，以及相关数据/安全/业务规则文档。

Bugfix/CI：

- 读取：`docs/documentation.md`、`docs/tasks.md`，以及问题所属区域的相关文档。
- 如果修复改变预期，更新 `docs/tasks.md`、`docs/decisions.md` 或 `docs/testing.md`。

实验：

- 读取：`docs/documentation.md`、`docs/product.md`、`docs/architecture.md` 和相关任务。
- 如果实验形成项目决策，更新 `docs/decisions.md`。
