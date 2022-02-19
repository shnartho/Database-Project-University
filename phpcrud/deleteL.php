<?php
include 'functions.php';
$pdo = pdo_connect_mysql();
$msg = '';
// Check that the Language ID exists
if (isset($_GET['LanguageID'])) {
    // Select the record that is going to be deleted
    $stmt = $pdo->prepare('SELECT * FROM Language WHERE LanguageID = ?');
    $stmt->execute([$_GET['LanguageID']]);
    $languages = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$languages) {
        exit('Language doesn\'t exist with that ID!');
    }
    // Make sure the user confirms beore deletion
    if (isset($_GET['confirm'])) {
        if ($_GET['confirm'] == 'yes') {
            // User clicked the "Yes" button, delete record
            $stmt = $pdo->prepare('DELETE FROM Language WHERE LanguageID = ?');
            $stmt->execute([$_GET['LanguageID']]);
            $msg = 'You have deleted the Language!';
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
	<h2>Delete Language #<?=$languages['LanguageID']?></h2>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php else: ?>
	<p>Are you sure you want to delete Language #<?=$languages['LanguageID']?>?</p>
    <div class="yesno">
        <a href="deleteL.php?LanguageID=<?=$languages['LanguageID']?>&confirm=yes">Yes</a>
        <a href="deleteL.php?LanguageID=<?=$languages['LanguageID']?>&confirm=no">No</a>
    </div>
    <?php endif; ?>
</div>

<?=template_footer()?>