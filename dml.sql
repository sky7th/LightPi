insert into user_info ( login_id, login_pw ) values ( 'sky7th', '0000' ); -- 나
insert into user_info ( login_id, login_pw ) values ( 'companyId', '0000' ); -- 회사 관리자
insert into user_info ( login_id, login_pw ) values ( 'libraryId', '0000' ); -- 도서관 관리자
insert into user_info ( login_id, login_pw ) values ( 'healthId', '0000' ); -- 헬스장 관리자


insert into model_info ( master_user_info_id, model_code, model_name, key_value ) values ( 1, '1111111111', '우리집', 'thisiskeyvalue' );
insert into model_info ( master_user_info_id, model_code, model_name, key_value ) values ( 2, '2222222222', '회사 입구', 'thisiscompanykey' );
insert into model_info ( master_user_info_id, model_code, model_name, key_value ) values ( 3, '3333333333', '도서관 입구', 'thisislibrarykey' );
insert into model_info ( master_user_info_id, model_code, model_name, key_value ) values ( 4, '4444444444', '헬스장 락커', 'thisishealthkey' );


insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 1, 1 );
insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 2, 1 );
insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 3, 1 );
insert into connect_info ( user_info_id, model_info_id, connect_flag ) values ( 1, 4, 1 );
