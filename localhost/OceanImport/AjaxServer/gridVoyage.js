function AutoDeleteRow(grid) {

    if (grid.store.getTotalCount() > 0) {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].POL;
            var Currency = grid.getRowsValues({ Selectedonly: true })[i].POD
            var PPD = grid.getRowsValues({ Selectedonly: true })[i].ETD;
            var CompanyCode = grid.getRowsValues({ Selectedonly: true })[i].ETA

            if (Qty == "" && PPD == undefined  && CompanyCode == undefined && Currency == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
}