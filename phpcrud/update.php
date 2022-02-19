

<?php
include 'functions.php';
$pdo = pdo_connect_mysql();
$msg = '';
// Check if the Film id exists, for example update.php?id=1 will get the film with the id of 1
if (isset($_GET['Film_ID'])) {
    if (!empty($_POST)) {
        // This part is similar to the create.php, but instead we update a record and not insert
        $Film_ID = isset($_POST['Film_ID']) ? $_POST['Film_ID'] : NULL;
        $LanguageID = isset($_POST['LanguageID']) ? $_POST['LanguageID'] : '';
        $RegionID = isset($_POST['RegionID']) ? $_POST['RegionID'] : '';
        $Title = isset($_POST['Title']) ? $_POST['Title'] : '';
        $Description = isset($_POST['Description']) ? $_POST['Description'] : '';

        $Release_Year = isset($_POST['Release_Year']) ? $_POST['Release_Year'] : '';
        $Rental_Duration = isset($_POST['Rental_Duration']) ? $_POST['Rental_Duration'] : '';
        $Rental_Rate = isset($_POST['Rental_Rate']) ? $_POST['Rental_Rate'] : '';

        $Length = isset($_POST['Length']) ? $_POST['Length'] : '';
        $Replacement_Cost = isset($_POST['Replacement_Cost']) ? $_POST['Replacement_Cost'] : '';
        $Rating = isset($_POST['Rating']) ? $_POST['Rating'] : '';

        $Special_Features = isset($_POST['Special_Features']) ? $_POST['Special_Features'] : '';
        $FullText_Var = isset($_POST['FullText_Var']) ? $_POST['FullText_Var'] : '';

        $Last_Update = isset($_POST['Last_Update']) ? $_POST['Last_Update'] : date('Y-m-d H:i:s');
        // Update the record
        $stmt = $pdo->prepare('UPDATE Film SET Film_ID = ?, LanguageID = ?, RegionID = ?, Title = ?, Description = ?, Release_Year = ?, Rental_Duration = ?, Rental_Rate = ?, Length = ?, Replacement_Cost = ?, Rating = ?, Special_Features = ?,FullText_Var = ?, Last_Update = ? WHERE Film_ID = ?');

        $stmt->execute([$Film_ID, $LanguageID, $RegionID, $Title, $Description, $Release_Year, $Rental_Duration, $Rental_Rate,$Length, $Replacement_Cost, $Rating,$Special_Features, $FullText_Var, $Last_Update, $_GET['Film_ID']]);
        $msg = 'Updated Successfully!';
    }
    // Get the films from the Film table
    $stmt = $pdo->prepare('SELECT * FROM Film WHERE Film_ID = ?');
    $stmt->execute([$_GET['Film_ID']]);
    $films = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$films) {
        exit('Film doesn\'t exist with that ID!');
    }
} else {
    exit('No ID specified!');
}

?>

<?=template_header('Read')?>

<div class="content update">
	<h2>Update Films #<?=$films['Film_ID']?></h2>
    <form action="update.php?Film_ID=<?=$films['Film_ID']?>" method="post">
        <label for="Film_ID">FilmID</label>
        <input type="text" name="Film_ID" placeholder="1" value="<?=$films['Film_ID']?>" id="Film_ID">

        <label for="LanguageID">LanguageID</label>
        <input type="text" name="LanguageID" placeholder="1" value="<?=$films['LanguageID']?>" id="LanguageID">

        <label for="RegionID">RegionID</label>
        <input type="text" name="RegionID" placeholder="1" value="<?=$films['RegionID']?>" id="RegionID">

    
        <label for="Title">Title</label>
        <input type="text" name="Title" placeholder="Title" value="<?=$films['Title']?>" id="Title">
        <label for="Description">Description</label>
        <input type="text" name="Description" placeholder="Description" value="<?=$films['Description']?>" id="Description">

        <label for="Release_Year">Release_Year</label>
        <input type="text" name="Release_Year" placeholder="Release_Year" value="<?=$films['Release_Year']?>" id="Release_Year">
        <label for="Rental_Duration">Rental_Duration</label>
        <input type="text" name="Rental_Duration" placeholder="Rental_Duration" value="<?=$films['Rental_Duration']?>" id="Rental_Duration">

        <label for="Rental_Rate">Rental_Rate</label>
        <input type="text" name="Rental_Rate" placeholder="Rental_Rate" value="<?=$films['Rental_Rate']?>" id="Rental_Rate">
        <label for="Length">Length</label>
        <input type="text" name="Length" placeholder="Length" value="<?=$films['Length']?>" id="Length">

        <label for="Replacement_Cost">Replacement_Cost</label>
        <input type="text" name="Replacement_Cost" placeholder="Replacement_Cost" value="<?=$films['Replacement_Cost']?>" id="Replacement_Cost">
        <label for="Rating">Rating</label>
        <input type="text" name="Rating" placeholder="Rating" value="<?=$films['Rating']?>" id="Rating">

        <label for="Special_Features">Special_Features</label>
        <input type="text" name="Special_Features" placeholder="Special_Features" value="<?=$films['Special_Features']?>" id="Special_Features">
        <label for="FullText_Var">FullText_Var</label>
        <input type="text" name="FullText_Var" placeholder="FullText_Var" value="<?=$films['FullText_Var']?>" id="FullText_Var">
       
        <label for="Last_Update">Last_Update</label>
        <input type="datetime-local" name="Last_Update" value="<?=date('Y-m-d\TH:i', strtotime($films['Last_Update']))?>" id="Last_Update">
        <input type="submit" value="Update">
    </form>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?>