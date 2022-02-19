

<?php
include 'functions.php';
// Connect to MySQL database
$pdo = pdo_connect_mysql();
// Get the page via GET request (URL param: page), if non exists default the page to 1
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
// Number of records to show on each page
$records_per_page = 5;

// Prepare the SQL statement and get records from our Film table, LIMIT will determine the page
$stmt = $pdo->prepare('SELECT * FROM Film ORDER BY Film_ID LIMIT :current_page, :record_per_page');
$stmt->bindValue(':current_page', ($page-1)*$records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':record_per_page', $records_per_page, PDO::PARAM_INT);
$stmt->execute();
// Fetch the records so we can display them in our template.
$Film = $stmt->fetchAll(PDO::FETCH_ASSOC);
// Get the total number of Film, this is so we can determine whether there should be a next and previous button
$num_Film = $pdo->query('SELECT COUNT(*) FROM Film')->fetchColumn();
?>

<?=template_header('Read')?>



<div class="content read">
	<h2>Read Films</h2>
	<a href="create.php" class="create-films">Create films</a>
	<table>
        <thead>
            <tr>
                <td>|FilmID|</td>
                <td>|LanguageID|</td>
                <td>|RegionID|</td>
                <td>|Title|</td>
                <td>|Description|</td>
                <td>|Release Year|</td>
                <td>|Rental Duration|</td>
                <td>|Rental Rate|</td>
                <td>|Length|</td>
                <td>|Replacement Cost|</td>
                <td>|Rating|</td>
                <td>|Special Features|</td>
                <td>|Full Text|</td>
                <td>|Last Update|</td>
                <td></td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($Film as $films): ?>
            <tr>
                <td><?=$films['Film_ID']?></td>
                <td><?=$films['LanguageID']?></td>
                <td><?=$films['RegionID']?></td>
                <td><?=$films['Title']?></td>
                <td><?=$films['Description']?></td>
                <td><?=$films['Release_Year']?></td>
                <td><?=$films['Rental_Duration']?></td>
                <td><?=$films['Rental_Rate']?></td>
                <td><?=$films['Length']?></td>
                <td><?=$films['Replacement_Cost']?></td>
                <td><?=$films['Rating']?></td>
                <td><?=$films['Special_Features']?></td>
                <td><?=$films['FullText_Var']?></td>
                <td><?=$films['Last_Update']?></td>
                <td class="actions">
                    <a href="update.php?Film_ID=<?=$films['Film_ID']?>" class="edit"><i class="fas fa-pen fa-xs"></i></a>
                    <a href="delete.php?Film_ID=<?=$films['Film_ID']?>" class="trash"><i class="fas fa-trash fa-xs"></i></a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
	<div class="pagination">
		<?php if ($page > 1): ?>
		<a href="read.php?page=<?=$page-1?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
		<?php endif; ?>
		<?php if ($page*$records_per_page < $num_Film): ?>
		<a href="read.php?page=<?=$page+1?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
		<?php endif; ?>
	</div>
</div>

<?=template_footer()?>
