From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Tue, 14 Apr 2020 11:19:32 -0700
Message-ID: <CAHk-=wiahqumRaQkkcQ_kFhknA9z==DCWNKK-j0GRJH7GUtPEw@mail.gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com> <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
 <20200413185452.pgj75pj5g7a42kik@ltop.local> <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
 <CAHk-=whNLSTtSsmMD5a6D3s_LtjEYwZPWOSvUdz4mCd5kFO26Q@mail.gmail.com>
 <20200413233900.t7fczyyqrees5gwr@ltop.local> <20200414074934.urvzzgpi2a36jdf2@ltop.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000b178a305a3443e48"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503749AbgDNSTx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Apr 2020 14:19:53 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069DC061A0C
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 11:19:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 198so532403lfo.7
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 11:19:53 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u19sm9702608lju.83.2020.04.14.11.19.48
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 11:19:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id l11so547604lfc.5
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 11:19:48 -0700 (PDT)
In-Reply-To: <20200414074934.urvzzgpi2a36jdf2@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

--000000000000b178a305a3443e48
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 14, 2020 at 12:49 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> The problem is that now normal labels use the new label_scope
> but the ones declared with __label__ use block_scope and these
> 2 scopes are kinda in a different namespace of scope.

Oh, I forgot about the special __label__ thing that actually declares labels.

That one has an interesting behavior, in that the _lifetime_ of the
symbol is the block scope, but the *use* of the symbol must remain in
label scope.

The most obvious fix is probably something like the appended: make the
'sym->scope' remain the lifetime scope, but then attach a "must be
used in this scope' thing to any NS_LABEL case.

That fairly clearly separates the two issues.

Again, not actually tested outside of the obvious trivial case.

              Linus

--000000000000b178a305a3443e48
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k908b8bi0>
X-Attachment-Id: f_k908b8bi0

IHBhcnNlLmMgIHwgMTYgKysrKysrKysrKystLS0tLQogc2NvcGUuYyAgfCAgMSArCiBzeW1ib2wu
aCB8ICAzICsrKwogMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3BhcnNlLmMgYi9wYXJzZS5jCmluZGV4IDhlMjM4ZjU5Li5iNjEw
OTUxNiAxMDA2NDQKLS0tIGEvcGFyc2UuYworKysgYi9wYXJzZS5jCkBAIC03MjgsNiArNzI4LDcg
QEAgc3RydWN0IHN5bWJvbCAqbGFiZWxfc3ltYm9sKHN0cnVjdCB0b2tlbiAqdG9rZW4pCiAJaWYg
KCFzeW0pIHsKIAkJc3ltID0gYWxsb2Nfc3ltYm9sKHRva2VuLT5wb3MsIFNZTV9MQUJFTCk7CiAJ
CWJpbmRfc3ltYm9sKHN5bSwgdG9rZW4tPmlkZW50LCBOU19MQUJFTCk7CisJCXN5bS0+ZGVjbGFy
ZWRfc2NvcGUgPSBsYWJlbF9zY29wZTsKIAkJZm5fbG9jYWxfc3ltYm9sKHN5bSk7CiAJfQogCXJl
dHVybiBzeW07CkBAIC0yNTQxLDEzICsyNTQyLDE0IEBAIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKnN0
YXRlbWVudChzdHJ1Y3QgdG9rZW4gKnRva2VuLCBzdHJ1Y3Qgc3RhdGVtZW50ICoqdHJlZSkKIAkJ
CX0KIAkJCS8qCiAJCQkgKiBJZiB0aGUgc2NvcGUgb2YgdGhlIGxhYmVsIHN5bWJvbCBpcyBkaWZm
ZXJlbnQKLQkJCSAqIGZyb20gdGhlIGN1cnJlbnQgbGFiZWwgc2NvcGUsIHRoYXQgbWVhbnMgdGhh
dAotCQkJICogaXQgbXVzdCBoYXZlIGJlZW4gdXNlZCBhdCBhbiBvdXRlciBzY29wZS4KKwkJCSAq
IGZyb20gdGhlIGRlY2xhcmVkIGxhYmVsIHNjb3BlLCB0aGF0IG1lYW5zIHRoYXQKKwkJCSAqIGl0
IG11c3QgaGF2ZSBiZWVuIHVzZWQgb3IgZGVjbGFyZWQgYXQgYW4gb3V0ZXIKKwkJCSAqIHNjb3Bl
LgogCQkJICoKIAkJCSAqIFRoYXQncyBub3Qgb2suCiAJCQkgKi8KLQkJCWlmIChzLT5zY29wZSAh
PSBsYWJlbF9zY29wZSkgewotCQkJCXNwYXJzZV9lcnJvcihzdG10LT5wb3MsICJsYWJlbCAnJXMn
IHVzZWQgb3V0c2lkZSBsYWJlbCBleHByZXNzaW9uIiwgc2hvd19pZGVudChzLT5pZGVudCkpOwor
CQkJaWYgKHMtPnNjb3BlICE9IHMtPmRlY2xhcmVkX3Njb3BlKSB7CisJCQkJc3BhcnNlX2Vycm9y
KHN0bXQtPnBvcywgImxhYmVsICclcycgdXNlZCBvdXRzaWRlIHN0YXRlbWVudCBleHByZXNzaW9u
Iiwgc2hvd19pZGVudChzLT5pZGVudCkpOwogCQkJCXNwYXJzZV9lcnJvcihzLT5wb3MsICJpbnZh
bGlkIHVzZSBoZXJlIik7CiAJCQl9CiAJCQlzdG10LT50eXBlID0gU1RNVF9MQUJFTDsKQEAgLTI1
NzUsOSArMjU3NywxMyBAQCBzdGF0aWMgc3RydWN0IHRva2VuICpsYWJlbF9zdGF0ZW1lbnQoc3Ry
dWN0IHRva2VuICp0b2tlbikKIHsKIAl3aGlsZSAodG9rZW5fdHlwZSh0b2tlbikgPT0gVE9LRU5f
SURFTlQpIHsKIAkJc3RydWN0IHN5bWJvbCAqc3ltID0gYWxsb2Nfc3ltYm9sKHRva2VuLT5wb3Ms
IFNZTV9MQUJFTCk7Ci0JCS8qIGl0J3MgYmxvY2stc2NvcGUsIGJ1dCB3ZSB3YW50IGxhYmVsIG5h
bWVzcGFjZSAqLworCisJCS8qIGl0J3MgbGlmZXRpbGUgaXMgYmxvY2stc2NvcGUsIGJ1dCB3ZSB3
YW50IGxhYmVsIG5hbWVzcGFjZSAqLwogCQliaW5kX3N5bWJvbChzeW0sIHRva2VuLT5pZGVudCwg
TlNfU1lNQk9MKTsKIAkJc3ltLT5uYW1lc3BhY2UgPSBOU19MQUJFTDsKKworCQkvKiBCdXQgd2Ug
bXVzdCBkZWZpbmUgaXQgaW4gdGhpcyBsYWJlbCBzY29wZSAqLworCQlzeW0tPmRlY2xhcmVkX3Nj
b3BlID0gbGFiZWxfc2NvcGU7CiAJCWZuX2xvY2FsX3N5bWJvbChzeW0pOwogCQl0b2tlbiA9IHRv
a2VuLT5uZXh0OwogCQlpZiAoIW1hdGNoX29wKHRva2VuLCAnLCcpKQpkaWZmIC0tZ2l0IGEvc2Nv
cGUuYyBiL3Njb3BlLmMKaW5kZXggNGIwZjc5NDcuLjExNzkyZWM0IDEwMDY0NAotLS0gYS9zY29w
ZS5jCisrKyBiL3Njb3BlLmMKQEAgLTE3MSw2ICsxNzEsNyBAQCB2b2lkIGVuZF9sYWJlbF9zY29w
ZSh2b2lkKQogCiAJCS8qIFJlLWJpbmQgdGhlIHN5bWJvbCB0byB0aGUgcGFyZW50IHNjb3BlLCB3
ZSdsbCB0cnkgYWdhaW4gKi8KIAkJYmluZF9zY29wZShzeW0sIGxhYmVsX3Njb3BlKTsKKwkJc3lt
LT5kZWNsYXJlZF9zY29wZSA9IGxhYmVsX3Njb3BlOwogCX0gRU5EX0ZPUl9FQUNIX1BUUihzeW0p
OwogCiAJZW5kX3Njb3BlKCZibG9ja19zY29wZSk7CmRpZmYgLS1naXQgYS9zeW1ib2wuaCBiL3N5
bWJvbC5oCmluZGV4IDE4NDc2NTgyLi4wOGUzNTQzOCAxMDA2NDQKLS0tIGEvc3ltYm9sLmgKKysr
IGIvc3ltYm9sLmgKQEAgLTE2Nyw2ICsxNjcsOSBAQCBzdHJ1Y3Qgc3ltYm9sIHsKIAkJCWludCAo
KmhhbmRsZXIpKHN0cnVjdCBzdHJlYW0gKiwgc3RydWN0IHRva2VuICoqLCBzdHJ1Y3QgdG9rZW4g
Kik7CiAJCQlpbnQgbm9ybWFsOwogCQl9OworCQlzdHJ1Y3QgLyogTlNfTEFCRUwgKi8geworCQkJ
c3RydWN0IHNjb3BlICpkZWNsYXJlZF9zY29wZTsKKwkJfTsKIAkJc3RydWN0IC8qIE5TX1NZTUJP
TCAqLyB7CiAJCQl1bnNpZ25lZCBsb25nCW9mZnNldDsKIAkJCWludAkJYml0X3NpemU7Cg==
--000000000000b178a305a3443e48--
