<?php

/**
 * app/Helpers/transaksi_helper.php
 *
 * Helper functions untuk perhitungan tambahan pada proses checkout:
 * - PPN (Pajak Pertambahan Nilai)
 * - Biaya Admin (tarif berjenjang)
 * - Diskon Voucher
 */

if (!function_exists('hitung_ppn')) {
    /**
     * Menghitung PPN sebesar 11% dari total harga pembelian (tidak termasuk ongkir).
     *
     * @param float $total_harga
     * @return float
     */
    function hitung_ppn(float $total_harga): float
    {
        return $total_harga * 0.11;
    }
}

if (!function_exists('hitung_biaya_admin')) {
    /**
     * Menghitung biaya admin berdasarkan tarif berjenjang dari total harga pembelian.
     *
     * <= Rp 20.000.000      : 0.6%
     * Rp 20.000.001 - 40jt  : 0.8%
     * > Rp 40.000.000       : 1.0%
     *
     * @param float $total_harga
     * @return float
     */
    function hitung_biaya_admin(float $total_harga): float
    {
        if ($total_harga <= 20000000) {
            $tarif = 0.006;
        } elseif ($total_harga <= 40000000) {
            $tarif = 0.008;
        } else {
            $tarif = 0.010;
        }

        return $total_harga * $tarif;
    }
}

if (!function_exists('daftar_voucher')) {
    /**
     * Daftar kode voucher yang tersedia beserta persentase diskonnya.
     *
     * @return array<string, float>
     */
    function daftar_voucher(): array
    {
        return [
            'FLASH10'  => 0.10,
            'FLASH15'  => 0.15,
            'MEMBER20' => 0.20,
        ];
    }
}

if (!function_exists('hitung_diskon_voucher')) {
    /**
     * Menghitung diskon voucher berdasarkan kode voucher yang diinput pelanggan.
     * Diskon dihitung dari total harga pembelian (sebelum PPN dan biaya admin).
     * Jika kode tidak valid, diskon = 0.
     *
     * @param float $total_harga
     * @param string|null $voucher_code
     * @return float
     */
    function hitung_diskon_voucher(float $total_harga, ?string $voucher_code): float
    {
        if (empty($voucher_code)) {
            return 0;
        }

        $voucher_code = strtoupper(trim($voucher_code));
        $vouchers = daftar_voucher();

        if (!array_key_exists($voucher_code, $vouchers)) {
            return 0;
        }

        return $total_harga * $vouchers[$voucher_code];
    }
}

if (!function_exists('is_voucher_valid')) {
    /**
     * Mengecek apakah kode voucher valid.
     *
     * @param string|null $voucher_code
     * @return bool
     */
    function is_voucher_valid(?string $voucher_code): bool
    {
        if (empty($voucher_code)) {
            return false;
        }

        return array_key_exists(strtoupper(trim($voucher_code)), daftar_voucher());
    }
}
