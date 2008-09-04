From: "Christopher Li" <sparse@chrisli.org>
Subject: [1/2] find ptr in a list
Date: Wed, 3 Sep 2008 22:34:29 -0700
Message-ID: <70318cbf0809032234y3dbc6968kde3dbfef0af8108f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_66860_29874675.1220506469168"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:29631 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYIDFea (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 01:34:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so337535fgg.17
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 22:34:29 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Alexey Zaytsev <alexey.zaytsev@gmail.com>, Josh Triplett <josh@freedesktop.org>

------=_Part_66860_29874675.1220506469168
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-Off-By: Christopher Li <sparse@chrisli.org>

------=_Part_66860_29874675.1220506469168
Content-Type: application/octet-stream; name=find-ptr-in-list
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkohh0s40
Content-Disposition: attachment; filename=find-ptr-in-list

QWRkaW5nIHNvbWUgaGVscGVyIGZ1bmN0aW9uIHRvIGZpbmQgYSBwb2ludGVyIGluIHRoZSBwdHJs
aXN0LgoKSW5kZXg6IHNwYXJzZS9wdHJsaXN0LmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gc3BhcnNlLm9yaWcv
cHRybGlzdC5oCisrKyBzcGFyc2UvcHRybGlzdC5oCkBAIC00NSw2ICs0NSw4IEBAIGV4dGVybiB2
b2lkIGNvbmNhdF9wdHJfbGlzdChzdHJ1Y3QgcHRyX2wKIGV4dGVybiB2b2lkIF9fZnJlZV9wdHJf
bGlzdChzdHJ1Y3QgcHRyX2xpc3QgKiopOwogZXh0ZXJuIGludCBwdHJfbGlzdF9zaXplKHN0cnVj
dCBwdHJfbGlzdCAqKTsKIGV4dGVybiBpbnQgbGluZWFyaXplX3B0cl9saXN0KHN0cnVjdCBwdHJf
bGlzdCAqLCB2b2lkICoqLCBpbnQpOworZXh0ZXJuIGludCBmaW5kX3B0cl9pbl9saXN0KHN0cnVj
dCBwdHJfbGlzdCogbGlzdCwgdm9pZCAqcHRyKTsKK2V4dGVybiBpbnQgZmluZF9wdHJfaW5kZXgo
c3RydWN0IHB0cl9saXN0KiBsaXN0LCB2b2lkICpwdHIpOwogCiAvKgogICogSGV5LCB3aG8gc2Fp
ZCB0aGF0IHlvdSBjYW4ndCBkbyBvdmVybG9hZGluZyBpbiBDPwpJbmRleDogc3BhcnNlL3B0cmxp
c3QuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSBzcGFyc2Uub3JpZy9wdHJsaXN0LmMKKysrIHNwYXJzZS9wdHJs
aXN0LmMKQEAgLTI0NiwzICsyNDYsMjkgQEAgdm9pZCBfX2ZyZWVfcHRyX2xpc3Qoc3RydWN0IHB0
cl9saXN0ICoqbAogCiAJKmxpc3RwID0gTlVMTDsKIH0KKworaW50IGZpbmRfcHRyX2luX2xpc3Qo
c3RydWN0IHB0cl9saXN0KiBsaXN0LCB2b2lkICpwdHIpCit7CisJdm9pZCAqcDsKKwlGT1JfRUFD
SF9QVFIobGlzdCwgcCkgeworCQlpZiAocCA9PSBwdHIpCisJCQlyZXR1cm4gMTsKKwl9IEVORF9G
T1JfRUFDSF9QVFIocCk7CisJcmV0dXJuIDA7Cit9CisKK2ludCBmaW5kX3B0cl9pbmRleChzdHJ1
Y3QgcHRyX2xpc3QqIGxpc3QsIHZvaWQgKnB0cikKK3sKKwl2b2lkICpwOworCWludCBpID0gMDsK
KwlGT1JfRUFDSF9QVFIobGlzdCwgcCkgeworCQlpZiAocCA9PSBwdHIpCisJCQlyZXR1cm4gaTsK
KwkJaSsrOworCX0gRU5EX0ZPUl9FQUNIX1BUUihwKTsKKwlyZXR1cm4gLTE7Cit9CisKKworCisK

------=_Part_66860_29874675.1220506469168--
