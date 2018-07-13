/**
*描述：此为数据库的生成SQL语句
*版本：1.3
*仍保留的问题：
*  1.对各字段的限制条件有待商榷。
*对原表做的改动：
*  增加级联的外码限制
**/


create database if not exists hrdb;

use hrdb;

/*部门表*/
create table if not exists Dept (
    name varchar(20) comment '部门名' primary key,
    minister int comment '部长' unique,
    sdept varchar(20) comment '上级部门',
    foreign key (sdept) references dept(name) ON DELETE CASCADE ON UPDATE CASCADE
);

/*岗位表*/
create table if not exists Job (
    jid int primary key auto_increment comment '岗位号',
    title varchar(15) not null comment '职业名称',
    dept varchar(20) not null comment '部门名',
    countDemand int not null comment '所需人数',
    countReal int not null comment '实际人数',
    salary int not null comment '薪酬',
    
    foreign key (dept) references dept(name) ON DELETE CASCADE ON UPDATE CASCADE
);

/*员工信息表*/
create table if not exists EmployeeInfo (
    eid int primary key auto_increment comment '员工号',
    name varchar(20) not null comment '姓名',
    age int not null comment '年龄',
    sex enum('男','女') not null comment '性别',
    hometown varchar(20) not null comment '籍贯',
    oldJob varchar(15) comment '上一个职业名称',
    experience int comment '职业从事年数',
    education varchar(10) comment '学历',
    cet4 enum('yes', 'no') comment '英语四级',
    family int comment '家庭成员人数',
    password varchar(20) comment '密码'
);

/*试用期合同表*/
create table if not exists PCon (
    id int primary key auto_increment comment '合同序号',
    salary int not null comment '试用期薪酬',
    startDate date not null comment '起始日期',
    deadline date not null comment  '截止日期',
    eid int not null unique comment '员工号',
    jid int not null comment '岗位号',
    
    foreign key (eid) references employeeInfo(eid) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (jid) references job(jid) ON DELETE CASCADE ON UPDATE CASCADE
);

/*调动表*/
create table if not exists PTrans (
    eid int comment '员工号',
    preJob int not null comment '调动前岗位',
    nextJob int not null comment '调动后的岗位',
    preDept char(20) not null comment '调动前部门',
    nextDept char(20) not null comment '调动后部门',
    `date` date not null comment '日期',
    PS varchar(100) comment '备注',
    
    primary key (eid, `date`),
    foreign key (eid) references employeeInfo(eid) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (prejob) references job(jid) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (nextjob) references job(jid) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (predept) references dept(name) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (nextdept) references dept(name) ON DELETE CASCADE ON UPDATE CASCADE
);

/*入职表*/
create table if not exists Entry (
    eid int comment '员工号' primary key,
    `date` date not null comment '入职时间',
    jid int not null comment '岗位号',
    dept varchar(20) not null comment '入职部门'
);

/*离职表*/
create table if not exists Dimission (
    eid int comment '员工号' primary key,
    `date` date not null comment '离职时间',
    jid int not null comment '岗位号',
    reason varchar(100) comment '原因'
);

show tables;
