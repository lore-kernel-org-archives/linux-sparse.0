From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: confusing shift warning
Date: Fri, 25 Apr 2008 11:58:36 +0300
Message-ID: <e51f66da0804250158o333eb371nbc0f810076c274cb@mail.gmail.com>
References: <e51f66da0804250053x2ec991dbu9a5a54fdcbea2a2a@mail.gmail.com>
	 <33544769883882222@unknownmsgid>
	 <e51f66da0804250134g7f05cc8fp9011d508f49295e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2748_19383171.1209113916510"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:10712 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758142AbYDYI6i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 04:58:38 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3515084fgb.17
        for <linux-sparse@vger.kernel.org>; Fri, 25 Apr 2008 01:58:36 -0700 (PDT)
In-Reply-To: <e51f66da0804250134g7f05cc8fp9011d508f49295e3@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

------=_Part_2748_19383171.1209113916510
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/25/08, Marko Kreen <markokr@gmail.com> wrote:
>  It seems that cgcc defaults to 64-bit on x86_64, but sparse to 32-bit.
>  Isn't it sparse bug then?  Shouldnt it follow platform defaults?

It can be fixed from cgcc side, but I still think its sparse bug,
the different defaults can still cause confusion in future.

Patch attached.

Sorry about attachement, but I don't trust gmail with copy-paste...

-- 
marko

------=_Part_2748_19383171.1209113916510
Content-Type: text/x-diff;
 name=0001-cgcc-always-pass-m32-m64-to-sparse-on-x86_64-def.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffgj5juz
Content-Disposition: attachment;
 filename=0001-cgcc-always-pass-m32-m64-to-sparse-on-x86_64-def.patch

RnJvbTogTWFya28gS3JlZW4gPG1hcmtva3JAZ21haWwuY29tPgpEYXRlOiBGcmksIDI1IEFwciAy
MDA4IDExOjUyOjQ3ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gY2djYzogYWx3YXlzIHBhc3MgLW0z
Mi8tbTY0IHRvIHNwYXJzZSBvbiB4ODZfNjQsIGRlZmF1bHRpbmcgdG8gLW02NC4KClNwYXJzZSBp
bnRlcm5hbGx5IGRlZmF1bHRzIHRvIC1tMzIuICBCeSBleHBsaWNpdGx5IGdpdmluZyAtbVhYLApj
Z2NjIG5vdyBmb2xsb3dzIHBsYXRmb3JtIHN0YW5kYXJkIG9uIHg4Nl82NCBhbmQgaXQgZnV0dXJl
LXByb29mCmFnYWluc3QgZml4aW5nIHNwYXJzZSBpbnRlcm5hbCBkZWZhdWx0LgoKU2lnbmVkLW9m
Zi1ieTogTWFya28gS3JlZW4gPG1hcmtva3JAZ21haWwuY29tPgotLS0KIGNnY2MgfCAgICAxICsK
IDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2NnY2MgYi9jZ2NjCmluZGV4IDRmYWI1MzAuLmQ4MGVhMDcgMTAwNzU1Ci0tLSBhL2Nn
Y2MKKysrIGIvY2djYwpAQCAtMjM4LDYgKzIzOCw3IEBAIHN1YiBhZGRfc3BlY3MgewogCQkmZGVm
aW5lX3NpemVfdCAoJG02NCA/ICJsb25nIHVuc2lnbmVkIGludCIgOiAidW5zaWduZWQgaW50Iikp
OwogICAgIH0gZWxzaWYgKCRzcGVjIGVxICd4ODZfNjQnKSB7CiAJcmV0dXJuICgnIC1EeDg2XzY0
PTEgLURfX3g4Nl82ND0xIC1EX194ODZfNjRfXz0xJyAuCisJCSgkbTMyID8gIiAtbTMyIiA6ICIg
LW02NCIpIC4KIAkJJmludGVnZXJfdHlwZXMgKDgsIDE2LCAzMiwgJG0zMiA/IDMyIDogNjQsIDY0
KSAuCiAJCSZmbG9hdF90eXBlcyAoMSwgMSwgMzMsIFsyNCw4XSwgWzUzLDExXSwgWzExMywxNV0p
IC4KIAkJJmRlZmluZV9zaXplX3QgKCRtMzIgPyAidW5zaWduZWQgaW50IiA6ICJsb25nIHVuc2ln
bmVkIGludCIpKTsKLS0gCjEuNS41LjEuNTcuZzU5MDljCgo=
------=_Part_2748_19383171.1209113916510--
