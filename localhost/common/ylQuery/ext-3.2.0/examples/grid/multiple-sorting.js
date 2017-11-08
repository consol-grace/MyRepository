/*!
 * Ext JS Library 3.2.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
/*!
 * Ext JS Library 3.2.0
 * Copyright(c) 2006-2010 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.onReady(function() {
    // create the data store
    var store = new Ext.data.ArrayStore({
        fields: [
           {name: 'rating', type: 'int'},
           {name: 'salary', type: 'float'},
           {name: 'name'}
        ]
    });

    // manually load local fake data
    store.loadData(createFakeData(25));
    
    var reorderer = new Ext.ux.ToolbarReorderer();
    var droppable = new Ext.ux.ToolbarDroppable({
        /**
         * Creates the new toolbar item from the drop event
         */
        createItem: function(data) {
            var column = this.getColumnFromDragDrop(data);
            
            return createSorterButton({
                text    : column.header,
                sortData: {
                    field: column.dataIndex,
                    direction: "ASC"
                }
            });
        },

        /**
         * Custom canDrop implementation which returns true if a column can be added to the toolbar
         * @param {Object} data Arbitrary data from the drag source
         * @return {Boolean} True if the drop is allowed
         */
        canDrop: function(dragSource, event, data) {
            var sorters = getSorters(),
                column  = this.getColumnFromDragDrop(data);

            for (var i=0; i < sorters.length; i++) {
                if (sorters[i].field == column.dataIndex) return false;
            }

            return true;
        },
        
        afterLayout: doSort,

        /**
         * Helper function used to find the column that was dragged
         * @param {Object} data Arbitrary data from
         */
        getColumnFromDragDrop: function(data) {
            var index    = data.header.cellIndex,
                colModel = grid.colModel,
                column   = colModel.getColumnById(colModel.getColumnId(index));

            return column;
        }
    });
    
    //create the toolbar with the 2 plugins
    var tbar = new Ext.Toolbar({
        items  : [],
        plugins: [reorderer, droppable],
        listeners: {
            scope: this,
            reordered: function(button) {
                changeSortDirection(button, false);
            }
        }
    });
    
    // create the Grid
    var grid = new Ext.grid.GridPanel({
        tbar : tbar,
        store: store,
        
        columns: [
            {header: 'HAWB',   width: 80, sortable: false, dataIndex: 'company', id:'company'},
            {header: 'Consignee', width: 125, sortable: false, dataIndex: 'Consignee', id:'Consignee'},
            {header: 'Final', width: 80, sortable: false, dataIndex: 'Final', id:'Final'},
			{header: 'GWT',   width: 80, sortable: false, dataIndex: 'GWT',   id:'GWT'},
            {header: 'VWT', width: 80, sortable: false, dataIndex: 'VWT', id:'VWT'},
            {header: 'CWT', width: 80, sortable: false, dataIndex: 'CWT', id:'CWT'},
		    {header: 'Piece(s)', width: 80, sortable: false, dataIndex: 'Piece', id:'Piece'},
            {header: 'Action', width: 80, sortable: false, dataIndex: 'Action', id:'Action'}
			
        ],
        autoExpandColumn: 'company',
        stripeRows: true,
        
        height: 350,
        width : 700,
        
        
        listeners: {
            scope: this,
            
            //here we tell the toolbar's droppable plugin that it can accept items from the columns' dragdrop group
            render: function() {
                var dragProxy = grid.getView().columnDrag,
                    ddGroup   = dragProxy.ddGroup;
                
                droppable.addDDGroup(ddGroup);
            }
        }
    })
    
    // render the grid to the specified div in the page
    grid.render('grid-example');
    doSort();
    
    //The following functions are used to get the sorting data from the toolbar and apply it to the store
    
    /**
     * Tells the store to sort itself according to our sort data
     */
    function doSort() {
        store.sort(getSorters(), "ASC");
    };
    
    /**
     * Callback handler used when a sorter button is clicked or reordered
     * @param {Ext.Button} button The button that was clicked
     * @param {Boolean} changeDirection True to change direction (default). Set to false for reorder
     * operations as we wish to preserve ordering there
     */
    function changeSortDirection(button, changeDirection) {
        var sortData = button.sortData,
            iconCls  = button.iconCls;
        
        if (sortData != undefined) {
            if (changeDirection !== false) {
                button.sortData.direction = button.sortData.direction.toggle("ASC", "DESC");
                button.setIconClass(iconCls.toggle("sort-asc", "sort-desc"));
            }
            
            store.clearFilter();
            doSort();
        }
    };
    
    /**
     * Returns an array of sortData from the sorter buttons
     * @return {Array} Ordered sort data from each of the sorter buttons
     */
    function getSorters() {
        var sorters = [];
        
        Ext.each(tbar.findByType('button'), function(button) {
            sorters.push(button.sortData);
        }, this);
        
        return sorters;
    }
    
    /**
     * Convenience function for creating Toolbar Buttons that are tied to sorters
     * @param {Object} config Optional config object
     * @return {Ext.Button} The new Button object
     */
    function createSorterButton(config) {
        config = config || {};
              
        Ext.applyIf(config, {
            listeners: {
                click: function(button, e) {
                    changeSortDirection(button, true);                    
                }
            },
            iconCls: 'sort-' + config.sortData.direction.toLowerCase(),
            reorderable: true
        });
        
        return new Ext.Button(config);
    };
    
    /**
     * Returns an array of fake data
     * @param {Number} count The number of fake rows to create data for
     * @return {Array} The fake record data, suitable for usage with an ArrayReader
     */
    function createFakeData(count) {
        var firstNames   = ['Ed', 'Tommy', 'Aaron', 'Abe', 'Jamie', 'Adam', 'Dave', 'David', 'Jay'],
            lastNames    = ['Spencer', 'Maintz', 'Conran', 'Elias', 'Avins', 'Mishcon', 'Kaneda', 'Davis', 'Robinson'],
            ratings      = [1, 2, 3, 4, 5],
            salaries     = [];

        var data = [];
        for (var i=0; i < (count || 25); i++) {
			
            var ratingId    = Math.floor(Math.random() * ratings.length),
                salaryId    = Math.floor(Math.random() * salaries.length),
                firstNameId = Math.floor(Math.random() * firstNames.length),
                lastNameId  = Math.floor(Math.random() * lastNames.length),

                rating      = ratings[ratingId],
                salary      = salaries[salaryId],
                name        = String.format("{0} {1}", firstNames[firstNameId], lastNames[lastNameId]);
				
			data.push([rating, salary, name]);
			
			/*
			var company = "company"+(i).toString();
			var Consignee =  "Consignee"+(i).toString();
			var Final =  "Final"+(i).toString();
			var GWT =  "GWT"+(i).toString();
			var VWT =  "VWT"+(i).toString();
			var CWT =  "CWT"+(i).toString();
			var Piece =  "Piece"+(i).toString();
			var Action =  "<font color='red'>Modify</font>";
            data.push([company, Consignee, Final, GWT, VWT, CWT, Piece, Action]);*/
			
			
        }
        
		alert(data[2]);
        return data;
		
		
		
		/*
		{header: 'HAWB',   width: 80, sortable: false, dataIndex: 'company', id:'company'},
            {header: 'Consignee', width: 125, sortable: false, dataIndex: 'Consignee', id:'Consignee'},
            {header: 'Final', width: 80, sortable: false, dataIndex: 'Final', id:'Final'},
			{header: 'GWT',   width: 80, sortable: false, dataIndex: 'GWT',   id:'GWT'},
            {header: 'VWT', width: 80, sortable: false, dataIndex: 'VWT', id:'VWT'},
            {header: 'CWT', width: 80, sortable: false, dataIndex: 'CWT', renderer: 'usMoney', id:'CWT'},
		    {header: 'Piece(s)', width: 80, sortable: false, dataIndex: 'Piece', id:'Piece'},
            {header: 'Action', width: 80, sortable: false, dataIndex: 'Action', renderer: 'usMoney', id:'Action'}*/
    }
});