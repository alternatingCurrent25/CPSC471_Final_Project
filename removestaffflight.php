<?php
function derivingalloperate() {
    $con=mysqli_connect("localhost","student","ensf","471");
    $query="SELECT Username, Plane_Serial FROM OPERATES ";

    $result = mysqli_query($con,$query);

    $derivingSuccess =  mysqli_num_rows($result);

    if ($derivingSuccess > 0) {
        while ($row = mysqli_fetch_row($result)) {
            echo "<p><b>Username:</b> ".$row[0]." <b>Plane Serial:</b> ".$row[1]."</p>";
        }
    }

    


    mysqli_close($con);
}

derivingalloperate();

?>

</html>
<body>
<form action="removestaffpage.php" method="post">
  Username:  <input type="text" name="username"><br>
  Plane Serial: <input type="text" name="flight"><br>
  <input type="submit">
</form>

</body>
</html>