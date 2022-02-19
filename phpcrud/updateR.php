
<?php
include 'functions.php';
$pdo = pdo_connect_mysql();
$msg = '';
// Check if the region id exists, for example update.php?id=1 will get the region with the id of 1
if (isset($_GET['RegionID'])) {
    if (!empty($_POST)) {
        // This part is similar to the create.php, but instead we update a record and not insert
        $RegionID = isset($_POST['RegionID']) ? $_POST['RegionID'] : NULL;
    
        $Name = isset($_POST['Name']) ? $_POST['Name'] : '';
    

        $Last_Update = isset($_POST['Last_Update']) ? $_POST['Last_Update'] : date('Y-m-d H:i:s');
        // Update the record
        $stmt = $pdo->prepare('UPDATE Region SET RegionID = ?, Name = ? , Last_Update = ? WHERE RegionID = ?');

        $stmt->execute([$RegionID, $Name, $Last_Update, $_GET['RegionID']]);
        $msg = 'Updated Successfully!';
    }
    // Get the regions from the Region table
    $stmt = $pdo->prepare('SELECT * FROM Region WHERE RegionID = ?');
    $stmt->execute([$_GET['RegionID']]);
    $regions = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$regions) {
        exit('Region doesn\'t exist with that ID!');
    }
} else {
    exit('No ID specified!');
}

?>

<?=template_header('Read')?>

<div class="content update">
	<h2>Update Regions #<?=$regions['RegionID']?></h2>
    <form action="updateR.php?RegionID=<?=$regions['RegionID']?>" method="post">
        <label for="RegionID">RegionID</label>
        <input type="text" name="RegionID" placeholder="1" value="<?=$regions['RegionID']?>" id="RegionID">
    
        <label for="Name">Name</label>
        <input type="text" name="Name" placeholder="Name" value="<?=$regions['Name']?>" id="Name">
       
        <label for="Last_Update">Last_Update</label>
        <input type="datetime-local" name="Last_Update" value="<?=date('Y-m-d\TH:i', strtotime($regions['Last_Update']))?>" id="Last_Update">
        <input type="submit" value="Update">
    </form>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?>