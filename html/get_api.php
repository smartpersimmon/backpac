<?php header('Access-Control-Allow-Origin: *');?>
<?php header("Content-Type: application/json;charset=utf-8");?>

<?php
/*error_reporting(E_ALL);
ini_set("display_errors", 1);*/

include "lib.php";

$api_mode = $_REQUEST['mode'];
$arrData = array();
$arrResult = array();

if($api_mode == 'join'){ // 회원가입
	$name = $_REQUEST['name'];
	$id = $_REQUEST['id'];
	$pass = $_REQUEST['pass'];
	$tel = preg_replace("/[^0-9]/", "", $_REQUEST['tel']);
	$email = $_REQUEST['email'];
	$sex = $_REQUEST['sex'];
	$nameptn = preg_match("/[^\x{1100}-\x{11FF}\x{3130}-\x{318F}\x{AC00}-\x{D7AF}a-zA-Z]/u", $name);
	$idptn = preg_match("/[^a-z]/", $id);
	$passnum = preg_match('/[0-9]/u', $pass);
	$passlow = preg_match('/[a-z]/u', $pass);
	$passupp = preg_match('/[A-Z]/u', $pass);
	$passspe = preg_match("/[\!\@\#\$\%\^\&\*]/u",$pass);
	$exp_email = explode("@", $email);

	if( !$name || !$id || !$pass || !$tel || !$email ){
		$elem = array("code" => 201, "result" => "Missing required data.");
	} else if($nameptn){
		$elem = array("code" => 301, "result" => "The name data is not valid.");
	} else if($idptn){
		$elem = array("code" => 302, "result" => "The ID data is not valid.");
	} else if(strlen($pass) <10 || !$passnum || !$passlow || !$passupp || !$passspe){
		$elem = array("code" => 303, "result" => "The password data is not valid.");
	} else if(!$exp_email[1] || strpos($email, "@") === false){
		$elem = array("code" => 304, "result" => "The email data is not valid.");
	} else if( $sex != 'f' && $sex != 'm' && $sex){
 		$elem = array("code" => 305, "result" => "The sex data is not valid.");
	} else {
		$query = "SELECT * FROM tbl_member where id = '$id'";
		$data = mysqli_query($conn, $query);
		$rows = mysqli_num_rows($data);
		if($rows){
			$elem = array("code" => 306, "result" => "There is an existing account for this ID.");
		} else {
			$query = "SELECT * FROM tbl_member where email = '$email'";
			$data = mysqli_query($conn, $query);
			$rows = mysqli_num_rows($data);
			if($rows){
				$elem = array("code" => 307, "result" => "There is an existing account for this email address.");
			} else {
				//$sql = "insert into tbl_member(id, pass, name, tel, email, sex) values('$id',md5('$pass'), '$name', '$tel', '$email', '$sex')";
				if($sex){
					$sql = "insert into tbl_member(id, pass, name, tel, email, sex) values('$id','$pass', '$name', '$tel', '$email', '$sex')";
				} else {
					$sql = "insert into tbl_member(id, pass, name, tel, email, sex) values('$id','$pass', '$name', '$tel', '$email', null)";
				}
				if(!mysqli_query($conn,$sql)){
					$elem = array("code" => 202, "result" => mysqli_error($conn));
				} else {
					$elem = array("code" => 200, "result" => "OK.");
				}
			}
		}
	}
	array_push($arrData, $elem);

} else if($api_mode == 'login'){ // 회원 로그인
	$id = $_REQUEST['id'];
	$pass = $_REQUEST['pass'];

	if( !$id || !$pass ){
		$elem = array("code" => 201, "result" => "Missing required data.");
	} else {
		$query = "SELECT * FROM tbl_member where id = '$id' and pass='$pass'";
		$data = mysqli_query($conn, $query);
		$rows = mysqli_num_rows($data);
		if(!$rows){
			$elem = array("code" => 203, "result" => "The user account does not exist.");
		} else {
			$elem = array("code" => 200, "result" => "OK.");
		}
	}
	array_push($arrData, $elem);
} else if($api_mode == 'info'){ //단일 회원 상세 정보 조회
	$id = $_REQUEST['id'];
	$pass = $_REQUEST['pass'];

	if( !$id || !$pass ){
		$elem = array("code" => 201, "result" => "Missing required data.");
	} else {
		$query = "SELECT * FROM tbl_member where id = '$id' and pass='$pass'";
		$data = mysqli_query($conn, $query);
		$rows = mysqli_num_rows($data);
		if(!$rows){
			$elem = array("code" => 203, "result" => "The user account does not exist.");
		} else {
			$row = mysqli_fetch_assoc($data);
			$query = "SELECT * FROM tbl_member where mid =".$row['mid'];
			$data = mysqli_query($conn, $query);
			$row = mysqli_fetch_assoc($data);
			if($row['sex'] != 'f' && $row['sex'] != 'm'){
				$sex = $row['sex'];
			} else {
				$sex = null;
			}
			$elem = array("code" => 200, "result" => "OK.",
							"id" => $row['id'], "name" => urlencode($row['name']), "tel" => $row['tel'], "email" => $row['email'], "sex" => $sex);
		}
	}
	array_push($arrData, $elem);

} else if($api_mode == 'orderlist'){ //단일 회원의 주문 목록 조회
	$id = $_REQUEST['id'];
	$pass = $_REQUEST['pass'];

	if($_REQUEST['p']){
		$pg = $_REQUEST['p'];
	} else {
		$pg = 1;
	}
	if($_REQUEST['block']){
		$block = $_REQUEST['block'];
	} else {
		$block = 10;
	}
	$slimit = ($pg-1) * $block;

	if( !$id || !$pass ){
		$elem = array("code" => 201, "result" => "Missing required data.");
	} else {
		$query = "SELECT * FROM tbl_member where id = '$id' and pass='$pass'";
		$data = mysqli_query($conn, $query);
		$rows = mysqli_num_rows($data);
		if(!$rows){
			$elem = array("code" => 203, "result" => "The user account does not exist.");
		} else {
			$query = "SELECT * FROM tbl_order where id ='".$id."' order by order_id desc limit ".$slimit.",".$block;
			$rs = mysqli_query($conn, $query);
			while($R = mysqli_fetch_array($rs)){
				$elem = array("order_id" => $R['order_id'], "prod_name" => urlencode($R['prod_name']), "paytime" => $R['paytime']);
				array_push($arrResult, $elem);
		 	}
			$elem = array("code" => 200, "result" => "OK.", "list" => $arrResult);
			array_push($arrData, $elem);
		}
	}

} else if($api_mode == 'memlist'){ //여러 회원 목록 조회
	if($_REQUEST['p']){
		$pg = $_REQUEST['p'];
	} else {
		$pg = 1;
	}
	if($_REQUEST['block']){
		$block = $_REQUEST['block'];
	} else {
		$block = 10;
	}
	$slimit = ($pg-1) * $block;
	$stype = $_REQUEST['stype'];
	$sval = $_REQUEST['sval'];

	if($stype && $sval){
		if($stype != 'email' && $stype != 'name'){
			$elem = array("code" => 401, "result" => "The stype data is not valid.");
			array_push($arrData, $elem);
			$json = json_encode($arrData);
			echo  prettyPrint(urldecode($json));
			exit;
		}
		$sql_where = $stype." like '%".$sval."%'";
	} else if($sval) {
		$sql_where = " name like '%".$sval."%' OR email like '%".$sval."%'";
	} else {
		$sql_where = " 1";
	}

	$sql = "select * from tbl_member t1 left join";
	$sql .= " (select id as subid1, prod_name, paytime from tbl_order sub1, (select id as subid2, max(paytime) as max_paytime from tbl_order group by subid2) sub2";
	$sql .= " where sub1.paytime=sub2.max_paytime) t2 on t1.id=t2.subid1";
	$sql .= " where".$sql_where." order by mid desc limit ".$slimit.",".$block;
  $rs = mysqli_query($conn, $sql);
  while($R = mysqli_fetch_array($rs)){
		if($R['sex']){
			$sex = $R['sex'];
		} else {
			$sex = null;
		}
		if(!$R['prod_name']){
			$prod_name = null;
		} else {
			$prod_name = urlencode($R['prod_name']);
		}
		$elem = array("id" => $R['id'], "name" => urlencode($R['name']), "tel" => $R['tel'], "email" => $R['email'], "sex" => $sex,
									"last_payprod" => $prod_name, "last_paytime" => $R['paytime']);
		array_push($arrResult, $elem);
  }
	$elem = array("code" => 200, "result" => "OK.", "list" => $arrResult);
	array_push($arrData, $elem);

} else {
	$elem = array("code" => 101, "result" => "The mode data is not valid.");
	array_push($arrData, $elem);
}

$json = json_encode($arrData);
echo  prettyPrint(urldecode($json));
?>
