function init_editor(textarea_id) {
    new TINY.editor.edit('editor',{
            id: textarea_id, // (required) ID of the textarea
            width:'100%', // (optional) width of the editor
            height:250, // (optional) heightof the editor
            cssclass:'te', // (optional) CSS class of the editor
            controlclass:'tecontrol', // (optional) CSS class of the buttons
            rowclass:'teheader', // (optional) CSS class of the button rows
            dividerclass:'tedivider', // (optional) CSS class of the button diviers
            controls:['bold', 'italic', 'underline', 'strikethrough', '|', 'subscript', 'superscript', '|', 'orderedlist', 'unorderedlist', '|' ,'outdent' ,'indent', '|', 'leftalign', 'centeralign', 'rightalign', 'blockjustify', '|', 'unformat', '|', 'undo', 'redo', 'n', 'font', 'size', 'style', '|', 'image', 'hr', 'link', 'unlink', '|', 'cut', 'copy', 'paste', 'print'], // (required) options you want available, a '|' represents a divider and an 'n' represents a new row
            footer:true, // (optional) show the footer
            fonts:['Verdana','Arial','Georgia','Trebuchet MS'],  // (optional) array of fonts to display
            xhtml:true, // (optional) generate XHTML vs HTML
            cssfile:'style.css', // (optional) attach an external CSS file to the editor
            css:'body{background-color:#fff}', // (optional) attach CSS to the editor
            bodyid:'editor', // (optional) attach an ID to the editor body
            footerclass:'tefooter', // (optional) CSS class of the footer
            toggle:{text:'source',activetext:'wysiwyg', cssclass:'toggle'}, // (optional) toggle to markup view options
            resize:{cssclass:'resize'} // (optional) display options for the editor resize
    });
}
