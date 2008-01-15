From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] saner warnings for restricted types
Date: Tue, 15 Jan 2008 12:36:12 -0500
Message-ID: <1200418572.17542.2.camel@dv>
References: <20080115165236.GS27894@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:57589 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756721AbYAORgP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jan 2008 12:36:15 -0500
In-Reply-To: <20080115165236.GS27894@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Tue, 2008-01-15 at 16:52 +0000, Al Viro wrote:
>  	if (class & TYPE_RESTRICT) {
> -		warning(expr->pos, "restricted degrades to integer");
>  		if (class & TYPE_FOULED)
>  			*ctype = unfoul(*ctype);
> +		warning(expr->pos, "%sdegrades to integer",
> +			show_typename(*ctype));

Missing space after "%s"?

-- 
Regards,
Pavel Roskin
