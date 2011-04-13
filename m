From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse, gcc 4.6 and a few build changes
Date: Wed, 13 Apr 2011 09:58:35 -0700
Message-ID: <BANLkTikS9NPWmaqt2JZHVLEcMarxznq97g@mail.gmail.com>
References: <1302226355.2407.7.camel@raven.home.flameeyes.eu>
	<BANLkTinOwWW0T6D+oFiNakXrc8SbpgqcpQ@mail.gmail.com>
	<1302692762.15959.50.camel@raven.home.flameeyes.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec51ba1f52c4fee04a0cfb8a2
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54621 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502Ab1DMQ6g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 12:58:36 -0400
Received: by vws1 with SMTP id 1so603923vws.19
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 09:58:35 -0700 (PDT)
In-Reply-To: <1302692762.15959.50.camel@raven.home.flameeyes.eu>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Diego_Elio_Petten=F2?= <flameeyes@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

--bcaec51ba1f52c4fee04a0cfb8a2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2011 at 4:06 AM, Diego Elio Petten=F2 <flameeyes@gmail.com>=
 wrote:

> Yes I know =97 that's why I used the "?=3D" setter: if CFLAGS is set in t=
he
> environment, it'll be used instead of the "CFLAGS ?=3D" line; all the +=
=3D
> lines will be maintained instead. This does obviously not work if you
> use "make CFLAGS=3D$something".

That is my point. It force the user set CFLAGS in enviroment
but not work the same way if you do "make CFLAGS=3D$something".
I want "make CFLAGS=3D$something" works the same way as
you set it in environment.

>
> Attachment is missing ;)

Oops, I forget to attach. Here we go again.

> It looks like no changes are needed for that at least, I'll send the
> remaining three patches for now then.

Ha, I am hoping that is my learning case to pull from some one else's
git tree. Using git tree or patches are  both fine.

Thanks

Chris

--bcaec51ba1f52c4fee04a0cfb8a2
Content-Type: application/octet-stream; name="cflags.patch"
Content-Disposition: attachment; filename="cflags.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmgi40n80

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggNzAxY2RjOS4uZWVjNWRhYSAx
MDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTksNiArOSw3IEBAIENGTEFH
UyArPSAtV2FsbCAtV3dyaXRlLXN0cmluZ3MKIExERkxBR1MgKz0gLWcKIEFSID0gYXIKIAorQUxM
X0NGTEFHUyA9ICQoQ0ZMQUdTKSAkKEJBU0lDX0NGTEFHUykKICMKICMgRm9yIGRlYnVnZ2luZywg
cHV0IHRoaXMgaW4gbG9jYWwubWs6CiAjCkBAIC0yMSwxMCArMjIsMTAgQEAgSEFWRV9HQ0NfREVQ
Oj0kKHNoZWxsIHRvdWNoIC5nY2MtdGVzdC5jICYmIAkJCQlcCiAJCWVjaG8gJ3llcyc7IHJtIC1m
IC5nY2MtdGVzdC5kIC5nY2MtdGVzdC5vIC5nY2MtdGVzdC5jKQogSEFWRV9HVEsyOj0kKHNoZWxs
IHBrZy1jb25maWcgLS1leGlzdHMgZ3RrKy0yLjAgMj4vZGV2L251bGwgJiYgZWNobyAneWVzJykK
IAotQ0ZMQUdTICs9IC1ER0NDX0JBU0U9XCIkKHNoZWxsICQoQ0MpIC0tcHJpbnQtZmlsZS1uYW1l
PSlcIgorQkFTSUNfQ0ZMQUdTID0gLURHQ0NfQkFTRT1cIiQoc2hlbGwgJChDQykgLS1wcmludC1m
aWxlLW5hbWU9KVwiCiAKIGlmZXEgKCQoSEFWRV9HQ0NfREVQKSx5ZXMpCi1DRkxBR1MgKz0gLVdw
LC1NRCwkKEBEKS8uJChARikuZAorQkFTSUNfQ0ZMQUdTICs9IC1XcCwtTUQsJChARCkvLiQoQEYp
LmQKIGVuZGlmCiAKIERFU1RESVI9CkBAIC01NSw3ICs1Niw3IEBAIEdUSzJfTElCUyA6PSAkKHNo
ZWxsIHBrZy1jb25maWcgLS1saWJzIGd0aystMi4wKQogUFJPR1JBTVMgKz0gdGVzdC1pbnNwZWN0
CiBJTlNUX1BST0dSQU1TICs9IHRlc3QtaW5zcGVjdAogdGVzdC1pbnNwZWN0X0VYVFJBX0RFUFMg
Oj0gYXN0LW1vZGVsLm8gYXN0LXZpZXcubyBhc3QtaW5zcGVjdC5vCi10ZXN0LWluc3BlY3QubyAk
KHRlc3QtaW5zcGVjdF9FWFRSQV9ERVBTKTogQ0ZMQUdTICs9ICQoR1RLMl9DRkxBR1MpCit0ZXN0
LWluc3BlY3QubyAkKHRlc3QtaW5zcGVjdF9FWFRSQV9ERVBTKTogQkFTSUNfQ0ZMQUdTICs9ICQo
R1RLMl9DRkxBR1MpCiB0ZXN0LWluc3BlY3RfRVhUUkFfT0JKUyA6PSAkKEdUSzJfTElCUykKIGVs
c2UKICQod2FybmluZyBZb3VyIHN5c3RlbSBkb2VzIG5vdCBoYXZlIGxpYmd0azIsIGRpc2FibGlu
ZyB0ZXN0LWluc3BlY3QpCkBAIC03Myw3ICs3NCw3IEBAIExJQl9PQkpTPSB0YXJnZXQubyBwYXJz
ZS5vIHRva2VuaXplLm8gcHJlLXByb2Nlc3MubyBzeW1ib2wubyBsaWIubyBzY29wZS5vIFwKIExJ
Ql9GSUxFPSBsaWJzcGFyc2UuYQogU0xJQl9GSUxFPSBsaWJzcGFyc2Uuc28KIAotIyBJZiB5b3Ug
YWRkICQoU0xJQl9GSUxFKSB0byB0aGlzLCB5b3UgYWxzbyBuZWVkIHRvIGFkZCAtZnBpYyB0byBD
RkxBR1MgYWJvdmUuCisjIElmIHlvdSBhZGQgJChTTElCX0ZJTEUpIHRvIHRoaXMsIHlvdSBhbHNv
IG5lZWQgdG8gYWRkIC1mcGljIHRvIEJBU0lDX0NGTEFHUyBhYm92ZS4KICMgRG9pbmcgc28gaW5j
dXJzIGEgbm90aWNlYWJsZSBwZXJmb3JtYW5jZSBoaXQsIGFuZCBTcGFyc2UgZG9lcyBub3QgaGF2
ZSBhCiAjIHN0YWJsZSBzaGFyZWQgbGlicmFyeSBpbnRlcmZhY2UsIHNvIHRoaXMgZG9lcyBub3Qg
b2NjdXIgYnkgZGVmYXVsdC4gIElmIHlvdQogIyByZWFsbHkgd2FudCBhIHNoYXJlZCBsaWJyYXJ5
LCB5b3UgbWF5IHdhbnQgdG8gYnVpbGQgU3BhcnNlIHR3aWNlOiBvbmNlCkBAIC0xNDksNyArMTUw
LDcgQEAgREVQX0ZJTEVTIDo9ICQod2lsZGNhcmQgLiouby5kKQogJChpZiAkKERFUF9GSUxFUyks
JChldmFsIGluY2x1ZGUgJChERVBfRklMRVMpKSkKIAogYzJ4bWwubzogYzJ4bWwuYyAkKExJQl9I
KQotCSQoUVVJRVRfQ0MpJChDQykgYHBrZy1jb25maWcgLS1jZmxhZ3MgbGlieG1sLTIuMGAgLW8g
JEAgLWMgJChDRkxBR1MpICQ8CisJJChRVUlFVF9DQykkKENDKSBgcGtnLWNvbmZpZyAtLWNmbGFn
cyBsaWJ4bWwtMi4wYCAtbyAkQCAtYyAkKEFMTF9DRkxBR1MpICQ8CiAKIGNvbXBhdC1saW51eC5v
OiBjb21wYXQvc3RydG9sZC5jIGNvbXBhdC9tbWFwLWJsb2IuYyAkKExJQl9IKQogY29tcGF0LXNv
bGFyaXMubzogY29tcGF0L21tYXAtYmxvYi5jICQoTElCX0gpCkBAIC0xNTcsNyArMTU4LDcgQEAg
Y29tcGF0LW1pbmd3Lm86ICQoTElCX0gpCiBjb21wYXQtY3lnd2luLm86ICQoTElCX0gpCiAKICUu
bzogJS5jCi0JJChRVUlFVF9DQykkKENDKSAtbyAkQCAtYyAkKENGTEFHUykgJDwKKwkkKFFVSUVU
X0NDKSQoQ0MpIC1vICRAIC1jICQoQUxMX0NGTEFHUykgJDwKIAogY2xlYW46IGNsZWFuLWNoZWNr
CiAJcm0gLWYgKi5bb2FdIC4qLmQgKi5zbyAkKFBST0dSQU1TKSAkKFNMSUJfRklMRSkgcHJlLXBy
b2Nlc3MuaCBzcGFyc2UucGMK
--bcaec51ba1f52c4fee04a0cfb8a2--
