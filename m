From: Damien Lespiau <damien.lespiau@gmail.com>
Subject: [PATCH] Ignore the may_alias GCC attribute
Date: Tue, 1 Jun 2010 17:35:52 +0100
Message-ID: <AANLkTikvGsi4Ju25yduhlszVP3BOiCEEHrlO6hNoGKFV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64982ec1074d60487fa91ea
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63705 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab0FAQmX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Jun 2010 12:42:23 -0400
Received: by wwb28 with SMTP id 28so2171923wwb.19
        for <linux-sparse@vger.kernel.org>; Tue, 01 Jun 2010 09:42:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--0016e64982ec1074d60487fa91ea
Content-Type: text/plain; charset=ISO-8859-1

Unfortunately, linux-sparse seems to reject my git send-emails with
GMail's SMTP server, so I'm attaching the git format-patch instead.

may_alias is used in the wild (glib) and makes sparse spew a lot of
unhelpful warning messages. Ignore it (for now?).

Signed-off-by: Damien Lespiau <damien.lespiau@gmail.com>

-- 
Damien

--0016e64982ec1074d60487fa91ea
Content-Type: application/octet-stream;
	name="0001-Ignore-the-may_alias-GCC-attribute.patch"
Content-Disposition: attachment;
	filename="0001-Ignore-the-may_alias-GCC-attribute.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9wy8udb0

RnJvbSAxZGZjYmJjNzE2MDg3N2Y0OWMxOWFjMDY0NDdmMDMzYmFlZWMxZWJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW1pZW4gTGVzcGlhdSA8ZGFtaWVuLmxlc3BpYXVAZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDI2IE1heSAyMDEwIDExOjUyOjU3ICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gSWdub3JlIHRoZSBtYXlfYWxpYXMgR0NDIGF0dHJpYnV0ZQoKbWF5X2FsaWFzIGlzIHVzZWQg
aW4gdGhlIHdpbGQgKGdsaWIpIGFuZCBtYWtlcyBzcGFyc2Ugc3BldyBhIGxvdCBvZgp1bmhlbHBm
dWwgd2FybmluZyBtZXNzYWdlcy4gSWdub3JlIGl0IChmb3Igbm93PykuCgpTaWduZWQtb2ZmLWJ5
OiBEYW1pZW4gTGVzcGlhdSA8ZGFtaWVuLmxlc3BpYXVAZ21haWwuY29tPgotLS0KIHBhcnNlLmMg
fCAgICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9wYXJzZS5jIGIvcGFyc2UuYwppbmRleCBmODFiMTlmLi5mNWM1NDk3
IDEwMDY0NAotLS0gYS9wYXJzZS5jCisrKyBiL3BhcnNlLmMKQEAgLTUxNyw2ICs1MTcsOCBAQCBj
b25zdCBjaGFyICppZ25vcmVkX2F0dHJpYnV0ZXNbXSA9IHsKIAkiX19ob3RfXyIsCiAJIm1hbGxv
YyIsCiAJIl9fbWFsbG9jX18iLAorCSJtYXlfYWxpYXMiLAorCSJfX21heV9hbGlhc19fIiwKIAki
bW9kZWwiLAogCSJfX21vZGVsX18iLAogCSJtc19hYmkiLAotLSAKMS43LjAuMQoK
--0016e64982ec1074d60487fa91ea--
