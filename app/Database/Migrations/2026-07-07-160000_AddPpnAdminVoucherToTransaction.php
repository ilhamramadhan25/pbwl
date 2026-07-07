<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddPpnAdminVoucherToTransaction extends Migration
{
    public function up()
    {
        $fields = [
            'ppn' => [
                'type'       => 'DOUBLE',
                'null'       => true,
                'after'      => 'total_harga',
                'comment'    => 'Nilai PPN (11%)'
            ],
            'biaya_admin' => [
                'type'       => 'DOUBLE',
                'null'       => true,
                'after'      => 'ppn',
                'comment'    => 'Nilai biaya admin (berjenjang)'
            ],
            'voucher_code' => [
                'type'       => 'VARCHAR',
                'constraint' => 20,
                'null'       => true,
                'after'      => 'biaya_admin',
                'comment'    => 'Kode voucher yang digunakan'
            ],
            'diskon_voucher' => [
                'type'       => 'DOUBLE',
                'null'       => true,
                'after'      => 'voucher_code',
                'comment'    => 'Nilai diskon dari voucher'
            ],
        ];

        $this->forge->addColumn('transaction', $fields);
    }

    public function down()
    {
        $this->forge->dropColumn('transaction', 'ppn');
        $this->forge->dropColumn('transaction', 'biaya_admin');
        $this->forge->dropColumn('transaction', 'voucher_code');
        $this->forge->dropColumn('transaction', 'diskon_voucher');
    }
}
