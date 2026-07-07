<?= $this->extend('layout') ?>
<?= $this->section('content') ?>

<div class="row">
    <div class="col-lg-6">
        <?= form_open('buy', 'class="row g-3"') ?>

<?= form_hidden('username', session()->get('username')) ?>
<?= form_hidden(['name' => 'total_harga', 'id' => 'total_harga', 'value' => '']) ?>
<div class="col-12">
    <?= form_label('Nama', 'nama', ['class' => 'form-label']) ?>
    <?= form_input([
        'name'     => 'nama',
        'id'       => 'nama',
        'class'    => 'form-control',
        'value'    => session()->get('username'),
        'readonly' => true]) ?>
</div>
<div class="col-12">
    <?= form_label('Alamat', 'alamat', ['class' => 'form-label']) ?>
    <?= form_input([
        'name'  => 'alamat',
        'id'    => 'alamat',
        'class' => 'form-control']) ?>
</div> 
<div class="col-12"> 
    <?= form_label('Kelurahan', 'kelurahan', ['class' => 'form-label']) ?>
    <?= form_dropdown('kelurahan', [], '', ['id' => 'kelurahan', 'class' => 'form-control']) ?>
</div>
<div class="col-12"> 
    <?= form_label('Layanan', 'layanan', ['class' => 'form-label']) ?> 
    <?= form_dropdown('layanan', [], '', ['id' => 'layanan', 'class' => 'form-control']) ?>
</div>
<div class="col-12">
    <?= form_label('Ongkir', 'ongkir', ['class' => 'form-label']) ?>
    <?= form_input([
        'name'     => 'ongkir',
        'id'       => 'ongkir',
        'class'    => 'form-control',
        'readonly' => true]) ?>
</div>
<div class="col-12">
    <?= form_label('Kode Voucher', 'voucher_code', ['class' => 'form-label']) ?>
    <?= form_input([
        'name'        => 'voucher_code',
        'id'          => 'voucher_code',
        'class'       => 'form-control',
        'placeholder' => 'Masukkan kode voucher (opsional)']) ?>
    <small class="text-muted">Tersedia: <?= implode(', ', $voucher_codes ?? []) ?></small>
    <div id="voucher_feedback" class="small mt-1"></div>
</div>
<div class="col-12">
    <?= form_submit(
        'submit',
        'Buat Pesanan',
        ['class' => 'btn btn-primary']) ?>
</div>

<?= form_close() ?> 
    </div>
    <div class="col-lg-6">
        <table class="table">
  <thead>
      <tr>
          <th scope="col">Nama</th>
          <th scope="col">Harga</th>
          <th scope="col">Jumlah</th>
          <th scope="col">Sub Total</th>
      </tr>
  </thead>
  <tbody>
      <?php 
      if (!empty($items)) :
          foreach ($items as $index => $item) :
      ?>
              <tr>
                  <td><?= $item['name'] ?></td>
                  <td><?= number_to_currency($item['price'], 'IDR') ?></td>
                  <td><?= $item['qty'] ?></td>
                  <td><?= number_to_currency($item['price'] * $item['qty'], 'IDR') ?></td>
              </tr>
      <?php
          endforeach;
      endif;
      ?>
      <tr>
          <td colspan="2"></td>
          <td>Subtotal</td>
          <td><?= number_to_currency($total, 'IDR') ?></td>
      </tr>
      <tr>
          <td colspan="2"></td>
          <td>Diskon Voucher</td>
          <td class="text-danger" id="row_diskon_voucher">- IDR 0</td>
      </tr>
      <tr>
          <td colspan="2"></td>
          <td>PPN (11%)</td>
          <td id="row_ppn">IDR 0</td>
      </tr>
      <tr>
          <td colspan="2"></td>
          <td>Biaya Admin</td>
          <td id="row_biaya_admin">IDR 0</td>
      </tr>
      <tr>
          <td colspan="2"></td>
          <td><strong>Subtotal (+PPN+Admin-Voucher)</strong></td>
          <td><strong><span id="row_subtotal_after_voucher"><?= number_to_currency($total, 'IDR') ?></span></strong></td>
      </tr>
      <tr>
          <td colspan="2"></td>
          <td><strong>Ongkir</strong></td>
          <td><strong><span id="row_ongkir">IDR 0</span></strong></td>
      </tr>
      <tr>
          <td colspan="2"></td>
          <td><strong>Grand Total (incl. Ongkir)</strong></td>
          <td><strong><span id="total"><?= number_to_currency($total, 'IDR') ?></span></strong></td>
      </tr>
  </tbody>
</table>
    </div>
</div>
<?= $this->section('script') ?>
<script>
$(document).ready(function() {
    let ongkir = 0;
    let subtotal = <?= $total ?>;
    let subtotalAfterVoucher = subtotal;
    let voucherTimer = null;

    hitungCheckout();

    function formatIDR(value) {
        return `IDR ${Math.round(value).toLocaleString('id-ID')}`;
    }

    function hitungTotal() {
        let total = subtotalAfterVoucher + ongkir;

        $("#ongkir").val(ongkir);
        $("#row_ongkir").text(formatIDR(ongkir));
        $("#total").text(formatIDR(total));
        $("#total_harga").val(total);
    }

    // Ambil perhitungan PPN, biaya admin, dan diskon voucher dari server
    function hitungCheckout() {
        let voucherCode = $("#voucher_code").val();

        $.ajax({
            url: "<?= site_url('ajax/hitung-checkout') ?>",
            dataType: "json",
            data: {
                voucher_code: voucherCode
            },
            success: function(data) {
                subtotalAfterVoucher = data.subtotal_after_voucher;

                $("#row_diskon_voucher").text('- ' + formatIDR(data.diskon_voucher));
                $("#row_ppn").text(formatIDR(data.ppn));
                $("#row_biaya_admin").text(formatIDR(data.biaya_admin));
                $("#row_subtotal_after_voucher").text(formatIDR(subtotalAfterVoucher));

                if (voucherCode) {
                    if (data.voucher_valid) {
                        $("#voucher_feedback").removeClass('text-danger').addClass('text-success')
                            .text('Voucher valid, diskon diterapkan.');
                    } else {
                        $("#voucher_feedback").removeClass('text-success').addClass('text-danger')
                            .text('Kode voucher tidak valid.');
                    }
                } else {
                    $("#voucher_feedback").removeClass('text-success text-danger').text('');
                }

                hitungTotal();
            }
        });
    }

    $("#voucher_code").on('input', function() {
        clearTimeout(voucherTimer);
        voucherTimer = setTimeout(hitungCheckout, 400);
    });

	$('#kelurahan').select2({
	    placeholder: 'Cari daerah tujuan',
	    minimumInputLength: 3, 
        ajax: {
    url: '<?= site_url('ajax/destinations') ?>',
    dataType: 'json',
    delay: 300,
    data: function(params) {
        return {
            q: params.term
        };
    },
    processResults: function(data) {
        return data;
    },
    cache: true
}
	});
    $("#kelurahan").on('change', function () {
    let id_kelurahan = $(this).val();

    $("#layanan").empty();
    ongkir = 0;
    hitungTotal(); 

    $.ajax({
    url: "<?= site_url('ajax/costs') ?>", 
    dataType: "json",
    data: {
        destination: id_kelurahan
    },
    success: function (data) { 
        data.forEach(function (item) {
            $("#layanan").append(
                $('<option>', {
                    value: item.cost,
                    text: `${item.description} (${item.service}) : estimasi ${item.etd}`
                })
            );
        });
    }
});
});
$("#layanan").on('change', function() {
    ongkir = parseInt($(this).val());
    hitungTotal();
}); 
});
</script>
<?= $this->endSection() ?>
<?= $this->endSection() ?>