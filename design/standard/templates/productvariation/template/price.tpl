{def $id=$attribute.id
     $settings=cond( is_set( $template.attribute_list.$id ), $template.attribute_list.$id, false() )
     $default_value=cond( is_set( $settings.default_value ), $settings.default_value, '' )
     $column_name=cond( is_set( $settings.column_name ), $settings.column_name, $attribute.name )
     $column_desc=cond( is_set( $settings.column_desc ), $settings.column_desc, $attribute.desc )
     $sliding=cond( is_set( $settings.sliding ), $settings.sliding, false() )
}
<div>
    <label>{"Column name:"|i18n( 'extension/xrowecommerce/productvariation' )|wash}</label>
    <input name="XrowProductTemplate_{$id}_column_name" type="text" class="box" value="{$column_name|wash}" maxlength="255" />
    <label>{"Column description:"|i18n( 'extension/xrowecommerce/productvariation' )|wash}</label>
    <textarea name="XrowProductTemplate_{$id|wash}_column_desc" rows="5" cols="70" class="box">{$column_desc|wash}</textarea>
    <label>{"Default value:"|i18n( 'extension/xrowecommerce/productvariation' )|wash}</label>
    <input name="XrowProductTemplate_{$id}_default" type="text" class="box" value="{$default_value|wash}" maxlength="255" />
    <div class="block inline">
        <label>
            {"Sliding price:"|i18n( 'extension/xrowecommerce/productvariation' )|wash}
            <input type="checkbox" name="XrowProductTemplate_{$id}_sliding" value="1"{if $sliding} checked="checked"{/if} />
        </label>
    </div>
</div>
