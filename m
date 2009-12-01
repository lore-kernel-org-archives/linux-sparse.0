From: Christopher Li <sparse@chrisli.org>
Subject: Re: Re: Getting info from used typedef
Date: Tue, 1 Dec 2009 10:49:18 -0800
Message-ID: <70318cbf0912011049w4cab5e4qa74a15371511c8a4@mail.gmail.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>
	 <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
	 <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>
	 <OFBC143B24.B977DCC6-ONC125767F.0037DE90-C125767F.0044B96C@br-automation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d976262e4f490479af37a5
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:7784 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbZLAStN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Dec 2009 13:49:13 -0500
Received: by ey-out-2122.google.com with SMTP id 4so1267272eyf.19
        for <linux-sparse@vger.kernel.org>; Tue, 01 Dec 2009 10:49:19 -0800 (PST)
In-Reply-To: <OFBC143B24.B977DCC6-ONC125767F.0037DE90-C125767F.0044B96C@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

--0016e6d976262e4f490479af37a5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 1, 2009 at 4:30 AM, Thomas Schmid
<Thomas.Schmid@br-automation.com> wrote:
> Of course: I wrote a tool, which converts C-declarations into another
> format (IEC61131).
> These generated declarations are used as a interface to communicate to
> programs of different languages.
> This IEC-format uses datatypes, which are not known in ANSI C, such as th=
e
> following:
>
> typedef signed long =A0 =A0DINT;
> typedef unsigned long =A0UDINT;
> typedef signed long =A0 =A0TIME;
> typedef unsigned long =A0DATE_AND_TIME;
> typedef unsigned short UINT;
> typedef unsigned short WSTRING;
>

So you only use sparse as a C source code processing tool. You don't
care about the back end part of the sparse right?

In that case, you can try this one line patch. It should preserve the typed=
ef
symbol as the base type. I will not commit that to main line though.

Will that work for you?

Chris

--0016e6d976262e4f490479af37a5
Content-Type: application/octet-stream;
	name="0001-hacking-preserve-typedef-name.patch"
Content-Disposition: attachment;
	filename="0001-hacking-preserve-typedef-name.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2p0rvuw0

RnJvbSA2ZjFhNTc3YWY3ZDlmYTIzYzkwNzBmMjc4YmRhYjAyZGJmOGZiMDY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBUdWUsIDEgRGVjIDIwMDkgMTA6Mzg6MDIgLTA4MDAKU3ViamVjdDogW1BBVENIXSBoYWNr
aW5nIHByZXNlcnZlIHR5cGVkZWYgbmFtZS4KCi0tLQogcGFyc2UuYyB8ICAgIDIgKy0KIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3BhcnNlLmMgYi9wYXJzZS5jCmluZGV4IDY2YjgxMTIuLjI0OTEzNWIgMTAwNjQ0Ci0tLSBhL3Bh
cnNlLmMKKysrIGIvcGFyc2UuYwpAQCAtMTQyOSw3ICsxNDI5LDcgQEAgc3RhdGljIHN0cnVjdCB0
b2tlbiAqZGVjbGFyYXRpb25fc3BlY2lmaWVycyhzdHJ1Y3QgdG9rZW4gKnRva2VuLCBzdHJ1Y3Qg
ZGVjbF9zdGEKIAkJCWlmIChzZWVuICYgU2V0X0FueSkKIAkJCQlicmVhazsKIAkJCXNlZW4gfD0g
U2V0X1MgfCBTZXRfVDsKLQkJCWN0eC0+Y3R5cGUuYmFzZV90eXBlID0gcy0+Y3R5cGUuYmFzZV90
eXBlOworCQkJY3R4LT5jdHlwZS5iYXNlX3R5cGUgPSBzOwogCQkJYXBwbHlfY3R5cGUodG9rZW4t
PnBvcywgJnMtPmN0eXBlLCAmY3R4LT5jdHlwZSk7CiAJCQl0b2tlbiA9IHRva2VuLT5uZXh0Owog
CQkJY29udGludWU7Ci0tIAoxLjYuMC42Cgo=
--0016e6d976262e4f490479af37a5--
