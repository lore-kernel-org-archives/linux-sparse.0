From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Make "break" and "continue" consistent with other label
Date: Wed, 27 Feb 2013 06:45:28 -0800
Message-ID: <CANeU7Qmkcc5zQbXOjBvF8wCGc9=i_UEkKtT7jLtfOCHme=WmFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0444ebbf3c1e7604d6b5d347
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:49652 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab3B0Op2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Feb 2013 09:45:28 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so1282998oag.15
        for <linux-sparse@vger.kernel.org>; Wed, 27 Feb 2013 06:45:28 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

--f46d0444ebbf3c1e7604d6b5d347
Content-Type: text/plain; charset=ISO-8859-1

Hi Xi,

I make some small improvement of your label checking change.

By setting the label->stmt, there is no need to do
keyword lookup. The keyword lookup can be incorrect
because it contain more than just  "break" and "continue".

Let me know if you found any thing wrong with it.

Chris

--f46d0444ebbf3c1e7604d6b5d347
Content-Type: application/octet-stream;
	name="0001-Make-break-and-continue-consistent-with-other-label.patch"
Content-Disposition: attachment;
	filename="0001-Make-break-and-continue-consistent-with-other-label.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hdolg8sr0

RnJvbSAwOTEzMDc5MTlkNmNhNzZlMzFiMzM2YjcwOGJhZmNhYWQ2NGM3NzlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBNb24sIDI1IEZlYiAyMDEzIDAyOjQ0OjI1IC0wODAwClN1YmplY3Q6IFtQQVRDSCAxLzNd
IE1ha2UgImJyZWFrIiBhbmQgImNvbnRpbnVlIiBjb25zaXN0ZW50IHdpdGggb3RoZXIgbGFiZWwu
CgpCeSBzZXR0aW5nIHRoZSBsYWJlbC0+c3RtdCwgdGhlcmUgaXMgbm8gbmVlZCB0byBkbwprZXl3
b3JkIGxvb2t1cC4gVGhlIGtleXdvcmQgbG9va3VwIGNhbiBiZSBpbmNvcnJlY3QKYmVjYXVzZSBp
dCBjb250YWluIG1vcmUgdGhhbiBqdXN0ICAiYnJlYWsiIGFuZCAiY29udGludWUiLgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoZXIgTGkgPHNwYXJzZUBjaHJpc2xpLm9yZz4KLS0tCiBldmFsdWF0
ZS5jIHwgMiArLQogcGFyc2UuYyAgICB8IDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2V2YWx1YXRlLmMgYi9ldmFsdWF0
ZS5jCmluZGV4IGQwOWYyNzEuLmNkMDUzZjcgMTAwNjQ0Ci0tLSBhL2V2YWx1YXRlLmMKKysrIGIv
ZXZhbHVhdGUuYwpAQCAtMzMyNCw3ICszMzI0LDcgQEAgc3RhdGljIHZvaWQgZXZhbHVhdGVfZ290
b19zdGF0ZW1lbnQoc3RydWN0IHN0YXRlbWVudCAqc3RtdCkKIHsKIAlzdHJ1Y3Qgc3ltYm9sICps
YWJlbCA9IHN0bXQtPmdvdG9fbGFiZWw7CiAKLQlpZiAobGFiZWwgJiYgIWxhYmVsLT5zdG10ICYm
ICFsb29rdXBfa2V5d29yZChsYWJlbC0+aWRlbnQsIE5TX0tFWVdPUkQpKQorCWlmIChsYWJlbCAm
JiAhbGFiZWwtPnN0bXQpCiAJCXNwYXJzZV9lcnJvcihzdG10LT5wb3MsICJsYWJlbCAnJXMnIHdh
cyBub3QgZGVjbGFyZWQiLCBzaG93X2lkZW50KGxhYmVsLT5pZGVudCkpOwogCiAJZXZhbHVhdGVf
ZXhwcmVzc2lvbihzdG10LT5nb3RvX2V4cHJlc3Npb24pOwpkaWZmIC0tZ2l0IGEvcGFyc2UuYyBi
L3BhcnNlLmMKaW5kZXggNDVmZmMxMC4uOWVjNTFmYiAxMDA2NDQKLS0tIGEvcGFyc2UuYworKysg
Yi9wYXJzZS5jCkBAIC0xOTkyLDggKzE5OTIsMTAgQEAgc3RhdGljIHZvaWQgc3RhcnRfaXRlcmF0
b3Ioc3RydWN0IHN0YXRlbWVudCAqc3RtdCkKIAogCXN0YXJ0X3N5bWJvbF9zY29wZSgpOwogCWNv
bnQgPSBhbGxvY19zeW1ib2woc3RtdC0+cG9zLCBTWU1fTk9ERSk7CisJY29udC0+c3RtdCA9IHN0
bXQ7CiAJYmluZF9zeW1ib2woY29udCwgJmNvbnRpbnVlX2lkZW50LCBOU19JVEVSQVRPUik7CiAJ
YnJrID0gYWxsb2Nfc3ltYm9sKHN0bXQtPnBvcywgU1lNX05PREUpOworCWJyay0+c3RtdCA9IHN0
bXQ7CiAJYmluZF9zeW1ib2woYnJrLCAmYnJlYWtfaWRlbnQsIE5TX0lURVJBVE9SKTsKIAogCXN0
bXQtPnR5cGUgPSBTVE1UX0lURVJBVE9SOwpAQCAtMjA1Miw2ICsyMDU0LDcgQEAgc3RhdGljIHZv
aWQgc3RhcnRfc3dpdGNoKHN0cnVjdCBzdGF0ZW1lbnQgKnN0bXQpCiAKIAlzdGFydF9zeW1ib2xf
c2NvcGUoKTsKIAlicmsgPSBhbGxvY19zeW1ib2woc3RtdC0+cG9zLCBTWU1fTk9ERSk7CisJYnJr
LT5zdG10ID0gc3RtdDsKIAliaW5kX3N5bWJvbChicmssICZicmVha19pZGVudCwgTlNfSVRFUkFU
T1IpOwogCiAJc3dpdGNoX2Nhc2UgPSBhbGxvY19zeW1ib2woc3RtdC0+cG9zLCBTWU1fTk9ERSk7
Ci0tIAoxLjguMS4yCgo=
--f46d0444ebbf3c1e7604d6b5d347--
