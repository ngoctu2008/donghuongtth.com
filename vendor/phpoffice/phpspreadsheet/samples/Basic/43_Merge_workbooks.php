<<<<<<< HEAD
<?php

use PhpOffice\PhpSpreadsheet\IOFactory;

require __DIR__ . '/../Header.php';

$helper->log('Load MergeBook1 from Xlsx file');
$filename1 = __DIR__ . '/../templates/43mergeBook1.xlsx';
$callStartTime = microtime(true);
$spreadsheet1 = IOFactory::load($filename1);
$helper->logRead('Xlsx', $filename1, $callStartTime);

$helper->log('Load MergeBook2 from Xlsx file');
$filename2 = __DIR__ . '/../templates/43mergeBook2.xlsx';
$callStartTime = microtime(true);
$spreadsheet2 = IOFactory::load($filename2);
$helper->logRead('Xlsx', $filename2, $callStartTime);

foreach ($spreadsheet2->getSheetNames() as $sheetName) {
    $sheet = $spreadsheet2->getSheetByName($sheetName);
    $sheet->setTitle($sheet->getTitle() . ' copied');
    $spreadsheet1->addExternalSheet($sheet);
}

// Save
$helper->write($spreadsheet1, __FILE__);
=======
<?php

use PhpOffice\PhpSpreadsheet\IOFactory;

require __DIR__ . '/../Header.php';

$helper->log('Load MergeBook1 from Xlsx file');
$filename1 = __DIR__ . '/../templates/43mergeBook1.xlsx';
$callStartTime = microtime(true);
$spreadsheet1 = IOFactory::load($filename1);
$helper->logRead('Xlsx', $filename1, $callStartTime);

$helper->log('Load MergeBook2 from Xlsx file');
$filename2 = __DIR__ . '/../templates/43mergeBook2.xlsx';
$callStartTime = microtime(true);
$spreadsheet2 = IOFactory::load($filename2);
$helper->logRead('Xlsx', $filename2, $callStartTime);

foreach ($spreadsheet2->getSheetNames() as $sheetName) {
    $sheet = $spreadsheet2->getSheetByName($sheetName);
    $sheet->setTitle($sheet->getTitle() . ' copied');
    $spreadsheet1->addExternalSheet($sheet);
}

// Save
$helper->write($spreadsheet1, __FILE__);
>>>>>>> ef5fa8aaa78785a2fbdffa493fb4f01b450fd53c
