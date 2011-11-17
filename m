From: Christopher Li <sparse@chrisli.org>
Subject: Re: Reduced call graph
Date: Thu, 17 Nov 2011 14:12:21 -0800
Message-ID: <CANeU7Qns9GDx=XtiEzBph-3gq7WKX+uZMyVu7y3GETzAenFEVg@mail.gmail.com>
References: <CACsJy8A2X0WukKXerJAN6pxARoGSh1O=8FM+iTZL-xzDCQ1W=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59280 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab1KQWMW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Nov 2011 17:12:22 -0500
Received: by ggnb2 with SMTP id b2so1713703ggn.19
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2011 14:12:21 -0800 (PST)
In-Reply-To: <CACsJy8A2X0WukKXerJAN6pxARoGSh1O=8FM+iTZL-xzDCQ1W=w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Nov 16, 2011 at 5:23 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hi,
>
> Is it possible to ask "graph" to generate a call graph of all calls
> from main() to specific function? If "graph" does not support it (I
> suspect so after looking at graph.c), could you please give me a few
> hints how to do it? I'm completely new to sparse.

Hi Duy,

In order to find out all the call graphs, you need to at least run
very file in sparse. Then for each function, after linearization, you
can find out all the "call" instruction. A easier but not so precise
way is examine the "access" list in the entry point. That will
include every symbol rather than just function called.

e.g.

		struct entrypoint *ep;
		pseudo_t p;

		expand_symbol(sym);
		ep = linearize_symbol(sym);

		FOR_EACH_PTR(ep->accesses, p) {
			printf("   pseudo: %p type %d %s\n", p, p->type, show_pseudo(p));
		} END_FOR_EACH_PTR(p);

You just filter out the non-function symbols. However you need to write
some code to do that recursively.

Hope that helps.

Chris
