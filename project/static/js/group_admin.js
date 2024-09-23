document.addEventListener("DOMContentLoaded", function() {
    const groupTypeField = document.getElementById('id_group_type');
    const comanagerField = document.querySelector('.form-row.field-comanager');

    function toggleComanagerField() {
        if (groupTypeField.value === 'single') {
            comanagerField.style.display = 'none';
        } else {
            comanagerField.style.display = 'block';
        }
    }

    // ページロード時の初期表示を設定
    toggleComanagerField();

    // group_typeが変更されたときのイベントリスナー
    groupTypeField.addEventListener('change', toggleComanagerField);
});
