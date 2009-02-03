From: Christopher Li <sparse@chrisli.org>
Subject: Re: fun with declarations and definitions
Date: Mon, 2 Feb 2009 19:07:24 -0800
Message-ID: <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:34345 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbZBCDHZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 22:07:25 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1795335rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 02 Feb 2009 19:07:24 -0800 (PST)
In-Reply-To: <20090202073018.GB28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Sun, Feb 1, 2009 at 11:30 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Anyway, proposed patch for (1) follows:

I read the patch, seems reasonable. It is only solve the inline case though.
The more generic problem still exist, symbol look up between partial
prototype declare and the real declare will get symbol with partial
information.

It would be great if we can apply the definition to the first symbol. But
I can haven't find a clean way to do it yet.

Most likely I will apply your patch until we find a better way to do it.

> @@ -2282,6 +2295,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>                        }
>                }
>        } else if (base_type && base_type->type == SYM_FN) {
> +               if (decl->next_id && decl->next_id->scope == decl->scope)

Not sure what this is trying to do. Shouldn't the next line to be indented
if I read it correctly?

Chris
