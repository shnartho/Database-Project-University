

<?php
include 'functions.php';
// Connect to MySQL database
$pdo = pdo_connect_mysql();
// Get the page via GET request (URL param: page), if non exists default the page to 1
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
// Number of records to show on each page
$records_per_page = 5;

// Prepare the SQL statement and get records from our Film table, LIMIT will determine the page
$stmt = $pdo->prepare('SELECT * FROM Region ORDER BY RegionID LIMIT :current_page, :record_per_page');
$stmt->bindValue(':current_page', ($page-1)*$records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':record_per_page', $records_per_page, PDO::PARAM_INT);
$stmt->execute();
// Fetch the records so we can display them in our template.
$Region = $stmt->fetchAll(PDO::FETCH_ASSOC);
// Get the total number of Film, this is so we can determine whether there should be a next and previous button
$num_Region = $pdo->query('SELECT COUNT(*) FROM Region')->fetchColumn();
?>

<?=template_header('Read')?>



<div class="content read">
	<h2>Read Region</h2>
	<a href="createR.php" class="create-films">Create Region</a>
	<table>
        <thead>
            <tr>
                <td>|RegionID|</td>
                <td>|Name|</td>
                <td>|Last Update|</td>
                <td></td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($Region as $regions): ?>
            <tr>
              
                <td><?=$regions['RegionID']?></td>
                <td><?=$regions['Name']?></td>
                <td><?=$regions['Last_Update']?></td>
                <td class="actions">
                    <a href="updateR.php?RegionID=<?=$regions['RegionID']?>" class="edit"><i class="fas fa-pen fa-xs"></i></a>
                    <a href="deleteR.php?RegionID=<?=$regions['RegionID']?>" class="trash"><i class="fas fa-trash fa-xs"></i></a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
	<div class="pagination">
		<?php if ($page > 1): ?>
		<a href="readR.php?page=<?=$page-1?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
		<?php endif; ?>
		<?php if ($page*$records_per_page < $num_Region): ?>
		<a href="readR.php?page=<?=$page+1?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
		<?php endif; ?>
	</div>
</div>

<?=template_footer()?>
