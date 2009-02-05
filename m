From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] Fix type_info_expression()
Date: Thu, 5 Feb 2009 19:23:23 +0000
Message-ID: <20090205192322.GN28946@ZenIV.linux.org.uk>
References: <20090202073151.GC28946@ZenIV.linux.org.uk> <70318cbf0902051029n11975b41l38f17a635dcf5fbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39506 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbZBETXZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 14:23:25 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0902051029n11975b41l38f17a635dcf5fbd@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Feb 05, 2009 at 10:29:19AM -0800, Christopher Li wrote:

> Setting expr->cast_type = NULL here is not straightly necessary right?
> The expr is EXPR_SIZEOF type, the expr->cast_type is not used in
> evaluation_sizeof. Of course it doesn't hurt, I just want to get a confirm
> that I understand it correct.y.

Take a look at evaluate_type_information().  If ->cast_type is not NULL,
it won't even look at ->cast_expression.  For sizeof (struct foo){0,1} that's
fine (you end with with sizeof(struct foo), essentially), but for
sizeof(struct foo){0,1}.x that'll give you the wrong answer.

IOW, it is necessary.
