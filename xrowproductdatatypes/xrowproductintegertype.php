<?php

class xrowProductIntegerType extends xrowProductDataType
{
    const DATA_TYPE_STRING = "integer";

    function xrowProductIntegerType()
    {
         $this->Table = 'xrowproduct_data';

        // definition of column
        $this->ColumnArray = array( 0 => array( 'sql_type' => 'INTEGER',
                                                'type' => 'number',
                                                'name' => '' ) );

         // params
        $params = array( 'translation_allowed' => false,
                         'unique' => false,
                         'required' => false );

        $this->xrowProductDataType( self::DATA_TYPE_STRING,
                                    ezpI18n::tr( 'extension/xrowecommerce/productvariation', "Integer", 'Datatype name' ),
                                    ezpI18n::tr( 'extension/xrowecommerce/productvariation', "Stores an integer.", 'Datatype description' ),
                                    $params );
    }

    /**
     * Validates the input of the template and
     * returns true if the input was valid for this datatype.
     * @param xrowProductTemplate $template
     * @param xrowProductAttribute $attribute
     * @param array $error
     * @param string $languageCode
     * @return boolean
     */
    function validateTemplateInput( xrowProductTemplate &$template, xrowProductAttribute &$attribute, array &$error, $languageCode )
    {
        $attributeID = $attribute->attribute( 'id' );
        $content = false;
        if ( isset( $template->Data['attributes'][$attributeID]['default'] ) )
        {
            $content = $template->Data['attributes'][$attributeID]['default'];
        }

        if ( $content !== false and strlen( $content ) > 0 )
        {
            $validator = new eZIntegerValidator( false, false );
            $ok = $validator->validate( $content );
            if ( $ok === eZInputValidator::STATE_ACCEPTED )
                return true;
            else
            {
                $error[$attributeID]['default_value'] = true;
                return false;
            }
        }
        return true;
    }

    function validateVariationInput( array $variationArray,
                                     $line,
                                     $column,
                                     eZContentObjectAttribute $contentObjectAttribute,
                                     $attribute,
                                     eZHTTPTool $http,
                                     array &$errorArray )
    {
        if ( ( $attribute['required'] and !isset( $variationArray[$line][$column] ) )
               or ( $attribute['required'] and strlen( $variationArray[$line][$column] ) == 0 ) )
        {
            $errorArray[$line][$column]['required'] = true;
            return;
        }

        if ( !isset( $variationArray[$line][$column] ) )
            return;

        $content = trim( $variationArray[$line][$column] );

        if ( strlen( $content ) == 0 )
            return;

        $validator = new eZIntegerValidator( false, false );
        $ok = $validator->validate( $content );
        if ( $ok !== eZInputValidator::STATE_ACCEPTED )
        {
            $errorArray[$line][$column]['not_valid'] = true;
        }
    }
    
    /**
     * Returns data for ezfind
     * @param $variation
     * @param $column
     */
    public function eZFindData( xrowProductData $variation, $column )
    {
        return array( 'content' => $this->metaData( $variation, $column ),
                      'type' => 'sint' );
    }
}

?>
