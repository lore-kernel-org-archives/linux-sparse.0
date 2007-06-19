From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [patchset] rewrite of initializer handling
Date: Tue, 19 Jun 2007 21:12:36 +0400
Message-ID: <20070619171236.GA5751@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:36732 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbXFSRIc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2007 13:08:32 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2707565mue
        for <linux-sparse@vger.kernel.org>; Tue, 19 Jun 2007 10:08:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: viro@ftp.linux.org.uk
Cc: linux-sparse@vger.kernel.org

sparse can segfault in while loop in is_string_literal():

static int is_string_literal(struct expression **v)
{
	struct expression *e = *v;
	while (e->type == EXPR_PREOP && e->op == '(')
===>		e = e->unop;	<===

Here expression is NULL.

Steps to reproduce:

	$ echo 'char a[][] = {(};' | sparse -
	-:1:16: error: Expected ) in expression
	-:1:16: error: got }
	Segmentation fault
