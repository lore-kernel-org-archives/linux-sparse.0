From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 08:53:23 -0700
Message-ID: <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
References: <4E588EB8.80808@garzik.org> <201108271334.17659.kdudka@redhat.com>
 <CA+55aFzGViNgNO8rkv1kT8TZBXNWoJ8kMDHFormT_EzK3LGvZQ@mail.gmail.com> <4E590F22.6030800@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d64562b507a404ab7eaa34
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab1H0Pxs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 11:53:48 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7RFrkRG021444
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 08:53:47 -0700
Received: by wwf5 with SMTP id 5so4432016wwf.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 08:53:45 -0700 (PDT)
In-Reply-To: <4E590F22.6030800@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

--0016e6d64562b507a404ab7eaa34
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 27, 2011 at 8:37 AM, Jeff Garzik <jeff@garzik.org> wrote:
>
> On our point of view, we probably prefer to simply turn off as many
> transformations as possible. =A0They just waste time, when an optimizing =
LLVM
> backend is going to perform the same transformations anyway.

I disagree - mainly because I don't think we're interested in the back
end, are we?

If we were doing LLVM hacking, then I'd agree. But as it is, we're
supposed to improve sparse, not LLVM, so we should make sure that the
_sparse_ output makes sense, and LLVM is just a code generator, no?

Also, I suspect LLVM has an easier time of it if we were to generate
straightforward code rather than the extra basic blocks we do now.

So with the attached patch, your test-case turns into

  t.c:1:5: warning: symbol 'foo' was not declared. Should it be static?
  foo:
  .L0x7fc91affa010:
	<entry-point>
	phisrc.32   %phi2(x) <- %arg1
	phisrc.32   %phi4(x) <- %arg1
	phisrc.32   %phi6(i) <- $0
	br          .L0x7fc91affa058

  .L0x7fc91affa058:
	phi.32      %r3 <- %phi4(x), %phi5(x)
	add.32      %r5 <- %r3, $42
	phisrc.32   %phi3(x) <- %r5
	phisrc.32   %phi5(x) <- %r5
	phi.32      %r7 <- %phi6(i), %phi7(i)
	add.32      %r8 <- %r7, $1
	setlt.32    %r10 <- %r8, $10
	phisrc.32   %phi7(i) <- %r8
	br          %r10, .L0x7fc91affa058, .L0x7fc91affa130

  .L0x7fc91affa130:
	ret.32      %r3

which looks messy due to all the phi's (that we don't combine - the
patch includes Kamil's "don't combine" thing), but looks simpler
otherwise. Now sparse has optimized away the entry conditional (simply
because it got linearized separately and then the optimization was a
trivial constant one).

phi2/phi3 are both dead, but theor 'phisrc' instructions haven't been
killed. Ugly.

The attached patch is ENTIRELY UNTESTED. The only thing I tested it on
is your test-case. Running "make test" requires stuff that I don't
even have installed, and I'm lazy ;^o

                   Linus

--0016e6d64562b507a404ab7eaa34
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grurrqx10

IGNzZS5jICAgICAgIHwgICAgNyAtLS0tLS0tCiBsaW5lYXJpemUuYyB8ICAgMTQgKysrKystLS0t
LS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9jc2UuYyBiL2NzZS5jCmluZGV4IDJhMTU3NDUzMTk5My4uMmFhYmI2NTc4
NWYwIDEwMDY0NAotLS0gYS9jc2UuYworKysgYi9jc2UuYwpAQCAtMzE3LDEzICszMTcsNiBAQCBz
dGF0aWMgc3RydWN0IGluc3RydWN0aW9uICogdHJ5X3RvX2NzZShzdHJ1Y3QgZW50cnlwb2ludCAq
ZXAsIHN0cnVjdCBpbnN0cnVjdGlvbgogCWIyID0gaTItPmJiOwogCiAJLyoKLQkgKiBQSEktbm9k
ZXMgZG8gbm90IGNhcmUgd2hlcmUgdGhleSBhcmUgLSB0aGUgb25seSB0aGluZyB0aGF0IG1hdHRl
cnMKLQkgKiBhcmUgdGhlIFBISSBfc291cmNlc18uCi0JICovCi0JaWYgKGkxLT5vcGNvZGUgPT0g
T1BfUEhJKQotCQlyZXR1cm4gY3NlX29uZV9pbnN0cnVjdGlvbihpMSwgaTIpOwotCi0JLyoKIAkg
KiBDdXJyZW50bHkgd2Ugb25seSBoYW5kbGUgdGhlIHVuaW50ZXJlc3RpbmcgZGVnZW5lcmF0ZSBj
YXNlIHdoZXJlCiAJICogdGhlIENTRSBpcyBpbnNpZGUgb25lIGJhc2ljLWJsb2NrLgogCSAqLwpk
aWZmIC0tZ2l0IGEvbGluZWFyaXplLmMgYi9saW5lYXJpemUuYwppbmRleCBmMjAzNGNlOTM1NzIu
LjA2MTI4ZWQ1YjVlZSAxMDA2NDQKLS0tIGEvbGluZWFyaXplLmMKKysrIGIvbGluZWFyaXplLmMK
QEAgLTIwNjAsMTYgKzIwNjAsMTAgQEAgcHNldWRvX3QgbGluZWFyaXplX3N0YXRlbWVudChzdHJ1
Y3QgZW50cnlwb2ludCAqZXAsIHN0cnVjdCBzdGF0ZW1lbnQgKnN0bXQpCiAJCWNvbmNhdF9zeW1i
b2xfbGlzdChzdG10LT5pdGVyYXRvcl9zeW1zLCAmZXAtPnN5bXMpOwogCQlsaW5lYXJpemVfc3Rh
dGVtZW50KGVwLCBwcmVfc3RhdGVtZW50KTsKIAotIAkJbG9vcF9ib2R5ID0gbG9vcF90b3AgPSBh
bGxvY19iYXNpY19ibG9jayhlcCwgc3RtdC0+cG9zKTsKKwkJbG9vcF9ib2R5ID0gYWxsb2NfYmFz
aWNfYmxvY2soZXAsIHN0bXQtPnBvcyk7CiAgCQlsb29wX2NvbnRpbnVlID0gYWxsb2NfYmFzaWNf
YmxvY2soZXAsIHN0bXQtPnBvcyk7CiAgCQlsb29wX2VuZCA9IGFsbG9jX2Jhc2ljX2Jsb2NrKGVw
LCBzdG10LT5wb3MpOwogIAotCQkvKiBBbiBlbXB0eSBwb3N0LWNvbmRpdGlvbiBtZWFucyB0aGF0
IGl0J3MgdGhlIHNhbWUgYXMgdGhlIHByZS1jb25kaXRpb24gKi8KLQkJaWYgKCFwb3N0X2NvbmRp
dGlvbikgewotCQkJbG9vcF90b3AgPSBhbGxvY19iYXNpY19ibG9jayhlcCwgc3RtdC0+cG9zKTsK
LQkJCXNldF9hY3RpdmVibG9jayhlcCwgbG9vcF90b3ApOwotCQl9Ci0KIAkJaWYgKHByZV9jb25k
aXRpb24pIAogIAkJCWxpbmVhcml6ZV9jb25kX2JyYW5jaChlcCwgcHJlX2NvbmRpdGlvbiwgbG9v
cF9ib2R5LCBsb29wX2VuZCk7CiAKQEAgLTIwODIsMTAgKzIwNzYsMTIgQEAgcHNldWRvX3QgbGlu
ZWFyaXplX3N0YXRlbWVudChzdHJ1Y3QgZW50cnlwb2ludCAqZXAsIHN0cnVjdCBzdGF0ZW1lbnQg
KnN0bXQpCiAKIAkJc2V0X2FjdGl2ZWJsb2NrKGVwLCBsb29wX2NvbnRpbnVlKTsKIAkJbGluZWFy
aXplX3N0YXRlbWVudChlcCwgcG9zdF9zdGF0ZW1lbnQpOworCisJCS8qIE5vIHBvc3QtY29uZGl0
aW9uIG1lYW5zIHRoYXQgaXQncyB0aGUgc2FtZSBhcyB0aGUgcHJlLWNvbmRpdGlvbiAqLwogCQlp
ZiAoIXBvc3RfY29uZGl0aW9uKQotCQkJYWRkX2dvdG8oZXAsIGxvb3BfdG9wKTsKKwkJCWxpbmVh
cml6ZV9jb25kX2JyYW5jaChlcCwgcHJlX2NvbmRpdGlvbiwgbG9vcF9ib2R5LCBsb29wX2VuZCk7
CiAJCWVsc2UKLSAJCQlsaW5lYXJpemVfY29uZF9icmFuY2goZXAsIHBvc3RfY29uZGl0aW9uLCBs
b29wX3RvcCwgbG9vcF9lbmQpOworCQkJbGluZWFyaXplX2NvbmRfYnJhbmNoKGVwLCBwb3N0X2Nv
bmRpdGlvbiwgbG9vcF9ib2R5LCBsb29wX2VuZCk7CiAJCXNldF9hY3RpdmVibG9jayhlcCwgbG9v
cF9lbmQpOwogCQlicmVhazsKIAl9Cg==
--0016e6d64562b507a404ab7eaa34--
