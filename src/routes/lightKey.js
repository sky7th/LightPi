const router = require('express').Router();

const lightKeyController = require('../controllers/lightKeyController');

// 나랑 연결 되어있는 모델들 불러오기, 해당 모델 키 값 가져오기, 모델 이름으로 모델 검색, 모델 코드로 모델 검색
router.get('/model/modelList/:userInfoLoginId', lightKeyController.getModelListByUserId);
router.get('/model/modelKey/:modelId', lightKeyController.getModelKeyByModelId);
router.get('/model/modelName/:modelName/:loginId', lightKeyController.getModelByModelName);
router.get('/model/modelCode/:modelCode/:loginId', lightKeyController.getModelByModelCode);

// 제품 등록, 내가 마스터인 모델 불러오기, 이름 변경
router.post('/model/edit', lightKeyController.updateModelMasterUserInfoId);
router.get('/model/:masterUserInfoId', lightKeyController.getModelByMasterUserInfoId);
router.post('/model/modelName/edit/:modelInfoId', lightKeyController.updateModelName);

// 연결 요청, 수락, 거절
router.post('/connect/add', lightKeyController.insertConnect);
router.post('/connect/edit/:connectInfoId', lightKeyController.updateConnectSetConnectFlag);
router.post('/connect/delete/:connectInfoId', lightKeyController.deleteConnectByConnectId);



module.exports = router;