<?php
include 'functions.php';
$pdo = pdo_connect_mysql();
$msg = '';
// Check that the Region ID exists
if (isset($_GET['RegionID'])) {
    // Select the record that is going to be deleted
    $stmt = $pdo->prepare('SELECT * FROM Region WHERE RegionID = ?');
    $stmt->execute([$_GET['RegionID']]);
    $regions = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$regions) {
        exit('Region doesn\'t exist with that ID!');
    }
    // Make sure the user confirms beore deletion
    if (isset($_GET['confirm'])) {
        if ($_GET['confirm'] == 'yes') {
            // User clicked the "Yes" button, delete record
            $stmt = $pdo->prepare('DELETE FROM Region WHERE RegionID = ?');
            $stmt->execute([$_GET['RegionID']]);
            $msg = 'You have deleted the Region!';
        } else {
            // User clicked the "No" button, redirect them back to the read page
            header('Location: read.php');
            exit;
        }
    }
} else {
    exit('No ID specified!');
}
?>

<?=template_header('Delete')?>

<div class="content delete">
	<h2>Delete Region #<?=$regions['RegionID']?></h2>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php else: ?>
	<p>Are you sure you want to delete Region #<?=$regions['RegionID']?>?</p>
    <div class="yesno">
        <a href="deleteR.php?RegionID=<?=$regions['RegionID']?>&confirm=yes">Yes</a>
        <a href="deleteR.php?RegionID=<?=$regions['RegionID']?>&confirm=no">No</a>
    </div>
    <?php endif; ?>
</div>

<?=template_footer()?>