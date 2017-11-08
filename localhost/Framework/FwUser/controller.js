/// <reference path="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../../common/ylQuery/ylQuery.js" />
/// <reference path="../../common/ylQuery/ext-3.2.0/adapter/ext/ext-base.js" />
/// <reference path="../../common/ylQuery/ext-3.2.0/ext-all.js" />
/// <reference path="../../common/Global/global.js" />

Ext.onReady(function() {
    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget = "under";

    // 定义form
    var frm = Ext.form;

    // 定义列
    var check_cm = new Ext.grid.CheckboxSelectionModel();
    var cm = new Ext.grid.ColumnModel([
        new Ext.grid.RowNumberer()
        , { header: "Active", dataIndex: "Active"} //check_cm
        , { header: "UserName", dataIndex: "UserName", sortable: true, width: 100, editor: new frm.TextField({ allowBlank: false }) }
        , { header: "NameCHS", dataIndex: "NameCHS", sortable: true, width: 100, editor: new frm.TextField({ allowBlank: false }) }
        , { header: "NameENG", dataIndex: "NameENG", sortable: true, width: 100, editor: new frm.TextField({ allowBlank: false }) }
        , { header: "Email", dataIndex: "Email", sortable: true, width: 100, editor: new frm.TextField({ allowBlank: false }) }
        , { header: "Question", dataIndex: "Question", sortable: true, width: 100, editor: new frm.TextField({ allowBlank: false }) }
        , { header: "Answer", dataIndex: "Answer", sortable: true, width: 100, editor: new frm.TextField({ allowBlank: false }) }
    ]);
    // 行资料
    var data = [{ "UserName": "KD10001", "NameCHS": "张三", "NameENG": "Zhangsan", "Email": "zhangsan@diygens.com", "Question": "最喜欢的歌典？", "Answer": "《十年》" }
        , { "UserName": "KD10002", "NameCHS": "李四", "NameENG": "lishi", "Email": "lishi@diygens.com", "Question": "我中学名称？", "Answer": "黄金湖中学" }
        , { "UserName": "KD10003", "NameCHS": "王五", "NameENG": "Wangwu", "Email": "Wangwu@diygens.com", "Question": "我的工号？", "Answer": "100000" }
        , { "UserName": "KD10004", "NameCHS": "赵六", "NameENG": "Zhaoliu", "Email": "Zhaoliu@diygens.com", "Question": "我的高中班主任？", "Answer": "余老师" }
        , { "UserName": "KD10005", "NameCHS": "孙子刚", "NameENG": "Sunzigang", "Email": "Sunzigang@diygens.com", "Question": "我的出生地？", "Answer": "黄金湖" }
        , { "UserName": "KD10006", "NameCHS": "韩信", "NameENG": "HangXin", "Email": "hanxin@diygens.com", "Question": "有意思的纪念日", "Answer": "2011-04-04" }
    ];
    var proxy = new Ext.data.MemoryProxy(data);
    var record = new Ext.data.Record.create([
        { name: "UserName", type: "String", mapping: "UserName" }
        , { name: "NameCHS", type: "String", mapping: "NameCHS" }
        , { name: "NameENG", type: "String", mapping: "NameENG" }
        , { name: "Email", type: "String", mapping: "Email" }
        , { name: "Question", type: "String", mapping: "Question" }
        , { name: "Answer", type: "String", mapping: "Answer" }
    ]);
    var reader = new Ext.data.JsonReader({}, record);
    var ds = new Ext.data.Store({ proxy: proxy
        , reader: reader
        , autoLoad: true
    });
    // 定义 GridPanel 对象
    var GridView1 = new Ext.grid.EditorGridPanel({
        title: "用户列表"
        , renderTo: Ext.getBody()
        , autoHeight: true
        , sm: check_cm
        , cm: cm
        , store: ds
        , clicksToEdit: 1
        , buttonAlign: "center"
        , buttons: [
            { id: "GridView1_btnAddnew"
                , text: "新增"
                , handler: function() {
                    var rowsCount = GridView1.getStore().getCount();
                    var newRow = new record({
                        UserName: "KD10007"
                        , NameCHS: "曹操"
                        , NameENG: "Caozao"
                        , Email: "Caozao@diygens.com"
                        , Question: "曹操名言？"
                        , Answer: "宁愿我负天下人，休叫天下人负我！"
                    });
                    GridView1.stopEditing();
                    ds.insert(rowsCount, newRow);
                    GridView1.startEditing(rowsCount, 1);

                    alert(newRow.data);
                }
            }
            , { text: "选中第一行"
                , handler: function() {
                    var rsm = GridView1.getSelectionModel();
                    rsm.selectFirstRow();
                }
            }
            , { text: "选中下一行"
                , handler: function() {
                    var rsm = GridView1.getSelectionModel();
                    if (rsm.hasNext()) rsm.selectNext(false); else Ext.Msg.alert("警告", "已经是最后一行！");
                }
            }
            , { text: "选中上一行"
                , handler: function() {
                    var rsm = GridView1.getSelectionModel();
                    if (rsm.hasPrevious()) rsm.selectPrevious(true); else Ext.Msg.alert("警告", "已经是第一行！");
                }
            }
            , { text: "选中所有行"
                , handler: function() {
                    var rsm = GridView1.getSelectionModel();
                    rsm.selectAll();
                }
            }
            , { text: "取消所有选中"
                , handler: function() {
                    var rsm = GridView1.getSelectionModel();
                    rsm.deselectRange(0, GridView1.getView().getRows().length - 1);
                }
            }
            , { text: "反选"
                , handler: function() {
                    var rsm = GridView1.getSelectionModel();
                    for (var i = GridView1.getView().getRows().length - 1; i <= 0; i--) {
                        if (rsm.isSelected(i)) {
                            rsm.deselectRow(i);
                        }
                        else {
                            rsm.selectRows([i], true); // or rsm.selectRow(i, true);
                        }
                    }
                }
            }
        ]
    });
});


