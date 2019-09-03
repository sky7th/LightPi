const router = require('express').Router();

const lightKeyController = require('../controllers/lightKeyController');

// 나랑 연결 되어있는 모델들 불러오기  
router.get('/model/modelList/:userInfoId', lightKeyController.getModelListByUserId);
// 해당 모델 키 값 가져오기
router.get('/model/modelKey/:modelId', lightKeyController.getModelKeyByModelId);
// 모델 이름으로 모델 검색
router.get('/model/modelName/:modelName/:userInfoId', lightKeyController.getModelByModelName);
// 모델 코드로 모델 검색
router.get('/model/modelCode/:modelCode/:userInfoId', lightKeyController.getModelByModelCode);


// 모델 등록,  
router.post('/model/edit', lightKeyController.updateModelMasterUserInfoId);
// 내가 마스터인 모델 불러오기
router.get('/model/masterModelList/:masterUserInfoId', lightKeyController.getModelByMasterUserInfoId);
// 모델 이름 변경
router.post('/model/modelName/edit', lightKeyController.updateModelName);


// 내 신청 목록 가져오기
router.get('/connect/:userInfoId', lightKeyController.getConnectApplyListByUserId);
// 연결 요청
router.post('/connect/add', lightKeyController.insertConnect);
// 연결 수락
router.post('/connect/edit', lightKeyController.updateConnectSetConnectFlag);
// 연결 삭제
router.post('/connect/delete', lightKeyController.deleteConnectByConnectId);


// 선택한 모델에 신청한 유저들 모두 가져오기
router.get('/model/applyModelList/:modelInfoId', lightKeyController.getMasterApplyListByModelInfoId);
// 선택한 모델에 신청한 유저들 이름으로 검색
router.get('/model/applyModelList/userName/:modelInfoId/:userName', lightKeyController.getMasterApplyListByUserName);
// 선택한 모델에 신청한 유저들 아이디로 검색
router.get('/model/applyModelList/userLoginId/:modelInfoId/:userLoginId', lightKeyController.getMasterApplyListByUserLoginId);

// 선택한 모델에 연결된 유저들 모두 가져오기
router.get('/model/connectModelList/:modelInfoId', lightKeyController.getMasterConnectListByModelInfoId);
// 선택한 모델에 연결된 유저들 이름으로 검색
router.get('/model/connectModelList/userName/:modelInfoId/:userName', lightKeyController.getMasterConnectListByUserName);
// 선택한 모델에 연결된 유저들 아이디로 검색
router.get('/model/connectModelList/userLoginId/:modelInfoId/:userLoginId', lightKeyController.getMasterConnectListByUserLoginId);



router.post('/user/join', lightKeyController.insertUserInfo);
router.post('/user/login', lightKeyController.getUserLogin);

router.post('/user/id', lightKeyController.getUserIdByUserLoginId);



module.exports = router;