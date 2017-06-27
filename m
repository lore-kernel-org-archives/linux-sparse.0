From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Adding ignored attribute optimize
Date: Tue, 27 Jun 2017 10:21:43 -0700
Message-ID: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a1140fbb036b0bc0552f44db4"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34898 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdF0RVp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 27 Jun 2017 13:21:45 -0400
Received: by mail-io0-f181.google.com with SMTP id h134so21712100iof.2
        for <linux-sparse@vger.kernel.org>; Tue, 27 Jun 2017 10:21:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

--001a1140fbb036b0bc0552f44db4
Content-Type: text/plain; charset="UTF-8"

I notice this unknow attribute "__optimize__"when I am looking
sparse checking result on the recent kernel compile.

Chris

--001a1140fbb036b0bc0552f44db4
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-Adding-ignored-attribute-optimize.patch"
Content-Disposition: attachment;
	filename="0001-Adding-ignored-attribute-optimize.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j4fu9kdz0

RnJvbSBkODkyNWYxMjVlZThiMWNjNmViMjlmNDMzMTJiODFmM2Y4NTkzNzRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBGcmksIDIzIEp1biAyMDE3IDE3OjEzOjE3IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gQWRk
aW5nIGlnbm9yZWQgYXR0cmlidXRlIG9wdGltaXplCgpJdCB3YXMgdXNlZCBpbiBrdm0vdm14LmMK
ClNpZ25lZC1vZi1CeTogQ2hyaXN0b3BoZXIgTGkgPHNwYXJzZUBjaHJpc2xpLm9yZz4KLS0tCiBw
YXJzZS5jICAgICAgICAgICAgICAgICAgICB8ICA2ICsrKystLQogdmFsaWRhdGlvbi9hdHRyLW9w
dGltaXplLmMgfCAxNiArKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdmFsaWRhdGlvbi9h
dHRyLW9wdGltaXplLmMKCmRpZmYgLS1naXQgYS9wYXJzZS5jIGIvcGFyc2UuYwppbmRleCAyMTQ1
NDc5Li5mNjY1ZjA1IDEwMDY0NAotLS0gYS9wYXJzZS5jCisrKyBiL3BhcnNlLmMKQEAgLTYwNyw2
ICs2MDcsOCBAQCBzdGF0aWMgY29uc3QgY2hhciAqaWdub3JlZF9hdHRyaWJ1dGVzW10gPSB7CiAJ
Il9fbmFrZWRfXyIsCiAJIm5vX2luc3RydW1lbnRfZnVuY3Rpb24iLAogCSJfX25vX2luc3RydW1l
bnRfZnVuY3Rpb25fXyIsCisJIm5vX3Nhbml0aXplX2FkZHJlc3MiLAorCSJfX25vX3Nhbml0aXpl
X2FkZHJlc3NfXyIsCiAJIm5vY2xvbmUiLAogCSJfX25vY2xvbmUiLAogCSJfX25vY2xvbmVfXyIs
CkBAIC02MTgsNiArNjIwLDggQEAgc3RhdGljIGNvbnN0IGNoYXIgKmlnbm9yZWRfYXR0cmlidXRl
c1tdID0gewogCSJub3Rocm93IiwKIAkiX19ub3Rocm93IiwKIAkiX19ub3Rocm93X18iLAorCSJv
cHRpbWl6ZSIsCisJIl9fb3B0aW1pemVfXyIsCiAJInJlZ3Bhcm0iLAogCSJfX3JlZ3Bhcm1fXyIs
CiAJInNlY3Rpb24iLApAQCAtNjQ2LDggKzY1MCw2IEBAIHN0YXRpYyBjb25zdCBjaGFyICppZ25v
cmVkX2F0dHJpYnV0ZXNbXSA9IHsKIAkiX193YXJuaW5nX18iLAogCSJ3ZWFrIiwKIAkiX193ZWFr
X18iLAotCSJub19zYW5pdGl6ZV9hZGRyZXNzIiwKLQkiX19ub19zYW5pdGl6ZV9hZGRyZXNzX18i
LAogfTsKIAogCmRpZmYgLS1naXQgYS92YWxpZGF0aW9uL2F0dHItb3B0aW1pemUuYyBiL3ZhbGlk
YXRpb24vYXR0ci1vcHRpbWl6ZS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LmM0NWNiZTgKLS0tIC9kZXYvbnVsbAorKysgYi92YWxpZGF0aW9uL2F0dHItb3B0aW1pemUuYwpA
QCAtMCwwICsxLDE2IEBACisKKyNkZWZpbmUgX19ub2Nsb25lCV9fYXR0cmlidXRlX18oKF9fbm9j
bG9uZV9fLCBfX29wdGltaXplX18oIm5vLXRyYWNlciIpKSkKKworc3RydWN0IGt2bV92Y3B1Owor
CitzdGF0aWMgdm9pZCBfX25vY2xvbmUgdm14X3ZjcHVfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSkKK3sKKwlfX2FzbV9fKCIiKTsKK30KKworZXh0ZXJuIHZvaWQgKnJ1bjsKK3ZvaWQgKnJ1biA9
IHZteF92Y3B1X3J1bjsKKworLyoKKyAqIGNoZWNrLW5hbWU6IG9wdGltaXplIGF0dHJpYnV0ZXMK
KyAqLwotLSAKMi45LjQKCg==
--001a1140fbb036b0bc0552f44db4--
