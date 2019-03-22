<?php 
	session_start();
	
	if( isset($_SESSION['user']) ){
	  header("Location: home.php");
	}
	
	require_once("DatabaseConfig.php");
	
	$error = false;
	
	if ( isset($_POST['btn-login']) ) { 
		$email = trim($_POST['email']);
		$email = strip_tags($email);
		$email = htmlspecialchars($email);

		$password = trim($_POST['password']);
		$password = strip_tags($password);
		$password = htmlspecialchars($password);
		
		if(empty($email)){
			$error = true;
			$errorMsg = "Please enter your email address.";
		} else if ( !filter_var($email,FILTER_VALIDATE_EMAIL) ) {
			$error = true;
			$errorMsg = "Please enter valid email address.";
		}

		if (empty($password)) {
			$error = true;
			$errorMsg = "Please enter password.";
		} else if(strlen($password) < 6) {
			$error = true;
			$errorMsg = "Password must have atleast 6 characters.";
		}

		if (!$error) {
			
			$query = "SELECT email, password FROM students WHERE email='$email' UNION SELECT email, password FROM instructors WHERE email='$email'";
			
			$res=mysqli_query($connect_DB,$query);
			$row=mysqli_fetch_array($res);
			$count = mysqli_num_rows($res);
			
			if( $count == 1 && password_verify($password, $row['password']) ) {
				$_SESSION['email'] = $row['email'];
				header("Location: cp/discussions.php");
			} else {
				$error = true;
				$errorMsg = "Incorrect Credentials, Try again...";
			}
		}
	}
	
	
?>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body, html {
    height: 100%;
    font-family: Arial, Helvetica, sans-serif;
}

* {
    box-sizing: border-box;
}

.login-page {
    /* The image used */
    color:blue;
	background-color:#3a717a;

    min-height: 625px;

    /* Center and scale the image nicely */
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}

/* Add styles to the form container */
.form {
    position: absolute;
    right: 0;
    margin: 20px;
    max-width: 340px;
    padding: 16px;
    background-color: white;
	border:3px #800000 solid;
}

/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 15px;
    margin: 5px 0 22px 0;
    border: 3px #800000 solid;
    background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
    background-color: #ddd;
    outline: none;
}

/* Set a style for the submit button */
.btn {
    background-color: #800000;
    color: white;
    padding: 16px 20px;
    border: none;
    cursor: pointer;
    width: 100%;
    opacity: 0.9;
}

.btn:hover {
    opacity: 1;
}
</style>
</head>
<body id="login">
		<div class="login-page">
		  <div class="form">
				<form class="login-form" method="post" action="login.php">
			
					<input type="text" name="email" placeholder="Email"/>
					<input type="password" name="password" placeholder="Password"/>
			  
					<button type="submit" name="btn-login" class="btn">LOGIN</button>
					<p class="message">Not registered? <a href="register.php">Create an account</a></p>
					
					<?php 
					if($error) 
						echo "<p class=\"text-error\">$errorMsg</p>";
					?>
			  
				</form>
		  </div>
		</div>
	</body>
</html>
<?php mysqli_close($connect_DB); ?>