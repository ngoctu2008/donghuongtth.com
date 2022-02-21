<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2022 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Mon, 21 Feb 2022 01:38:18 GMT
 */

if (!defined('NV_IS_FILE_ADMIN'))
    die('Stop!!!');

// Change status
if ($nv_Request->isset_request('change_status', 'post, get')) {
    $id = $nv_Request->get_int('id', 'post, get', 0);
    $content = 'NO_' . $id;

    $query = 'SELECT for_control FROM ' . NV_PREFIXLANG . '_' . $module_data . '_history_ghtk WHERE id=' . $id;
    $row = $db->query($query)->fetch();
    if (isset($row['for_control'])) {
        $for_control = ($row['for_control']) ? 0 : 1;
        $query = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_history_ghtk SET for_control=' . intval($for_control) . ' WHERE id=' . $id;
        $db->query($query);
        $content = 'OK_' . $id;
    }
    $nv_Cache->delMod($module_name);
    include NV_ROOTDIR . '/includes/header.php';
    echo $content;
    include NV_ROOTDIR . '/includes/footer.php';
}


$row = array();
$error = array();
$where = '';
$q = $nv_Request->get_title('q', 'post,get');
$store_id = $nv_Request->get_title('store_id', 'post,get');
if (!empty($q)) {
    $where .= ' AND t1.label LIKE "%' . $q . '%"';
}
if (!empty($store_id)) {
    $where .= ' AND t2.store_id = ' . $store_id;
}

// Fetch Limit
$show_view = false;
if (!$nv_Request->isset_request('id', 'post,get')) {
    $show_view = true;
    $per_page = 20;
    $page = $nv_Request->get_int('page', 'post,get', 1);
    $db->sqlreset()
        ->select('COUNT(*)')
        ->from('' . TABLE . '_history_ghtk t1 ')
        ->join('INNER JOIN ' . TABLE . '_order t2 ON t1.order_id = t2.id ')
        ->where('t2.status != 1 ' . $where);
    $sth = $db->prepare($db->sql());

    $sth->execute();
    $num_items = $sth->fetchColumn();
    $db->select('*')
        ->order('t1.time_add DESC')
        ->limit($per_page)
        ->offset(($page - 1) * $per_page);
    $sth = $db->prepare($db->sql());
    $sth->execute();
}

$xtpl = new XTemplate('history_ghtk.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('MODULE_UPLOAD', $module_upload);
$xtpl->assign('NV_ASSETS_DIR', NV_ASSETS_DIR);
$xtpl->assign('OP', $op);
$xtpl->assign('ROW', $row);
$xtpl->assign('store_id', $store_id);
$xtpl->assign('Q', $q);



if ($show_view) {
    $list_store = get_full_store();
    foreach ($list_store as $value2) {

        $xtpl->assign('store_id_list', array(
            'key' => $value2['id'],
            'title' => $value2['company_name'],
            'selected' => ($value2['id'] == $store_id) ? ' selected="selected"' : ''
        ));
        $xtpl->parse('main.view.store_id');
    }
    $base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op;
    if (!empty($q)) {
        $base_url .= '&q=' . $q;
    }
    $generate_page = nv_generate_page($base_url, $num_items, $per_page, $page);
    if (!empty($generate_page)) {
        $xtpl->assign('NV_GENERATE_PAGE', $generate_page);
        $xtpl->parse('main.view.generate_page');
    }

    $number = $page > 1 ? ($per_page * ($page - 1)) + 1 : 1;
    while ($view = $sth->fetch()) {
        $view['shop_name'] = get_name_store($view['store_id']);
        $view['status_ghtk'] = $global_status_order_ghtk[$view['status_id']]['name'];
        if ($view['fee'] != $view['fee_update']) {
            $xtpl->assign('no_equal', 'alert-warning');
        } else {
            $xtpl->assign('no_equal', '');
        }
        $view['fee'] = number_format($view['fee']) . 'đ';
        $view['fee_update'] = number_format($view['fee_update']) . 'đ';
        $xtpl->assign('CHECK', $view['for_control'] == 1 ? 'checked' : '');
        $view['time_edit'] = (empty($view['time_edit'])) ? '' : nv_date('H:i d/m/Y', $view['time_edit']);
        $view['time_add'] = (empty($view['time_add'])) ? '' : nv_date('H:i d/m/Y', $view['time_add']);
        $view['link_view'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . 'history_ghtk_detail' . '&amp;id=' . $view['id'];

        $view['link_view_order'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . 'view_order' . '&amp;id=' . $view['id'];

        $view['link_delete'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;delete_id=' . $view['id'] . '&amp;delete_checkss=' . md5($view['id'] . NV_CACHE_PREFIX . $client_info['session_id']);
        $xtpl->assign('VIEW', $view);
        $xtpl->parse('main.view.loop');
    }
    $xtpl->parse('main.view');
}


if (!empty($error)) {
    $xtpl->assign('ERROR', implode('<br />', $error));
    $xtpl->parse('main.error');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

$page_title = $lang_module['history_ghtk'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
