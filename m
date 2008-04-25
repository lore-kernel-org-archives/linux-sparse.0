From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Re: Re: Re: [PATCH 15/16] deal with enum members without excessive PITA
Date: Fri, 25 Apr 2008 07:27:52 +0200
Message-ID: <OF213DC17B.1BAFEFCE-ONC1257436.001C5DD3-C1257436.001E04D4@br-automation.com>
References: <70318cbf0712141301s7bafda84ta7d7b087a0f13685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_mixed 001E04D1C1257436_="
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:55365 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbYDYFoq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 01:44:46 -0400
In-Reply-To: <70318cbf0712141301s7bafda84ta7d7b087a0f13685@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, linux-sparse-owner@vger.kernel.org, Christopher Li <sparse@chrisli.org>

--=_mixed 001E04D1C1257436_=
Content-Type: text/plain; charset="US-ASCII"

Hello Josh,

Christopger Li sent this patch 4 month ago and i'd appreciate to see this 
patch applied.
I added an "Acked-by" to the patch.

Enum-members will now be stored in symbol->symbol_list.

Thanks,
Tom

linux-sparse-owner@vger.kernel.org schrieb am 14.12.2007 22:01:03:

> On Dec 14, 2007 4:09 AM, Thomas Schmid <Thomas.Schmid@br-automation.
> com> wrote:
> > How about the idea, looping over the syms within global_scope?
> 
> I think that will work too.
> 
> > > > It should be trivial make a patch to add members to the parent
> > > symbol->symbol_list though.
> > Would you possibly?
> 
> Can you try the attached patch?
> 
> Chris
>
--=_mixed 001E04D1C1257436_=
Content-Type: application/octet-stream; name="enum-members"
Content-Disposition: attachment; filename="enum-members"
Content-Transfer-Encoding: base64

QWRkIGVudW0gbWVtYmVyIGxpc3QgdG8gdGhlIHBhcmVudAoKU2lnbmVkLU9mZi1CeTogQ2hyaXN0
b3BoZXIgTGkgPHNwYXJzZUBjaHJpc2xpLm9yZz4KQWNrZWQtYnk6IFRob21hcyBTY2htaWQgPFRo
b21hcy5TY2htaWRAYnItYXV0b21hdGlvbi5jb20+DQoKSW5kZXg6IHNwYXJzZS9wYXJzZS5jCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KLS0tIHNwYXJzZS5vcmlnL3BhcnNlLmMJMjAwNy0xMi0xNCAxMjozMzowNS4wMDAw
MDAwMDAgLTA4MDAKKysrIHNwYXJzZS9wYXJzZS5jCTIwMDctMTItMTQgMTI6NDI6MzkuMDAwMDAw
MDAwIC0wODAwCkBAIC02NTEsNyArNjUxLDYgQEAgc3RhdGljIHN0cnVjdCB0b2tlbiAqcGFyc2Vf
ZW51bV9kZWNsYXJhdAogCXVuc2lnbmVkIGxvbmcgbG9uZyBsYXN0dmFsID0gMDsKIAlzdHJ1Y3Qg
c3ltYm9sICpjdHlwZSA9IE5VTEwsICpiYXNlX3R5cGUgPSBOVUxMOwogCU51bSB1cHBlciA9IHst
MSwgMH0sIGxvd2VyID0gezEsIDB9OwotCXN0cnVjdCBzeW1ib2xfbGlzdCAqZW50cmllcyA9IE5V
TEw7CiAKIAlwYXJlbnQtPmV4YW1pbmVkID0gMTsKIAlwYXJlbnQtPmN0eXBlLmJhc2VfdHlwZSA9
ICZpbnRfY3R5cGU7CkBAIC02ODcsNyArNjg2LDcgQEAgc3RhdGljIHN0cnVjdCB0b2tlbiAqcGFy
c2VfZW51bV9kZWNsYXJhdAogCQlzeW0tPmluaXRpYWxpemVyID0gZXhwcjsKIAkJc3ltLT5lbnVt
X21lbWJlciA9IDE7CiAJCXN5bS0+Y3R5cGUuYmFzZV90eXBlID0gcGFyZW50OwotCQlhZGRfcHRy
X2xpc3QoJmVudHJpZXMsIHN5bSk7CisJCWFkZF9wdHJfbGlzdCgmcGFyZW50LT5zeW1ib2xfbGlz
dCwgc3ltKTsKIAogCQlpZiAoYmFzZV90eXBlICE9ICZiYWRfY3R5cGUpIHsKIAkJCWlmIChjdHlw
ZS0+dHlwZSA9PSBTWU1fTk9ERSkKQEAgLTc2Myw4ICs3NjIsNyBAQCBzdGF0aWMgc3RydWN0IHRv
a2VuICpwYXJzZV9lbnVtX2RlY2xhcmF0CiAJcGFyZW50LT5jdHlwZS5tb2RpZmllcnMgfD0gKGJh
c2VfdHlwZS0+Y3R5cGUubW9kaWZpZXJzICYgTU9EX1VOU0lHTkVEKTsKIAlwYXJlbnQtPmV4YW1p
bmVkID0gMDsKIAotCWNhc3RfZW51bV9saXN0KGVudHJpZXMsIGJhc2VfdHlwZSk7Ci0JZnJlZV9w
dHJfbGlzdCgmZW50cmllcyk7CisJY2FzdF9lbnVtX2xpc3QocGFyZW50LT5zeW1ib2xfbGlzdCwg
YmFzZV90eXBlKTsKIAogCXJldHVybiB0b2tlbjsKIH0K

--=_mixed 001E04D1C1257436_=--
