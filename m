From: Christopher Li <sparse@chrisli.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Sat, 2 Aug 2014 11:09:01 -0700
Message-ID: <CANeU7QnTx50Hrw3-8vqAc=3e59v7ppnjgS6GVGMwbhOMZvbH9A@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFxptOTqCR9b0o8sEKwzyQOU0rfKTptRY5s=j5R_X=UdUg@mail.gmail.com>
	<CA+55aFwg=yuR6Ro1O3g50Y1QR-hPeW5y_BLQ18go_DoX9SZe6Q@mail.gmail.com>
	<CANeU7Q=11kDQdW7=2m6UwCzf6pcQU05stuSp+ysPus5d1oneJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c12ce6838ed904ffa9660c
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:43523 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSJC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 14:09:02 -0400
Received: by mail-qg0-f42.google.com with SMTP id j5so7201942qga.29
        for <linux-sparse@vger.kernel.org>; Sat, 02 Aug 2014 11:09:01 -0700 (PDT)
In-Reply-To: <CANeU7Q=11kDQdW7=2m6UwCzf6pcQU05stuSp+ysPus5d1oneJA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, John Keeping <john@keeping.me.uk>

--001a11c12ce6838ed904ffa9660c
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Aug 2, 2014 at 1:27 AM, Christopher Li <sparse@chrisli.org> wrote:
> I just apply that without the "FIXME" part. That two lines are from an incorrect
> fix for the external inline bug. I just remove it for now. Currently
> sparse will fail
> at the external inline test. I will fix that in a separate patch.

This is a follow up change to fix the extern-inline.c validation bug.
Feed back are welcome.

Consider the following case, extern inline declare after
extern declare of the same function.

extern int g(int);
extern __inline__ int g(int x)
{
        return x;
}

Sparse will give the first function global scope and
the second one file scope. Also the first one will get the
function body from the second one. That cause the failure
of the validation/extern-inlien.c

This change rebind the scope of the same_symbol chain to
the new scope. It will pass the extern-inline.c test case.

Chris

--001a11c12ce6838ed904ffa9660c
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Make-same_symbol-list-share-the-same-scope.patch"
Content-Disposition: attachment;
	filename="0001-Make-same_symbol-list-share-the-same-scope.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hyd93er70

RnJvbSA3YWJkOGE3NmI0ZTA3YWQ2MGI1MjYyZTRjNzg1OGU2Mzg0NjdmYWI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBTYXQsIDIgQXVnIDIwMTQgMTA6NTY6NTkgLTA3MDAKU3ViamVjdDogW1BBVENIXSBNYWtl
IHNhbWVfc3ltYm9sIGxpc3Qgc2hhcmUgdGhlIHNhbWUgc2NvcGUKCkNvbnNpZGVyIHRoZSBmb2xs
b3dpbmcgY2FzZSwgZXh0ZXJuIGlubGluZSBkZWNsYXJlIGFmdGVyCmV4dGVybiBkZWNsYXJlIG9m
IHRoZSBzYW1lIGZ1bmN0aW9uLgoKZXh0ZXJuIGludCBnKGludCk7CmV4dGVybiBfX2lubGluZV9f
IGludCBnKGludCB4KQp7CiAgICAgICAgcmV0dXJuIHg7Cn0KClNwYXJzZSB3aWxsIGdpdmUgdGhl
IGZpcnN0IGZ1bmN0aW9uIGdsb2JhbCBzY29wZSBhbmQKdGhlIHNlY29uZCBvbmUgZmlsZSBzY29w
ZS4gQWxzbyB0aGUgZmlyc3Qgb25lIHdpbGwgZ2V0IHRoZQpmdW5jdGlvbiBib2R5IGZyb20gdGhl
IHNlY29uZCBvbmUuIFRoYXQgY2F1c2UgdGhlIGZhaWx1cmUKb2YgdGhlIHZhbGlkYXRpb24vZXh0
ZXJuLWlubGllbi5jCgpUaGlzIGNoYW5nZSByZWJpbmQgdGhlIHNjb3BlIG9mIHRoZSBzYW1lX3N5
bWJvbCBjaGFpbiB0bwp0aGUgbmV3IHNjb3BlLiBJdCB3aWxsIHBhc3MgdGhlIGV4dGVybi1pbmxp
bmUuYyB0ZXN0IGNhc2UuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNo
cmlzbGkub3JnPgotLS0KIHBhcnNlLmMgfCAgMSArCiBzY29wZS5jIHwgMTQgKysrKysrKysrKysr
KysKIHNjb3BlLmggfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9wYXJzZS5jIGIvcGFyc2UuYwppbmRleCA1NWE1N2E3Li5lYWExODgzIDEwMDY0
NAotLS0gYS9wYXJzZS5jCisrKyBiL3BhcnNlLmMKQEAgLTI2MTEsNiArMjYxMSw3IEBAIHN0YXRp
YyBzdHJ1Y3QgdG9rZW4gKnBhcnNlX2Z1bmN0aW9uX2JvZHkoc3RydWN0IHRva2VuICp0b2tlbiwg
c3RydWN0IHN5bWJvbCAqZGVjCiAJCWluZm8ocHJldi0+ZGVmaW5pdGlvbi0+cG9zLCAiIHRoZSBw
cmV2aW91cyBvbmUgaXMgaGVyZSIpOwogCX0gZWxzZSB7CiAJCXdoaWxlIChwcmV2KSB7CisJCQly
ZWJpbmRfc2NvcGUocHJldiwgZGVjbC0+c2NvcGUpOwogCQkJcHJldi0+ZGVmaW5pdGlvbiA9IGRl
Y2w7CiAJCQlwcmV2ID0gcHJldi0+c2FtZV9zeW1ib2w7CiAJCX0KZGlmZiAtLWdpdCBhL3Njb3Bl
LmMgYi9zY29wZS5jCmluZGV4IGI0MTVhY2UuLmNiZjJmY2YgMTAwNjQ0Ci0tLSBhL3Njb3BlLmMK
KysrIGIvc2NvcGUuYwpAQCAtNDYsNiArNDYsMjAgQEAgdm9pZCBiaW5kX3Njb3BlKHN0cnVjdCBz
eW1ib2wgKnN5bSwgc3RydWN0IHNjb3BlICpzY29wZSkKIAlhZGRfc3ltYm9sKCZzY29wZS0+c3lt
Ym9scywgc3ltKTsKIH0KIAorCit2b2lkIHJlYmluZF9zY29wZShzdHJ1Y3Qgc3ltYm9sICpzeW0s
IHN0cnVjdCBzY29wZSAqbmV3KQoreworCXN0cnVjdCBzY29wZSAqb2xkID0gc3ltLT5zY29wZTsK
KworCWlmIChvbGQgPT0gbmV3KQorCQlyZXR1cm47CisKKwlpZiAob2xkKQorCQlkZWxldGVfcHRy
X2xpc3RfZW50cnkoKHN0cnVjdCBwdHJfbGlzdCoqKSAmb2xkLT5zeW1ib2xzLCBzeW0sIDEpOwor
CisJYmluZF9zY29wZShzeW0sIG5ldyk7Cit9CisKIHN0YXRpYyB2b2lkIHN0YXJ0X3Njb3BlKHN0
cnVjdCBzY29wZSAqKnMpCiB7CiAJc3RydWN0IHNjb3BlICpzY29wZSA9IF9fYWxsb2Nfc2NvcGUo
MCk7CmRpZmYgLS1naXQgYS9zY29wZS5oIGIvc2NvcGUuaAppbmRleCAwNDVjMzU2Li45YmJiNjc1
IDEwMDY0NAotLS0gYS9zY29wZS5oCisrKyBiL3Njb3BlLmgKQEAgLTU1LDYgKzU1LDcgQEAgZXh0
ZXJuIHZvaWQgc3RhcnRfZnVuY3Rpb25fc2NvcGUodm9pZCk7CiBleHRlcm4gdm9pZCBlbmRfZnVu
Y3Rpb25fc2NvcGUodm9pZCk7CiAKIGV4dGVybiB2b2lkIGJpbmRfc2NvcGUoc3RydWN0IHN5bWJv
bCAqLCBzdHJ1Y3Qgc2NvcGUgKik7CitleHRlcm4gdm9pZCByZWJpbmRfc2NvcGUoc3RydWN0IHN5
bWJvbCAqLCBzdHJ1Y3Qgc2NvcGUgKik7CiAKIGV4dGVybiBpbnQgaXNfb3V0ZXJfc2NvcGUoc3Ry
dWN0IHNjb3BlICopOwogI2VuZGlmCi0tIAoxLjkuMwoK
--001a11c12ce6838ed904ffa9660c--
