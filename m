From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Fri, 1 Aug 2014 18:16:08 -0700
Message-ID: <CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1133614e2683ab04ff9b40e6
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:42025 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaHBBQJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Aug 2014 21:16:09 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so7979573vcb.1
        for <linux-sparse@vger.kernel.org>; Fri, 01 Aug 2014 18:16:08 -0700 (PDT)
In-Reply-To: <CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Chris Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

--001a1133614e2683ab04ff9b40e6
Content-Type: text/plain; charset=UTF-8

On Thu, Jul 31, 2014 at 7:41 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. It exposes other problems.
>
> For example, the fact that we look up the identifier now exposes the
> fact that "first_subobject()" creates this dummy "EXPR_IDENTIFIER"
> expression that has no identifier. That will then cause
> "find_identifier()" to fail, which in turn causes convert_ident() to
> fail. Resulting in the parse tree having remaining EXPR_IDENTIFIER
> nodes, which will later result in "unknown expression (25,0)" errors.
>
> That's easy enough to fix with just adding the proper initializer, ie
>
>     new->expr_ident = field->ident;
>
> to first_subobject().

Actually, sadly, while that worked for my test-cases (and for Josh's
case), it turns out to really *not* work in general: the dummy
EXPR_IDENTIFIER that we create may end up referring to a unnamed
union, which doesn't *have* an ident associated with it.

This only really triggers when you mix named initializers with then
relying on the whole "initialize the next one without a name", but
that does happen. And it fundamentally breaks that whole "use
find_identifier()" approach.

So convert_ident() really cannot use find_indent(), and really does
have to use "sym->offset". But that doesn't work for anonymous union
members, because that offset was the offset within the anonymous
union, not the parent structure.

However, the fix is "simple". We can just say that anonymous
union/structure member offsets have to be the offsets within the
parent union instead, and fix things up. So how about a patch like
this *instead* of the previous patch..

                 Linus

--001a1133614e2683ab04ff9b40e6
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hyc91eyk0

IGV2YWx1YXRlLmMgfCAgMiArLQogc3ltYm9sLmMgICB8IDE2ICsrKysrKysrKysrKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2V2YWx1YXRlLmMgYi9ldmFsdWF0ZS5jCmluZGV4IDAzOTkyZDAzYWUxZC4uNzgxNTBmODNh
MTlmIDEwMDY0NAotLS0gYS9ldmFsdWF0ZS5jCisrKyBiL2V2YWx1YXRlLmMKQEAgLTE4OTgsNyAr
MTg5OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3ltYm9sICpmaW5kX2lkZW50aWZpZXIoc3RydWN0IGlk
ZW50ICppZGVudCwgc3RydWN0IHN5bWJvbF9saXN0ICpfCiAJCQkJc3ViID0gZmluZF9pZGVudGlm
aWVyKGlkZW50LCBjdHlwZS0+c3ltYm9sX2xpc3QsIG9mZnNldCk7CiAJCQkJaWYgKCFzdWIpCiAJ
CQkJCWNvbnRpbnVlOwotCQkJCSpvZmZzZXQgKz0gc3ltLT5vZmZzZXQ7CisJCQkJKm9mZnNldCA9
IHN5bS0+b2Zmc2V0OwogCQkJCXJldHVybiBzdWI7CiAJCQl9CQogCQl9CmRpZmYgLS1naXQgYS9z
eW1ib2wuYyBiL3N5bWJvbC5jCmluZGV4IGEyNzMxMzQ4YTAxMS4uMzJhZjY0MDUwYTY0IDEwMDY0
NAotLS0gYS9zeW1ib2wuYworKysgYi9zeW1ib2wuYwpAQCAtMTE2LDYgKzExNiwxOCBAQCBzdGF0
aWMgaW50IGJpdGZpZWxkX2Jhc2Vfc2l6ZShzdHJ1Y3Qgc3ltYm9sICpzeW0pCiAJcmV0dXJuIHN5
bS0+Yml0X3NpemU7CiB9CiAKK3N0YXRpYyB2b2lkIHVwZGF0ZV9zeW1ib2xfb2Zmc2V0cyhzdHJ1
Y3Qgc3ltYm9sICpzeW0sIHVuc2lnbmVkIGludCBvZmZzZXQpCit7CisJc3RydWN0IHN5bWJvbCAq
ZmllbGQ7CisKKwlpZiAoc3ltLT50eXBlICE9IFNZTV9TVFJVQ1QgJiYgc3ltLT50eXBlICE9IFNZ
TV9VTklPTikKKwkJcmV0dXJuOworCUZPUl9FQUNIX1BUUihzeW0tPnN5bWJvbF9saXN0LCBmaWVs
ZCkgeworCQlmaWVsZC0+b2Zmc2V0ICs9IG9mZnNldDsKKwkJdXBkYXRlX3N5bWJvbF9vZmZzZXRz
KGZpZWxkLCBvZmZzZXQpOworCX0gRU5EX0ZPUl9FQUNIX1BUUihmaWVsZCk7Cit9CisKIC8qCiAg
KiBTdHJ1Y3R1cmVzIGFyZSBhIGJpdCBtb3JlIGludGVyZXN0aW5nIHRvIGxheSBvdXQKICAqLwpA
QCAtMTc0LDYgKzE4NiwxMCBAQCBzdGF0aWMgdm9pZCBsYXlfb3V0X3N0cnVjdChzdHJ1Y3Qgc3lt
Ym9sICpzeW0sIHN0cnVjdCBzdHJ1Y3RfdW5pb25faW5mbyAqaW5mbykKIAliaXRfc2l6ZSA9IChi
aXRfc2l6ZSArIGFsaWduX2JpdF9tYXNrKSAmIH5hbGlnbl9iaXRfbWFzazsKIAlzeW0tPm9mZnNl
dCA9IGJpdHNfdG9fYnl0ZXMoYml0X3NpemUpOwogCisJLyogSWYgaXQncyBhbiB1bm5hbWVkIHN0
cnVjdCBvciB1bmlvbiwgdXBkYXRlIHRoZSBvZmZzZXRzIG9mIHRoZSBzdWItbWVtYmVycyAqLwor
CWlmIChzeW0tPm9mZnNldCAmJiAhc3ltLT5pZGVudCkKKwkJdXBkYXRlX3N5bWJvbF9vZmZzZXRz
KHN5bSwgc3ltLT5vZmZzZXQpOworCiAJaW5mby0+Yml0X3NpemUgPSBiaXRfc2l6ZSArIGJhc2Vf
c2l6ZTsKIAkvLyB3YXJuaW5nIChzeW0tPnBvcywgInJlZ3VsYXI6IG9mZnNldD0lZCIsIHN5bS0+
b2Zmc2V0KTsKIH0K
--001a1133614e2683ab04ff9b40e6--
