

<?php
include 'functions.php';
// Connect to MySQL database
$pdo = pdo_connect_mysql();
// Get the page via GET request (URL param: page), if non exists default the page to 1
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
// Number of records to show on each page
$records_per_page = 5;

// Prepare the SQL statement and get records from our Film table, LIMIT will determine the page
$stmt = $pdo->prepare('SELECT * FROM Language ORDER BY LanguageID LIMIT :current_page, :record_per_page');
$stmt->bindValue(':current_page', ($page-1)*$records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':record_per_page', $records_per_page, PDO::PARAM_INT);
$stmt->execute();
// Fetch the records so we can display them in our template.
$Language = $stmt->fetchAll(PDO::FETCH_ASSOC);
// Get the total number of Film, this is so we can determine whether there should be a next and previous button
$num_Language = $pdo->query('SELECT COUNT(*) FROM Language')->fetchColumn();
?>

<?=template_header('Read')?>



<div class="content read">
	<h2>Read Language</h2>
	<a href="createL.php" class="create-films">Create Language</a>
	<table>
        <thead>
            <tr>
                <td>|LanguageID|</td>
                <td>|Name|</td>
                <td>|Last Update|</td>
                <td></td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($Language as $Languages): ?>
            <tr>
              
                <td><?=$Languages['LanguageID']?></td>
                <td><?=$Languages['Name']?></td>
                <td><?=$Languages['Last_Update']?></td>
                <td class="actions">
                    <a href="updateL.php?LanguageID=<?=$Languages['LanguageID']?>" class="edit"><i class="fas fa-pen fa-xs"></i></a>
                    <a href="deleteL.php?LanguageID=<?=$Languages['LanguageID']?>" class="trash"><i class="fas fa-trash fa-xs"></i></a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
	<div class="pagination">
		<?php if ($page > 1): ?>
		<a href="readL.php?page=<?=$page-1?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
		<?php endif; ?>
		<?php if ($page*$records_per_page < $num_Language): ?>
		<a href="readL.php?page=<?=$page+1?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
		<?php endif; ?>
	</div>
</div>

<?=template_footer()?>
