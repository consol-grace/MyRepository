	/*!
	* Ext JS Library 3.2.0
	* Copyright(c) 2006-2010 Ext JS, Inc.
	* licensing@extjs.com
	* http://www.extjs.com/license
	*/
	Ext.onReady(function(){
	
	var store = new Ext.data.Store({
	remoteSort: true,
	baseParams: {lightWeight:true,ext: 'js'},
	sortInfo: {field:'lastpost', direction:'DESC'},
	autoLoad: {params:{start:0, limit:17}},
	
	proxy: new Ext.data.ScriptTagProxy({
/*	url: 'http://extjs.com/forum/topics-browse-remote.php'*/
	}),
	
	reader: new Ext.data.JsonReader({
	root: 'topics',
	totalProperty: 'totalCount',
	idProperty: 'threadid',
	fields: [
	'title', 'forumtitle', 'forumid', 'author',
	{name: 'replycount', type: 'int'},
	{name: 'lastpost', mapping: 'lastpost', type: 'date', dateFormat: 'timestamp'},
	'lastposter', 'excerpt'
	]
	})
	});
	
	var grid = new Ext.grid.GridPanel({
	renderTo: 'topic-grid',
	width:980,
	height:500,
	frame:true,
	title:'ExtJS.com - Browse Forums',
	trackMouseOver:false,
	autoExpandColumn: 'topic',
	store: store,
	
	columns: [new Ext.grid.RowNumberer({width: 20}),{
	header: "Direct",
	dataIndex: 'title',
	width: 40,
	align: 'center',
	
	sortable:true
	},{
	id: 'Lot',
	header: "Lot No",
	dataIndex: 'lastpost',
	width: 130,
	align:'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'topic',
	header: "MAWB",
	align:'center',
	dataIndex: 'replycount',
	width: 200,
	renderer: renderTopic,
	sortable:true
	},{
	id: 'Shipper',
	header: "Shipper",
	dataIndex: 'lastpost',
	width: 80,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'Consignee',
	header: "Consignee",
	dataIndex: 'lastpost',
	width: 80,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'Flight',
	header: "Flight No",
	dataIndex: 'lastpost',
	width: 80,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'Arrival',
	header: "Arrival",
	dataIndex: 'lastpost',
	width: 80,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'From',
	header: "From",
	dataIndex: 'lastpost',
	width: 50,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'To',
	header: "To",
	dataIndex: 'lastpost',
	width: 50,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'GWT',
	header: "GWT",
	dataIndex: 'lastpost',
	width: 50,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'CWT',
	header: "CWT",
	dataIndex: 'lastpost',
	width: 50,
	align: 'center',
	renderer: renderLast,
	sortable:true
	}
	,{
	id: 'Closed',
	header: "Closed",
	dataIndex: 'lastpost',
	width: 50,
	align: 'center',
	renderer: renderLast,
	sortable:true
	},{
	id: 'Void',
	header:'Void',
	dataIndex: 'lastpost',
	width: 50,
	align: 'center'
	}
	
	],
	
	bbar: new Ext.PagingToolbar({
	store: store,
	pageSize:17,
	displayInfo:true
	}),
	
	view: new Ext.ux.grid.BufferView({
	// custom row height
	rowHeight: 34,
	// render rows as they come into viewable area.
	scrollDelay: false
	})
	});
	
	
	// render functions
	function renderTopic(value, p, record){
	return String.format(
	'<b><a href="http://extjs.com/forum/showthread.php?t={2}" target="_blank">{0}</a></b><a href="http://extjs.com/forum/forumdisplay.php?f={3}" target="_blank">{1} Forum</a>',
	value, record.data.forumtitle, record.id, record.data.forumid);
	}
	function renderLast(value, p, r){
	return String.format('{0}<br/>by {1}', value.dateFormat('M j, Y, g:i a'), r.data['lastposter']);
	}
	
	});
