<<<<<<< HEAD
<?php

namespace PhpOffice\PhpSpreadsheet\Reader;

interface IReadFilter
{
    /**
     * Should this cell be read?
     *
     * @param string $column Column address (as a string value like "A", or "IV")
     * @param int $row Row number
     * @param string $worksheetName Optional worksheet name
     *
     * @return bool
     */
    public function readCell($column, $row, $worksheetName = '');
}
=======
<?php

namespace PhpOffice\PhpSpreadsheet\Reader;

interface IReadFilter
{
    /**
     * Should this cell be read?
     *
     * @param string $column Column address (as a string value like "A", or "IV")
     * @param int $row Row number
     * @param string $worksheetName Optional worksheet name
     *
     * @return bool
     */
    public function readCell($column, $row, $worksheetName = '');
}
>>>>>>> ef5fa8aaa78785a2fbdffa493fb4f01b450fd53c
