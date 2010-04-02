From: Christopher Li <sparse@chrisli.org>
Subject: Re: building of call tree
Date: Fri, 2 Apr 2010 10:55:19 -0700
Message-ID: <y2v70318cbf1004021055i2aa4ec82h1d6b2f43a2af01d0@mail.gmail.com>
References: <k2u48239d391004020916w712535dala168de2a6d2b2bf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43476 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab0DBRzU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Apr 2010 13:55:20 -0400
Received: by gyg13 with SMTP id 13so1089592gyg.19
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2010 10:55:19 -0700 (PDT)
In-Reply-To: <k2u48239d391004020916w712535dala168de2a6d2b2bf7@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Apr 2, 2010 at 9:16 AM, Sergey Lapin <slapinid@gmail.com> wrote:
> but I fail with scoping. I need to detect which function that
> particular reference belongs to,
> and how to detect if that reference is really a function.

What do you mean by "reference"? If you mean the struct symbol *
in the AST. It can point to the function prototype or declaration. It is easy to
find out the symbol is a function or not.

Some thing along the lines of :

if (sym->type == SYM_NODE)
    sym = sym->ctype.base_type
if (sym && sym->type = SYM_FN) {
    /* sym is a function */
}


> sym->type isn't what I need, sym->ctype.base_type is used to print base type,
> but I'd like to print type as is, and detect if that is a function a proper way.

You need understand that, each local variable or function start with a SYM_NODE.
SYM_NODE bind a type to a instance of the type. e.g. a variable.
A function is just a SYM_NODE with base type as SYM_FN.

You can also try debug_symbol(), see how it print out the function prototype.

I am about to post a AST inspection patch series. That tool should
help you understand
the AST as well. Stay tuned.

Chris
