From: "Blue Swirl" <blauwirbel@gmail.com>
Subject: [PATCH] Sparc64 (Sparc V9, LP64) support
Date: Sun, 2 Nov 2008 10:37:12 +0200
Message-ID: <f43fc5580811020137n6d0be9f4i98a69c48f917b40d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_60652_2012365.1225615032457"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:17268 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYKBIhN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 2 Nov 2008 03:37:13 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1987519wfd.4
        for <linux-sparse@vger.kernel.org>; Sun, 02 Nov 2008 01:37:12 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

------=_Part_60652_2012365.1225615032457
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This patch adds support for Sparc64 (Sparc V9, LP64). I'm not
subscribed, please CC.

Signed-off-by: Blue Swirl <blauwirbel@gmail.com>

------=_Part_60652_2012365.1225615032457
Content-Type: plain/text; name=sparse-sparc64.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fn1fi7i9
Content-Disposition: attachment; filename=sparse-sparc64.diff

ZGlmZiAtLWdpdCBhL2NnY2MgYi9jZ2NjCmluZGV4IDJmMDllMGQuLjVkMTI5YjkgMTAwNzU1Ci0t
LSBhL2NnY2MKKysrIGIvY2djYwpAQCAtMjQ2LDYgKzI0NiwxMSBAQCBzdWIgYWRkX3NwZWNzIHsK
IAkJJmludGVnZXJfdHlwZXMgKDgsIDE2LCAzMiwgJG02NCA/IDY0IDogMzIsIDY0KSAuCiAJCSZm
bG9hdF90eXBlcyAoMSwgMSwgMzMsIFsyNCw4XSwgWzUzLDExXSwgWzExMywxNV0pIC4KIAkJJmRl
ZmluZV9zaXplX3QgKCRtNjQgPyAibG9uZyB1bnNpZ25lZCBpbnQiIDogInVuc2lnbmVkIGludCIp
KTsKKyAgICB9IGVsc2lmICgkc3BlYyBlcSAnc3BhcmM2NCcpIHsKKwlyZXR1cm4gKCcgLURzcGFy
Yz0xIC1EX19zcGFyYz0xIC1EX19zcGFyY19fPTEgLURfX3NwYXJjdjlfXz0xIC1EX19zcGFyYzY0
X189MSAtRF9fYXJjaDY0X189MSAtRF9fTFA2NF9fPTEnIC4KKwkJJmludGVnZXJfdHlwZXMgKDgs
IDE2LCAzMiwgNjQsIDY0KSAuCisJCSZmbG9hdF90eXBlcyAoMSwgMSwgMzMsIFsyNCw4XSwgWzUz
LDExXSwgWzExMywxNV0pIC4KKwkJJmRlZmluZV9zaXplX3QgKCJsb25nIHVuc2lnbmVkIGludCIp
KTsKICAgICB9IGVsc2lmICgkc3BlYyBlcSAneDg2XzY0JykgewogCXJldHVybiAoJyAtRHg4Nl82
ND0xIC1EX194ODZfNjQ9MSAtRF9feDg2XzY0X189MScgLgogCQkmaW50ZWdlcl90eXBlcyAoOCwg
MTYsIDMyLCAkbTMyID8gMzIgOiA2NCwgNjQpIC4KQEAgLTI3MSw2ICsyNzYsOCBAQCBzdWIgYWRk
X3NwZWNzIHsKIAkgICAgcmV0dXJuICZhZGRfc3BlY3MgKCd4ODZfNjQnKTsKIAl9IGVsc2lmICgk
YXJjaCA9fiAvXihwcGMpJC9pKSB7CiAJICAgIHJldHVybiAmYWRkX3NwZWNzICgncHBjJyk7CisJ
fSBlbHNpZiAoJGFyY2ggPX4gL14oc3BhcmM2NCkkL2kpIHsKKwkgICAgcmV0dXJuICZhZGRfc3Bl
Y3MgKCdzcGFyYzY0Jyk7CiAJfQogICAgIH0gZWxzZSB7CiAJZGllICIkMDogaW52YWxpZCBzcGVj
czogJHNwZWNcbiI7Cg==
------=_Part_60652_2012365.1225615032457--
