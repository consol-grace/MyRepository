<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExtGrid.aspx.cs" Inherits="Common_ylQuery_ExtGrid" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <link href="jquery.ui.custom/css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
        <script src="jquery.ui.custom/js/jquery-1.6.1.js" type="text/javascript"></script>
        <script src="jquery.ui.custom/js/jquery-ui-1.8.14.custom.min.js" type="text/javascript"></script>
        <link href="themes/ylQuery.css" rel="stylesheet" type="text/css" />
        <script src="ylQuery.js" type="text/javascript"></script>
        <link href="ext-3.2.0/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
        <script src="ext-3.2.0/adapter/ext/ext-base.js" type="text/javascript"></script>
        <script src="ext-3.2.0/ext-all.js" type="text/javascript"></script>
        <script type="text/javascript">
            Ext.onReady(function() {
                var csm = new Ext.grid.CheckboxSelectionModel();
                var cm = new Ext.grid.ColumnModel([new Ext.grid.RowNumberer(), csm
                    , { header: "编号", dataIndex: "id", sortable: true, editor: new Ext.grid.GridEditor(new Ext.form.TextField({ allowBlank: false })) }
                    , { header: "名称", dataIndex: "name", editor: new Ext.grid.GridEditor(new Ext.form.TextField({ allowBlank: false })) }
                    , { id: "desc", header: "描述", dataIndex: "desc", editor: new Ext.grid.GridEditor(new Ext.form.TextField({ allowBlank: false })) }
                    , { header: "日期", dataIndex: "date", editor: new Ext.grid.GridEditor(new Ext.form.TextField({ allowBlank: false })) }
                ]);

                var data = [["1", "name1", "desc1", "2011-07-06"]
                    , ["2", "name2", "desc2", "2011-07-06"]
                    , ["3", "name3", "desc3", "2011-07-06"]
                    , ["4", "name4", "desc4", "2011-07-06"]
                    , ["5", "name5", "desc5", "2011-07-06"]

                    , ["6", "name6", "desc6", "2011-07-06"]
                    , ["7", "name7", "desc7", "2011-07-06"]
                    , ["8", "name8", "desc8", "2011-07-06"]
                    , ["9", "name9", "desc9", "2011-07-06"]
                    , ["10", "name10", "desc10", "2011-07-06"]

                    , ["11", "name11", "desc11", "2011-07-06"]
                    , ["12", "name12", "desc12", "2011-07-06"]
                    , ["13", "name13", "desc13", "2011-07-06"]
                    , ["14", "name14", "desc14", "2011-07-06"]
                    , ["15", "name15", "desc15", "2011-07-06"]
                ];

                var store1 = new Ext.data.Store({ proxy: new Ext.data.MemoryProxy(data)
                    , reader: new Ext.data.ArrayReader({}, [{ name: "id" }
                        , { name: "name" }
                        , { name: "desc" }
                        , { name: "date" }
                    ])
                });
                store1.load();

                // record object
                var Record = Ext.data.Record.create([{ name: "id", type: "string" }
                    , { name: "name", type: "string" }
                    , { name: "desc", type: "string" }
                    , { name: "date", type: "string" }
                ]);


                var grid = new Ext.grid.EditorGridPanel({ renderTo: "grid"
                    , cm: cm
                    , store: store1
                    , height: 200
                    , width: 480
                    , stripeRows: true
                    , loadMask: true
                    , clickToEdit: 1
                    , viewConfig: { forceFit: true }
                    // , autoExpandColumn: "desc"

                    , tbar: new Ext.Toolbar(["-", { text: "添加一行", handler: function() {
                            var p = new Record({ id: "", name: "", desc: "", date: "" });
                            grid.stopEditing();
                            store1.insert(0, p);
                            grid.startEditing(0, 0);
                        } }
                        , "-", { text: "删除一行", handler: function() {
                            Ext.Msg.confirm("信息", "确定删除吗？", function(btn) {
                                if(btn=="yes") {
                                    var gsm = grid.getSelectionModel();
                                    var cell = gsm.getSelectedCell();
                                    var record = store1.getAt(cell[0]);
                                    store1.remove(record);
                                }
                            });                        
                        } }
                        , "-", { text: "保存", handler: function() {
                            
                        } }
                    ])
                    , bbar: new Ext.PagingToolbar({ pageSize: 10
                        , store: store1
                        , displayInfo: true
                        , displayMsg: "显示　第{0}条 到 {1}条记录, 一共{2}条"
                        , emptyMsg: "没有记录"
                    })
                });
            });
        </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <div id="grid"></div>
        
        </form>
    </body>
</html>
