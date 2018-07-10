/**
*描述：此为数据库的生成SQL语句
*版本：1.0
*仍保留的问题：
*  1.未解决auto_increment自动增加员工id的问题，
*    员工id的类型为char,不知道能不能自增，而且
*    不知道如果采用自增后如何删除。故先不用自增。
*  2.对各字段的限制条件有待商榷。
*对原表做的改动：
*  更改了一些字段的属性
**/


create database if not exists hrdb;

use hrdb;

/*部门表*/
create table if not exists dept (
	name varchar(20) comment '部门名' primary key,
    minister varchar(20) comment '部长',
    sdept varchar(20) comment '上级部门'
);

/*岗位表*/
create table if not exists job (
	jid char(3) primary key comment '岗位号',
    title varchar(15) not null comment '职业名称',
    dept varchar(20) not null comment '部门名',
    countDemand int comment '所需人数',
    countReal int comment '实际人数',
    salary int comment '薪酬'
);

/*员工信息表*/
create table if not exists employeeInfo (
	eid char(6) primary key comment '员工号',
    name varchar(20) not null comment '姓名',
    age int not null comment '年龄',
    sex enum('男','女') comment '性别',
    hometown varchar(20) comment '籍贯',
    oldjob varchar(15) comment '上一个职业名称',
    experience int comment '职业从事年数',
    education varchar(10) comment '学历',
    cet4 enum('yes', 'no') comment '英语四级',
    family int comment '家庭成员人数'
);

/*试用期合同表*/
create table if not exists PCon (
	id int primary key comment '合同序号',
    salary int not null comment '试用期薪酬',
    startdate date comment '起始日期',
    deadline date comment  '截止日期',
    eid char(6) comment '员工号',
    jid char(3) comment '岗位号'
);

/*调动表*/
create table if not exists PTrans (
	eid char(6) comment '员工号',
    prejob char(3) comment '调动前岗位',
    nextjob char(3) comment '调动后的岗位',
    predept char(20) comment '调动前部门',
    nextdept char(20) comment '调动后部门',
    `date` date comment '日期',
    PS varchar(100) comment '备注'
);

/*入职表*/
create table if not exists entry (
	eid char(6) comment '员工号',
    `date` date comment '入职时间',
    jid char(3) comment '岗位号',
    dept varchar(20) comment '入职部门'
);

/*离职表*/
create table if not exists dimission (
	eid char(6) comment '员工号',
    `date` date comment '离职时间',
    jid char(3) comment '岗位号',
    reason varchar(100) comment '原因'
);
