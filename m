From: Chris Li <christ.li@gmail.com>
Subject: Re: typedefs and alignment
Date: Wed, 10 Feb 2010 01:46:39 -0800
Message-ID: <70318cbf1002100146r4b1ae748ida389c688d3fc4ce@mail.gmail.com>
References: <20100208103501.GA14210@bicker>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00c09f99e37a5601e6047f3be9e0
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:18331 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0BJJqn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Feb 2010 04:46:43 -0500
Received: by qw-out-2122.google.com with SMTP id 9so1046400qwb.37
        for <linux-sparse@vger.kernel.org>; Wed, 10 Feb 2010 01:46:42 -0800 (PST)
In-Reply-To: <20100208103501.GA14210@bicker>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-sparse@vger.kernel.org

--00c09f99e37a5601e6047f3be9e0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 8, 2010 at 2:35 AM, Dan Carpenter <error27@gmail.com> wrote:
> I've found an issue handling typedefs and alignment. =A0In the appended
> code sparse things 'ptr' has to be aligned so the size of 'bar' is 1024.
> I haven't looked at how to fix this at all, I thought I would ask the
> experts for hints first.

Can you try this one line patch?

Thanks

Chris

--00c09f99e37a5601e6047f3be9e0
Content-Type: application/octet-stream;
	name="0002-Pointer-don-t-inherent-the-alignment-from-base-type.patch"
Content-Disposition: attachment;
	filename="0002-Pointer-don-t-inherent-the-alignment-from-base-type.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5hxp1kd0

RnJvbSAyN2FmMDRjNDcxNjRkNmM2YTQ5ZjY0YzU2OGQyNGQ5OWE5MDJlNDQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8Y2hyaXNsQGhlbGkuKG5vbmUpPgpE
YXRlOiBXZWQsIDEwIEZlYiAyMDEwIDAxOjMyOjMwIC0wODAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IFBvaW50ZXIgZG9uJ3QgaW5oZXJlbnQgdGhlIGFsaWdubWVudCBmcm9tIGJhc2UgdHlwZQoKU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoZXIgTGkgPHNwYXJzZUBjaHJpc2xpLm9yZz4KLS0tCiBwYXJz
ZS5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9wYXJzZS5jIGIvcGFyc2UuYwppbmRleCA2NmI4MTEyLi5mODFi
MTlmIDEwMDY0NAotLS0gYS9wYXJzZS5jCisrKyBiL3BhcnNlLmMKQEAgLTE2OTgsNiArMTY5OCw3
IEBAIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKnBvaW50ZXIoc3RydWN0IHRva2VuICp0b2tlbiwgc3Ry
dWN0IGRlY2xfc3RhdGUgKmN0eCkKIAkJY3R4LT5jdHlwZS5iYXNlX3R5cGUgPSBwdHI7CiAJCWN0
eC0+Y3R5cGUuYXMgPSAwOwogCQljdHgtPmN0eXBlLmNvbnRleHRzID0gTlVMTDsKKwkJY3R4LT5j
dHlwZS5hbGlnbm1lbnQgPSAwOwogCiAJCXRva2VuID0gaGFuZGxlX3F1YWxpZmllcnModG9rZW4t
Pm5leHQsIGN0eCk7CiAJCWN0eC0+Y3R5cGUuYmFzZV90eXBlLT5lbmRwb3MgPSB0b2tlbi0+cG9z
OwotLSAKMS42LjIuNQoK
--00c09f99e37a5601e6047f3be9e0--
