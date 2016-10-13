From: Christopher Li <sparse@chrisli.org>
Subject: Review: [PATCH] Fix warning compiling sparse
Date: Thu, 13 Oct 2016 00:30:43 -0700
Message-ID: <CANeU7QnrQ8RRTbOxog-RbhbzFb3SfEadDooyz4oKMuL=_AJiyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1144675e609451053eba168b
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36455 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbcJMHbS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Oct 2016 03:31:18 -0400
Received: by mail-it0-f44.google.com with SMTP id l13so172347010itl.1
        for <linux-sparse@vger.kernel.org>; Thu, 13 Oct 2016 00:30:44 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

--001a1144675e609451053eba168b
Content-Type: text/plain; charset=UTF-8

    Fix warning compiling sparse-llvm

    -pedantic in the llvm-config --cflags cause a lot of warning.


Chris

--001a1144675e609451053eba168b
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-warning-compiling-sparse-llvm.patch"
Content-Disposition: attachment;
	filename="0001-Fix-warning-compiling-sparse-llvm.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iu80yl6o0

RnJvbSA0MzY0NzI2NjQ2OTU0YTg4YTE4ZWFjZmI1NmE5YjAzODllNzczZDA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBUaHUsIDI5IFNlcCAyMDE2IDAwOjM4OjMxIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gRml4
IHdhcm5pbmcgY29tcGlsaW5nIHNwYXJzZS1sbHZtCgotcGVkYW50aWMgaW4gdGhlIGxsdm0tY29u
ZmlnIC0tY2ZsYWdzIGNhdXNlIGEgbG90IG9mIHdhcm5pbmcuCi0tLQogTWFrZWZpbGUgfCAyICst
CiB0b2tlbi5oICB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggYzcwMzFh
Zi4uZjU5OTkzZiAxMDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTg0LDcg
Kzg0LDcgQEAgaWZlcSAoJChzaGVsbCBleHByICIkKExMVk1fVkVSU0lPTikiIDogJ1szLTldXC4n
KSwyKQogTExWTV9QUk9HUyA6PSBzcGFyc2UtbGx2bQogJChMTFZNX1BST0dTKTogTEQgOj0gZysr
CiBMTFZNX0xERkxBR1MgOj0gJChzaGVsbCAkKExMVk1fQ09ORklHKSAtLWxkZmxhZ3MpCi1MTFZN
X0NGTEFHUyA6PSAkKHNoZWxsICQoTExWTV9DT05GSUcpIC0tY2ZsYWdzIHwgc2VkIC1lICJzLy1E
TkRFQlVHLy9nIikKK0xMVk1fQ0ZMQUdTIDo9ICQoc2hlbGwgJChMTFZNX0NPTkZJRykgLS1jZmxh
Z3MgfCBzZWQgLWUgInMvLUROREVCVUcvL2ciIHwgc2VkIC1lICJzLy1wZWRhbnRpYy8vZyIpCiBM
TFZNX0xJQlMgOj0gJChzaGVsbCAkKExMVk1fQ09ORklHKSAtLWxpYnMpCiBMTFZNX0xJQlMgKz0g
JChzaGVsbCAkKExMVk1fQ09ORklHKSAtLXN5c3RlbS1saWJzIDI+L2Rldi9udWxsKQogUFJPR1JB
TVMgKz0gJChMTFZNX1BST0dTKQpkaWZmIC0tZ2l0IGEvdG9rZW4uaCBiL3Rva2VuLmgKaW5kZXgg
YWY2NmIyYi4uZjdkODhlYiAxMDA2NDQKLS0tIGEvdG9rZW4uaAorKysgYi90b2tlbi5oCkBAIC0y
MzAsNyArMjMwLDcgQEAgZXh0ZXJuIHN0cnVjdCB0b2tlbiAqIHRva2VuaXplX2J1ZmZlcih2b2lk
ICosIHVuc2lnbmVkIGxvbmcsIHN0cnVjdCB0b2tlbiAqKik7CiBleHRlcm4gdm9pZCBzaG93X2lk
ZW50aWZpZXJfc3RhdHModm9pZCk7CiBleHRlcm4gc3RydWN0IHRva2VuICpwcmVwcm9jZXNzKHN0
cnVjdCB0b2tlbiAqKTsKIAotc3RhdGljIGlubGluZSBpbnQgbWF0Y2hfb3Aoc3RydWN0IHRva2Vu
ICp0b2tlbiwgaW50IG9wKQorc3RhdGljIGlubGluZSBpbnQgbWF0Y2hfb3Aoc3RydWN0IHRva2Vu
ICp0b2tlbiwgdW5zaWduZWQgaW50IG9wKQogewogCXJldHVybiB0b2tlbi0+cG9zLnR5cGUgPT0g
VE9LRU5fU1BFQ0lBTCAmJiB0b2tlbi0+c3BlY2lhbCA9PSBvcDsKIH0KLS0gCjIuNy40Cgo=
--001a1144675e609451053eba168b--
