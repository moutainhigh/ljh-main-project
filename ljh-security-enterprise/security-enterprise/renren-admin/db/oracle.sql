CREATE TABLE sys_user (
  id NUMBER(20, 0) NOT NULL,
  username varchar2(50) NOT NULL,
  password varchar2(100),
  real_name varchar2(50),
  head_url varchar2(200),
  gender NUMBER(2, 0),
  email varchar2(100),
  mobile varchar2(100),
  dept_id NUMBER(20, 0),
  super_admin NUMBER(2, 0),
  status NUMBER(2, 0),
  creator NUMBER(20, 0),
  create_date date,
  updater NUMBER(20, 0),
  update_date date,
  primary key (id)
);

CREATE UNIQUE INDEX uk_sys_user_username on sys_user(username);
CREATE INDEX idx_sys_user_create_date on sys_user(create_date);

COMMENT ON TABLE sys_user IS '用户管理';
COMMENT ON COLUMN sys_user.id IS 'id';
COMMENT ON COLUMN sys_user.username IS '用户名';
COMMENT ON COLUMN sys_user.password IS '密码';
COMMENT ON COLUMN sys_user.real_name IS '姓名';
COMMENT ON COLUMN sys_user.head_url IS '头像';
COMMENT ON COLUMN sys_user.gender IS '性别   0：男   1：女    2：保密';
COMMENT ON COLUMN sys_user.email IS '邮箱';
COMMENT ON COLUMN sys_user.mobile IS '手机号';
COMMENT ON COLUMN sys_user.dept_id IS '部门ID';
COMMENT ON COLUMN sys_user.super_admin IS '超级管理员   0：否   1：是';
COMMENT ON COLUMN sys_user.status IS '状态  0：停用    1：正常';
COMMENT ON COLUMN sys_user.creator IS '创建者';
COMMENT ON COLUMN sys_user.create_date IS '创建时间';
COMMENT ON COLUMN sys_user.updater IS '更新者';
COMMENT ON COLUMN sys_user.update_date IS '更新时间';


CREATE TABLE sys_dept (
  id NUMBER(20, 0) NOT NULL,
  pid NUMBER(20, 0),
  pids varchar2(500),
  name varchar2(50),
  sort NUMBER(10, 0),
  creator NUMBER(20, 0),
  create_date date,
  updater NUMBER(20, 0),
  update_date date,
  primary key (id)
);
CREATE INDEX idx_sys_dept_pid on sys_dept(pid);
CREATE INDEX idx_sys_dept_idx_sort on sys_dept(sort);

COMMENT ON TABLE sys_dept IS '部门管理';
COMMENT ON COLUMN sys_dept.id IS 'id';
COMMENT ON COLUMN sys_dept.pid IS '上级ID';
COMMENT ON COLUMN sys_dept.pids IS '所有上级ID，用逗号分开';
COMMENT ON COLUMN sys_dept.name IS '部门名称';
COMMENT ON COLUMN sys_dept.sort IS '排序';
COMMENT ON COLUMN sys_dept.creator IS '创建者';
COMMENT ON COLUMN sys_dept.create_date IS '创建时间';
COMMENT ON COLUMN sys_dept.updater IS '更新者';
COMMENT ON COLUMN sys_dept.update_date IS '更新时间';


create table sys_role
(
  id                   NUMBER(20, 0) NOT NULL,
  name                 varchar2(32),
  remark               varchar2(100),
  dept_id              NUMBER(20, 0),
  creator              NUMBER(20, 0),
  create_date          date,
  updater              NUMBER(20, 0),
  update_date          date,
  primary key (id)
);

CREATE INDEX idx_sys_role_dept_id on sys_role(dept_id);

COMMENT ON TABLE sys_role IS '角色管理';
COMMENT ON COLUMN sys_role.id IS 'id';
COMMENT ON COLUMN sys_role.name IS '角色名称';
COMMENT ON COLUMN sys_role.remark IS '备注';
COMMENT ON COLUMN sys_role.dept_id IS '部门ID';
COMMENT ON COLUMN sys_role.creator IS '创建者';
COMMENT ON COLUMN sys_role.create_date IS '创建时间';
COMMENT ON COLUMN sys_role.updater IS '更新者';
COMMENT ON COLUMN sys_role.update_date IS '更新时间';


create table sys_menu
(
  id                   NUMBER(20, 0) NOT NULL,
  pid                  NUMBER(20, 0),
  url                  varchar2(200),
  permissions          varchar2(500),
  type                 NUMBER(2, 0),
  icon                 varchar2(50),
  sort                 NUMBER(10, 0),
  creator              NUMBER(20, 0),
  create_date          date,
  updater              NUMBER(20, 0),
  update_date          date,
  primary key (id)
);

CREATE INDEX idx_sys_menu_pid on sys_menu(pid);
CREATE INDEX idx_sys_menu_sort on sys_menu(sort);

COMMENT ON TABLE sys_menu IS '菜单管理';
COMMENT ON COLUMN sys_menu.id IS 'id';
COMMENT ON COLUMN sys_menu.pid IS '上级ID，一级菜单为0';
COMMENT ON COLUMN sys_menu.url IS '菜单URL';
COMMENT ON COLUMN sys_menu.permissions IS '授权(多个用逗号分隔，如：sys:user:list,sys:user:save)';
COMMENT ON COLUMN sys_menu.type IS '类型   0：菜单   1：按钮';
COMMENT ON COLUMN sys_menu.icon IS '菜单图标';
COMMENT ON COLUMN sys_menu.sort IS '排序';
COMMENT ON COLUMN sys_menu.creator IS '创建者';
COMMENT ON COLUMN sys_menu.create_date IS '创建时间';
COMMENT ON COLUMN sys_menu.updater IS '更新者';
COMMENT ON COLUMN sys_menu.update_date IS '更新时间';


create table sys_role_user
(
  id                   varchar2(32) NOT NULL,
  role_id              varchar2(32),
  user_id              varchar2(32),
  creator              varchar2(32),
  create_date          date,
  primary key (id)
);

CREATE INDEX idx_sys_role_user_role_id on sys_role_user(role_id);
CREATE INDEX idx_sys_role_user_user_id on sys_role_user(user_id);

COMMENT ON TABLE sys_role_user IS '角色用户关系';
COMMENT ON COLUMN sys_role_user.role_id IS '角色ID';
COMMENT ON COLUMN sys_role_user.user_id IS '用户ID';
COMMENT ON COLUMN sys_role_user.creator IS '创建者';
COMMENT ON COLUMN sys_role_user.create_date IS '创建时间';


create table sys_role_menu
(
  id                   NUMBER(20, 0) NOT NULL,
  role_id              NUMBER(20, 0),
  menu_id              NUMBER(20, 0),
  creator              NUMBER(20, 0),
  create_date          date,
  primary key (id)
);

CREATE INDEX idx_sys_role_menu_role_id on sys_role_menu(role_id);
CREATE INDEX idx_sys_role_menu_menu_id on sys_role_menu(menu_id);

COMMENT ON TABLE sys_role_menu IS '角色菜单关系';
COMMENT ON COLUMN sys_role_menu.role_id IS '角色ID';
COMMENT ON COLUMN sys_role_menu.menu_id IS '菜单ID';
COMMENT ON COLUMN sys_role_menu.creator IS '创建者';
COMMENT ON COLUMN sys_role_menu.create_date IS '创建时间';


create table sys_role_data_scope
(
  id                   NUMBER(20, 0) NOT NULL,
  role_id              NUMBER(20, 0),
  dept_id              NUMBER(20, 0),
  creator              NUMBER(20, 0),
  create_date          date,
  primary key (id)
);
CREATE INDEX idx_data_scope_role_id on sys_role_data_scope(role_id);

COMMENT ON TABLE sys_role_data_scope IS '角色数据权限';
COMMENT ON COLUMN sys_role_data_scope.role_id IS '角色ID';
COMMENT ON COLUMN sys_role_data_scope.dept_id IS '部门ID';
COMMENT ON COLUMN sys_role_data_scope.creator IS '创建者';
COMMENT ON COLUMN sys_role_data_scope.create_date IS '创建时间';


create table sys_params
(
  id                   NUMBER(20, 0) NOT NULL,
  param_code           varchar2(32),
  param_value          varchar2(2000),
  param_type           NUMBER(2, 0) DEFAULT 1 NOT NULL,
  remark               varchar2(200),
  creator              NUMBER(20, 0),
  create_date          date,
  updater              NUMBER(20, 0),
  update_date          date,
  primary key (id)
);
CREATE UNIQUE INDEX uk_sys_params_param_code on sys_params(param_code);
CREATE INDEX idx_sys_params_create_date on sys_params(create_date);

COMMENT ON TABLE sys_params IS '参数管理';
COMMENT ON COLUMN sys_params.param_code IS '参数编码';
COMMENT ON COLUMN sys_params.param_value IS '参数值';
COMMENT ON COLUMN sys_params.param_type IS '类型   0：系统参数   1：非系统参数';
COMMENT ON COLUMN sys_params.remark IS '备注';
COMMENT ON COLUMN sys_params.creator IS '创建者';
COMMENT ON COLUMN sys_params.create_date IS '创建时间';
COMMENT ON COLUMN sys_params.updater IS '更新者';
COMMENT ON COLUMN sys_params.update_date IS '更新时间';


create table sys_dict_type
(
    id                   NUMBER(20, 0) NOT NULL,
    dict_type            varchar2(100),
    dict_name            varchar2(255),
    remark               varchar2(255),
    sort                 NUMBER(10, 0),
    creator              NUMBER(20, 0),
    create_date          date,
    updater              NUMBER(20, 0),
    update_date          date,
    primary key (id)
);
CREATE UNIQUE INDEX uk_sys_dict_type_dict_type on sys_dict_type(dict_type);

COMMENT ON TABLE sys_dict_type IS '字典类型';
COMMENT ON COLUMN sys_dict_type.id IS 'id';
COMMENT ON COLUMN sys_dict_type.dict_type IS '字典类型';
COMMENT ON COLUMN sys_dict_type.dict_name IS '字典名称';
COMMENT ON COLUMN sys_dict_type.remark IS '备注';
COMMENT ON COLUMN sys_dict_type.sort IS '排序';
COMMENT ON COLUMN sys_dict_type.creator IS '创建者';
COMMENT ON COLUMN sys_dict_type.create_date IS '创建时间';
COMMENT ON COLUMN sys_dict_type.updater IS '更新者';
COMMENT ON COLUMN sys_dict_type.update_date IS '更新时间';

create table sys_dict_data
(
    id                   NUMBER(20, 0) NOT NULL,
    dict_type_id         NUMBER(20, 0) NOT NULL,
    dict_label           varchar2(255),
    dict_value           varchar2(255),
    remark               varchar2(255),
    sort                 NUMBER(10, 0),
    creator              NUMBER(20, 0),
    create_date          date,
    updater              NUMBER(20, 0),
    update_date          date,
    primary key (id)
);
CREATE INDEX idx_sys_dict_data_sort on sys_dict_data(sort);
CREATE UNIQUE INDEX uk_dict_type_value on sys_dict_data(dict_type_id, dict_value);

COMMENT ON TABLE sys_dict_data IS '字典数据';
COMMENT ON COLUMN sys_dict_data.id IS 'id';
COMMENT ON COLUMN sys_dict_data.dict_type_id IS '字典类型ID';
COMMENT ON COLUMN sys_dict_data.dict_label IS '字典标签';
COMMENT ON COLUMN sys_dict_data.dict_value IS '字典值';
COMMENT ON COLUMN sys_dict_data.remark IS '备注';
COMMENT ON COLUMN sys_dict_data.sort IS '排序';
COMMENT ON COLUMN sys_dict_data.creator IS '创建者';
COMMENT ON COLUMN sys_dict_data.create_date IS '创建时间';
COMMENT ON COLUMN sys_dict_data.updater IS '更新者';
COMMENT ON COLUMN sys_dict_data.update_date IS '更新时间';

create table sys_log_login
(
  id                   NUMBER(20, 0) NOT NULL,
  operation            NUMBER(2, 0),
  status               NUMBER(2, 0),
  user_agent           varchar2(500),
  ip                   varchar2(32),
  creator_name         varchar2(50),
  creator              NUMBER(20, 0),
  create_date          date,
  primary key (id)
);
CREATE INDEX idx_login_status on sys_log_login(status);
CREATE INDEX idx_login_create_date on sys_log_login(create_date);

COMMENT ON TABLE sys_log_login IS '登录日志';
COMMENT ON COLUMN sys_log_login.id IS 'id';
COMMENT ON COLUMN sys_log_login.operation IS '用户操作   0：用户登录   1：用户退出';
COMMENT ON COLUMN sys_log_login.status IS '状态  0：失败    1：成功    2：账号已锁定';
COMMENT ON COLUMN sys_log_login.user_agent IS '用户代理';
COMMENT ON COLUMN sys_log_login.ip IS '操作IP';
COMMENT ON COLUMN sys_log_login.creator_name IS '用户名';
COMMENT ON COLUMN sys_log_login.creator IS '创建者';
COMMENT ON COLUMN sys_log_login.create_date IS '创建时间';


create table sys_log_operation
(
  id                   NUMBER(20, 0) NOT NULL,
  operation            varchar2(50),
  request_uri          varchar2(200),
  request_method       varchar2(20),
  request_params       clob,
  request_time         NUMBER(10, 0),
  user_agent           varchar2(500),
  ip                   varchar2(32),
  status               NUMBER(2, 0),
  creator_name         varchar2(50),
  creator              NUMBER(20, 0),
  create_date          date,
  primary key (id)
);
CREATE INDEX idx_operation_create_date on sys_log_operation(create_date);

COMMENT ON TABLE sys_log_operation IS '操作日志';
COMMENT ON COLUMN sys_log_operation.id IS 'id';
COMMENT ON COLUMN sys_log_operation.operation IS '用户操作';
COMMENT ON COLUMN sys_log_operation.request_uri IS '请求URI';
COMMENT ON COLUMN sys_log_operation.request_method IS '请求方式';
COMMENT ON COLUMN sys_log_operation.request_params IS '请求参数';
COMMENT ON COLUMN sys_log_operation.request_time IS '请求时长(毫秒)';
COMMENT ON COLUMN sys_log_operation.user_agent IS '用户代理';
COMMENT ON COLUMN sys_log_operation.ip IS '操作IP';
COMMENT ON COLUMN sys_log_operation.status IS '状态  0：失败   1：成功';
COMMENT ON COLUMN sys_log_operation.creator_name IS '用户名';
COMMENT ON COLUMN sys_log_operation.creator IS '创建者';
COMMENT ON COLUMN sys_log_operation.create_date IS '创建时间';


create table sys_log_error
(
  id                   NUMBER(20, 0) NOT NULL,
  request_uri          varchar2(200),
  request_method       varchar2(20),
  request_params       clob,
  user_agent           varchar2(500),
  ip                   varchar2(32),
  error_info           clob,
  creator              NUMBER(20, 0),
  create_date          date,
  primary key (id)
);
CREATE INDEX idx_error_create_date on sys_log_error(create_date);

COMMENT ON TABLE sys_log_error IS '异常日志';
COMMENT ON COLUMN sys_log_error.id IS 'id';
COMMENT ON COLUMN sys_log_error.request_uri IS '请求URI';
COMMENT ON COLUMN sys_log_error.request_method IS '请求方式';
COMMENT ON COLUMN sys_log_error.request_params IS '请求参数';
COMMENT ON COLUMN sys_log_error.user_agent IS '用户代理';
COMMENT ON COLUMN sys_log_error.ip IS '操作IP';
COMMENT ON COLUMN sys_log_error.error_info IS '异常信息';
COMMENT ON COLUMN sys_log_error.creator IS '创建者';
COMMENT ON COLUMN sys_log_error.create_date IS '创建时间';


create table sys_sms
(
    id                   NUMBER(20, 0) NOT NULL,
    sms_code             varchar2(32),
    platform             NUMBER(2, 0),
    sms_config           varchar2(2000),
    remark               varchar2(200),
    creator              NUMBER(20, 0),
    create_date          date,
    updater              NUMBER(20, 0),
    update_date          date,
    primary key (id)
);
CREATE UNIQUE INDEX uk_sms_code on sys_sms(sms_code);
CREATE INDEX idx_sys_sms_create_date on sys_sms(create_date);

COMMENT ON TABLE sys_sms IS '短信';
COMMENT ON COLUMN sys_sms.id IS 'id';
COMMENT ON COLUMN sys_sms.sms_code IS '短信编码';
COMMENT ON COLUMN sys_sms.platform IS '平台类型';
COMMENT ON COLUMN sys_sms.sms_config IS '短信配置';
COMMENT ON COLUMN sys_sms.remark IS '备注';
COMMENT ON COLUMN sys_sms.creator IS '创建者';
COMMENT ON COLUMN sys_sms.create_date IS '创建时间';
COMMENT ON COLUMN sys_sms.updater IS '更新者';
COMMENT ON COLUMN sys_sms.update_date IS '更新时间';


CREATE TABLE sys_sms_log (
  id NUMBER(20, 0) NOT NULL,
  sms_code   varchar2(32),
  platform NUMBER(2, 0),
  mobile varchar2(20),
  params_1 varchar2(50),
  params_2 varchar2(50),
  params_3 varchar2(50),
  params_4 varchar2(50),
  status NUMBER(2, 0),
  creator NUMBER(20, 0),
  create_date date,
  PRIMARY KEY (id)
);
CREATE INDEX idx_sys_sms_log_sms_code on sys_sms_log(sms_code);

COMMENT ON TABLE sys_sms_log IS '短信发送记录';
COMMENT ON COLUMN sys_sms_log.id IS 'id';
COMMENT ON COLUMN sys_sms_log.sms_code IS '短信编码';
COMMENT ON COLUMN sys_sms_log.platform IS '平台类型';
COMMENT ON COLUMN sys_sms_log.mobile IS '手机号';
COMMENT ON COLUMN sys_sms_log.params_1 IS '参数1';
COMMENT ON COLUMN sys_sms_log.params_2 IS '参数2';
COMMENT ON COLUMN sys_sms_log.params_3 IS '参数3';
COMMENT ON COLUMN sys_sms_log.params_4 IS '参数4';
COMMENT ON COLUMN sys_sms_log.status IS '发送状态  0：失败  1：成功';
COMMENT ON COLUMN sys_sms_log.creator IS '创建者';
COMMENT ON COLUMN sys_sms_log.create_date IS '创建时间';

CREATE TABLE sys_notice (
    id NUMBER(20, 0) NOT NULL,
    type NUMBER(10, 0) NOT NULL,
    title varchar2(200),
    content clob,
    receiver_type NUMBER(2, 0),
    receiver_type_ids varchar2(500),
    status NUMBER(2, 0),
    sender_name varchar2(50),
    sender_date date,
    creator NUMBER(20, 0),
    create_date date,
    PRIMARY KEY (id)
);
CREATE INDEX idx_sys_notice_create_date on sys_notice(create_date);

COMMENT ON TABLE sys_notice IS '通知管理';
COMMENT ON COLUMN sys_notice.id IS 'id';
COMMENT ON COLUMN sys_notice.type IS '通知类型';
COMMENT ON COLUMN sys_notice.title IS '标题';
COMMENT ON COLUMN sys_notice.content IS '内容';
COMMENT ON COLUMN sys_notice.receiver_type IS '接收者  0：全部  1：部门';
COMMENT ON COLUMN sys_notice.receiver_type_ids IS '接收者ID，用逗号分开';
COMMENT ON COLUMN sys_notice.status IS '发送状态  0：草稿  1：已发布';
COMMENT ON COLUMN sys_notice.sender_name IS '发送者';
COMMENT ON COLUMN sys_notice.sender_date IS '发送时间';
COMMENT ON COLUMN sys_notice.creator IS '创建者';
COMMENT ON COLUMN sys_notice.create_date IS '创建时间';


CREATE TABLE sys_notice_user (
    receiver_id NUMBER(20, 0) NOT NULL,
    notice_id NUMBER(20, 0) NOT NULL,
    read_status NUMBER(2, 0) NOT NULL,
    read_date date,
    PRIMARY KEY (receiver_id, notice_id)
);

COMMENT ON TABLE sys_notice_user IS '我的通知';
COMMENT ON COLUMN sys_notice_user.receiver_id IS '接收者ID';
COMMENT ON COLUMN sys_notice_user.notice_id IS '通知ID';
COMMENT ON COLUMN sys_notice_user.read_status IS '阅读状态  0：未读  1：已读';
COMMENT ON COLUMN sys_notice_user.read_date IS '阅读时间';


CREATE TABLE sys_mail_template (
  id NUMBER(20, 0) NOT NULL,
  name varchar2(100),
  subject varchar2(200),
  content clob,
  creator NUMBER(20, 0),
  create_date date,
  updater NUMBER(20, 0),
  update_date date,
  PRIMARY KEY (id)
);

CREATE INDEX idx_mail_template_create_date on sys_mail_template(create_date);

COMMENT ON TABLE sys_mail_template IS '邮件模板';
COMMENT ON COLUMN sys_mail_template.id IS 'id';
COMMENT ON COLUMN sys_mail_template.name IS '模板名称';
COMMENT ON COLUMN sys_mail_template.subject IS '邮件主题';
COMMENT ON COLUMN sys_mail_template.content IS '邮件正文';
COMMENT ON COLUMN sys_mail_template.creator IS '创建者';
COMMENT ON COLUMN sys_mail_template.create_date IS '创建时间';
COMMENT ON COLUMN sys_mail_template.updater IS '更新者';
COMMENT ON COLUMN sys_mail_template.update_date IS '更新时间';


CREATE TABLE sys_mail_log (
  id NUMBER(20, 0) NOT NULL,
  template_id NUMBER(20, 0) NOT NULL,
  mail_from varchar2(200),
  mail_to varchar2(400),
  mail_cc varchar2(400),
  subject varchar2(200),
  content clob,
  status NUMBER(2, 0),
  creator NUMBER(20, 0),
  create_date date,
  PRIMARY KEY (id)
);

CREATE INDEX idx_mail_log_create_date on sys_mail_log(create_date);

COMMENT ON TABLE sys_mail_log IS '邮件发送记录';
COMMENT ON COLUMN sys_mail_log.id IS 'id';
COMMENT ON COLUMN sys_mail_log.template_id IS '邮件模板ID';
COMMENT ON COLUMN sys_mail_log.mail_from IS '发送者';
COMMENT ON COLUMN sys_mail_log.mail_to IS '收件人';
COMMENT ON COLUMN sys_mail_log.mail_cc IS '抄送者';
COMMENT ON COLUMN sys_mail_log.subject IS '邮件主题';
COMMENT ON COLUMN sys_mail_log.content IS '邮件正文';
COMMENT ON COLUMN sys_mail_log.status IS '发送状态  0：失败  1：成功';
COMMENT ON COLUMN sys_mail_log.creator IS '创建者';
COMMENT ON COLUMN sys_mail_log.create_date IS '创建时间';


CREATE TABLE sys_oss (
  id NUMBER(20, 0) NOT NULL,
  url varchar2(200),
  creator NUMBER(20, 0),
  create_date date,
  PRIMARY KEY (id)
);
CREATE INDEX idx_sys_oss_create_date on sys_oss(create_date);

COMMENT ON TABLE sys_oss IS '文件上传';
COMMENT ON COLUMN sys_oss.id IS 'id';
COMMENT ON COLUMN sys_oss.url IS 'URL地址';
COMMENT ON COLUMN sys_mail_log.creator IS '创建者';
COMMENT ON COLUMN sys_mail_log.create_date IS '创建时间';


CREATE TABLE schedule_job (
  id NUMBER(20, 0) NOT NULL,
  bean_name varchar2(200),
  params varchar2(2000),
  cron_expression varchar2(100),
  status NUMBER(2, 0),
  remark varchar2(255),
  creator NUMBER(20, 0),
  create_date date,
  updater NUMBER(20, 0),
  update_date date,
  PRIMARY KEY (id)
);

CREATE INDEX idx_schedule_job_create_date on schedule_job(create_date);

COMMENT ON TABLE schedule_job IS '定时任务';
COMMENT ON COLUMN schedule_job.id IS 'id';
COMMENT ON COLUMN schedule_job.bean_name IS 'spring bean名称';
COMMENT ON COLUMN schedule_job.params IS '参数';
COMMENT ON COLUMN schedule_job.cron_expression IS 'cron表达式';
COMMENT ON COLUMN schedule_job.status IS '任务状态  0：暂停  1：正常';
COMMENT ON COLUMN schedule_job.remark IS '备注';
COMMENT ON COLUMN schedule_job.creator IS '创建者';
COMMENT ON COLUMN schedule_job.create_date IS '创建时间';
COMMENT ON COLUMN schedule_job.updater IS '更新者';
COMMENT ON COLUMN schedule_job.update_date IS '更新时间';


CREATE TABLE schedule_job_log (
  id NUMBER(20, 0) NOT NULL,
  job_id NUMBER(20, 0) NOT NULL,
  bean_name varchar2(200),
  params varchar2(2000),
  status NUMBER(2, 0),
  error varchar2(2000),
  times NUMBER(10, 0),
  create_date date,
  PRIMARY KEY (id)
);

CREATE INDEX idx_job_log_job_id on schedule_job_log(job_id);
CREATE INDEX idx_job_log_create_date on schedule_job_log(create_date);

COMMENT ON TABLE schedule_job_log IS '定时任务日志';
COMMENT ON COLUMN schedule_job_log.id IS 'id';
COMMENT ON COLUMN schedule_job_log.bean_name IS 'spring bean名称';
COMMENT ON COLUMN schedule_job_log.params IS '参数';
COMMENT ON COLUMN schedule_job_log.status IS '任务状态  0：失败    1：成功';
COMMENT ON COLUMN schedule_job_log.error IS '失败信息';
COMMENT ON COLUMN schedule_job_log.times IS '耗时(单位：毫秒)';
COMMENT ON COLUMN schedule_job.create_date IS '创建时间';


CREATE TABLE sys_user_token (
  id NUMBER(20, 0) NOT NULL,
  user_id NUMBER(20, 0),
  token varchar2(100),
  expire_date date,
  update_date date,
  create_date date,
  PRIMARY KEY (id)
);

CREATE UNIQUE INDEX uk_sys_user_token_user_id on sys_user_token(user_id);
CREATE UNIQUE INDEX uk_sys_user_token on sys_user_token(token);

COMMENT ON TABLE sys_user_token IS '系统用户Token';
COMMENT ON COLUMN sys_user_token.id IS 'id';
COMMENT ON COLUMN sys_user_token.user_id IS '用户id';
COMMENT ON COLUMN sys_user_token.token IS '用户token';
COMMENT ON COLUMN sys_user_token.expire_date IS '过期时间';
COMMENT ON COLUMN sys_user_token.update_date IS '更新时间';
COMMENT ON COLUMN sys_user_token.create_date IS '创建时间';


CREATE TABLE sys_language (
  table_name varchar2(32) NOT NULL,
  table_id NUMBER(20, 0) NOT NULL,
  field_name varchar2(32) NOT NULL,
  field_value varchar2(200) NOT NULL,
  language varchar2(10) NOT NULL,
  primary key (table_name, table_id, field_name, language)
);

CREATE INDEX idx_sys_language_table_id on sys_language(table_id);

COMMENT ON TABLE sys_language IS '国际化';
COMMENT ON COLUMN sys_language.table_name IS '表名';
COMMENT ON COLUMN sys_language.table_id IS '表主键';
COMMENT ON COLUMN sys_language.field_name IS '字段名';
COMMENT ON COLUMN sys_language.field_value IS '字段值';
COMMENT ON COLUMN sys_language.language IS '语言';


CREATE TABLE sys_region (
  id NUMBER(20, 0) NOT NULL,
  pid NUMBER(20, 0),
  name varchar2(100),
  tree_level NUMBER(2, 0),
  leaf NUMBER(2, 0),
  sort NUMBER(20, 0),
  creator NUMBER(20, 0),
  create_date date,
  updater NUMBER(20, 0),
  update_date date,
  PRIMARY KEY (id)
);

COMMENT ON TABLE sys_region IS '行政区域';
COMMENT ON COLUMN sys_region.pid IS '上级ID';
COMMENT ON COLUMN sys_region.name IS '名称';
COMMENT ON COLUMN sys_region.tree_level IS '层级';
COMMENT ON COLUMN sys_region.leaf IS '是否叶子节点  0：否   1：是';
COMMENT ON COLUMN sys_region.sort IS '排序';
COMMENT ON COLUMN sys_region.creator IS '创建者';
COMMENT ON COLUMN sys_region.create_date IS '创建时间';
COMMENT ON COLUMN sys_region.updater IS '更新者';
COMMENT ON COLUMN sys_region.update_date IS '更新时间';


CREATE TABLE tb_news (
  id NUMBER(20, 0) NOT NULL,
  title varchar2(100),
  content clob,
  pub_date date,
  dept_id NUMBER(20, 0),
  creator NUMBER(20, 0),
  create_date date,
  updater NUMBER(20, 0),
  update_date date,
  PRIMARY KEY (id)
);

COMMENT ON TABLE tb_news IS '新闻管理';
COMMENT ON COLUMN tb_news.id IS 'id';
COMMENT ON COLUMN tb_news.title IS '标题';
COMMENT ON COLUMN tb_news.content IS '内容';
COMMENT ON COLUMN tb_news.pub_date IS '发布时间';
COMMENT ON COLUMN tb_news.dept_id IS '创建者dept_id';
COMMENT ON COLUMN tb_news.creator IS '创建者';
COMMENT ON COLUMN tb_news.create_date IS '创建时间';
COMMENT ON COLUMN tb_news.updater IS '更新者';
COMMENT ON COLUMN tb_news.update_date IS '更新时间';


CREATE TABLE tb_process_biz_route (
  id NUMBER(20, 0) NOT NULL,
  proc_def_id varchar2(64),
  biz_route varchar2(255),
  proc_def_key varchar2(255),
  version NUMBER(20, 0),
  PRIMARY KEY (id)
);

COMMENT ON TABLE tb_process_biz_route IS '工作流业务路由';
COMMENT ON COLUMN tb_process_biz_route.id IS 'id';
COMMENT ON COLUMN tb_process_biz_route.proc_def_id IS '流程定义ID';
COMMENT ON COLUMN tb_process_biz_route.biz_route IS '业务路由';
COMMENT ON COLUMN tb_process_biz_route.proc_def_key IS '流程定义KEY';
COMMENT ON COLUMN tb_process_biz_route.version IS '版本号';

CREATE TABLE tb_correction (
   id NUMBER(20, 0) NOT NULL,
   apply_post varchar2(255),
   entry_date date,
   correction_date date,
   work_content varchar2(2000),
   achievement varchar2(2000),
   instance_id varchar2(80),
   creator NUMBER(20, 0),
   create_date date,
   PRIMARY KEY (id)
);

COMMENT ON TABLE tb_correction IS '转正申请';
COMMENT ON COLUMN tb_correction.id IS 'id';
COMMENT ON COLUMN tb_correction.apply_post IS '申请岗位';
COMMENT ON COLUMN tb_correction.entry_date IS '入职日期';
COMMENT ON COLUMN tb_correction.correction_date IS '转正日期';
COMMENT ON COLUMN tb_correction.work_content IS '工作内容';
COMMENT ON COLUMN tb_correction.achievement IS '工作成绩';
COMMENT ON COLUMN tb_correction.instance_id IS '实例ID';
COMMENT ON COLUMN tb_correction.creator IS '创建者';
COMMENT ON COLUMN tb_correction.create_date IS '创建时间';


CREATE TABLE tb_product (
    id NUMBER(20, 0) NOT NULL,
    name varchar2(100),
    content varchar2(2000),
    creator NUMBER(20, 0),
    create_date date,
    updater NUMBER(20, 0),
    update_date date,
    PRIMARY KEY (id)
);

COMMENT ON TABLE tb_product IS '产品管理';
COMMENT ON COLUMN tb_product.id IS 'id';
COMMENT ON COLUMN tb_product.name IS '产品名称';
COMMENT ON COLUMN tb_product.content IS '产品介绍';
COMMENT ON COLUMN tb_product.creator IS '创建者';
COMMENT ON COLUMN tb_product.create_date IS '创建时间';
COMMENT ON COLUMN tb_product.updater IS '更新者';
COMMENT ON COLUMN tb_product.update_date IS '更新时间';

CREATE TABLE tb_product_params (
    id NUMBER(20, 0) NOT NULL,
    param_name varchar2(100),
    param_value varchar2(200),
    product_id NUMBER(20, 0),
    creator NUMBER(20, 0),
    create_date date,
    updater NUMBER(20, 0),
    update_date date,
    PRIMARY KEY (id)
);

COMMENT ON TABLE tb_product_params IS '产品参数管理';
COMMENT ON COLUMN tb_product_params.id IS 'id';
COMMENT ON COLUMN tb_product_params.param_name IS '参数名';
COMMENT ON COLUMN tb_product_params.param_value IS '参数值';
COMMENT ON COLUMN tb_product_params.product_id IS '产品ID';
COMMENT ON COLUMN tb_product_params.creator IS '创建者';
COMMENT ON COLUMN tb_product_params.create_date IS '创建时间';
COMMENT ON COLUMN tb_product_params.updater IS '更新者';
COMMENT ON COLUMN tb_product_params.update_date IS '更新时间';

create table sys_ureport_data (
    id NUMBER(20, 0) NOT NULL,
    file_name varchar2(200),
    content clob,
    create_date date,
    update_date date,
    PRIMARY KEY (id)
);

COMMENT ON TABLE sys_ureport_data IS '报表数据';
COMMENT ON COLUMN sys_ureport_data.id IS 'id';
COMMENT ON COLUMN sys_ureport_data.file_name IS '报表文件名';
COMMENT ON COLUMN sys_ureport_data.content IS '内容';
COMMENT ON COLUMN sys_ureport_data.create_date IS '创建时间';
COMMENT ON COLUMN sys_ureport_data.update_date IS '更新时间';

-- 初始数据
INSERT INTO sys_user(id, username, password, real_name, gender, email, mobile, status, dept_id, super_admin, creator, create_date, updater, update_date) VALUES (1067246875800000001, 'admin', '$2a$10$012Kx2ba5jzqr9gLlG4MX.bnQJTD9UWqF57XDo2N3.fPtLne02u/m', '管理员', 0, 'root@renren.io', '13612345678', 1, null, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);


INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000002, '0', NULL, NULL, 0, 'icon-safetycertificate', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000003, 1067246875800000055, NULL, 'sys:user:save,sys:dept:list,sys:role:list', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000004, 1067246875800000055, NULL, 'sys:user:update,sys:dept:list,sys:role:list', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000005, 1067246875800000055, NULL, 'sys:user:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000006, 1067246875800000055, NULL, 'sys:user:export', 1, NULL, 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000007, 1067246875800000002, 'sys/role', NULL, 0, 'icon-team', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000008, 1067246875800000007, NULL, 'sys:role:page,sys:role:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000009, 1067246875800000007, NULL, 'sys:role:save,sys:menu:select,sys:dept:list', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000010, 1067246875800000007, NULL, 'sys:role:update,sys:menu:select,sys:dept:list', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000011, 1067246875800000007, NULL, 'sys:role:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000012, 1067246875800000002, 'sys/dept', NULL, 0, 'icon-apartment', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000014, 1067246875800000012, NULL, 'sys:dept:list,sys:dept:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000015, 1067246875800000012, NULL, 'sys:dept:save', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000016, 1067246875800000012, NULL, 'sys:dept:update', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000017, 1067246875800000012, NULL, 'sys:dept:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000018, 1150940491508928513, 'activiti/process', 'sys:process:all', 0, 'icon-detail', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000019, 1150940491508928513, 'activiti/model', 'sys:model:all', 0, 'icon-appstore-fill', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000020, 1150940491508928513, 'activiti/running', 'sys:running:all', 0, 'icon-play-square', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000021, 1067246875800000024, 'message/sms', 'sys:sms:all', 0, 'icon-message-fill', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000022, 1067246875800000024, 'message/mail_template', 'sys:mail:all', 0, 'icon-mail', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000023, 1067246875800000024, 'message/mail_log', 'sys:mail:log', 0, 'icon-detail-fill', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000024, '0', NULL, NULL, 0, 'icon-message', 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000025, 1067246875800000035, 'sys/menu', NULL, 0, 'icon-unorderedlist', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000026, 1067246875800000025, NULL, 'sys:menu:list,sys:menu:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000027, 1067246875800000025, NULL, 'sys:menu:save', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000028, 1067246875800000025, NULL, 'sys:menu:update', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000029, 1067246875800000025, NULL, 'sys:menu:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000030, 1067246875800000035, 'job/schedule', NULL, 0, 'icon-dashboard', 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000031, 1067246875800000030, NULL, 'sys:schedule:page,sys:schedule:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000032, 1067246875800000030, NULL, 'sys:schedule:save', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000033, 1067246875800000030, NULL, 'sys:schedule:update', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000034, 1067246875800000030, NULL, 'sys:schedule:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000035, '0', NULL, NULL, 0, 'icon-setting', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000036, 1067246875800000030, NULL, 'sys:schedule:pause', 1, NULL, 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000037, 1067246875800000030, NULL, 'sys:schedule:resume', 1, NULL, 5, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000038, 1067246875800000030, NULL, 'sys:schedule:run', 1, NULL, 6, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000039, 1067246875800000030, NULL, 'sys:schedule:log', 1, NULL, 7, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000040, 1067246875800000035, 'sys/params', '', 0, 'icon-fileprotect', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000041, 1067246875800000035, 'sys/dict-type', NULL, 0, 'icon-golden-fill', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000042, 1067246875800000041, NULL, 'sys:dict:page,sys:dict:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000043, 1067246875800000041, NULL, 'sys:dict:save', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000044, 1067246875800000041, NULL, 'sys:dict:update', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000045, 1067246875800000041, NULL, 'sys:dict:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000046, '0', NULL, NULL, 0, 'icon-container', 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000047, 1067246875800000035, 'oss/oss', 'sys:oss:all', 0, 'icon-upload', 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000048, 1067246875800000046, 'sys/log-login', 'sys:log:login', 0, 'icon-filedone', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000049, 1067246875800000046, 'sys/log-operation', 'sys:log:operation', 0, 'icon-solution', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000050, 1067246875800000046, 'sys/log-error', 'sys:log:error', 0, 'icon-file-exception', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000051, 1067246875800000053, '{{ window.SITE_CONFIG["apiURL"] }}/druid/sql.html', NULL, 0, 'icon-database', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000052, 1067246875800000054, 'demo/news', 'demo:news:all', 0, 'icon-file-word', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000053, '0', NULL, NULL, 0, 'icon-desktop', 5, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000054, '0', NULL, NULL, 0, 'icon-windows', 6, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000055, 1067246875800000002, 'sys/user', NULL, 0, 'icon-user', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000056, 1067246875800000055, NULL, 'sys:user:page,sys:user:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000057, 1067246875800000040, NULL, 'sys:params:save', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000058, 1067246875800000040, NULL, 'sys:params:export', 1, NULL, 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000059, 1067246875800000040, '', 'sys:params:page,sys:params:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000060, 1067246875800000040, NULL, 'sys:params:update', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000061, 1067246875800000040, '', 'sys:params:delete', 1, '', 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1150940491508928513, '0', NULL, NULL, 0, 'icon-reloadtime', 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1150941310262235138, '0',  NULL, NULL, 0, 'icon-user', 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1150941384811794433, 1150941310262235138, 'activiti/my-todo-task', 'sys:correction:all,sys:process:all,sys:running:all,sys:task:all', 0, 'icon-dashboard', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1150941447038488577, 1150941310262235138, 'activiti/my-join-task', 'sys:his:all', 0, 'icon-check-square', 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1150941506626965506, 1150940491508928513, 'activiti/process-initiation', 'sys:process:all', 0, 'icon-play-square', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1150941588046794754, 1150941310262235138, 'activiti/my-apply', 'sys:correction:all,sys:process:all,sys:running:all,sys:task:all', 0, 'icon-edit-square', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1151384841607028738, 1150941310262235138, 'activiti/my-todo-task-pool', 'sys:correction:all,sys:process:all,sys:running:all,sys:task:all', 0, 'icon-interation', 5, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1156748733921165314, 1067246875800000053, '{{ window.SITE_CONFIG["apiURL"] }}/doc.html', '', 0, 'icon-file-word', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1158267114314842114, 1150941310262235138, 'activiti/demo/correction', 'sys:correction:all,sys:process:all,sys:running:all,sys:task:all', 0, 'icon-issuesclose', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1158267114314842115, 1067246875800000035, 'sys/region', NULL, 0, 'icon-location', 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1158267114314842116, 1158267114314842115, NULL, 'sys:region:list,sys:region:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1158267114314842117, 1158267114314842115, NULL, 'sys:region:save', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1158267114314842118, 1158267114314842115, NULL, 'sys:region:update', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1158267114314842119, 1158267114314842115, NULL, 'sys:region:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000300, '0',  NULL, NULL, 0, 'icon-bell', 4, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000301, 1067246875800000300, 'notice/notice', 'sys:notice:all', 0, 'icon-bell', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000302, 1067246875800000300, 'notice/notice-user', 'sys:notice:all', 0, 'icon-notification', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1067246875800000303, 1067246875800000024, 'message/sms-log', 'sys:smslog:all', 0, 'icon-unorderedlist', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1270380959719501825, 1067246875800000054, 'demo/product', NULL, 0, 'icon-tag', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1270380959719501826, 1270380959719501825, NULL, 'demo:product:page,demo:product:info', 1, NULL, 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1270380959719501827, 1270380959719501825, NULL, 'demo:product:save', 1, NULL, 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1270380959719501828, 1270380959719501825, NULL, 'demo:product:update', 1, NULL, 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1270380959719501829, 1270380959719501825, NULL, 'demo:product:delete', 1, NULL, 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1300278047072649217, 0, '', '', 0, 'icon-filesearch', 3, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1300278435729440769, 1300278047072649217, '{{ window.SITE_CONFIG["apiURL"] }}/ureport/designer', '', 0, 'icon-book', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_menu(id, pid, url, permissions, type, icon, sort, creator, create_date, updater, update_date) VALUES (1300381796852060161, 1300278047072649217, 'ureport/ureport', 'sys:ureport:all', 0, 'icon-up-circle', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000300, 'name', 'Station Notice', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000300, 'name', '站内通知', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000300, 'name', '站內通知', 'zh-TW');

INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000301, 'name', 'Notice Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000301, 'name', '通知管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000301, 'name', '通知管理', 'zh-TW');

INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000302, 'name', 'My Notice', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000302, 'name', '我的通知', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000302, 'name', '我的通知', 'zh-TW');

INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000303, 'name', 'SMS History', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000303, 'name', '短信发送记录', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000303, 'name', '短信發送記錄', 'zh-TW');

INSERT INTO sys_dict_type(id, dict_type, dict_name, remark, sort, creator, create_date, updater, update_date) VALUES (1225813644059140097, 'notice_type', '站内通知-类型', '', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dict_data(id, dict_type_id, dict_label, dict_value, remark, sort, creator, create_date, updater, update_date) VALUES (1225814069634195457, 1225813644059140097, '公告', '0', '', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dict_data(id, dict_type_id, dict_label, dict_value, remark, sort, creator, create_date, updater, update_date) VALUES (1225814107559092225, 1225813644059140097, '会议', '1', '', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dict_data(id, dict_type_id, dict_label, dict_value, remark, sort, creator, create_date, updater, update_date) VALUES (1225814271879340034, 1225813644059140097, '其他', '2', '', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300278047072649217, 'name', 'Report Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300278047072649217, 'name', '报表管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300278047072649217, 'name', '報表管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300278435729440769, 'name', 'Report Design', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300278435729440769, 'name', '报表设计器', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300278435729440769, 'name', '報表設計器', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300381796852060161, 'name', 'Report List', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300381796852060161, 'name', '报表列表', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1300381796852060161, 'name', '報表列表', 'zh-TW');

INSERT INTO sys_sms(id, sms_code, platform, sms_config, remark, creator, create_date, updater, update_date) VALUES (1228954061084676097, '1001', 1, '{"aliyunAccessKeyId":"1","aliyunAccessKeySecret":"1","aliyunSignName":"1","aliyunTemplateCode":"1","qcloudAppKey":"","qcloudSignName":"","qcloudTemplateId":"","qiniuAccessKey":"","qiniuSecretKey":"","qiniuTemplateId":""}', '', 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000002, 'name', 'Authority Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000002, 'name', '权限管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000002, 'name', '權限管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000003, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000003, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000003, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000004, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000004, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000004, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000005, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000005, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000005, 'name', '刪除', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000006, 'name', 'Export', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000006, 'name', '导出', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000006, 'name', '導出', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000007, 'name', 'Role Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000007, 'name', '角色管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000007, 'name', '角色管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000008, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000008, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000008, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000009, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000009, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000009, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000010, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000010, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000010, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000011, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000011, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000011, 'name', '刪除', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000012, 'name', 'Department Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000012, 'name', '部门管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000012, 'name', '部門管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000014, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000014, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000014, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000015, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000015, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000015, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000016, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000016, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000016, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000017, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000017, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000017, 'name', '刪除', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000018, 'name', 'Process Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000018, 'name', '流程管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000018, 'name', '流程管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000019, 'name', 'Model Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000019, 'name', '模型管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000019, 'name', '模型管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000020, 'name', 'Running Process', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000020, 'name', '运行中的流程', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000020, 'name', '運行中的流程', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000021, 'name', 'SMS Service', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000021, 'name', '短信服务', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000021, 'name', '短信服務', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000022, 'name', 'Mail Template', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000022, 'name', '邮件模板', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000022, 'name', '郵件模板', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000023, 'name', 'Mail Log', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000023, 'name', '邮件发送记录', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000023, 'name', '郵件發送記錄', 'zh-TW ');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000024, 'name', 'Message Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000024, 'name', '消息管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000024, 'name', '消息管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000025, 'name', 'Menu Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000025, 'name', '菜单管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000025, 'name', '菜單管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000026, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000026, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000026, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000027, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000027, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000027, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000028, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000028, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000028, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000029, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000029, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000029, 'name', '刪除', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000030, 'name', 'Timed Task', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000030, 'name', '定时任务', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000030, 'name', '定時任務', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000031, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000031, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000031, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000032, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000032, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000032, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000033, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000033, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000033, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000034, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000034, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000034, 'name', '刪除', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000035, 'name', 'Setting', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000035, 'name', '系统设置', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000035, 'name', '系統設置', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000036, 'name', 'Pause', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000036, 'name', '暂停', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000036, 'name', '暫停', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000037, 'name', 'Resume', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000037, 'name', '恢复', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000037, 'name', '恢復', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000038, 'name', 'Execute', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000038, 'name', '立即执行', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000038, 'name', '立即執行', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000039, 'name', 'Log List', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000039, 'name', '日志列表', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000039, 'name', '日誌列表', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000040, 'name', 'Parameter Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000040, 'name', '参数管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000040, 'name', '參數管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000041, 'name', 'Dict Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000041, 'name', '字典管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000041, 'name', '字典管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000042, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000042, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000042, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000043, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000043, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000043, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000044, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000044, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000044, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000045, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000045, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000045, 'name', '刪除', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000046, 'name', 'Log Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000046, 'name', '日志管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000046, 'name', '日誌管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000047, 'name', 'File Upload', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000047, 'name', '文件上传', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000047, 'name', '文件上傳', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000048, 'name', 'Login Log', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000048, 'name', '登录日志', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000048, 'name', '登錄日誌', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000049, 'name', 'Operation Log', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000049, 'name', '操作日志', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000049, 'name', '操作日誌', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000050, 'name', 'Error Log', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000050, 'name', '异常日志', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000050, 'name', '異常日誌', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000051, 'name', 'SQL Monitoring', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000051, 'name', 'SQL监控', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000051, 'name', 'SQL監控', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000052, 'name', 'News Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000052, 'name', '新闻管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000052, 'name', '新聞管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000053, 'name', 'System Monitoring', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000053, 'name', '系统监控', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000053, 'name', '系統監控', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000054, 'name', 'Demo', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000054, 'name', '功能示例', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000054, 'name', '功能示例', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000055, 'name', 'User Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000055, 'name', '用户管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000055, 'name', '用戶管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000056, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000056, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000056, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000057, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000057, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000057, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000058, 'name', 'Export', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000058, 'name', '导出', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000058, 'name', '導出', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000059, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000059, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000059, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000060, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000060, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000060, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000061, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000061, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1067246875800000061, 'name', '刪除', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150940491508928513, 'name', 'Process Management', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150940491508928513, 'name', '流程管理', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150940491508928513, 'name', '流程管理', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941310262235138, 'name', 'Personal Office', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941310262235138, 'name', '个人办公', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941310262235138, 'name', '個人辦公', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941384811794433, 'name', 'My To-do', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941384811794433, 'name', '我的待办', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941384811794433, 'name', '我的待辦', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941447038488577, 'name', 'Task Already', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941447038488577, 'name', '已办任务', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941447038488577, 'name', '已辦任務', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941506626965506, 'name', 'Initiation Process', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941506626965506, 'name', '发起流程', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941506626965506, 'name', '發起流程', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941588046794754, 'name', 'My Application', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941588046794754, 'name', '我的申请', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1150941588046794754, 'name', '我的申請', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1151384841607028738, 'name', 'To Be Signed', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1151384841607028738, 'name', '待签收任务', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1151384841607028738, 'name', '待簽收任務', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1156748733921165314, 'name', 'Interface Document', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1156748733921165314, 'name', '接口文档', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1156748733921165314, 'name', '接口文檔', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842114, 'name', 'Correction Request', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842114, 'name', '转正申请', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842114, 'name', '轉正申請', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842115, 'name', 'Administrative Regions', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842115, 'name', '行政区域', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842115, 'name', '行政區域', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842116, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842116, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842116, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842117, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842117, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842117, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842118, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842118, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842118, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842119, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842119, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1158267114314842119, 'name', '刪除', 'zh-TW');

INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501825, 'name', 'Master And Child', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501825, 'name', '主子表演示', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501825, 'name', '主子表演示', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501826, 'name', 'View', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501826, 'name', '查看', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501826, 'name', '查看', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501827, 'name', 'Add', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501827, 'name', '新增', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501827, 'name', '新增', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501828, 'name', 'Edit', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501828, 'name', '修改', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501828, 'name', '修改', 'zh-TW');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501829, 'name', 'Delete', 'en-US');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501829, 'name', '删除', 'zh-CN');
INSERT INTO sys_language(table_name, table_id, field_name, field_value, language) VALUES ('sys_menu', 1270380959719501829, 'name', '刪除', 'zh-TW');

INSERT INTO sys_dept(id, pid, pids, name, sort, creator, create_date, updater, update_date) VALUES (1067246875800000062, 1067246875800000063, '1067246875800000066,1067246875800000063', '技术部', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dept(id, pid, pids, name, sort, creator, create_date, updater, update_date) VALUES (1067246875800000063, 1067246875800000066, '1067246875800000066', '长沙分公司', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dept(id, pid, pids, name, sort, creator, create_date, updater, update_date) VALUES (1067246875800000064, 1067246875800000066, '1067246875800000066', '上海分公司', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dept(id, pid, pids, name, sort, creator, create_date, updater, update_date) VALUES (1067246875800000065, 1067246875800000064, '1067246875800000066,1067246875800000064', '市场部', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dept(id, pid, pids, name, sort, creator, create_date, updater, update_date) VALUES (1067246875800000066, 0, '0', '人人开源集团', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dept(id, pid, pids, name, sort, creator, create_date, updater, update_date) VALUES (1067246875800000067, 1067246875800000064, '1067246875800000066,1067246875800000064', '销售部', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dept(id, pid, pids, name, sort, creator, create_date, updater, update_date) VALUES (1067246875800000068, 1067246875800000063, '1067246875800000066,1067246875800000063', '产品部', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_dict_type(id, dict_type, dict_name, remark, sort, creator, create_date, updater, update_date) VALUES (1160061077912858625, 'gender', '性别', '', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dict_data(id, dict_type_id, dict_label, dict_value, remark, sort, creator, create_date, updater, update_date) VALUES (1160061112075464705, 1160061077912858625, '男', '0', '', 0, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dict_data(id, dict_type_id, dict_label, dict_value, remark, sort, creator, create_date, updater, update_date) VALUES (1160061146967879681, 1160061077912858625, '女', '1', '', 1, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_dict_data(id, dict_type_id, dict_label, dict_value, remark, sort, creator, create_date, updater, update_date) VALUES (1160061190127267841, 1160061077912858625, '保密', '2', '', 2, 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_params(id, param_code, param_value, param_type, remark, creator, create_date, updater, update_date) VALUES (1067246875800000073, 'CLOUD_STORAGE_CONFIG_KEY', '{"type":1,"qiniuDomain":"http://test.oss.renren.io","qiniuPrefix":"upload","qiniuAccessKey":"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ","qiniuSecretKey":"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV","qiniuBucketName":"renren-oss","aliyunDomain":"","aliyunPrefix":"","aliyunEndPoint":"","aliyunAccessKeyId":"","aliyunAccessKeySecret":"","aliyunBucketName":"","qcloudDomain":"","qcloudPrefix":"","qcloudSecretId":"","qcloudSecretKey":"","qcloudBucketName":""}', '0', '云存储配置信息', 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);
INSERT INTO sys_params(id, param_code, param_value, param_type, remark, creator, create_date, updater, update_date) VALUES (1067246875800000075, 'MAIL_CONFIG_KEY', '{"smtp":"smtp.163.com","port":25,"username":"renrenio_test@163.com","password":"renren123456"}', 0, '邮件配置信息', 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO schedule_job (id, bean_name, params, cron_expression, status, remark, creator, create_date, updater, update_date) VALUES (1067246875800000076, 'testTask', 'renren', '0 0/30 * * * ?', 0, '有参测试，多个参数使用json', 1067246875800000001, CURRENT_DATE, 1067246875800000001, CURRENT_DATE);

INSERT INTO sys_mail_template(id, name, subject, content, create_date) VALUES (1067246875800000077, '验证码模板', '人人开源注册验证码', '<p>人人开源注册验证码：${code}</p>', CURRENT_DATE);


--  quartz自带表结构
CREATE TABLE qrtz_job_details
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  JOB_NAME  VARCHAR2(200) NOT NULL,
  JOB_GROUP VARCHAR2(200) NOT NULL,
  DESCRIPTION VARCHAR2(250) NULL,
  JOB_CLASS_NAME   VARCHAR2(250) NOT NULL,
  IS_DURABLE VARCHAR2(1) NOT NULL,
  IS_NONCONCURRENT VARCHAR2(1) NOT NULL,
  IS_UPDATE_DATA VARCHAR2(1) NOT NULL,
  REQUESTS_RECOVERY VARCHAR2(1) NOT NULL,
  JOB_DATA BLOB NULL,
  CONSTRAINT QRTZ_JOB_DETAILS_PK PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);
CREATE TABLE qrtz_triggers
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  TRIGGER_NAME VARCHAR2(200) NOT NULL,
  TRIGGER_GROUP VARCHAR2(200) NOT NULL,
  JOB_NAME  VARCHAR2(200) NOT NULL,
  JOB_GROUP VARCHAR2(200) NOT NULL,
  DESCRIPTION VARCHAR2(250) NULL,
  NEXT_FIRE_TIME NUMBER(13) NULL,
  PREV_FIRE_TIME NUMBER(13) NULL,
  PRIORITY NUMBER(13) NULL,
  TRIGGER_STATE VARCHAR2(16) NOT NULL,
  TRIGGER_TYPE VARCHAR2(8) NOT NULL,
  START_TIME NUMBER(13) NOT NULL,
  END_TIME NUMBER(13) NULL,
  CALENDAR_NAME VARCHAR2(200) NULL,
  MISFIRE_INSTR NUMBER(2) NULL,
  JOB_DATA BLOB NULL,
  CONSTRAINT QRTZ_TRIGGERS_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_TRIGGER_TO_JOBS_FK FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
  REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);
CREATE TABLE qrtz_simple_triggers
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  TRIGGER_NAME VARCHAR2(200) NOT NULL,
  TRIGGER_GROUP VARCHAR2(200) NOT NULL,
  REPEAT_COUNT NUMBER(7) NOT NULL,
  REPEAT_INTERVAL NUMBER(12) NOT NULL,
  TIMES_TRIGGERED NUMBER(10) NOT NULL,
  CONSTRAINT QRTZ_SIMPLE_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_SIMPLE_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_cron_triggers
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  TRIGGER_NAME VARCHAR2(200) NOT NULL,
  TRIGGER_GROUP VARCHAR2(200) NOT NULL,
  CRON_EXPRESSION VARCHAR2(120) NOT NULL,
  TIME_ZONE_ID VARCHAR2(80),
  CONSTRAINT QRTZ_CRON_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_CRON_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_simprop_triggers
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  TRIGGER_NAME VARCHAR2(200) NOT NULL,
  TRIGGER_GROUP VARCHAR2(200) NOT NULL,
  STR_PROP_1 VARCHAR2(512) NULL,
  STR_PROP_2 VARCHAR2(512) NULL,
  STR_PROP_3 VARCHAR2(512) NULL,
  INT_PROP_1 NUMBER(10) NULL,
  INT_PROP_2 NUMBER(10) NULL,
  LONG_PROP_1 NUMBER(13) NULL,
  LONG_PROP_2 NUMBER(13) NULL,
  DEC_PROP_1 NUMERIC(13,4) NULL,
  DEC_PROP_2 NUMERIC(13,4) NULL,
  BOOL_PROP_1 VARCHAR2(1) NULL,
  BOOL_PROP_2 VARCHAR2(1) NULL,
  CONSTRAINT QRTZ_SIMPROP_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_SIMPROP_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_blob_triggers
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  TRIGGER_NAME VARCHAR2(200) NOT NULL,
  TRIGGER_GROUP VARCHAR2(200) NOT NULL,
  BLOB_DATA BLOB NULL,
  CONSTRAINT QRTZ_BLOB_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  CONSTRAINT QRTZ_BLOB_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_calendars
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  CALENDAR_NAME  VARCHAR2(200) NOT NULL,
  CALENDAR BLOB NOT NULL,
  CONSTRAINT QRTZ_CALENDARS_PK PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);
CREATE TABLE qrtz_paused_trigger_grps
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  TRIGGER_GROUP  VARCHAR2(200) NOT NULL,
  CONSTRAINT QRTZ_PAUSED_TRIG_GRPS_PK PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_fired_triggers
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  ENTRY_ID VARCHAR2(95) NOT NULL,
  TRIGGER_NAME VARCHAR2(200) NOT NULL,
  TRIGGER_GROUP VARCHAR2(200) NOT NULL,
  INSTANCE_NAME VARCHAR2(200) NOT NULL,
  FIRED_TIME NUMBER(13) NOT NULL,
  SCHED_TIME NUMBER(13) NOT NULL,
  PRIORITY NUMBER(13) NOT NULL,
  STATE VARCHAR2(16) NOT NULL,
  JOB_NAME VARCHAR2(200) NULL,
  JOB_GROUP VARCHAR2(200) NULL,
  IS_NONCONCURRENT VARCHAR2(1) NULL,
  REQUESTS_RECOVERY VARCHAR2(1) NULL,
  CONSTRAINT QRTZ_FIRED_TRIGGER_PK PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);
CREATE TABLE qrtz_scheduler_state
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  INSTANCE_NAME VARCHAR2(200) NOT NULL,
  LAST_CHECKIN_TIME NUMBER(13) NOT NULL,
  CHECKIN_INTERVAL NUMBER(13) NOT NULL,
  CONSTRAINT QRTZ_SCHEDULER_STATE_PK PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);
CREATE TABLE qrtz_locks
(
  SCHED_NAME VARCHAR2(120) NOT NULL,
  LOCK_NAME  VARCHAR2(40) NOT NULL,
  CONSTRAINT QRTZ_LOCKS_PK PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);

create index idx_qrtz_j_req_recovery on qrtz_job_details(SCHED_NAME,REQUESTS_RECOVERY);
create index idx_qrtz_j_grp on qrtz_job_details(SCHED_NAME,JOB_GROUP);

create index idx_qrtz_t_j on qrtz_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);
create index idx_qrtz_t_jg on qrtz_triggers(SCHED_NAME,JOB_GROUP);
create index idx_qrtz_t_c on qrtz_triggers(SCHED_NAME,CALENDAR_NAME);
create index idx_qrtz_t_g on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP);
create index idx_qrtz_t_state on qrtz_triggers(SCHED_NAME,TRIGGER_STATE);
create index idx_qrtz_t_n_state on qrtz_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
create index idx_qrtz_t_n_g_state on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
create index idx_qrtz_t_next_fire_time on qrtz_triggers(SCHED_NAME,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_st on qrtz_triggers(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_st_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
create index idx_qrtz_t_nft_st_misfire_grp on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

create index idx_qrtz_ft_trig_inst_name on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME);
create index idx_qrtz_ft_inst_job_req_rcvry on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
create index idx_qrtz_ft_j_g on qrtz_fired_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);
create index idx_qrtz_ft_jg on qrtz_fired_triggers(SCHED_NAME,JOB_GROUP);
create index idx_qrtz_ft_t_g on qrtz_fired_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
create index idx_qrtz_ft_tg on qrtz_fired_triggers(SCHED_NAME,TRIGGER_GROUP);


