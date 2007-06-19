From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patchset] rewrite of initializer handling
Date: Tue, 19 Jun 2007 18:21:43 +0100
Message-ID: <20070619172143.GM21478@ftp.linux.org.uk>
References: <20070619171236.GA5751@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37555 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936AbXFSRVo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2007 13:21:44 -0400
Content-Disposition: inline
In-Reply-To: <20070619171236.GA5751@martell.zuzino.mipt.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Jun 19, 2007 at 09:12:36PM +0400, Alexey Dobriyan wrote:
> sparse can segfault in while loop in is_string_literal():
> 
> static int is_string_literal(struct expression **v)
> {
> 	struct expression *e = *v;
> 	while (e->type == EXPR_PREOP && e->op == '(')
> ===>		e = e->unop;	<===
> 
> Here expression is NULL.
> 
> Steps to reproduce:
> 
> 	$ echo 'char a[][] = {(};' | sparse -
> 	-:1:16: error: Expected ) in expression
> 	-:1:16: error: got }
> 	Segmentation fault

Gaack...  The fix is obvious (add e && into that condition and into
e->type == EXPR_STRING a couple of lines below), but...  I wonder
if adding EXPR_BAD and using it to deal with such crap in parser
would be better.  Comments?
