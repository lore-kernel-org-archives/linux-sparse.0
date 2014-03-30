From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Use any previous initializer to size a symbol
Date: Sun, 30 Mar 2014 11:38:39 -0700
Message-ID: <CA+55aFy=Y_xOBdQFdhgvadEpmSFp85FiPQZc8VTKBkDO=WLhgA@mail.gmail.com>
References: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c3cec05c9dc504f5d73e67
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:32862 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaC3Sik (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Mar 2014 14:38:40 -0400
Received: by mail-vc0-f174.google.com with SMTP id ld13so7430757vcb.19
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 11:38:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

--001a11c3cec05c9dc504f5d73e67
Content-Type: text/plain; charset=UTF-8

On Sun, Mar 30, 2014 at 10:22 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This seems to be the simplest approach. Chris, what was your concern about
> scoping? The "same_symbol" list should already take scoping into account.

Ho humm. I found a test-case that still messes up:

  extern const char *v4l2_type_names[];
  const char *v4l2_type_names[] = {
    "test", "hello"
  };

  static unsigned test(void)
  {
    extern const char *v4l2_type_names[];
    return sizeof(v4l2_type_names);
  }

and the reason seems to be that the 'same_symbol' list is incomplete.

What happen sis that we tie the two "extern" v4l2_type_names[] things
together, and the declaration of v4l2_type_names[] with the
initializer is also tied to the first 'extern' declaration, but we do
*not* tie the second 'extern' in block scope to the one with the
initializer.

The reason seems to be that our logic in check_declaration[] is
broken: it only ties things together based on both symbols having
'extern'. So the actual declaration with an initializer, that lacks
the extern (but is in global scope) is missed.

The attached patch would seem to fix it. Chris, what is the reason for
that MOD_INLINE check? You added it in commit 8cf99394ee4c ("move
extern inline function to file scope") and I suspect it messes up the
same_symbol logic. But I left it alone, and added a comment. If you
can resolve that comment, please apply this patch with my sign-off and
some random commit message..

                      Linus

--001a11c3cec05c9dc504f5d73e67
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hteo8ke40

IHN5bWJvbC5jIHwgMTQgKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3ltYm9sLmMgYi9zeW1ib2wuYwpp
bmRleCA0YjkxYWJkODAyMWUuLmM1ZTQ3ODQ3MzRhOCAxMDA2NDQKLS0tIGEvc3ltYm9sLmMKKysr
IGIvc3ltYm9sLmMKQEAgLTU3NiwxMSArNTc2LDE1IEBAIHZvaWQgY2hlY2tfZGVjbGFyYXRpb24o
c3RydWN0IHN5bWJvbCAqc3ltKQogCQkJc3ltLT5zYW1lX3N5bWJvbCA9IG5leHQ7CiAJCQlyZXR1
cm47CiAJCX0KLQkJaWYgKHN5bS0+Y3R5cGUubW9kaWZpZXJzICYgbmV4dC0+Y3R5cGUubW9kaWZp
ZXJzICYgTU9EX0VYVEVSTikgewotCQkJaWYgKChzeW0tPmN0eXBlLm1vZGlmaWVycyBeIG5leHQt
PmN0eXBlLm1vZGlmaWVycykgJiBNT0RfSU5MSU5FKQotCQkJCWNvbnRpbnVlOwotCQkJc3ltLT5z
YW1lX3N5bWJvbCA9IG5leHQ7Ci0JCQlyZXR1cm47CisJCS8qIEV4dGVybiBpbiBibG9jayBsZXZl
bCBtYXRjaGVzIGEgVE9QTEVWRUwgbm9uLXN0YXRpYyBzeW1ib2wgKi8KKwkJaWYgKHN5bS0+Y3R5
cGUubW9kaWZpZXJzICYgTU9EX0VYVEVSTikgeworCQkJaWYgKChuZXh0LT5jdHlwZS5tb2RpZmll
cnMgJiAoTU9EX1RPUExFVkVMfE1PRF9TVEFUSUMpKSA9PSBNT0RfVE9QTEVWRUwpIHsKKwkJCQkv
KiBGSVhNRT8gRGlmZmVycyBpbiAnaW5saW5lJyBvbmx5PyBXaHkgZG9lcyB0aGF0IG1hdHRlcj8g
Ki8KKwkJCQlpZiAoKHN5bS0+Y3R5cGUubW9kaWZpZXJzIF4gbmV4dC0+Y3R5cGUubW9kaWZpZXJz
KSAmIE1PRF9JTkxJTkUpCisJCQkJCWNvbnRpbnVlOworCQkJCXN5bS0+c2FtZV9zeW1ib2wgPSBu
ZXh0OworCQkJCXJldHVybjsKKwkJCX0KIAkJfQogCiAJCWlmICghV3NoYWRvdyB8fCB3YXJuZWQp
Cg==
--001a11c3cec05c9dc504f5d73e67--
