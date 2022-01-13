<<<<<<< HEAD
<?php

namespace PhpOffice\PhpSpreadsheet\Calculation;

use PhpOffice\PhpSpreadsheet\Exception as PhpSpreadsheetException;

class Exception extends PhpSpreadsheetException
{
    /**
     * Error handler callback.
     *
     * @param mixed $code
     * @param mixed $string
     * @param mixed $file
     * @param mixed $line
     * @param mixed $context
     */
    public static function errorHandlerCallback($code, $string, $file, $line, $context)
    {
        $e = new self($string, $code);
        $e->line = $line;
        $e->file = $file;

        throw $e;
    }
}
=======
<?php

namespace PhpOffice\PhpSpreadsheet\Calculation;

use PhpOffice\PhpSpreadsheet\Exception as PhpSpreadsheetException;

class Exception extends PhpSpreadsheetException
{
    /**
     * Error handler callback.
     *
     * @param mixed $code
     * @param mixed $string
     * @param mixed $file
     * @param mixed $line
     * @param mixed $context
     */
    public static function errorHandlerCallback($code, $string, $file, $line, $context)
    {
        $e = new self($string, $code);
        $e->line = $line;
        $e->file = $file;

        throw $e;
    }
}
>>>>>>> ef5fa8aaa78785a2fbdffa493fb4f01b450fd53c
