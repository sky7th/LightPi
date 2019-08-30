insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'sky7th', '0000', '이태화' ); -- 나
insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'companyId', '0000', '회사 관리실' ); -- 회사 관리자
insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'libraryId', '0000', '도서관 사서' ); -- 도서관 관리자
insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'healthId', '0000', '헬스장 사장님' ); -- 헬스장 관리자
insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'rmsdud12', '0000', '김근영' );
insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'ehdgur12', '0000', '장동혁' );
insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'wodud12', '0000', '주재영' );
insert into user_info ( user_login_id, user_login_pw, user_name ) values ( 'dmswl12', '0000', '진은지' );


insert into model_info ( master_user_info_id, model_code, model_name, model_key_value ) values ( 1, '1111111111', '우리집', 'thisiskeyvalue' );
insert into model_info ( master_user_info_id, model_code, model_name, model_key_value ) values ( 2, '2222222222', '회사 입구', 'thisiscompanykey' );
insert into model_info ( master_user_info_id, model_code, model_name, model_key_value ) values ( 3, '3333333333', '도서관 입구', 'thisislibrarykey' );
insert into model_info ( master_user_info_id, model_code, model_name, model_key_value ) values ( 4, '4444444444', '헬스장 락커', 'thisishealthkey' );

insert into model_info ( model_code, model_key_value ) values ( '5555555555', '1111' );
insert into model_info ( model_code, model_key_value ) values ( '6666666666', '1111' );
insert into model_info ( model_code, model_key_value ) values ( '8888888888', '1111' );
insert into model_info ( model_code, model_key_value ) values ( '9999999999', '1111' );

insert into model_info ( master_user_info_id, model_code, model_name, model_key_value ) values ( 1, '7777777777', 'pincom 동방', 'thisispincomkey' );


insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 1, 1 );
insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 2, 1 );
insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 3, 1 );
insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 4, 0 );

insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 5, 7, 0 );

-- 모델 null 값으로
update model_info set master_user_info_id = null, model_name = null where id = 5;
