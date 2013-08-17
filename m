From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 09:16:54 -0700
Message-ID: <CA+55aFxeSzQuF7RR5jDcwwGeL0XFTRsLWe+X0=ybVPAsAkggBA@mail.gmail.com>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e016341aa1a2da704e427094d
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:51074 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab3HQQQz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 12:16:55 -0400
In-Reply-To: <nsxtxio1jeh.fsf@lambda.thunk.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Theodore Ts'o <tytso@thunk.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

--089e016341aa1a2da704e427094d
Content-Type: text/plain; charset=UTF-8

On Sat, Aug 17, 2013 at 7:28 AM, Theodore Ts'o <tytso@thunk.org> wrote:
>
> It apparently has something to do with rcu and "address spaces" but I'm
> not completely sure what sparse is complaining about --- and whether it
> is a false positive or a bug in the posix_acl.h.

So rcu_assign_pointer() wants the destination to be a pointer to
something in the "__rcu" address space, but here "p" is just a normal
kernel pointer (it's a pointer to a regular "struct posix_acl *").

(The unreadable "asn:4" comes from the fact that sparse only has a
generic notion of address spaces, where address space zero is the
"normal" C pointer address space, and then you can just make up your
own ones by number. It was initially done for just "user space", but
designed so that it could be extended to other things, and "rcu space"
was another later use for checking certain pointer semantics).

I guess we should mark i_acl and i_defauly_acl to be RCU-accessed, and
then annotate all the accesses properly.

The attached patch does so, but I only compile-tested that one file
(fs/ext4/acl.c), so it will quite possible cause tons of new warnings
elsewhere. But I'm hoping the patch at least illustrates the concept.

               Linus

--089e016341aa1a2da704e427094d
Content-Type: application/octet-stream; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkh13gee0

IGluY2x1ZGUvbGludXgvZnMuaCAgICAgICAgfCAgNCArKy0tCiBpbmNsdWRlL2xpbnV4L3Bvc2l4
X2FjbC5oIHwgMTggKysrKysrKysrKy0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMu
aCBiL2luY2x1ZGUvbGludXgvZnMuaAppbmRleCA5ODE4NzQ3NzNlODUuLjg4M2MwNzA2ODQ4NSAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oCisrKyBiL2luY2x1ZGUvbGludXgvZnMuaApA
QCAtNTI4LDggKzUyOCw4IEBAIHN0cnVjdCBpbm9kZSB7CiAJdW5zaWduZWQgaW50CQlpX2ZsYWdz
OwogCiAjaWZkZWYgQ09ORklHX0ZTX1BPU0lYX0FDTAotCXN0cnVjdCBwb3NpeF9hY2wJKmlfYWNs
OwotCXN0cnVjdCBwb3NpeF9hY2wJKmlfZGVmYXVsdF9hY2w7CisJc3RydWN0IHBvc2l4X2FjbCBf
X3JjdQkqaV9hY2w7CisJc3RydWN0IHBvc2l4X2FjbCBfX3JjdQkqaV9kZWZhdWx0X2FjbDsKICNl
bmRpZgogCiAJY29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlvbnMJKmlfb3A7CmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3Bvc2l4X2FjbC5oIGIvaW5jbHVkZS9saW51eC9wb3NpeF9hY2wuaApp
bmRleCA3OTMxZWZlNzExNzUuLmMzYzQ2YTM3ZGQ2NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9wb3NpeF9hY2wuaAorKysgYi9pbmNsdWRlL2xpbnV4L3Bvc2l4X2FjbC5oCkBAIC05NSw3ICs5
NSw3IEBAIGV4dGVybiBzdHJ1Y3QgcG9zaXhfYWNsICpnZXRfcG9zaXhfYWNsKHN0cnVjdCBpbm9k
ZSAqLCBpbnQpOwogZXh0ZXJuIGludCBzZXRfcG9zaXhfYWNsKHN0cnVjdCBpbm9kZSAqLCBpbnQs
IHN0cnVjdCBwb3NpeF9hY2wgKik7CiAKICNpZmRlZiBDT05GSUdfRlNfUE9TSVhfQUNMCi1zdGF0
aWMgaW5saW5lIHN0cnVjdCBwb3NpeF9hY2wgKiphY2xfYnlfdHlwZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBpbnQgdHlwZSkKK3N0YXRpYyBpbmxpbmUgc3RydWN0IHBvc2l4X2FjbCBfX3JjdSAqKmFj
bF9ieV90eXBlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCB0eXBlKQogewogCXN3aXRjaCAodHlw
ZSkgewogCWNhc2UgQUNMX1RZUEVfQUNDRVNTOgpAQCAtMTA5LDExICsxMDksMTEgQEAgc3RhdGlj
IGlubGluZSBzdHJ1Y3QgcG9zaXhfYWNsICoqYWNsX2J5X3R5cGUoc3RydWN0IGlub2RlICppbm9k
ZSwgaW50IHR5cGUpCiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IHBvc2l4X2FjbCAqZ2V0X2NhY2hl
ZF9hY2woc3RydWN0IGlub2RlICppbm9kZSwgaW50IHR5cGUpCiB7Ci0Jc3RydWN0IHBvc2l4X2Fj
bCAqKnAgPSBhY2xfYnlfdHlwZShpbm9kZSwgdHlwZSk7Ci0Jc3RydWN0IHBvc2l4X2FjbCAqYWNs
ID0gQUNDRVNTX09OQ0UoKnApOworCXN0cnVjdCBwb3NpeF9hY2wgX19yY3UgKipwID0gYWNsX2J5
X3R5cGUoaW5vZGUsIHR5cGUpOworCXN0cnVjdCBwb3NpeF9hY2wgKmFjbCA9IHJjdV9kZXJlZmVy
ZW5jZSgqcCk7CiAJaWYgKGFjbCkgewogCQlzcGluX2xvY2soJmlub2RlLT5pX2xvY2spOwotCQlh
Y2wgPSAqcDsKKwkJYWNsID0gcmN1X2RlcmVmZXJlbmNlKCpwKTsKIAkJaWYgKGFjbCAhPSBBQ0xf
Tk9UX0NBQ0hFRCkKIAkJCWFjbCA9IHBvc2l4X2FjbF9kdXAoYWNsKTsKIAkJc3Bpbl91bmxvY2so
Jmlub2RlLT5pX2xvY2spOwpAQCAtMTMwLDExICsxMzAsMTMgQEAgc3RhdGljIGlubGluZSB2b2lk
IHNldF9jYWNoZWRfYWNsKHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAJCQkJICBpbnQgdHlwZSwKIAkJ
CQkgIHN0cnVjdCBwb3NpeF9hY2wgKmFjbCkKIHsKLQlzdHJ1Y3QgcG9zaXhfYWNsICoqcCA9IGFj
bF9ieV90eXBlKGlub2RlLCB0eXBlKTsKLQlzdHJ1Y3QgcG9zaXhfYWNsICpvbGQ7CisJc3RydWN0
IHBvc2l4X2FjbCBfX3JjdSAqKnAgPSBhY2xfYnlfdHlwZShpbm9kZSwgdHlwZSk7CisJc3RydWN0
IHBvc2l4X2FjbCAqb2xkLCAqbmV3OworCisJbmV3ID0gcG9zaXhfYWNsX2R1cChhY2wpOwogCXNw
aW5fbG9jaygmaW5vZGUtPmlfbG9jayk7Ci0Jb2xkID0gKnA7Ci0JcmN1X2Fzc2lnbl9wb2ludGVy
KCpwLCBwb3NpeF9hY2xfZHVwKGFjbCkpOworCW9sZCA9IHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0
ZWQoKnAsIHRydWUpOworCXJjdV9hc3NpZ25fcG9pbnRlcigqcCwgbmV3KTsKIAlzcGluX3VubG9j
aygmaW5vZGUtPmlfbG9jayk7CiAJaWYgKG9sZCAhPSBBQ0xfTk9UX0NBQ0hFRCkKIAkJcG9zaXhf
YWNsX3JlbGVhc2Uob2xkKTsK
--089e016341aa1a2da704e427094d--
