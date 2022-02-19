<?php
include 'functions.php';
$pdo = pdo_connect_mysql();
$msg = '';
// Check if POST data is not empty
if (!empty($_POST)) {
    // Post data not empty insert a new record
    // Set-up the variables that are going to be inserted, we must check if the POST variables exist if not we can default them to blank
    $RegionID = isset($_POST['RegionID']) && !empty($_POST['RegionID']) && $_POST['RegionID'] != 'auto' ? $_POST['RegionID'] : NULL;
    // Check if POST variable "LanguageID" exists, if not default the value to blank, basically the same for all variables
    $Name = isset($_POST['Name']) ? $_POST['Name'] : '';
    $Last_Update = isset($_POST['Last_Update']) ? $_POST['Last_Update'] : date('Y-m-d H:i:s');
    // Insert new record into the region  table
    $stmt = $pdo->prepare('INSERT INTO Region VALUES (?, ?, ?)');
    $stmt->execute([$RegionID, $Name, $Last_Update]);
    // Output message
    $msg = 'Created Successfully!';
}
?>

<?=template_header('Create')?>

<div class="content update">
	<h2>Create Region</h2>
    <form action="createR.php" method="post">
        <label for="RegionID">RegionID</label>
        <input type="text" name="RegionID" placeholder="26" value="auto" id="RegionID">
    
        <label for="Name">Name</label>
        <input type="text" name="Name" placeholder="Name" id="Name">

       
        <label for="Last_Update">Last_Update</label>
        <input type="datetime-local" name="Last_Update" value="<?=date('Y-m-d\TH:i')?>" id="Last_Update">
        <input type="submit" value="Create">
    </form>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?>
