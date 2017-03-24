From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v4 03/63] canonicalize compare instructions
Date: Fri, 24 Mar 2017 16:47:35 -0700
Message-ID: <CANeU7QnU-mdNq5MDXcu4-s3V85p2cjF-siSRULjZHD-AB+MxWA@mail.gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
 <20170321001607.75169-4-luc.vanoostenryck@gmail.com> <CANeU7Qkhygbv5xBHKicwJDRdDY-EJctauxvLoz33wZ_keeqXHQ@mail.gmail.com>
 <20170324081156.qhblvgndemthg7wf@macbook.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c0b91fc422762054b829e73
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37581 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdCXXri (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:47:38 -0400
Received: by mail-it0-f54.google.com with SMTP id 190so5338093itm.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:47:37 -0700 (PDT)
In-Reply-To: <20170324081156.qhblvgndemthg7wf@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

--94eb2c0b91fc422762054b829e73
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 24, 2017 at 1:11 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:


>
> Yes, indeed.
> In fact, I think it need a name which explain even more
> the purpose. I'll see.

Sure, I am open to suggestion.

BTW, the previous function is call compare_opcode() what
it actually do is invert_compare(). I would just move the inverse
test outside of this function and call it invert_compare() or
invert_compare_opcode()

> Yes, it's kinda ugly.
> OTOH, given that jumps are cheaper and cheaper on modern CPU
> and memory accesses slower and slower, is what you propose
> really an optimization? And even if it would, does it matter?

Well, jump through a indirect table is quit different than jump
to a fix offset. I don't know what modern CPU does now days. It
used to be indirect jump will flush the instruction pipe line.



>
> My preference, if performance mattered here, would be to play
> with the bits of the opcode, something like:
>         #define OP_SET__EQUAL   (1 << ...)
>         #define OP_SET__SIGNED  (1 << ...)
>         #define OP_SET__LTHAN   ...
>         #define OP_SET__GTHAN   ...
>
>         ...
>
>         int swap_compare_opcode(opcode) { return opcode ^= (OP_SET__LTHAN|OP_SET__GTHAN); }

That is ugly. I don't want that.

I cook up an untested patch include here to show what I have in mind.
It should be very close to your case statement way of writing it.  You are
welcome to change it.

Chris

--94eb2c0b91fc422762054b829e73
Content-Type: text/x-patch; charset=US-ASCII; name="swap_opcode.patch"
Content-Disposition: attachment; filename="swap_opcode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0oh51ig0

ZGlmZiAtLWdpdCBhL3NpbXBsaWZ5LmMgYi9zaW1wbGlmeS5jCmluZGV4IDNmMzk4MTkuLjZlMTEz
ZDkgMTAwNjQ0Ci0tLSBhL3NpbXBsaWZ5LmMKKysrIGIvc2ltcGxpZnkuYwpAQCAtNDM4LDIyICs0
MzgsMjQgQEAgc3RhdGljIGludCBjb21wYXJlX29wY29kZShpbnQgb3Bjb2RlLCBpbnQgaW52ZXJz
ZSkKIAogc3RhdGljIGludCBjb21wYXJlX3N3YXAoaW50IG9wY29kZSkKIHsKLQlzd2l0Y2ggKG9w
Y29kZSkgewotCWNhc2UgT1BfU0VUX0VROglyZXR1cm4gT1BfU0VUX0VROwotCWNhc2UgT1BfU0VU
X05FOglyZXR1cm4gT1BfU0VUX05FOwotCi0JY2FzZSBPUF9TRVRfTFQ6CXJldHVybiBPUF9TRVRf
R1Q7Ci0JY2FzZSBPUF9TRVRfTEU6CXJldHVybiBPUF9TRVRfR0U7Ci0JY2FzZSBPUF9TRVRfR1Q6
CXJldHVybiBPUF9TRVRfTFQ7Ci0JY2FzZSBPUF9TRVRfR0U6CXJldHVybiBPUF9TRVRfTEU7Ci0K
LQljYXNlIE9QX1NFVF9BOglyZXR1cm4gT1BfU0VUX0I7Ci0JY2FzZSBPUF9TRVRfQUU6CXJldHVy
biBPUF9TRVRfQkU7Ci0JY2FzZSBPUF9TRVRfQjoJcmV0dXJuIE9QX1NFVF9BOwotCWNhc2UgT1Bf
U0VUX0JFOglyZXR1cm4gT1BfU0VUX0FFOwotCWRlZmF1bHQ6Ci0JCXJldHVybiBvcGNvZGU7Ci0J
fQorCisjZGVmaW5lIENNUF9PRkZTRVQob3Bjb2RlKSAoKG9wY29kZSkgLSBPUF9CSU5DTVApCisJ
c3RhdGljIGNvbnN0IGludCBzd2FwX29wY29kZXNbQ01QX09GRlNFVChPUF9CSU5DTVBfRU5EKSAr
IDFdID0geworCQlbQ01QX09GRlNFVChPUF9TRVRfRVEpXSA9IE9QX1NFVF9FUSwKKwkJW0NNUF9P
RkZTRVQoT1BfU0VUX05FKV0gPSBPUF9TRVRfTkUsCisKKwkJW0NNUF9PRkZTRVQoT1BfU0VUX0xU
KV0gPSBPUF9TRVRfR1QsCisJCVtDTVBfT0ZGU0VUKE9QX1NFVF9HVCldID0gT1BfU0VUX0xULAor
CQlbQ01QX09GRlNFVChPUF9TRVRfTEUpXSA9IE9QX1NFVF9HRSwKKwkJW0NNUF9PRkZTRVQoT1Bf
U0VUX0dFKV0gPSBPUF9TRVRfTEUsCisKKwkJW0NNUF9PRkZTRVQoT1BfU0VUX0EpXSA9IE9QX1NF
VF9CLAorCQlbQ01QX09GRlNFVChPUF9TRVRfQildID0gT1BfU0VUX0EsCisJCVtDTVBfT0ZGU0VU
KE9QX1NFVF9BRSldID0gT1BfU0VUX0JFLAorCQlbQ01QX09GRlNFVChPUF9TRVRfQkUpXSA9IE9Q
X1NFVF9BRSwKKwl9OworCWFzc2VydChvcGNvZGUgPj0gT1BfQklOQ01QICYmIG9wY29kZSA8PSBP
UF9CSU5DTVBfRU5EKTsKKwlyZXR1cm4gc3dhcF9vcGNvZGVzW0NNUF9PRkZTRVQob3Bjb2RlKV07
CiB9CiAKIHN0YXRpYyBpbnQgc2ltcGxpZnlfc2V0ZXFfc2V0bmUoc3RydWN0IGluc3RydWN0aW9u
ICppbnNuLCBsb25nIGxvbmcgdmFsdWUpCg==
--94eb2c0b91fc422762054b829e73--
