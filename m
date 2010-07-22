From: Chris Li <christ.li@gmail.com>
Subject: Re: Bogus warning when comparing nocast short variables
Date: Thu, 22 Jul 2010 15:35:01 -0700
Message-ID: <AANLkTimxVUO9UNbv6rgKgiukDbCTzMeaKEAoVD7FAt1T@mail.gmail.com>
References: <1279731062.9003.15.camel@mj>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0022152d7c8f637a5c048c018786
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56138 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab0GVWfB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Jul 2010 18:35:01 -0400
Received: by iwn7 with SMTP id 7so8242480iwn.19
        for <linux-sparse@vger.kernel.org>; Thu, 22 Jul 2010 15:35:01 -0700 (PDT)
In-Reply-To: <1279731062.9003.15.camel@mj>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

--0022152d7c8f637a5c048c018786
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 21, 2010 at 9:51 AM, Pavel Roskin <proski@gnu.org> wrote:
> Hello!
>
> This test file causes a warning:
>
> typedef short __attribute__((nocast)) u16;
> int main(int argc, char **argv)
> {
> =A0 =A0 =A0 =A0u16 i =3D (u16)argc;
> =A0 =A0 =A0 =A0u16 j =3D (u16)2;
> =A0 =A0 =A0 =A0return (i =3D=3D j);
> }
>
> $ sparse test1.c
> test1.c:6:17: warning: implicit cast from nocast type
> test1.c:6:22: warning: implicit cast from nocast type

The warning come from the implicit cast in the compare
expression. It try to cast "i" and "j" into "int" type before the
compare.

The following patch allow the test-inspect to show the cast
expression.

No patch for the fix yet.

Chris

--0022152d7c8f637a5c048c018786
Content-Type: application/octet-stream; name="inspect-cast.patch"
Content-Disposition: attachment; filename="inspect-cast.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gby5n9k10

ZGlmZiAtLWdpdCBhL2FzdC1pbnNwZWN0LmMgYi9hc3QtaW5zcGVjdC5jCmluZGV4IDI5MzMzNGUu
LjUzNjNkZTMgMTAwNjQ0Ci0tLSBhL2FzdC1pbnNwZWN0LmMKKysrIGIvYXN0LWluc3BlY3QuYwpA
QCAtNjYsNiArNjYsMTIgQEAgdm9pZCBpbnNwZWN0X3N0YXRlbWVudChBc3ROb2RlICpub2RlKQog
CQkJYXN0X2FwcGVuZF9jaGlsZChub2RlLCAicG9zdF9zdGF0ZW1lbnQ6Iiwgc3RtdC0+aXRlcmF0
b3JfcG9zdF9zdGF0ZW1lbnQsCiAJCQkJCSBpbnNwZWN0X3N0YXRlbWVudCk7CiAJCQlicmVhazsK
KworCQljYXNlIFNUTVRfUkVUVVJOOgorCQkJYXN0X2FwcGVuZF9jaGlsZChub2RlLCAicmV0X3Zh
bHVlOiIsIHN0bXQtPnJldF92YWx1ZSwgaW5zcGVjdF9leHByZXNzaW9uKTsKKwkJCWFzdF9hcHBl
bmRfY2hpbGQobm9kZSwgInJldF90YXJnZXQ6Iiwgc3RtdC0+cmV0X3RhcmdldCwgaW5zcGVjdF9z
eW1ib2wpOworCQkJYnJlYWs7CisKIAkJZGVmYXVsdDoKIAkJCWJyZWFrOwogCX0KQEAgLTEwOSw3
ICsxMTUsNyBAQCB2b2lkIGluc3BlY3Rfc3ltYm9sKEFzdE5vZGUgKm5vZGUpCiB7CiAJc3RydWN0
IHN5bWJvbCAqc3ltID0gbm9kZS0+cHRyOwogCW5vZGUtPnRleHQgPSBnX3N0cmR1cF9wcmludGYo
IiVzICVzOiAlcyIsIG5vZGUtPnRleHQsIHN5bWJvbF90eXBlX25hbWUoc3ltLT50eXBlKSwKLQkJ
CQkgICAgICBzaG93X2lkZW50KHN5bS0+aWRlbnQpKTsKKwkJCQkgICAgICBidWlsdGluX3R5cGVu
YW1lKHN5bSkgPzogc2hvd19pZGVudChzeW0tPmlkZW50KSk7CiAJYXN0X2FwcGVuZF9jaGlsZChu
b2RlLCAiY3R5cGUuYmFzZV90eXBlOiIsIHN5bS0+Y3R5cGUuYmFzZV90eXBlLGluc3BlY3Rfc3lt
Ym9sKTsKIAogCXN3aXRjaCAoc3ltLT50eXBlKSB7CkBAIC0xODEsNiArMTg3LDE4IEBAIHZvaWQg
aW5zcGVjdF9leHByZXNzaW9uKEFzdE5vZGUgKm5vZGUpCiAJCQlhc3RfYXBwZW5kX2NoaWxkKG5v
ZGUsICJsZWZ0OiIsIGV4cHItPmxlZnQsIGluc3BlY3RfZXhwcmVzc2lvbik7CiAJCQlhc3RfYXBw
ZW5kX2NoaWxkKG5vZGUsICJyaWdodDoiLCBleHByLT5yaWdodCwgaW5zcGVjdF9leHByZXNzaW9u
KTsKIAkJCWJyZWFrOworCisJCWNhc2UgRVhQUl9DQVNUOgorCQljYXNlIEVYUFJfRk9SQ0VfQ0FT
VDoKKwkJY2FzZSBFWFBSX0lNUExJRURfQ0FTVDoKKwkJCWFzdF9hcHBlbmRfY2hpbGQobm9kZSwg
ImNhc3RfdHlwZToiLCBleHByLT5jYXN0X3R5cGUsIGluc3BlY3Rfc3ltYm9sKTsKKwkJCWFzdF9h
cHBlbmRfY2hpbGQobm9kZSwgImNhc3RfZXhwcmVzc2lvbjoiLCBleHByLT5jYXN0X2V4cHJlc3Np
b24sIGluc3BlY3RfZXhwcmVzc2lvbik7CisJCQlicmVhazsKKworCQljYXNlIEVYUFJfUFJFT1A6
CisJCQlhc3RfYXBwZW5kX2NoaWxkKG5vZGUsICJ1bm9wOiIsIGV4cHItPnVub3AsIGluc3BlY3Rf
ZXhwcmVzc2lvbik7CisJCQlicmVhazsKKwkJCiAJCWRlZmF1bHQ6CiAJCQlicmVhazsKIAl9Cg==
--0022152d7c8f637a5c048c018786--
