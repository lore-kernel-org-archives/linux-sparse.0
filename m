From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/3] allow builtins to have prototype and evaluate/expand methods
Date: Wed, 8 Feb 2017 04:32:08 +0800
Message-ID: <CANeU7QnfuFjr_bZRqeED8Q54xcm-yeo9-=R8vVHbhvt8ukjxTQ@mail.gmail.com>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
 <20170123213728.89900-3-luc.vanoostenryck@gmail.com> <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
 <20170207201253.4i2ye6inqwma65rf@macpro.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1140bd8e6030440547f6a47f
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35463 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdBGUlm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:41:42 -0500
Received: by mail-it0-f66.google.com with SMTP id 203so13549828ith.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:41:42 -0800 (PST)
In-Reply-To: <20170207201253.4i2ye6inqwma65rf@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

--001a1140bd8e6030440547f6a47f
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 8, 2017 at 4:12 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I'm very well aware of this bug/problem, it creates all sort of complications
> but I vaguely understood it was a design choice. To be 100%, you're talking
> the fact that each declaration create a new symbol only related by their
> identifier chain, right?

Yes. I don't see a way not creating the symbol for each declaration.
However, we can make a better job at migrating the bits between each
declaration.

>
> Yes and diagnose any compatibility.
> I'll give it a try but I won't be able to do that before the weekend.

No problem. Just in case you miss it. I attach a one line patch in my
previous email. I attach it here again.

Chris

--001a1140bd8e6030440547f6a47f
Content-Type: text/x-patch; charset=US-ASCII; name="migrate-same-symbol.patch"
Content-Disposition: attachment; filename="migrate-same-symbol.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iyvzfd1z0

Ci0tLSBzcGFyc2UuY2hyaXNsLm9yaWcvcGFyc2UuYworKysgc3BhcnNlLmNocmlzbC9wYXJzZS5j
CkBAIC0yODc5LDggKzI4NzksMTAgQEAgc3RydWN0IHRva2VuICpleHRlcm5hbF9kZWNsYXJhdGlv
bihzdHJ1YwogCQkJfQogCQl9CiAJCWNoZWNrX2RlY2xhcmF0aW9uKGRlY2wpOwotCQlpZiAoZGVj
bC0+c2FtZV9zeW1ib2wpCisJCWlmIChkZWNsLT5zYW1lX3N5bWJvbCkgewogCQkJZGVjbC0+ZGVm
aW5pdGlvbiA9IGRlY2wtPnNhbWVfc3ltYm9sLT5kZWZpbml0aW9uOworCQkJZGVjbC0+b3AgPSBk
ZWNsLT5zYW1lX3N5bWJvbC0+b3A7CisJCX0KIAogCQlpZiAoIW1hdGNoX29wKHRva2VuLCAnLCcp
KQogCQkJYnJlYWs7Cg==
--001a1140bd8e6030440547f6a47f--
