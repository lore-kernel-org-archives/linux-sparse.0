From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix type_info_expression()
Date: Thu, 5 Feb 2009 10:29:19 -0800
Message-ID: <70318cbf0902051029n11975b41l38f17a635dcf5fbd@mail.gmail.com>
References: <20090202073151.GC28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:19141 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbZBES3V (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 13:29:21 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2582542rvb.5
        for <linux-sparse@vger.kernel.org>; Thu, 05 Feb 2009 10:29:20 -0800 (PST)
In-Reply-To: <20090202073151.GC28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Sun, Feb 1, 2009 at 11:31 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> sizeof (typename){initializers}.foo is nice and valid C99 - it's parsed
> as sizeof primary.foo <- sizeof postfix.foo <- sizeof postfix <- sizeof unary
> <- unary.  Current type_info_expression() stops too early.

Thanks for the patch. Looks great.

> -       if (match_op(token, '{'))
> -               token = initializer(&expr->cast_expression, token);
> +       if (match_op(token, '{')) {
> +               struct expression *cast = alloc_expression(p->pos, EXPR_CAST);
> +               cast->cast_type = expr->cast_type;
> +               expr->cast_type = NULL;

Setting expr->cast_type = NULL here is not straightly necessary right?
The expr is EXPR_SIZEOF type, the expr->cast_type is not used in
evaluation_sizeof. Of course it doesn't hurt, I just want to get a confirm
that I understand it correct.y.

Chris
