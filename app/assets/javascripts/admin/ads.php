<?php
// no direct access
defined( '_HEXEC' ) or die( 'Access error' );

class ControllerAds extends ControllerClass 
{
	private $c='ads';
		
	function viewList(){
		global $view;
		$model = new ModelAds();
		$data = $model->getAdses();
		$view->assign('data', $data);
		$view->loadView('ads', 'list');
	}
	
	function add(){
		global $view, $cinput;
		$msg = '';
		$model = new ModelAds();
		$arrLanguages = $model->getArrLanguages();
		$languageCode = 'en';
		$ads = $model->getAdses();
		$cnt = count($ads);
		if(isset($ads[$cnt -1]->order)){
			$biggestOrder = $ads[$cnt -1]->order;
		}
		else $biggestOrder = 0;
		
		if(isset($_POST['submit'])){
			$postData = $_POST['data'];
			$postData['order'] = $biggestOrder + 1;
			$insertId = $model->add($postData);
			if(!$insertId){
				$msg = 'Unsucessful. Please try again later';
			}
			else{
				$adsContentData = $_POST['adsContentData'];
				$adsContentData['adsId'] = $insertId;
				$result = $model->addAdsContent($adsContentData);
				redirect("index.php?c=ads&task=viewList");
			}
		}
		$view->assign('msg', $msg);
		$view->assign('adsArr', $adsArr);
		
		$view->assign('arrLanguages', $arrLanguages);
		$view->assign('languageCode', $languageCode);
		$view->loadView('ads', 'add');	
	}
	
	function edit(){
		global $cinput, $view;
		$model = new ModelAds();
		$id = $cinput->get('id');
		$data = $model->getAds($id);
		
		$arrLanguages = $model->getArrLanguages();
		$languageCode = getVar('languageCode');
		if($languageCode == '')
			$languageCode = 'en';
		$adsContent = $model->getAdsContent($id, $languageCode);
		//echo $adsContent;
		$s = getVar('s');
		$msg = '';
		if($s == 1)
			$msg = 'Successfully saved !';
		if(isset($_POST['submit'])){
			$postData = $_POST['data'];
			if($postData['active'] != 1)
				$postData['active'] = 0;
			if($postData['hasContactButton'] != 1)
				$postData['hasContactButton'] = 0;
				
			$adsContentData = $_POST['adsContentData'];
			$adsContentData['adsId'] = $id;
			$submitLanguage = $adsContentData['languageCode'];
			
			$rs = $model->edit($postData, $id);
			
			if($model->adsContentExists($id, $submitLanguage)){
				$result = $model->editAdsContent($adsContentData, $id, $submitLanguage);	// For table tbl_ads_content
				if($result)
					$s = 1;
			}
			else{
				$result = $model->addAdsContent($adsContentData);	
				if($result)
					$s = 1;
			}
			
			if(!$rs){
				$s = 0;
			}
			else{
				$s = 1;
			}
			redirect("index.php?c=ads&task=edit&id=$id&languageCode=$submitLanguage&s=$s");	
		}
		$view->assign('msg', $msg);
		$view->assign('data', $data);
		$view->assign('adsContent', $adsContent);
		$view->assign('arrLanguages', $arrLanguages);
		$view->loadView('ads', 'edit');
	}

	function duplicate()
	{
		$id = getVar('id');
		echo 'duplicate ' . $id;
		return;
		$model = new ModelAds();
		$model->duplicate($id);
	}
	
	function changeOrder(){
		global $cinput, $view;
		$model = new ModelAds();
		$move = getVar('move');
		$id = getVar('id');
		//$pageId = getVar('pageId');
		
		$model->changeOrder($id, $move);
		redirect('index.php?c=ads&task=viewList');
	}
	
	function delete(){
		global $cinput, $view;
		$model = new ModelAds();
		$ids = '';
		if(isset($_POST['check'])){
			$check = $_POST['check'];
			$cnt = count($check);
			for($i=0; $i<$cnt; $i++){
				$ids .= $check[$i] . ',';
			}
			$ids = substr($ids, 0, -1);
		}
		else{
			$ids = getVar('id');
		}
		$rs = $model->delete($ids);
		redirect('index.php?c=ads&task=viewList');
	}
}
?>