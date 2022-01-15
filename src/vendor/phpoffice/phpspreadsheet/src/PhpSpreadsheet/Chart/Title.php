<<<<<<< HEAD
<?php

namespace PhpOffice\PhpSpreadsheet\Chart;

class Title
{
    /**
     * Title Caption.
     *
     * @var string
     */
    private $caption;

    /**
     * Title Layout.
     *
     * @var Layout
     */
    private $layout;

    /**
     * Create a new Title.
     *
     * @param null|mixed $caption
     * @param null|Layout $layout
     */
    public function __construct($caption = null, Layout $layout = null)
    {
        $this->caption = $caption;
        $this->layout = $layout;
    }

    /**
     * Get caption.
     *
     * @return string
     */
    public function getCaption()
    {
        return $this->caption;
    }

    /**
     * Set caption.
     *
     * @param string $caption
     *
     * @return $this
     */
    public function setCaption($caption)
    {
        $this->caption = $caption;

        return $this;
    }

    /**
     * Get Layout.
     *
     * @return Layout
     */
    public function getLayout()
    {
        return $this->layout;
    }
}
=======
<?php

namespace PhpOffice\PhpSpreadsheet\Chart;

class Title
{
    /**
     * Title Caption.
     *
     * @var string
     */
    private $caption;

    /**
     * Title Layout.
     *
     * @var Layout
     */
    private $layout;

    /**
     * Create a new Title.
     *
     * @param null|mixed $caption
     * @param null|Layout $layout
     */
    public function __construct($caption = null, Layout $layout = null)
    {
        $this->caption = $caption;
        $this->layout = $layout;
    }

    /**
     * Get caption.
     *
     * @return string
     */
    public function getCaption()
    {
        return $this->caption;
    }

    /**
     * Set caption.
     *
     * @param string $caption
     *
     * @return $this
     */
    public function setCaption($caption)
    {
        $this->caption = $caption;

        return $this;
    }

    /**
     * Get Layout.
     *
     * @return Layout
     */
    public function getLayout()
    {
        return $this->layout;
    }
}
>>>>>>> ef5fa8aaa78785a2fbdffa493fb4f01b450fd53c
