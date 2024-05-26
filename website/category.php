<!DOCTYPE html>
<html>
<head>
    <title>Archer Category</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <nav>
        <a href="index.php">Archer Info</a>
        <a href="scores.php">Scores</a>
        <a href="rounds.php">Rounds</a>
        <a href="category.php">Category</a>
    </nav>

    <?php
    // Including the dbconnect.php file at the top
    $dbconnectPath = 'dbconnect.php';
    if (file_exists($dbconnectPath)) {
        include($dbconnectPath);
    } else {
        die("The dbconnect.php file is missing. Please check the file path.");
    }

    function getRounds() {
        $conn = getDBConnection();
        $sql = "SELECT ID, RoundName FROM Rounds";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            echo "<select name='RoundID'>";
            while ($row = $result->fetch_assoc()) {
                echo "<option value='" . $row['ID'] . "'>" . $row['RoundName'] . "</option>";
            }
            echo "</select>";
        } else {
            echo "No rounds found.";
        }

        $conn->close();
    }

    function getCompetition() {
        $conn = getDBConnection();
        $sql = "SELECT ID, CompetitionName FROM ClubCompetition";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            echo "<select name='CompetitionID'>";
            while ($row = $result->fetch_assoc()) {
                echo "<option value='" . $row['ID'] . "'>" . $row['CompetitionName'] . "</option>";
            }
            echo "</select>";
        } else {
            echo "No competitions found.";
        }

        $conn->close();
    }

    function getArcherName() {
        $conn = getDBConnection();
        $sql = "SELECT ID, FirstName, LastName FROM ArcherInfo";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            echo "<select name='ArcherID'>";
            while ($row = $result->fetch_assoc()) {
                $selected = isset($_POST['ArcherID']) && $_POST['ArcherID'] == $row['ID'] ? 'selected' : '';
                echo "<option value='" . $row['ID'] . "' $selected>" . $row['FirstName'] . " " . $row['LastName'] . "</option>";
            }
            echo "</select>";
        } else {
            echo "No archers found.";
        }

        $conn->close();
    }

    function getEquipment() {
        $conn = getDBConnection();
        $sql = "SELECT ID, Description FROM Division";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            echo "<select name='DivisionID'>";
            while ($row = $result->fetch_assoc()) {
                echo "<option value='" . $row['ID'] . "'>" . $row['Description'] . "</option>";
            }
            echo "</select>";
        } else {
            echo "No equipment found.";
        }

        $conn->close();
    }

    function getClass($archerID) {
        $conn = getDBConnection();
        $sql = "SELECT c.ID, c.Description 
                FROM Classification c
                INNER JOIN ArcherInfo a ON c.MinimumAge <= TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) 
                    AND c.MaximumAge >= TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) 
                    AND c.Gender = a.Gender
                WHERE a.ID = $archerID";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            echo "<select name='ClassificationID'>";
            while ($row = $result->fetch_assoc()) {
                echo "<option value='" . $row['ID'] . "'>" . $row['Description'] . "</option>";
            }
            echo "</select>";
        } else {
            echo "No classes found for the selected archer.";
        }

        $conn->close();
    }

    function getYears() {
        $options = "";
        $currentYear = date("Y");
        $startYear = 1980;

        for ($year = $currentYear; $year >= $startYear; $year--) {
            $options .= "<option value='$year'>$year</option>";
        }

        echo "<select name='RegisterYear'>$options</select>";
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submitCategory'])) {
        $conn = getDBConnection();

        $selectedArcherID = $_POST['ArcherID'];
        $selectedCompetitionID = $_POST['CompetitionID'];
        $selectedRoundID = $_POST['RoundID'];
        $selectedClassificationID = $_POST['ClassificationID'];
        $selectedDivisionID = $_POST['DivisionID'];
        $selectedYear = $_POST['RegisterYear'];

        $sql = "INSERT INTO Category (ArcherID, CompetitionID, RoundID, ClassificationID, RegisterYear, DivisionID) VALUES ('$selectedArcherID', '$selectedCompetitionID', '$selectedRoundID', '$selectedClassificationID', '$selectedYear', '$selectedDivisionID')";

        if ($conn->query($sql) === TRUE) {
            echo "Category added successfully!";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

        $conn->close();
    }
    ?>

    <div>
        <h2>Add Category</h2>
        <form method="post" action="category.php">
            <label for="RoundID">Round name:</label>
            <?php echo getRounds(); ?><br>
            <label for="CompetitionID">Competition:</label>
            <?php echo getCompetition(); ?><br>
            <label for="ArcherID">Archer Name:</label>
            <?php echo getArcherName(); ?>
            <button type="submit" name="updateArcher">Retrieve Class</button><br>
            <label for="DivisionID">Equipment:</label>
            <?php echo getEquipment(); ?><br>
            <label for="ClassificationID">Class:</label>
            <?php 
            if (isset($_POST['ArcherID'])) {
                getClass($_POST['ArcherID']);
            } 
            ?><br>
            <label for="RegisterYear">Year:</label>
            <?php echo getYears(); ?><br>
            <input type="submit" name="submitCategory" value="Add Category">
        </form>
    </div>
</body>
</html>
