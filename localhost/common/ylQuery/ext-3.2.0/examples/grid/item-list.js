			/*!
			* Ext JS Library 3.2.0
			* Copyright(c) 2006-2010 Ext JS, Inc.
			* licensing@extjs.com
			* http://www.extjs.com/license
			*/

Ext.onReady(function() {
					 
    Ext.QuickTips.init();

    var xg = Ext.grid;

    // shared reader
    var reader = new Ext.data.ArrayReader({}, [
			{ name: 'Code' },
			{ name: 'Short' },
			{ name: 'Description' },
			{ name: 'Unit' },
			{ name: 'Active' },
			{ name: 'Values' },
			{ name: 'Round' },
			{ name: 'Values' },
			{ name: 'Round' }
			]);


    var sm = new xg.CheckboxSelectionModel();
    var grid2 = new xg.GridPanel({
        store: new Ext.data.Store({
            reader: reader,
            data: xg.dummyData
        }),
        cm: new xg.ColumnModel({
            defaults: {
                width: 120,
                sortable: true

            },
            columns: [
			{ id: 'Code', header: "Code", width: 60, dataIndex: 'Code' },
			{ id: 'Short', header: "Short", width: 60, dataIndex: 'Short' },
			{ header: "Description", width: 200, dataIndex: 'Description' },
			{ header: "Unit", width: 60, dataIndex: 'Unit' },
			{ header: "Active", width: 60, dataIndex: 'Active' },
			{ header: "Values", width: 200, dataIndex: 'Values' },
			{ header: "Round", width: 60, dataIndex: 'Round' },
			{ header: "Values", width: 200, dataIndex: 'Values' },
			{ header: "Round", width: 60, dataIndex: 'Round' }


			]
			
			
        }),
        sm: sm,
        columnLines: true,
        width: 924,
        height: 282,
        renderTo: "GridView"

    });


});
			
			
			
			// Array data for the grids
			Ext.grid.dummyData = [
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', '2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)'],
			['REB', 'REB', 'REBATE', 'KG', checkbox("text-align:center", "Active"), 'By: CWT  Min: 100.0  Rate:0.5', ' 2 (Down)', 'By: CWT  Min: 500.0  Rate:2.0', '  1 (Down)']
			
	
			
			];
			
			// add in some dummy descriptions
			for(var i = 0; i < Ext.grid.dummyData.length; i++){
			Ext.grid.dummyData[i].push('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.');

}

function checkbox(style, name) { 
    return'<div style="'+ style +'" ><input type="checkbox" name="'+ name+'"></div>';
}