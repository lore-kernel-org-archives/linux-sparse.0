From: Christopher Li <sparse@chrisli.org>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Thu, 10 Aug 2017 15:59:56 -0400
Message-ID: <CANeU7QmDs0Dbdd=-ceD55rD9fHuz53Vy2=a==8J1OjV1d7RVHg@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local> <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
 <CACXZuxeTzEGNME0WV8S9Gbe-Vbu--pq6XF4sH4YEKPD_gysiNA@mail.gmail.com>
 <CACXZuxfrgT1Q9X5B7iw=+zYA7bO4uchBo8txqsqnBw-xf+2C_A@mail.gmail.com>
 <CANeU7QmpT1-zEXmxtesaicD+W_dwMMxODno7og+5C6tuBFimpQ@mail.gmail.com>
 <CACXZuxcWQBtjH=szWHOzjU9D1+t3E+Bd-2XK=+e_Fx9rO29jvg@mail.gmail.com>
 <CANeU7Qk37J8WTVmzDhzjCbpmJ6cf59LNB6sX6ncRFHP=wvJFQw@mail.gmail.com>
 <CACXZuxddPW-gr+eRLqVTyJmKhVKAB2xEkzEfBbmLKHGK4h_twg@mail.gmail.com>
 <CANeU7QnT-bco_UUcXx2nTEFPR3M=zmx9i=a6vXRZyUmY6M+5vg@mail.gmail.com> <CACXZuxcBaNb40zNh1FgAbJP5nhxEU8pf09_ejnOwWWhjWS3Jwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a1148ad600c46c205566ba460"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34096 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdHJT75 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 15:59:57 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so11280887ywg.1
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 12:59:57 -0700 (PDT)
In-Reply-To: <CACXZuxcBaNb40zNh1FgAbJP5nhxEU8pf09_ejnOwWWhjWS3Jwg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

--001a1148ad600c46c205566ba460
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 9, 2017 at 4:03 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> On 9 August 2017 at 12:57, Christopher Li <sparse@chrisli.org> wrote:
>> Can you do a "ldd test-inspect"?
>>
>> Which version of Ubuntu are you using? I think I need to get one of those to
>> test it.
>>
>
> I am using ubuntu 16.04 LTS.
>


OK. I have install ubuntu 16.04 LTS and writing this email
on ubuntu now.

The first patch I send you should be correct. But I think
there is a bug in the updated version of ubuntu 16.04
libgtk2.0-dev. I am not able to reproduce it with the
fresh install libgtk2 but I can't go back now.

I can duplicate the crash with update to latest version.

It seems to me that, when I click on one sub item,
it is passing iter == NULL. That seems wrong.
It shouldn't pass iter == NULL for sub list item.

Again, I am not GUI developer at all. This
test-inspect is all my GUI skill at best already.

With the patch I send earlier, this cause the gtk
go into infinity loop of asking about the child
of the child. It is asking for child with iter==NULL.
So I get it the root node, gtk seems get confused
after that.

The patch I send out before obvious should be applied.

The good news is that, in Ubuntu 16.04. GTK3.0 does
not have this problem. I am able to run gtk3 and
test-inspect will not crash.

I attach the patch here. You can try it out.
Please let me know how it work out for you.

I am writing a patch for RC5 to compile with gtk3
if available.

Chris

--001a1148ad600c46c205566ba460
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-switch-to-gtk3.patch"
Content-Disposition: attachment; filename="0001-switch-to-gtk3.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j66uvdnl0

RnJvbSAwMDJjYjUwNDk5Y2E2NDUzOWQ2NzdlNDZmMDM1YTBkNjJhYjk4MWUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpcyBMaSA8Y2hyaXNAY29vbD4KRGF0ZTogVGh1LCAxMCBB
dWcgMjAxNyAxNTozNDoxNCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIHN3aXRjaCB0byBndGszCgot
LS0KIE1ha2VmaWxlICAgIHwgNiArKystLS0KIGFzdC1tb2RlbC5jIHwgMyArKy0KIDIgZmlsZXMg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL01h
a2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggOTZlODFjNC4uZGI0MTBlYiAxMDA2NDQKLS0tIGEvTWFr
ZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTMwLDcgKzMwLDcgQEAgSEFWRV9MSUJYTUw6PSQoc2hl
bGwgJChQS0dfQ09ORklHKSAtLWV4aXN0cyBsaWJ4bWwtMi4wIDI+L2Rldi9udWxsICYmIGVjaG8g
J3llcycKIEhBVkVfR0NDX0RFUDo9JChzaGVsbCB0b3VjaCAuZ2NjLXRlc3QuYyAmJiAJCQkJXAog
CQkkKENDKSAtYyAtV3AsLU1ELC5nY2MtdGVzdC5kIC5nY2MtdGVzdC5jIDI+L2Rldi9udWxsICYm
IFwKIAkJZWNobyAneWVzJzsgcm0gLWYgLmdjYy10ZXN0LmQgLmdjYy10ZXN0Lm8gLmdjYy10ZXN0
LmMpCi1IQVZFX0dUSzI6PSQoc2hlbGwgJChQS0dfQ09ORklHKSAtLWV4aXN0cyBndGsrLTIuMCAy
Pi9kZXYvbnVsbCAmJiBlY2hvICd5ZXMnKQorSEFWRV9HVEsyOj0kKHNoZWxsICQoUEtHX0NPTkZJ
RykgLS1leGlzdHMgZ3RrKy0zLjAgMj4vZGV2L251bGwgJiYgZWNobyAneWVzJykKIExMVk1fQ09O
RklHOj1sbHZtLWNvbmZpZwogSEFWRV9MTFZNOj0kKHNoZWxsICQoTExWTV9DT05GSUcpIC0tdmVy
c2lvbiA+L2Rldi9udWxsIDI+JjEgJiYgZWNobyAneWVzJykKIApAQCAtNjcsOCArNjcsOCBAQCAk
KHdhcm5pbmcgWW91ciBzeXN0ZW0gZG9lcyBub3QgaGF2ZSBsaWJ4bWwsIGRpc2FibGluZyBjMnht
bCkKIGVuZGlmCiAKIGlmZXEgKCQoSEFWRV9HVEsyKSx5ZXMpCi1HVEsyX0NGTEFHUyA6PSAkKHNo
ZWxsICQoUEtHX0NPTkZJRykgLS1jZmxhZ3MgZ3RrKy0yLjApCi1HVEsyX0xJQlMgOj0gJChzaGVs
bCAkKFBLR19DT05GSUcpIC0tbGlicyBndGsrLTIuMCkKK0dUSzJfQ0ZMQUdTIDo9ICQoc2hlbGwg
JChQS0dfQ09ORklHKSAtLWNmbGFncyBndGsrLTMuMCkKK0dUSzJfTElCUyA6PSAkKHNoZWxsICQo
UEtHX0NPTkZJRykgLS1saWJzIGd0aystMy4wKQogUFJPR1JBTVMgKz0gdGVzdC1pbnNwZWN0CiBJ
TlNUX1BST0dSQU1TICs9IHRlc3QtaW5zcGVjdAogdGVzdC1pbnNwZWN0X0VYVFJBX0RFUFMgOj0g
YXN0LW1vZGVsLm8gYXN0LXZpZXcubyBhc3QtaW5zcGVjdC5vCmRpZmYgLS1naXQgYS9hc3QtbW9k
ZWwuYyBiL2FzdC1tb2RlbC5jCmluZGV4IDcwNGM0ODcuLmQ3ZjBjM2EgMTAwNjQ0Ci0tLSBhL2Fz
dC1tb2RlbC5jCisrKyBiL2FzdC1tb2RlbC5jCkBAIC00MDEsNyArNDAxLDggQEAgc3RhdGljIGdp
bnQKIGFzdF9pdGVyX25fY2hpbGRyZW4gKEd0a1RyZWVNb2RlbCAqdHJlZV9tb2RlbCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgR3RrVHJlZUl0ZXIgICppdGVyKQogewotCUFzdE5vZGUgICpu
b2RlID0gaXRlci0+dXNlcl9kYXRhOworCUFzdE5vZGUgICpub2RlID0gaXRlciA/IGl0ZXItPnVz
ZXJfZGF0YQorCQkJCTogQVNUX05PREUodHJlZV9tb2RlbCk7CiAKIAlpbnNwZWN0X2NoaWxkX25v
ZGUobm9kZSk7CiAJcmV0dXJuIG5vZGUtPmNoaWxkbm9kZXMtPmxlbjsKLS0gCjIuNy40Cgo=
--001a1148ad600c46c205566ba460--
