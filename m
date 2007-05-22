From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/5] Sparse on Cygwin (and git).
Date: Tue, 22 May 2007 18:56:29 +0100
Message-ID: <46532ECD.2020502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090005050409000709090104"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-fallback-95.mail.demon.net ([194.217.242.82]:34719 "EHLO
	anchor-fallback-95.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758482AbXEVTOG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 15:14:06 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4050 "EHLO
	anchor-post-34.mail.demon.net") by anchor-fallback-95.mail.demon.net
	with ESMTP id S473825AbXEVSRO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:17:14 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090005050409000709090104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh,

Since git uses sparse in it's "check" make target, I decided to download the
(then current) 0.2 tar-ball and see what sparse was about. Unfortunately, at present,
I am using cygwin on win32 until I get around to installing Linux. ;-)
Hence, the following patch series...

0001-Add-support-for-WIN32-attribute-names.patch
0002-Fix-an-__attribute__-parsing-error.patch
0003-Add-cygwin-support-to-cgcc.patch
0004-Fix-a-Wtypesign-bug.patch

Well, when the 0.3 tar-ball was released, I had to update the patch series.
Changes to the attribute parsing code meant an update to patch 0001 was
required. Patch 0004 now seems to be unnecessary (probably due to commit
ef2596162115bfdc2a1d3639ac99dd3ba2a71af2). Also compilation errors lead to
the introduction of two new patches (1&2/5), as follows ...

0001-Fix-an-attribute-__sentinel__-unknown-warning.patch
0002-Fix-some-enum-value-XXX-not-handled-in-switch-wa.patch
0003-Add-support-for-WIN32-attribute-names.patch
0004-Fix-an-__attribute__-parsing-error.patch
0005-Add-cygwin-support-to-cgcc.patch

As I am somewhat bandwidth challenged, until recently, I had never cloned a
git repository (not even the git repo). So, last week I cloned the sparse
repository; thankfully it only took about ten minutes (yep a slow pipe!).
Thus, again I had to update the patch series. Patch 0003 overlapped a
recent commit (baf2c5a8) by Michael Stefaniuc and patch 0004 required an
update due to handle_attributes() gaining a third parameter. So the final
patch series is:

0001-Fix-an-__sentinel__-attribute-directive-ignored.patch
0002-Fix-some-enum-value-XXX-not-handled-in-switch-wa.patch
0003-Add-more-support-for-WIN32-attribute-names.patch
0004-Fix-an-__attribute__-parsing-error.patch
0005-Add-cygwin-support-to-cgcc.patch

which was built on top of: 0.3-15-gb5bd30f

I have attached "0004-Fix-a-Wtypesign-bug.patch" simply out of interest, as
it does not require the parameter type of "function returning..." to decay to
"pointer to function returning...".  The test case comes from git:

$cat tsb.c

typedef int erf(const char *r, const unsigned char *s, int f, void *c);

extern int fer(erf, void *);

static int ar(const char *r, const unsigned char *s, int f, void *c)
{
	return 0;
}

int main (int argc, char *argv[])
{
	fer(ar, (void *)0);
}

$

Hope you find this useful.

All the best,

Ramsay Jones


--------------090005050409000709090104
Content-Type: application/xxxxx;
 name="0004-Fix-a-Wtypesign-bug.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="0004-Fix-a-Wtypesign-bug.patch"

RnJvbSA5OWIzYTE4ZjgyY2RlYjIyMWFlMGI4MTdlMGM1ZDcxYmEzMWZkMjczIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBNb24sIDIxIE1heSAyMDA3IDE1OjQ4OjUyICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gRml4IGEgLVd0eXBlc2lnbiBidWcuCgoKU2lnbmVkLW9mZi1ieTogUmFt
c2F5IEpvbmVzIDxyYW1zYXlAcmFtc2F5MS5kZW1vbi5jby51az4KLS0tCiBldmFsdWF0ZS5j
IHwgICAgNiArKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2V2YWx1YXRlLmMgYi9ldmFsdWF0ZS5jCmluZGV4
IGNhNDllZDAuLjUzMDg4MjcgMTAwNjQ0Ci0tLSBhL2V2YWx1YXRlLmMKKysrIGIvZXZhbHVh
dGUuYwpAQCAtNjY5LDcgKzY2OSw3IEBAIGNvbnN0IGNoYXIgKiB0eXBlX2RpZmZlcmVuY2Uo
c3RydWN0IHN5bWJvbCAqdGFyZ2V0LCBzdHJ1Y3Qgc3ltYm9sICpzb3VyY2UsCiAJCQl0YXJn
ZXQgPSB0YXJnZXQtPmN0eXBlLmJhc2VfdHlwZTsKIAkJCWlmICghdGFyZ2V0KQogCQkJCXJl
dHVybiAiYmFkIHR5cGVzIjsKLQkJCWlmICh0YXJnZXQtPnR5cGUgPT0gU1lNX1BUUikgewor
CQkJaWYgKHRhcmdldC0+dHlwZSA9PSBTWU1fUFRSIHx8IHRhcmdldC0+dHlwZSA9PSBTWU1f
Rk4pIHsKIAkJCQltb2QxID0gMDsKIAkJCQlhczEgPSAwOwogCQkJfQkKQEAgLTY4MCw3ICs2
ODAsNyBAQCBjb25zdCBjaGFyICogdHlwZV9kaWZmZXJlbmNlKHN0cnVjdCBzeW1ib2wgKnRh
cmdldCwgc3RydWN0IHN5bWJvbCAqc291cmNlLAogCQkJc291cmNlID0gc291cmNlLT5jdHlw
ZS5iYXNlX3R5cGU7CiAJCQlpZiAoIXNvdXJjZSkKIAkJCQlyZXR1cm4gImJhZCB0eXBlcyI7
Ci0JCQlpZiAoc291cmNlLT50eXBlID09IFNZTV9QVFIpIHsKKwkJCWlmIChzb3VyY2UtPnR5
cGUgPT0gU1lNX1BUUiB8fCBzb3VyY2UtPnR5cGUgPT0gU1lNX0ZOKSB7CiAJCQkJbW9kMiA9
IDA7CiAJCQkJYXMyID0gMDsKIAkJCX0KQEAgLTcxOCw2ICs3MTgsNyBAQCBjb25zdCBjaGFy
ICogdHlwZV9kaWZmZXJlbmNlKHN0cnVjdCBzeW1ib2wgKnRhcmdldCwgc3RydWN0IHN5bWJv
bCAqc291cmNlLAogCQkJY2FzZSBTWU1fRk46CiAJCQkJdHlwZTEgPSBTWU1fRk47CiAJCQkJ
dGFyZ2V0ID0gYmFzZTE7CisJCQkJbW9kMSA9IHRhcmdldC0+Y3R5cGUubW9kaWZpZXJzOwog
CQkJCWJhc2UxID0gYmFzZTEtPmN0eXBlLmJhc2VfdHlwZTsKIAkJCWRlZmF1bHQ6CiAJCQkJ
Lyogbm90aGluZyAqLzsKQEAgLTcyOSw2ICs3MzAsNyBAQCBjb25zdCBjaGFyICogdHlwZV9k
aWZmZXJlbmNlKHN0cnVjdCBzeW1ib2wgKnRhcmdldCwgc3RydWN0IHN5bWJvbCAqc291cmNl
LAogCQkJY2FzZSBTWU1fRk46CiAJCQkJdHlwZTIgPSBTWU1fRk47CiAJCQkJc291cmNlID0g
YmFzZTI7CisJCQkJbW9kMiA9IHNvdXJjZS0+Y3R5cGUubW9kaWZpZXJzOwogCQkJCWJhc2Uy
ID0gYmFzZTItPmN0eXBlLmJhc2VfdHlwZTsKIAkJCWRlZmF1bHQ6CiAJCQkJLyogbm90aGlu
ZyAqLzsKLS0gCjEuNS4xCgo=
--------------090005050409000709090104
Content-Type: text/plain;
 name="tsb.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tsb.c"


typedef int erf(const char *r, const unsigned char *s, int f, void *c);

extern int fer(erf, void *);

static int ar(const char *r, const unsigned char *s, int f, void *c)
{
	return 0;
}

int main (int argc, char *argv[])
{
	fer(ar, (void *)0);
}


--------------090005050409000709090104--
