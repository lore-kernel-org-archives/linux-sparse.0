From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] Null ctype should have ptr_ctype as its base type.
Date: Sun, 28 Dec 2008 12:52:59 -0800
Message-ID: <70318cbf0812281252m70c70493h507295316e6621df@mail.gmail.com>
References: <20081225182817.26024.19045.stgit@zaytsev.su>
	 <20081228151134.6062.83633.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_120082_23531105.1230497579625"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:34039 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbYL1UxA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Dec 2008 15:53:00 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4145012rvb.1
        for <linux-sparse@vger.kernel.org>; Sun, 28 Dec 2008 12:52:59 -0800 (PST)
In-Reply-To: <20081228151134.6062.83633.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-sparse@vger.kernel.org, Tommy Thorn <tommy@numba-tu.com>

------=_Part_120082_23531105.1230497579625
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, Dec 28, 2008 at 7:14 AM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:

> So, we are getting a sizeof(NULL), or a sizeof((void *)0). It triggers here

That is my fault. My test for void type should have been more careful.

> because we are getting a null_ctype, and it's base_type points to
> void_ctype. I'm not sure if this patch is correct, but it seems to do
> the trick, all void warnings are gone. Christopher?

No, that is not the right way to fix it. Now you declare NULL as pointer
to a pointer type "(void**) 0".

Thanks for finding it out. Does my patch work for you?

Chris

------=_Part_120082_23531105.1230497579625
Content-Type: application/octet-stream;
 name=0001-Correct-testing-for-void-type.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fpa6b71c0
Content-Disposition: attachment;
 filename=0001-Correct-testing-for-void-type.patch

RnJvbSBhN2I1ZGU5MGVhM2VhODQ4NTg4MmJhMzQ4YjA0NTI3OTcwOWJkNmQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBTdW4sIDI4IERlYyAyMDA4IDEyOjMxOjUwIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gQ29y
cmVjdCB0ZXN0aW5nIGZvciB2b2lkIHR5cGUuCgpUaGUgbGFzdCBzaXplb2Yodm9pZCkgd2Fybmlu
ZyBjb21taXQgdG9vIGVhZ2VyIHRvCmRlY2xhcmUgdHlwZSBpcyB2b2lkLiBJdCBlbmQgdXAgc2l6
ZW9mKE5VTEwpID09IDEKYXMgd2VsbC4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waGVyIExpIDxz
cGFyc2VAY2hyaXNsaS5vcmc+Ci0tLQogZXZhbHVhdGUuYyB8ICAgMTEgKysrKysrKysrLS0KIDEg
ZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2V2YWx1YXRlLmMgYi9ldmFsdWF0ZS5jCmluZGV4IGQ5OWQzNGYuLjJmZmY0NmUgMTAwNjQ0
Ci0tLSBhL2V2YWx1YXRlLmMKKysrIGIvZXZhbHVhdGUuYwpAQCAtMzM3LDYgKzMzNywxMyBAQCBz
dGF0aWMgaW5saW5lIGludCBpc19ieXRlX3R5cGUoc3RydWN0IHN5bWJvbCAqdHlwZSkKIAlyZXR1
cm4gdHlwZS0+Yml0X3NpemUgPT0gYml0c19pbl9jaGFyICYmIHR5cGUtPnR5cGUgIT0gU1lNX0JJ
VEZJRUxEOwogfQogCitzdGF0aWMgaW5saW5lIGludCBpc192b2lkX3R5cGUoc3RydWN0IHN5bWJv
bCAqdHlwZSkKK3sKKwlpZiAodHlwZS0+dHlwZSA9PSBTWU1fTk9ERSkKKwkJdHlwZSA9IHR5cGUt
PmN0eXBlLmJhc2VfdHlwZTsKKwlyZXR1cm4gdHlwZSA9PSAmdm9pZF9jdHlwZTsKK30KKwogZW51
bSB7CiAJVFlQRV9OVU0gPSAxLAogCVRZUEVfQklURklFTEQgPSAyLApAQCAtNTg0LDcgKzU5MSw3
IEBAIHN0YXRpYyBzdHJ1Y3Qgc3ltYm9sICpldmFsdWF0ZV9wdHJfYWRkKHN0cnVjdCBleHByZXNz
aW9uICpleHByLCBzdHJ1Y3Qgc3ltYm9sICppCiAJfQogCiAJLyogR2V0IHRoZSBzaXplIG9mIHdo
YXRldmVyIHRoZSBwb2ludGVyIHBvaW50cyB0byAqLwotCW11bHRpcGx5ID0gKGJhc2UgPT0gJnZv
aWRfY3R5cGUpID8gMSA6IGJpdHNfdG9fYnl0ZXMoYmFzZS0+Yml0X3NpemUpOworCW11bHRpcGx5
ID0gaXNfdm9pZF90eXBlKGJhc2UpID8gMSA6IGJpdHNfdG9fYnl0ZXMoYmFzZS0+Yml0X3NpemUp
OwogCiAJaWYgKGN0eXBlID09ICZudWxsX2N0eXBlKQogCQljdHlwZSA9ICZwdHJfY3R5cGU7CkBA
IC0yMDUwLDcgKzIwNTcsNyBAQCBzdGF0aWMgc3RydWN0IHN5bWJvbCAqZXZhbHVhdGVfc2l6ZW9m
KHN0cnVjdCBleHByZXNzaW9uICpleHByKQogCiAJc2l6ZSA9IHR5cGUtPmJpdF9zaXplOwogCi0J
aWYgKHR5cGUtPmN0eXBlLmJhc2VfdHlwZSA9PSAmdm9pZF9jdHlwZSkgeworCWlmIChzaXplIDwg
MCAmJiBpc192b2lkX3R5cGUodHlwZSkpIHsKIAkJd2FybmluZyhleHByLT5wb3MsICJleHByZXNz
aW9uIHVzaW5nIHNpemVvZih2b2lkKSIpOwogCQlzaXplID0gYml0c19pbl9jaGFyOwogCX0KLS0g
CjEuNi4wLjYKCg==
------=_Part_120082_23531105.1230497579625--
