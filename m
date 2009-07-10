From: Christopher Li <sparse@chrisli.org>
Subject: Re: Multiple translation unit regression
Date: Fri, 10 Jul 2009 16:27:14 -0700
Message-ID: <70318cbf0907101627w1b9760a4oc7d13969751e3d00@mail.gmail.com>
References: <4A5131F4.7070007@ramsay1.demon.co.uk>
	 <70318cbf0907060232j7067f7fcra857b71ebdf62348@mail.gmail.com>
	 <70318cbf0907062327u51a4253fub2c0f1b2f64c1a@mail.gmail.com>
	 <4A54F452.8030601@ramsay1.demon.co.uk>
	 <70318cbf0907081315w1e066a1fiac24b1b58ef146bb@mail.gmail.com>
	 <4A57AA66.4080305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e647f026fb924a046e624f59
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f199.google.com ([209.85.212.199]:52158 "EHLO
	mail-vw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229AbZGJX1P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Jul 2009 19:27:15 -0400
Received: by vwj37 with SMTP id 37so1010803vwj.33
        for <linux-sparse@vger.kernel.org>; Fri, 10 Jul 2009 16:27:14 -0700 (PDT)
In-Reply-To: <4A57AA66.4080305@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

--0016e647f026fb924a046e624f59
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2009 at 1:53 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> w=
rote:
> =A0 =A011 =A0extern int g(int);
> =A0 =A012
> =A0 =A013 =A0extern __inline__ int
> =A0 =A014 =A0g(int x)
> =A0 =A015 =A0{
> =A0 =A016 =A0 =A0 =A0 =A0 =A0return x;
> =A0 =A017 =A0}
> =A0 =A018

Err, that is ugly. I just find out what happen there.
The none inline version picks up the function definition
from the inline version because they are both "extern".
Sparse only has one global extern scope.

Later even the inline version get remove from the
filescope, the second file still conflict with the non-inline
version of the function body, which steal from the inline
version.

I add two lines to distinguish the "extern inline" vs "extern".
They are not the same_symbol any more. Because effectly
the "extern inline" is not visiable in the global "extern" scope.
Any one see problem using this approach?

I attach the patch follows. Can you give it a try?

Chris

--0016e647f026fb924a046e624f59
Content-Type: application/octet-stream; name=extern-inline-1
Content-Disposition: attachment; filename=extern-inline-1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwz20m1k1

bW92ZSBleHRlcm4gaW5saW5lIGZ1bmN0aW9uIHRvIGZpbGUgc2NvcGUKCkluIGdjYyBleHRlcm4g
aW5saW5lIGZ1bmN0aW9uIGhhcyBzcGVjaWFsIG1lYW5pbmcuIFRoZSBpbmxpbmUKZnVuY3Rpb24g
d2lsbCBuZXZlciBlbWl0IHN0YW5kIGFsb25lIGNvcHkgb2YgdGhlIGZ1bmN0aW9uLiBJdCBhbHNv
CmFsbG93IG11bHRpcGxlIGltcGxlbWVudGF0aW9ucyBjcm9zcyBkaWZmZXJlbnQgZmlsZS4gVGhh
dCBlZmZlY3RpdmVseQptYWtlcyB0aGUgZXh0ZXJuIGlubGluZSBoYXMgZmlsZSBzY29wZS4KCklu
ZGV4OiBzcGFyc2UuY2hyaXNsL3N5bWJvbC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNwYXJzZS5jaHJpc2wu
b3JpZy9zeW1ib2wuaAorKysgc3BhcnNlLmNocmlzbC9zeW1ib2wuaApAQCAtMzQwLDYgKzM0MCwx
OCBAQCBzdGF0aWMgaW5saW5lIGludCBpc192b2lkX3R5cGUoc3RydWN0IHN5CiAJcmV0dXJuIHR5
cGUgPT0gJnZvaWRfY3R5cGU7CiB9CiAKK3N0YXRpYyBpbmxpbmUgaW50IGlzX2Z1bmN0aW9uKHN0
cnVjdCBzeW1ib2wgKnR5cGUpCit7CisJcmV0dXJuIHR5cGUgJiYgdHlwZS0+dHlwZSA9PSBTWU1f
Rk47Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IGlzX2V4dGVybl9pbmxpbmUoc3RydWN0IHN5bWJv
bCAqc3ltKQoreworCXJldHVybiAoc3ltLT5jdHlwZS5tb2RpZmllcnMgJiBNT0RfRVhURVJOKSAm
JgorCQkoc3ltLT5jdHlwZS5tb2RpZmllcnMgJiBNT0RfSU5MSU5FKSAmJgorCQlpc19mdW5jdGlv
bihzeW0tPmN0eXBlLmJhc2VfdHlwZSk7Cit9CisKIHN0YXRpYyBpbmxpbmUgaW50IGdldF9zeW1f
dHlwZShzdHJ1Y3Qgc3ltYm9sICp0eXBlKQogewogCWlmICh0eXBlLT50eXBlID09IFNZTV9OT0RF
KQpJbmRleDogc3BhcnNlLmNocmlzbC9ldmFsdWF0ZS5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNwYXJzZS5j
aHJpc2wub3JpZy9ldmFsdWF0ZS5jCisrKyBzcGFyc2UuY2hyaXNsL2V2YWx1YXRlLmMKQEAgLTUz
NiwxMSArNTM2LDYgQEAgc3RhdGljIGlubGluZSBpbnQgbHZhbHVlX2V4cHJlc3Npb24oc3RydQog
CXJldHVybiBleHByLT50eXBlID09IEVYUFJfUFJFT1AgJiYgZXhwci0+b3AgPT0gJyonOwogfQog
Ci1zdGF0aWMgaW5saW5lIGludCBpc19mdW5jdGlvbihzdHJ1Y3Qgc3ltYm9sICp0eXBlKQotewot
CXJldHVybiB0eXBlICYmIHR5cGUtPnR5cGUgPT0gU1lNX0ZOOwotfQotCiBzdGF0aWMgc3RydWN0
IHN5bWJvbCAqZXZhbHVhdGVfcHRyX2FkZChzdHJ1Y3QgZXhwcmVzc2lvbiAqZXhwciwgc3RydWN0
IHN5bWJvbCAqaXR5cGUpCiB7CiAJc3RydWN0IGV4cHJlc3Npb24gKmluZGV4ID0gZXhwci0+cmln
aHQ7CkluZGV4OiBzcGFyc2UuY2hyaXNsL3N5bWJvbC5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNwYXJzZS5j
aHJpc2wub3JpZy9zeW1ib2wuYworKysgc3BhcnNlLmNocmlzbC9zeW1ib2wuYwpAQCAtNTIyLDYg
KzUyMiw4IEBAIHZvaWQgY2hlY2tfZGVjbGFyYXRpb24oc3RydWN0IHN5bWJvbCAqc3kKIAkJCXJl
dHVybjsKIAkJfQogCQlpZiAoc3ltLT5jdHlwZS5tb2RpZmllcnMgJiBuZXh0LT5jdHlwZS5tb2Rp
ZmllcnMgJiBNT0RfRVhURVJOKSB7CisJCQlpZiAoKHN5bS0+Y3R5cGUubW9kaWZpZXJzIF4gbmV4
dC0+Y3R5cGUubW9kaWZpZXJzKSAmIE1PRF9JTkxJTkUpCisJCQkJY29udGludWU7CiAJCQlzeW0t
PnNhbWVfc3ltYm9sID0gbmV4dDsKIAkJCXJldHVybjsKIAkJfQpAQCAtNTU4LDggKzU2MCwxMCBA
QCB2b2lkIGJpbmRfc3ltYm9sKHN0cnVjdCBzeW1ib2wgKnN5bSwgc3RyCiAJc2NvcGUgPSBibG9j
a19zY29wZTsKIAlpZiAobnMgPT0gTlNfU1lNQk9MICYmIHRvcGxldmVsKHNjb3BlKSkgewogCQl1
bnNpZ25lZCBtb2QgPSBNT0RfQUREUkVTU0FCTEUgfCBNT0RfVE9QTEVWRUw7CisKIAkJc2NvcGUg
PSBnbG9iYWxfc2NvcGU7Ci0JCWlmIChzeW0tPmN0eXBlLm1vZGlmaWVycyAmIE1PRF9TVEFUSUMp
IHsKKwkJaWYgKHN5bS0+Y3R5cGUubW9kaWZpZXJzICYgTU9EX1NUQVRJQyB8fAorCQkgICAgaXNf
ZXh0ZXJuX2lubGluZShzeW0pKSB7CiAJCQlzY29wZSA9IGZpbGVfc2NvcGU7CiAJCQltb2QgPSBN
T0RfVE9QTEVWRUw7CiAJCX0KSW5kZXg6IHNwYXJzZS5jaHJpc2wvc2NvcGUuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
CkluZGV4OiBzcGFyc2UuY2hyaXNsL3ZhbGlkYXRpb24vZXh0ZXJuLWlubGluZS5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIHNwYXJzZS5jaHJpc2wub3JpZy92YWxpZGF0aW9uL2V4dGVybi1pbmxpbmUuYworKysg
c3BhcnNlLmNocmlzbC92YWxpZGF0aW9uL2V4dGVybi1pbmxpbmUuYwpAQCAtMCwwICsxLDIyIEBA
CitleHRlcm4gX19pbmxpbmVfXyBpbnQgZihpbnQpOworCitleHRlcm4gX19pbmxpbmVfXyBpbnQK
K2YoaW50IHgpCit7CisgICAgICAgIHJldHVybiB4OworfQorCitleHRlcm4gaW50IGcoaW50KTsK
KworZXh0ZXJuIF9faW5saW5lX18gaW50CitnKGludCB4KQoreworICAgICAgICByZXR1cm4geDsK
K30KKworCisvKgorICogY2hlY2stbmFtZTogZXh0ZXJuIGlubGluZSBmdW5jdGlvbgorICogY2hl
Y2stZGVzY3JpcHRpb246IEV4dGVybiBpbmxpbmUgZnVuY3Rpb24gbmV2ZXIgZW1pdHMgc3RhbmQg
YWxvbmUgY29weQorICogb2YgdGhlIGZ1bmN0aW9uLiBJdCBhbGxvd3MgbXVsdGlwbGUgc3VjaCBk
ZWZpbml0aW9ucyBpbiBkaWZmZXJlbnQgZmlsZS4KKyAqLwo=
--0016e647f026fb924a046e624f59--
