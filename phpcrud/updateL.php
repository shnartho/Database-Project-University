
<?php
include 'functions.php';
$pdo = pdo_connect_mysql();
$msg = '';
// Check if the Language id exists, for example update.php?id=1 will get the Language with the id of 1
if (isset($_GET['LanguageID'])) {
    if (!empty($_POST)) {
        // This part is similar to the create.php, but instead we update a record and not insert
        $LanguageID = isset($_POST['LanguageID']) ? $_POST['LanguageID'] : NULL;
    
        $Name = isset($_POST['Name']) ? $_POST['Name'] : '';
    

        $Last_Update = isset($_POST['Last_Update']) ? $_POST['Last_Update'] : date('Y-m-d H:i:s');
        // Update the record
        $stmt = $pdo->prepare('UPDATE Language SET LanguageID = ?, Name = ? , Last_Update = ? WHERE LanguageID = ?');

        $stmt->execute([$LanguageID, $Name, $Last_Update, $_GET['LanguageID']]);
        $msg = 'Updated Successfully!';
    }
    // Get the languages from the Language table
    $stmt = $pdo->prepare('SELECT * FROM Language WHERE LanguageID = ?');
    $stmt->execute([$_GET['LanguageID']]);
    $languages = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$languages) {
        exit('Language doesn\'t exist with that ID!');
    }
} else {
    exit('No ID specified!');
}

?>

<?=template_header('Read')?>

<div class="content update">
	<h2>Update Languages #<?=$languages['LanguageID']?></h2>
    <form action="updateL.php?LanguageID=<?=$languages['LanguageID']?>" method="post">
        <label for="LanguageID">LanguageID</label>
        <input type="text" name="LanguageID" placeholder="1" value="<?=$languages['LanguageID']?>" id="LanguageID">
    
        <label for="Name">Name</label>
        <input type="text" name="Name" placeholder="Name" value="<?=$languages['Name']?>" id="Name">
       
        <label for="Last_Update">Last_Update</label>
        <input type="datetime-local" name="Last_Update" value="<?=date('Y-m-d\TH:i', strtotime($languages['Last_Update']))?>" id="Last_Update">
        <input type="submit" value="Update">
    </form>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?>