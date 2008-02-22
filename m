From: "Chris Li" <christ.li@gmail.com>
Subject: Re: for (int i = expr; ....)
Date: Fri, 22 Feb 2008 12:26:30 -0800
Message-ID: <70318cbf0802221226l7888c24auafbe2aabfa9774b9@mail.gmail.com>
References: <20080221150527.GA7117@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2208_26328.1203711990305"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:47098 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYBVU0c (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Feb 2008 15:26:32 -0500
Received: by wr-out-0506.google.com with SMTP id c48so838151wra.23
        for <linux-sparse@vger.kernel.org>; Fri, 22 Feb 2008 12:26:31 -0800 (PST)
In-Reply-To: <20080221150527.GA7117@artemis.madism.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pierre Habouzit <pierre.habouzit@m4x.org>
Cc: linux-sparse@vger.kernel.org

------=_Part_2208_26328.1203711990305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Feb 21, 2008 at 7:05 AM, Pierre Habouzit
<pierre.habouzit@m4x.org> wrote:
> Sparse doesn't support the C99 construct `for (int i = expr; ....)` properly.
>  for example, the following C code:
>
>     #include <stdlib.h>
>
>     int main(void)
>     {
>         for (int i = atoi("12"); i < 10; i++);
>         return 0;
>     }
>
>  make sparse spit:
>
>     $ sparse -Wall test.c
>     test.c:5:22: warning: call with no type!
>
>  In fact sparse doesn't support 'expr' to be a complex enough expression
>  (expressions that can be folded work, but not any other afaict).

Nah, sparse supports expression in initializer all right.
It just need to evaluate them to give it the correct ctype.

Please try the this one line patch I attached.

Chris

------=_Part_2208_26328.1203711990305
Content-Type: application/octet-stream; name=init-notype
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fcz2erf90
Content-Disposition: attachment; filename=init-notype

ZXZhbHVhdGUgaXRlcmF0b3Igc3ltYm9scwoKZXZhbHVhdGUuYyBmb3JnZXRzIHRvIGV2YWx1YXRl
IGl0ZXJhdG9yX3N5bXMsIHdoaWNoCm1pZ2h0IGhhdmUgc29tZSBleHByZXNzaW9uIGluIGluaXRp
YWxpemVyLgoKU2lnbmVkLU9mZi1CeTogQ2hyaXN0b3BoZXIgTGkgPHNwYXJzZUBjaHJpc2xpLm9y
Zz4KCkluZGV4OiBzcGFyc2UvZXZhbHVhdGUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBzcGFyc2Uub3JpZy9l
dmFsdWF0ZS5jCTIwMDgtMDItMTMgMDk6MjU6MjEuMDAwMDAwMDAwIC0wODAwCisrKyBzcGFyc2Uv
ZXZhbHVhdGUuYwkyMDA4LTAyLTIyIDEwOjA3OjEwLjAwMDAwMDAwMCAtMDgwMApAQCAtMzA5Myw2
ICszMDkzLDcgQEAgc3RhdGljIHZvaWQgZXZhbHVhdGVfaWZfc3RhdGVtZW50KHN0cnVjdAogCiBz
dGF0aWMgdm9pZCBldmFsdWF0ZV9pdGVyYXRvcihzdHJ1Y3Qgc3RhdGVtZW50ICpzdG10KQogewor
CWV2YWx1YXRlX3N5bWJvbF9saXN0KHN0bXQtPml0ZXJhdG9yX3N5bXMpOwogCWV2YWx1YXRlX2Nv
bmRpdGlvbmFsKHN0bXQtPml0ZXJhdG9yX3ByZV9jb25kaXRpb24sIDEpOwogCWV2YWx1YXRlX2Nv
bmRpdGlvbmFsKHN0bXQtPml0ZXJhdG9yX3Bvc3RfY29uZGl0aW9uLDEpOwogCWV2YWx1YXRlX3N0
YXRlbWVudChzdG10LT5pdGVyYXRvcl9wcmVfc3RhdGVtZW50KTsK
------=_Part_2208_26328.1203711990305--
