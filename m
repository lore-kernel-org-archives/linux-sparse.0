From: Christopher Li <sparse@chrisli.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Sun, 28 Aug 2011 01:51:47 -0700
Message-ID: <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636831d56833f8b04ab8ce3ba
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46883 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1H1Ivs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 04:51:48 -0400
Received: by qwk3 with SMTP id 3so2751641qwk.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 01:51:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

--001636831d56833f8b04ab8ce3ba
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 27, 2011 at 11:08 PM, Pekka Enberg <penberg@kernel.org> wrote:
> Hi everyone,
>
> Jeff Garzik and myself have been hacking on LLVM backed for Sparse. The
> sources
> are available on Github:
>
> =A0git clone git://github.com/penberg/sparse-llvm.git
>

Very impressive. That is some sparse 0.5 material.
I will start merging it as soon as I release 0.4.4

I play around with it a little bit, It seems choke on the hello
world program. Shouldn't be hard to fix though.

I attach a patch to limit g++ usage only to llvm related programs.
Currently it use g++ to link other sparse programs.

Chris

--001636831d56833f8b04ab8ce3ba
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Limit-usage-of-g-to-llvm-related-programs.patch"
Content-Disposition: attachment;
	filename="0001-Limit-usage-of-g-to-llvm-related-programs.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grvs2i0p0

RnJvbSBjMDBkMTAyMGFiZjUyNDA1NzgzZmE5NzNkYTZmMjhmZTcwMGZhYzNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBTdW4sIDI4IEF1ZyAyMDExIDAxOjA0OjQxIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gTGlt
aXQgdXNhZ2Ugb2YgZysrIHRvIGxsdm0gcmVsYXRlZCBwcm9ncmFtcy4KClNpZ25lZC1vZmYtYnk6
IENocmlzdG9waGVyIExpIDxzcGFyc2VAY2hyaXNsaS5vcmc+Ci0tLQogTWFrZWZpbGUgfCAgICA1
ICsrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IGE5ZjliMzUuLmFiMGIxODYg
MTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC02NiwxMSArNjYsMTIgQEAg
JCh3YXJuaW5nIFlvdXIgc3lzdGVtIGRvZXMgbm90IGhhdmUgbGliZ3RrMiwgZGlzYWJsaW5nIHRl
c3QtaW5zcGVjdCkKIGVuZGlmCiAKIGlmZXEgKCQoSEFWRV9MTFZNKSx5ZXMpCi1MRCA9IGcrKwor
TExWTV9QUk9HUyA6PSBzcGFyc2UtbGx2bSAKKyQoTExWTV9QUk9HUyk6IExEIDo9IGcrKwogTERG
TEFHUyArPSAkKHNoZWxsIGxsdm0tY29uZmlnIC0tbGRmbGFncykKIExMVk1fQ0ZMQUdTIDo9ICQo
c2hlbGwgbGx2bS1jb25maWcgLS1jZmxhZ3MgfCBzZWQgLWUgInMvLUROREVCVUcvL2ciKQogTExW
TV9MSUJTIDo9ICQoc2hlbGwgbGx2bS1jb25maWcgLS1saWJzKQotUFJPR1JBTVMgKz0gc3BhcnNl
LWxsdm0KK1BST0dSQU1TICs9ICQoTExWTV9QUk9HUykKIElOU1RfUFJPR1JBTVMgKz0gc3BhcnNl
LWxsdm0gc3BhcnNlYwogc3BhcnNlLWxsdm1fRVhUUkFfREVQUyA6PSBzcGFyc2UtbGx2bS5vCiBz
cGFyc2UtbGx2bS5vICQoc3BhcnNlLWxsdm1fRVhUUkFfREVQUyk6IEJBU0lDX0NGTEFHUyArPSAk
KExMVk1fQ0ZMQUdTKQotLSAKMS43LjYKCg==
--001636831d56833f8b04ab8ce3ba--
