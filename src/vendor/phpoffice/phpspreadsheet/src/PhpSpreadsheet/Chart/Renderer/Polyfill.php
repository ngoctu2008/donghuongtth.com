<<<<<<< HEAD
<?php

// This is a dirty workaround to output JpGraph charts even when antialiasing is not available
if (!function_exists('imageantialias')) {
    function imageantialias(...$args)
    {
        // Do nothing
    }
}
=======
<?php

// This is a dirty workaround to output JpGraph charts even when antialiasing is not available
if (!function_exists('imageantialias')) {
    function imageantialias(...$args)
    {
        // Do nothing
    }
}
>>>>>>> ef5fa8aaa78785a2fbdffa493fb4f01b450fd53c
