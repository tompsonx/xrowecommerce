{if is_set($packingslip)|not}
    {def $packingslip=false()}
{/if}
{literal}
<style type="text/css">
table tbody td
{
    page-break-inside: avoid;
}
thead {
    display: table-header-group;
}
</style>
{/literal}

<p style="margin-top:2em"></p>
    {include uri="design:shop/invoice/header.tpl"}
<div class="break" style="clear:both;"></div>
    {shop_account_view_gui view=invoice order=$order packingslip=$packingslip}
<div class="break" style="clear:both;"></div>
<p style="margin-top:2em;">
<b>{'Product items'|i18n( 'design/admin/shop/orderview' )}</b>
</p>
<table class="list" width="70%" cellspacing="0" cellpadding="0" border="0" align="right">
<thead>
<tr>
    <th class="tight">{'Quantity'|i18n( 'extension/xrowecommerce' )}</th>
    <th class="tight">{'SKU'|i18n( 'extension/xrowecommerce' )}</th>
    <th>{'Product'|i18n( 'extension/xrowecommerce' )}</th>
{if $packingslip|not}
    <th class="tight">{'Unit price'|i18n( 'extension/xrowecommerce' )}</th>
    <th class="tight">{'Extended price'|i18n( 'extension/xrowecommerce' )}</th>
{/if}
</tr>
</thead>
<tbody>

{section name=ProductItem loop=$order.product_items show=$order.product_items sequence=array(bglight,bgdark)}
<tr>
    <td class="number" align="right">{$ProductItem:item.item_count}</td>
    {section show=$ProductItem:item.item_object.option_list}
        {section var=Options loop=$ProductItem:item.item_object.option_list}
        <td align="left">{$:Options.item.value|wash}</td>
        <td>{$ProductItem:item.item_object.name|wash}
        {def $vary=$ProductItem:item.item_object.contentobject.data_map.variation.content.option_list[$ProductItem:item.item_object.option_list.0.option_item_id]}
        {if $vary.comment}
            <br />Variation: {$vary.comment}
        {/if}
        </td>
        {/section}
    {section-else}
    <td align="left">{$ProductItem:item.item_object.contentobject.data_map.product_id.content}{$ProductItem:item.item_object.contentobject.data_map.variation.data_text}
</div>
    </td>
    <td>{$ProductItem:item.item_object.name|wash}</td>
    {/section}
    {if $packingslip|not}
    <td class="number" align="right">{$ProductItem:item.price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
    <td class="number" align="left">{$ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
    {/if}
</tr>
{/section}
{if $packingslip|not}
<tr>
<td colspan="9">&nbsp;</td>
</tr>
<tr>
    <th colspan="4">{'Subtotal Ex. Tax'|i18n( 'extension/xrowecommerce' )}:</th>
    <td class="number" align="right">{$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
</tr>
{foreach $order.order_items as $order_item sequence array(bglight,bgdark) as $sequence}
<tr>
    <th colspan="4">{$order_item.description}:</th>
    <td class="number" align="right">{$order_item.price_ex_vat|l10n( 'currency', $locale, $symbol )}</td>
</tr>
{/foreach}
{def $taxpercent = mul( div(sub($order.total_inc_vat, $order.total_ex_vat), $order.total_ex_vat), 100)
     $percentage = mul( div(sub($order.total_inc_vat, $order.total_ex_vat), $order.total_ex_vat), 100)|l10n('number') }
<tr>
    <th colspan="4">{'Tax'|i18n( 'extension/xrowecommerce' )}:</th>
    <td class="number" align="right">{$order.product_total_inc_vat|sub($order.product_total_ex_vat)|l10n( 'currency', $locale, $symbol )}</td>
</tr>
<tr>
    <th colspan="4"><b>{'Order total'|i18n( 'extension/xrowecommerce' )}</b></th>
    <td class="number" align="right"><b>{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}</b></td>
</tr>
{/if}
</tbody>
</table>
{if ezini('InvoiceSettings','ShowFooter','xrowecommerce.ini')|eq('enabled')}
{include uri="design:shop/invoice/footer.tpl" packingslip=$packingslip}
{/if}