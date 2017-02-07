From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH 2/3] allow builtins to have prototype and evaluate/expand methods
Date: Wed, 8 Feb 2017 03:49:54 +0800
Message-ID: <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com> <20170123213728.89900-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c0562ca5dcede0547f60da4
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35832 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932098AbdBGTuB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 14:50:01 -0500
Received: by mail-io0-f195.google.com with SMTP id m98so13844998iod.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 11:49:55 -0800 (PST)
In-Reply-To: <20170123213728.89900-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>

--94eb2c0562ca5dcede0547f60da4
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 24, 2017 at 5:37 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> So far, builtin functions which had some evaluate/expand method
> couldn't also have a prototype because each would have its own symbol
> and only the one for the prototype will be seen.
> This also meant that the evaluate/expand functions had to take care
> to set the correct types for they argumenst & results, which is fine
> for some generic builtins like __builtin_constant_p() it's much less
> practical for the ones like __builtin_bswap{16,32,64}().
>
> Fix this by marking the idents for the builtins we declare some
> evaluate/expand methods has being the ident of a builtin function
> and later at evaluation time, to share the methods between all the symbols
> corresponding to an identifier so marked.

This certainly fix the problem for builtin functions. However, I think there
is more general bug in sparse not limit to builtin functions. When the symbol
is declare twice, the later one did not migrate all the declare information from
the previous one.

In function external_declaration()

        check_declaration(decl);
        if (decl->same_symbol)
                decl->definition = decl->same_symbol->definition;

Here it only migrates the definition. I think if you add symbol->op in
the migration
as well, it *should* work for your case. I haven't test this myself.
If that works for you, it is a more general fix. Want to give it a try?

We might want to extract the migration code into a new function and
later adding new code it. e.g. function attributes.

A more complicate example will involve same symbol in different scope.

void __attr_x foo(void);

void a(void)
{
        void __attr_y foo(void); // foo should have both __attr_{x,y}
        {
                void _attr_z foo(void); // foo should have all __attr_{x,y,z}
        }
        // now foo should only have __attr_{x,y}
}

update:

I attach a quick and dirty patch file for you to try. It will replace
this 2/3 patch.
I just try the test suite and nothing seems complain about it.

Chris

--94eb2c0562ca5dcede0547f60da4
Content-Type: application/octet-stream; name=migrate-same-symbol
Content-Disposition: attachment; filename=migrate-same-symbol
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iyvxppxl0

Ci0tLSBzcGFyc2UuY2hyaXNsLm9yaWcvcGFyc2UuYworKysgc3BhcnNlLmNocmlzbC9wYXJzZS5j
CkBAIC0yODc5LDggKzI4NzksMTAgQEAgc3RydWN0IHRva2VuICpleHRlcm5hbF9kZWNsYXJhdGlv
bihzdHJ1YwogCQkJfQogCQl9CiAJCWNoZWNrX2RlY2xhcmF0aW9uKGRlY2wpOwotCQlpZiAoZGVj
bC0+c2FtZV9zeW1ib2wpCisJCWlmIChkZWNsLT5zYW1lX3N5bWJvbCkgewogCQkJZGVjbC0+ZGVm
aW5pdGlvbiA9IGRlY2wtPnNhbWVfc3ltYm9sLT5kZWZpbml0aW9uOworCQkJZGVjbC0+b3AgPSBk
ZWNsLT5zYW1lX3N5bWJvbC0+b3A7CisJCX0KIAogCQlpZiAoIW1hdGNoX29wKHRva2VuLCAnLCcp
KQogCQkJYnJlYWs7Cg==
--94eb2c0562ca5dcede0547f60da4--
