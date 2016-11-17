From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/5] testsuite: report as error tests known to fail but
 which succeed
Date: Fri, 18 Nov 2016 00:13:58 +0800
Message-ID: <CANeU7QnHYuW7-h+wKFcQZe=6xNUZgNdSAtLnqdAm=OBNARvR-Q@mail.gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com> <20161102214509.36571-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113f732a192b460541817a74
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35027 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934401AbcKQRI2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:08:28 -0500
Received: by mail-it0-f65.google.com with SMTP id b123so16515900itb.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:08:28 -0800 (PST)
In-Reply-To: <20161102214509.36571-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

--001a113f732a192b460541817a74
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 3, 2016 at 5:45 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Such situation may simply show that what was tested is now fixed
> and that it's juste the test annotation which need to be adapted,
> but can be a sign that something else is broken.
>
> Reporting the exact result (failure/success, known-to-fail/expect-to-succeed)
> make the testsuite more useful and allow to use more efficiently
> git-bisect or other automated testing tools.

I like what you are doing as a result.

But I think the implementation has room to improve.
I don't like deep and messy "else" statement.

I attach a patch which I modify base on yours. I hope it is
easier to read. Care to review it?

Chris

--001a113f732a192b460541817a74
Content-Type: text/x-patch; charset=US-ASCII; name="known-to-fail.patch"
Content-Disposition: attachment; filename="known-to-fail.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivmjxzll0

LS0tIC5wYy85NDA5OTE5LTMtNS10ZXN0c3VpdGUtcmVwb3J0LWFzLWVycm9yLXRlc3RzLWtub3du
LXRvLWZhaWwtYnV0LXdoaWNoLXN1Y2NlZWQucGF0Y2gvdmFsaWRhdGlvbi90ZXN0LXN1aXRlCTIw
MTYtMTAtMjQgMTc6Mzc6MjkuMzAzODQ2MDAwICswODAwCisrKyB2YWxpZGF0aW9uL3Rlc3Qtc3Vp
dGUJMjAxNi0xMS0xNyAyMzo1NjozNS40MDQzOTI0NTQgKzA4MDAKQEAgLTE2MSwxOCArMTYxLDI1
IEBAIGRvX3Rlc3QoKQogCQl0ZXN0X2ZhaWxlZD0xCiAJZmkKIAotCWlmIFsgIiR0ZXN0X2ZhaWxl
ZCIgLWVxICIxIiBdOyB0aGVuCi0JCWtvX3Rlc3RzPWBleHByICRrb190ZXN0cyArIDFgCi0JCWdl
dF90YWcgImNoZWNrLWtub3duLXRvLWZhaWwiICRmaWxlCi0JCWlmIFsgIiQ/IiAtZXEgIjAiIF07
IHRoZW4KKwlnZXRfdGFnICJjaGVjay1rbm93bi10by1mYWlsIiAkZmlsZQorCW11c3RfZmFpbD1g
ZXhwciAiJD8iID0gMGAKKwlrbm93bl9rb190ZXN0cz1gZXhwciAka25vd25fa29fdGVzdHMgKyAk
bXVzdF9mYWlsYAorCisJaWYgWyAiJG11c3RfZmFpbCIgLWVxICIxIiBdOyB0aGVuCisJCWlmIFsg
IiR0ZXN0X2ZhaWxlZCIgLWVxICIxIiBdOyB0aGVuCiAJCQllY2hvICJpbmZvOiB0ZXN0ICckZmls
ZScgaXMga25vd24gdG8gZmFpbCIKLQkJCWtub3duX2tvX3Rlc3RzPWBleHByICRrbm93bl9rb190
ZXN0cyArIDFgCisJCWVsc2UKKwkJCWVjaG8gImluZm86IHRlc3QgJyRmaWxlJyBpcyBrbm93biB0
byBmYWlsIGJ1dCBzdWNjZWVkISIKKwkJCXRlc3RfZmFpbGVkPTEKIAkJZmkKLQkJcmV0dXJuIDEK
KwlmaQorCisJaWYgWyAiJHRlc3RfZmFpbGVkIiAtZXEgIjEiIF07IHRoZW4KKwkJa29fdGVzdHM9
YGV4cHIgJGtvX3Rlc3RzICsgMWAKIAllbHNlCiAJCW9rX3Rlc3RzPWBleHByICRva190ZXN0cyAr
IDFgCi0JCXJldHVybiAwCiAJZmkKKwlyZXR1cm4gJHRlc3RfZmFpbGVkCiB9CiAKIGRvX3Rlc3Rf
c3VpdGUoKQo=
--001a113f732a192b460541817a74--
