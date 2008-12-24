From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 03/15] Add type information to struct instruction.
Date: Tue, 23 Dec 2008 19:09:44 -0800
Message-ID: <70318cbf0812231909i812a363s353d26572c8fddd2@mail.gmail.com>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
	 <20081215002610.16107.25437.stgit@zaytsev.su>
	 <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
	 <4950CA43.6090101@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_80245_28740797.1230088185044"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:26678 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYLXDJp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 22:09:45 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2664250rvb.1
        for <linux-sparse@vger.kernel.org>; Tue, 23 Dec 2008 19:09:45 -0800 (PST)
In-Reply-To: <4950CA43.6090101@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

------=_Part_80245_28740797.1230088185044
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Dec 23, 2008 at 3:23 AM, David Given <dg@cowlark.com> wrote:
> I'm sure there's a better way of doing it, but I just couldn't find one!
> So if you can think of any way to clean all this up I'd be delighted.
> The underlying issue, BTW, is that OP_LOAD doesn't carry enough
> information in its arguments to determine the type of the instruction.

OK, if it is just for OP_LOAD. Will this attached patch solve your problem?

Instead of adding type to every instruction. It just add that for the OP_LOAD
instruction in insn->orig_type. If that works for you. I am very glad to reclaim
the space back on instruction structure.

> Incidentally, speaking of distinguishing arguments, one of the issues I
> have with Clue is that sparse can't distinguish between parameters of
> the different types but the same size in some situations --- e.g.:
>
> extern void foo(float i);
> ...
> foo(5);
>
> ...will call foo() with an *integer* parameter rather than a float one.
> This is preventing me doing certain optimisations (like being able to
> store ints in ints rather than doubles!). Is this related?

I think sparse should do the proper cast for you when you call
the function call. If it does not, that is a bug and we can fix it.

Please let me know if you can use the patch.

Chris

------=_Part_80245_28740797.1230088185044
Content-Type: application/octet-stream; name=load_type
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fp38s13f0
Content-Disposition: attachment; filename=load_type

TWFrZSB0eXBlIGluZm9ybWF0aW9uIG9ubHkgZm9yIE9QX0xPQUQKCkluZGV4OiBzcGFyc2UvbGlu
ZWFyaXplLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gc3BhcnNlLm9yaWcvbGluZWFyaXplLmMKKysrIHNwYXJz
ZS9saW5lYXJpemUuYwpAQCAtNTUsOSArNTUsNyBAQCBzdGF0aWMgaW5saW5lIGludCB0eXBlX3Np
emUoc3RydWN0IHN5bWJvCiAKIHN0YXRpYyBzdHJ1Y3QgaW5zdHJ1Y3Rpb24gKmFsbG9jX3R5cGVk
X2luc3RydWN0aW9uKGludCBvcGNvZGUsIHN0cnVjdCBzeW1ib2wgKnR5cGUpCiB7Ci0Jc3RydWN0
IGluc3RydWN0aW9uICppbnNuID0gYWxsb2NfaW5zdHJ1Y3Rpb24ob3Bjb2RlLCB0eXBlX3NpemUo
dHlwZSkpOwotCWluc24tPnR5cGUgPSB0eXBlOwotCXJldHVybiBpbnNuOworCXJldHVybiBhbGxv
Y19pbnN0cnVjdGlvbihvcGNvZGUsIHR5cGVfc2l6ZSh0eXBlKSk7CiB9CiAKIHN0YXRpYyBzdHJ1
Y3QgZW50cnlwb2ludCAqYWxsb2NfZW50cnlwb2ludCh2b2lkKQpAQCAtOTE1LDYgKzkxMyw3IEBA
IHN0YXRpYyBwc2V1ZG9fdCBhZGRfbG9hZChzdHJ1Y3QgZW50cnlwb2kKIAogCWluc24tPnRhcmdl
dCA9IG5ldzsKIAlpbnNuLT5vZmZzZXQgPSBhZC0+b2Zmc2V0OworCWluc24tPm9yaWdfdHlwZSA9
IGFkLT5zb3VyY2VfdHlwZTsKIAl1c2VfcHNldWRvKGluc24sIGFkLT5hZGRyZXNzLCAmaW5zbi0+
c3JjKTsKIAlhZGRfb25lX2luc24oZXAsIGluc24pOwogCXJldHVybiBuZXc7CkluZGV4OiBzcGFy
c2UvbGluZWFyaXplLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gc3BhcnNlLm9yaWcvbGluZWFyaXplLmgKKysr
IHNwYXJzZS9saW5lYXJpemUuaApAQCAtNzEsNyArNzEsNiBAQCBzdHJ1Y3QgaW5zdHJ1Y3Rpb24g
ewogCQkgc2l6ZToyNDsKIAlzdHJ1Y3QgYmFzaWNfYmxvY2sgKmJiOwogCXN0cnVjdCBwb3NpdGlv
biBwb3M7Ci0Jc3RydWN0IHN5bWJvbCAqdHlwZTsKIAl1bmlvbiB7CiAJCXBzZXVkb190IHRhcmdl
dDsKIAkJcHNldWRvX3QgY29uZDsJCS8qIGZvciBicmFuY2ggYW5kIHN3aXRjaCAqLwo=
------=_Part_80245_28740797.1230088185044--
