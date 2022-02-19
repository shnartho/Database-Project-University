<?php
include 'functions.php';
$pdo = pdo_connect_mysql();
$msg = '';
// Check that the film ID exists
if (isset($_GET['Film_ID'])) {
    // Select the record that is going to be deleted
    $stmt = $pdo->prepare('SELECT * FROM Film WHERE Film_ID = ?');
    $stmt->execute([$_GET['Film_ID']]);
    $films = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$films) {
        exit('Film doesn\'t exist with that ID!');
    }
    // Make sure the user confirms beore deletion
    if (isset($_GET['confirm'])) {
        if ($_GET['confirm'] == 'yes') {
            // User clicked the "Yes" button, delete record
            $stmt = $pdo->prepare('DELETE FROM Film WHERE Film_ID = ?');
            $stmt->execute([$_GET['Film_ID']]);
            $msg = 'You have deleted the Film!';
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
	<h2>Delete Film #<?=$films['Film_ID']?></h2>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php else: ?>
	<p>Are you sure you want to delete contact #<?=$films['Film_ID']?>?</p>
    <div class="yesno">
        <a href="delete.php?Film_ID=<?=$films['Film_ID']?>&confirm=yes">Yes</a>
        <a href="delete.php?Film_ID=<?=$films['Film_ID']?>&confirm=no">No</a>
    </div>
    <?php endif; ?>
</div>

<?=template_footer()?>