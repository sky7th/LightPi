const router = require('express').Router();

const con = require('../controllers');

// 나랑 연결 되어있는 모델들 불러오기  
router.get('/model/modelList/:userInfoId', con.HomeTabController.getModelListByUserId);
// 해당 모델 키 값 가져오기
router.get('/model/modelKey/:modelId', con.HomeTabController.getModelKeyByModelId);
// 모델 이름으로 모델 검색
router.get('/model/modelName/:modelName/:userInfoId', con.SearchTabController.getModelByModelName);
// 모델 코드로 모델 검색
router.get('/model/modelCode/:modelCode/:userInfoId', con.SearchTabController.getModelByModelCode);


// 모델 등록,  
router.post('/model/edit', con.MypageTabController.updateModelMasterUserInfoId);
// 내가 마스터인 모델 불러오기
router.get('/model/masterModelList/:masterUserInfoId', con.MypageTabController.getModelByMasterUserInfoId);
// 모델 이름 변경
router.post('/model/modelName/edit', con.MypageTabController.updateModelName);


// 내 신청 목록 가져오기
router.get('/connect/:userInfoId', con.MypageTabController.getConnectApplyListByUserId);
// 연결 요청
router.post('/connect/add', con.SearchTabController.insertConnect);
// 연결 수락
router.post('/connect/edit', con.ManageScreenController.updateConnectSetConnectFlag);
// 연결 삭제
router.post('/connect/delete', con.ManageScreenController.deleteConnectByConnectId);


// 선택한 모델에 신청한 유저들 모두 가져오기
router.get('/model/applyModelList/:modelInfoId', con.ManageScreenController.getMasterApplyListByModelInfoId);
// 선택한 모델에 신청한 유저들 이름으로 검색
router.get('/model/applyModelList/userName/:modelInfoId/:userName', con.ManageScreenController.getMasterApplyListByUserName);
// 선택한 모델에 신청한 유저들 아이디로 검색
router.get('/model/applyModelList/userLoginId/:modelInfoId/:userLoginId', con.ManageScreenController.getMasterApplyListByUserLoginId);

// 선택한 모델에 연결된 유저들 모두 가져오기
router.get('/model/connectModelList/:modelInfoId', con.ManageScreenController.getMasterConnectListByModelInfoId);
// 선택한 모델에 연결된 유저들 이름으로 검색
router.get('/model/connectModelList/userName/:modelInfoId/:userName', con.ManageScreenController.getMasterConnectListByUserName);
// 선택한 모델에 연결된 유저들 아이디로 검색
router.get('/model/connectModelList/userLoginId/:modelInfoId/:userLoginId', con.ManageScreenController.getMasterConnectListByUserLoginId);



router.post('/user/join', con.LoginController.insertUserInfo);
router.post('/user/login', con.LoginController.getUserLogin);

router.post('/user/id', con.LoginController.getUserIdByUserLoginId);



module.exports = router;