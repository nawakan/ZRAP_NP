CLASS zcl_demo_testrun DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DEMO_TESTRUN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT SINGLE * FROM ZC_Demo_Mass_Phy_Doc
    INTO @DATA(lw_data).

    TRY.

        MODIFY ENTITIES OF I_PhysicalInventoryDocumentTP
        ENTITY PhysicalInventoryDocument
        CREATE
        FROM VALUE #( (
            %cid = 'CID_DOCUMENT'
            DocumentDate = sy-datum
            PhysInventoryPlannedCountDate = sy-datum
            Plant = lw_data-Plant
            StorageLocation = lw_data-StorageLocation
            %control-DocumentDate = if_abap_behv=>mk-on
            %control-PhysInventoryPlannedCountDate = if_abap_behv=>mk-on
            %control-Plant = if_abap_behv=>mk-on
            %control-StorageLocation = if_abap_behv=>mk-on ) )

        CREATE BY \_PhysicalInventoryDocumentItem
        FROM VALUE #( (
            %cid_ref = 'CID_DOCUMENT'
            %target = VALUE #(
            (
                %cid = 'CID_ITEM_1'
                Material = lw_data-MaterialNumber
                PhysicalInventoryStockType = '1'
*                QuantityInUnitOfEntry = lw_data-Quantity
*                UnitOfEntry = lw_data-Unit
*                Batch = lw_data-Batch
                %control-Material = if_abap_behv=>mk-on
                %control-PhysicalInventoryStockType = if_abap_behv=>mk-on
*                %control-QuantityInUnitOfEntry = if_abap_behv=>mk-on
*                %control-UnitOfEntry = if_abap_behv=>mk-on
                )
*            (
*                %cid = 'CID_ITEM_2'
*                Material = 'TG0012'
*                PhysicalInventoryStockType = '1'
*                %control-Material = if_abap_behv=>mk-on
*                %control-PhysicalInventoryStockType = if_abap_behv=>mk-on )
            ) ) )
        FAILED DATA(lw_failed)
        MAPPED DATA(lw_mapped)
        REPORTED DATA(lw_reported).

        COMMIT ENTITIES
        RESPONSE OF I_PhysicalInventoryDocumentTP
        FAILED DATA(lw_failed2)
        REPORTED DATA(lw_reported2).

      CATCH cx_root INTO DATA(lo_exception).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
