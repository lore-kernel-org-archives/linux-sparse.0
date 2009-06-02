From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/4] Have Makefile import config.mak if it exists.
Date: Tue, 2 Jun 2009 13:30:48 -0700
Message-ID: <70318cbf0906021330n7d0df47y5010dd158f731966@mail.gmail.com>
References: <1243881445-30069-1-git-send-email-naesten@gmail.com>
	 <1243881445-30069-2-git-send-email-naesten@gmail.com>
	 <1243881445-30069-3-git-send-email-naesten@gmail.com>
	 <1243881445-30069-4-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd3287207b7e2046b636b03
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:5687 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbZFBUaq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Jun 2009 16:30:46 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2977887wfd.4
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jun 2009 13:30:48 -0700 (PDT)
In-Reply-To: <1243881445-30069-4-git-send-email-naesten@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
Cc: linux-sparse@vger.kernel.org

--000e0cd3287207b7e2046b636b03
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Jun 1, 2009 at 11:37 AM, Samuel Bronson <naesten@gmail.com> wrote:
> This will allow users to override build settings without dirtying their
> trees, making life with `git stash' a bit easier.
>
I modify the patch to use "local.mk" and add it in .gitignore.

If that works for you, I am going to apply it as yours.

Thanks

Chris

--000e0cd3287207b7e2046b636b03
Content-Type: application/octet-stream;
	name="4-4-Have-Makefile-import-config.mak-if-it-exists..patch"
Content-Disposition: attachment;
	filename="4-4-Have-Makefile-import-config.mak-if-it-exists..patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvgl25le0

RnJvbSBwYXRjaHdvcmsgTW9uIEp1biAgMSAxODozNzoyNSAyMDA5CkNvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD0idXRmLTgiCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDdiaXQKU3ViamVjdDogWzQvNF0gSGF2ZSBNYWtlZmlsZSBpbXBvcnQgY29u
ZmlnLm1hayBpZiBpdCBleGlzdHMuCkRhdGU6IE1vbiwgMDEgSnVuIDIwMDkgMTg6Mzc6MjUgLTAw
MDAKRnJvbTogU2FtdWVsIEJyb25zb24gPG5hZXN0ZW5AZ21haWwuY29tPgpYLVBhdGNod29yay1J
ZDogMjcyNjQKClRoaXMgd2lsbCBhbGxvdyB1c2VycyB0byBvdmVycmlkZSBidWlsZCBzZXR0aW5n
cyB3aXRob3V0IGRpcnR5aW5nIHRoZWlyCnRyZWVzLCBtYWtpbmcgbGlmZSB3aXRoIGBnaXQgc3Rh
c2gnIGEgYml0IGVhc2llci4KClNpZ25lZC1vZmYtYnk6IFNhbXVlbCBCcm9uc29uIDxuYWVzdGVu
QGdtYWlsLmNvbT4KCi0tLQpNYWtlZmlsZSB8ICAgMTAgKysrKysrKystLQogMSBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpJbmRleDogc3BhcnNlLmNocmlz
bC9NYWtlZmlsZQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Ci0tLSBzcGFyc2UuY2hyaXNsLm9yaWcvTWFrZWZpbGUKKysr
IHNwYXJzZS5jaHJpc2wvTWFrZWZpbGUKQEAgLTEwLDkgKzEwLDEwIEBAIExERkxBR1MgKz0gLWcK
IEFSID0gYXIKIAogIwotIyBGb3IgZGVidWdnaW5nLCB1bmNvbW1lbnQgdGhlIG5leHQgb25lCisj
IEZvciBkZWJ1Z2dpbmcsIHB1dCB0aGlzIGluIGxvY2FsLm1rOgorIworIyAgICAgQ0ZMQUdTICs9
IC1PMCAtRERFQlVHIC1nMyAtZ2R3YXJmLTIKICMKLSNDRkxBR1MgKz0gLU8wIC1EREVCVUcgLWcz
IC1nZHdhcmYtMgogCiBIQVZFX0xJQlhNTD0kKHNoZWxsIHBrZy1jb25maWcgLS1leGlzdHMgbGli
eG1sLTIuMCAmJiBlY2hvICd5ZXMnKQogSEFWRV9HQ0NfREVQPSQoc2hlbGwgdG91Y2ggLmdjYy10
ZXN0LmMgJiYgCQkJCVwKQEAgLTg5LDYgKzkwLDExIEBAIFNFRF9QQ19DTUQgPSAnc3xAdmVyc2lv
bkB8JChWRVJTSU9OKXxnOwkKIAkgICAgICBzfEBpbmNsdWRlZGlyQHwkKElOQ0xVREVESVIpfGcn
CiAKIAorCisjIEFsbG93IHVzZXJzIHRvIG92ZXJyaWRlIGJ1aWxkIHNldHRpbmdzIHdpdGhvdXQg
ZGlydHlpbmcgdGhlaXIgdHJlZXMKKy1pbmNsdWRlIGxvY2FsLm1rCisKKwogYWxsOiAkKFBST0dS
QU1TKSBzcGFyc2UucGMKIAogaW5zdGFsbDogJChJTlNUX1BST0dSQU1TKSAkKExJQlMpICQoTElC
X0gpIHNwYXJzZS5wYwpJbmRleDogc3BhcnNlLmNocmlzbC8uZ2l0aWdub3JlCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
LS0tIHNwYXJzZS5jaHJpc2wub3JpZy8uZ2l0aWdub3JlCisrKyBzcGFyc2UuY2hyaXNsLy5naXRp
Z25vcmUKQEAgLTMzLDMgKzMzLDcgQEAgcGF0Y2hlcy0qCiAjIHF1aWx0J3MgZmlsZXMKIHBhdGNo
ZXMKIHNlcmllcworCisjIGxvY2FsIG1ha2VmaWxlCitsb2NhbC5taworCg==
--000e0cd3287207b7e2046b636b03--
