// ==UserScript==
// @name         bbs readonly helper
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  bbs只读助手
// @author       xs
// @match        https://bbs.pku.edu.cn/*
// @grant        none
// ==/UserScript==

(function () {
    console.log("[bbs readonly] start");
    var cssFix = document.createElement('style');
    // 隐藏发送按钮，其实没必要了
    cssFix.innerHTML += '.publish-button.extended{ display: none!important;}';
    // 隐藏头像，
    cssFix.innerHTML += '.portrait.pic{display: none}'
    // 隐藏id
    cssFix.innerHTML += '[data-role=login-username]{display: none!important}';
    // 隐藏nick、等级和文章数
    cssFix.innerHTML += '[data-role=login-nickname]{display: none!important}';
    cssFix.innerHTML += '[data-role=login-rankname]{display: none!important}';
    cssFix.innerHTML += '[data-role=login-numposts]{display: none!important}';

    // 隐藏输入文本的框框
    cssFix.innerHTML += 'textarea{display: none}'
    document.getElementsByTagName('head')[0].appendChild(cssFix);
})();