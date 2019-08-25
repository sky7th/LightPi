const router = require('express').Router();

const lightKeyController = require('../controllers/lightKeyController');

router.get('/getModelList/:userInfoLoginId', lightKeyController.getModelList);
router.get('/getModelKey/:modelId', lightKeyController.getModelKey);


module.exports = router;