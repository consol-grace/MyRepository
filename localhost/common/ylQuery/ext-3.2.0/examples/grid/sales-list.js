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
	{name: 'Name'},
	{name: 'USGROUP'},
	{name:'Active'}
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
		{id:'Code',header: "Code", width: 80, dataIndex: 'Code'},        
		{header: "Name", width:160,dataIndex: 'Name'}, 
		{header: "USGROUP", width:62,dataIndex: 'USGROUP'},
		{header: "Belong to", width:220,dataIndex: ''},
		{header: "Active", width:62,dataIndex: 'Active'}
		 
	
	]
	}),
	sm: sm,
	columnLines: true,
	width:605,
	height:262,              
	renderTo: "GridView"
	
	});
	
	
	});
	
	
	
	// Array data for the grids
	Ext.grid.dummyData = [
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")],
	['USG/ORD','USG/ORD',checkbox("text-align:center","USGROUP"),checkbox("text-align:center", "Active")]
	
	
	];
	
	// add in some dummy descriptions
	for(var i = 0; i < Ext.grid.dummyData.length; i++){
	Ext.grid.dummyData[i].push('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.');
	}
	
	
function checkbox(style, name){
	return '<div style="'+ style +'"><input type="checkbox" name="'+ name +'" /></div>';	
}
