/*!
 * Ext JS Library 3.2.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */

Ext.onReady(function(){

    Ext.QuickTips.init();

    var xg = Ext.grid;

    // shared reader
    var reader = new Ext.data.ArrayReader({}, [
       {name: 'Code'},
       {name: 'Type'},
       {name: 'Name'}
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
                {id:'Code',header: "Code", width: 100, dataIndex: 'Code'},        
                {header: "Type", width:100,dataIndex: 'Type'}, 
				{header: "Name",width:200, dataIndex: 'Name'}
				

            ]
        }),
        sm: sm,
        columnLines: true,
        width:421,
        height:445,              
        renderTo: "GridView"/*,
		title:'System Table Configure List'*/
		
    });

   
});



// Array data for the grids
Ext.grid.dummyData = [
    ['172ONTCA01','Local Customer','1726690 ONTARIO CORP/'],
    ['172ONTCA01','Foreign Customer','1726690 ONTARIO CORP/ '],
    ['172ONTCA03','SKID(S)','1726690 ONTARIO CORP/'],
    ['172ONTCA04','Agent','1726690 ONTARIO CORP/'],
    ['172ONTCA05','W/PLTS','1726690 ONTARIO CORP/'],
    ['172ONTCA06','Airline','1726690 ONTARIO CORP/'],
	['172ONTCA07','Vessel','1726690 ONTARIO CORP/'],
	['172ONTCA08','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','WOODEN P','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','WOODEN P','1726690 ONTARIO CORP/'],
	['172ONTCA01','Local Customer','1726690 ONTARIO CORP/'],
    ['172ONTCA01','Foreign Customer','1726690 ONTARIO CORP/ '],
    ['172ONTCA03','SKID(S)','1726690 ONTARIO CORP/'],
    ['172ONTCA04','Agent','1726690 ONTARIO CORP/'],
    ['172ONTCA05','W/PLTS','1726690 ONTARIO CORP/'],
    ['172ONTCA06','Airline','1726690 ONTARIO CORP/'],
	['172ONTCA07','Vessel','1726690 ONTARIO CORP/'],
	['172ONTCA08','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
    ['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','WOODEN P','1726690 ONTARIO CORP/'],
	['172ONTCA09','Branch','1726690 ONTARIO CORP/'],
	['172ONTCA09','WOODEN P','1726690 ONTARIO CORP/']
   
];

// add in some dummy descriptions
for(var i = 0; i < Ext.grid.dummyData.length; i++){
    Ext.grid.dummyData[i].push('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.');
}