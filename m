From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cgcc and -Dx86_64
Date: Wed, 21 Dec 2016 09:13:07 -0800
Message-ID: <CA+55aFxawUQnNhuVMqLmXMJj1Kek6NruD2K27AN_cGqNLHi+hg@mail.gmail.com>
References: <13736b0d-b29a-0118-6846-f08bb3bb76f4@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c0775804b309805442e4427
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36268 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757659AbcLURNJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Dec 2016 12:13:09 -0500
Received: by mail-io0-f196.google.com with SMTP id b194so26327314ioa.3
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2016 09:13:09 -0800 (PST)
In-Reply-To: <13736b0d-b29a-0118-6846-f08bb3bb76f4@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

--94eb2c0775804b309805442e4427
Content-Type: text/plain; charset=UTF-8

On Wed, Dec 21, 2016 at 8:07 AM, Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> I was trying to run sparse against the upstream kpatch project and ran
> into problems with an include file that defined an "x86_64" variable:

Yeah,. that's bogus. It should be removed. It goes back to the
original x86-64 specific cgcc patch from 2007 (commit 0fcbcbf:
"Implement x86-64 support in cgcc").

It may be that old versions of gcc did the same, who knows. They
definitely don't any more, I checked:

  $ gcc -dM -E - < /dev/null | grep -v 'define __'

  #define _STDC_PREDEF_H 1
  #define unix 1
  #define linux 1
  #define _LP64 1

and so gcc itself definitely doesn't do the x86_64 thing (it does
pre-define versions with double underscores before and after):

  $ gcc -dM -E - < /dev/null | grep x86
  #define __x86_64 1
  #define __x86_64__ 1

> I can avoid this by renaming the structure member to something like
> "foo_x86_64".  I believe the problem stems from cgcc passing "-Dx86_64"
> to gcc... sparse later gets confused as there is now a preprocessor
> variable defined with the same name.

You shouldn't need that.

> We could s/x86_64/something_else/g across the whole project to avoid
> this glitch, but was wondering if there was a better way.

The fix it so just remove x86_64 from cgcc. It already does define the
underscored versions.

Same for the other architectures, for that matter. Obvios trivial (and
totally untested) patch attached.

              Linus

--94eb2c0775804b309805442e4427
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iwz76rb90

IGNnY2MgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NnY2MgYi9jZ2NjCmluZGV4IGQ3YjFjOTkuLmMyOWZh
NTggMTAwNzU1Ci0tLSBhL2NnY2MKKysrIGIvY2djYwpAQCAtMjUwLDI1ICsyNTAsMjUgQEAgc3Vi
IGFkZF9zcGVjcyB7CiAJICAgICIgLUQnX19mYXN0Y2FsbD1fX2F0dHJpYnV0ZV9fKChfX2Zhc3Rj
YWxsX18pKSciIC4KIAkgICAgIiAtRCdfX2RlY2xzcGVjKHgpPV9fYXR0cmlidXRlX18oKHgpKSci
OwogICAgIH0gZWxzaWYgKCRzcGVjIGVxICdpODYnKSB7Ci0JcmV0dXJuICgnIC1EaTM4Nj0xIC1E
X19pMzg2PTEgLURfX2kzODZfXz0xJyAuCisJcmV0dXJuICgnIC1EX19pMzg2PTEgLURfX2kzODZf
Xz0xJyAuCiAJCSZpbnRlZ2VyX3R5cGVzICg4LCAxNiwgMzIsICRtNjQgPyA2NCA6IDMyLCA2NCkg
LgogCQkmZmxvYXRfdHlwZXMgKDEsIDEsIDIxLCBbMjQsOF0sIFs1MywxMV0sIFs2NCwxNV0pIC4K
IAkJJmRlZmluZV9zaXplX3QgKCRtNjQgPyAibG9uZyB1bnNpZ25lZCBpbnQiIDogInVuc2lnbmVk
IGludCIpIC4KIAkJJyAtRF9fU0laRU9GX1BPSU5URVJfXz0nIC4gKCRtNjQgPyAnOCcgOiAnNCcp
KTsKICAgICB9IGVsc2lmICgkc3BlYyBlcSAnc3BhcmMnKSB7Ci0JcmV0dXJuICgnIC1Ec3BhcmM9
MSAtRF9fc3BhcmM9MSAtRF9fc3BhcmNfXz0xJyAuCisJcmV0dXJuICgnIC1EX19zcGFyYz0xIC1E
X19zcGFyY19fPTEnIC4KIAkJJmludGVnZXJfdHlwZXMgKDgsIDE2LCAzMiwgJG02NCA/IDY0IDog
MzIsIDY0KSAuCiAJCSZmbG9hdF90eXBlcyAoMSwgMSwgMzMsIFsyNCw4XSwgWzUzLDExXSwgWzEx
MywxNV0pIC4KIAkJJmRlZmluZV9zaXplX3QgKCRtNjQgPyAibG9uZyB1bnNpZ25lZCBpbnQiIDog
InVuc2lnbmVkIGludCIpIC4KIAkJJyAtRF9fU0laRU9GX1BPSU5URVJfXz0nIC4gKCRtNjQgPyAn
OCcgOiAnNCcpKTsKICAgICB9IGVsc2lmICgkc3BlYyBlcSAnc3BhcmM2NCcpIHsKLQlyZXR1cm4g
KCcgLURzcGFyYz0xIC1EX19zcGFyYz0xIC1EX19zcGFyY19fPTEgLURfX3NwYXJjdjlfXz0xIC1E
X19zcGFyYzY0X189MSAtRF9fYXJjaDY0X189MSAtRF9fTFA2NF9fPTEnIC4KKwlyZXR1cm4gKCcg
LURfX3NwYXJjPTEgLURfX3NwYXJjX189MSAtRF9fc3BhcmN2OV9fPTEgLURfX3NwYXJjNjRfXz0x
IC1EX19hcmNoNjRfXz0xIC1EX19MUDY0X189MScgLgogCQkmaW50ZWdlcl90eXBlcyAoOCwgMTYs
IDMyLCA2NCwgNjQsIDEyOCkgLgogCQkmZmxvYXRfdHlwZXMgKDEsIDEsIDMzLCBbMjQsOF0sIFs1
MywxMV0sIFsxMTMsMTVdKSAuCiAJCSZkZWZpbmVfc2l6ZV90ICgibG9uZyB1bnNpZ25lZCBpbnQi
KSAuCiAJCScgLURfX1NJWkVPRl9QT0lOVEVSX189OCcpOwogICAgIH0gZWxzaWYgKCRzcGVjIGVx
ICd4ODZfNjQnKSB7Ci0JcmV0dXJuICgnIC1EeDg2XzY0PTEgLURfX3g4Nl82ND0xIC1EX194ODZf
NjRfXz0xJyAuICgkbTMyID8gJycgOiAnIC1EX19MUDY0X189MScpIC4KKwlyZXR1cm4gKCcgLURf
X3g4Nl82ND0xIC1EX194ODZfNjRfXz0xJyAuICgkbTMyID8gJycgOiAnIC1EX19MUDY0X189MScp
IC4KIAkJJmludGVnZXJfdHlwZXMgKDgsIDE2LCAzMiwgJG0zMiA/IDMyIDogNjQsIDY0LCAxMjgp
IC4KIAkJJmZsb2F0X3R5cGVzICgxLCAxLCAzMywgWzI0LDhdLCBbNTMsMTFdLCBbMTEzLDE1XSkg
LgogCQkmZGVmaW5lX3NpemVfdCAoJG0zMiA/ICJ1bnNpZ25lZCBpbnQiIDogImxvbmcgdW5zaWdu
ZWQgaW50IikgLgo=
--94eb2c0775804b309805442e4427--
