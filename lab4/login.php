<?php
    require_once "include/app.inc.php";
    
    $login = "";
    $password = "";

    if (!isset($_SESSION['user_auth']))
    {
        if (!empty($_POST["login"]))
        {
            $login = $_POST["login"];
        }

        if (!empty($_POST["password"]))
        {
            $password = $_POST["password"];
        }

        if ($login && $password)
        {
            $user = R::findOne('user', ' login = ? and password = ? ', [$login, md5($password)]);
            if (isset($user->login))
            {
                $_SESSION['user_auth'] = $login;
                header("Location: http://ormlab.localhost:8000/index.php");
                exit();
            }
            else
            {
                echo "Пользователь с логином " . $login . " не найден.";
            }
        }
    }
    else
    {
        header("Location: http://ormlab.localhost:8000/index.php");
    }
?>

<?php if(!isset($_SESSION['user_auth'])): ?>
    <h2>Войти:</h2>
    <form action method="post">
        Логин: <input type="text" name="login"><br>
        Пароль: <input type="password" name="password"><br>
        <input type="submit" name="submit" value="Submit">
    </form>
<?php endif; ?>