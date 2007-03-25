From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] handle label attributes
Date: Sun, 25 Mar 2007 11:52:23 -0700
Message-ID: <20070325115223.f040a571.rdunlap@xenotime.net>
References: <20070322063600.GD15364@redhat.com>
	<20070322073344.GU4095@ftp.linux.org.uk>
	<20070322070354.GA22151@chrisli.org>
	<20070322171118.GL15364@redhat.com>
	<20070322221050.GC22151@chrisli.org>
	<20070323150459.52b02342.rdunlap@xenotime.net>
	<20070323231008.GD27992@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:37952 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751950AbXCYSvQ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 25 Mar 2007 14:51:16 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Sun, 25 Mar 2007 11:51:12 -0700
In-Reply-To: <20070323231008.GD27992@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Fri, 23 Mar 2007 16:10:08 -0700 Christopher Li wrote:

> On Fri, Mar 23, 2007 at 03:04:59PM -0700, Randy Dunlap wrote:
> > 1.  net/sched/cls_api.c, lines 593-611:
> > 
> > 	return 0;
> > rtattr_failure: __attribute__ ((unused))
> > 	return -1;
> > }
> 
> 
> Singed-Off-By: Christopher Li<sparse@chrisli.org>

Hi,
Yes, that does handle the label attributes cleanly.

Thanks.

> Index: sparse/parse.c
> ===================================================================
> --- sparse.orig/parse.c	2007-03-23 16:09:39.000000000 -0700
> +++ sparse/parse.c	2007-03-23 16:10:00.000000000 -0700
> @@ -1701,7 +1701,8 @@ static struct token *statement(struct to
>  		if (match_op(token->next, ':')) {
>  			stmt->type = STMT_LABEL;
>  			stmt->label_identifier = label_symbol(token);
> -			return statement(token->next->next, &stmt->label_statement);
> +			token = handle_attributes(token->next->next, &stmt->label_identifier->ctype);
> +			return statement(token, &stmt->label_statement);
>  		}
>  	}
>  
> Index: sparse/validation/label-attr.c
> ===================================================================
> --- sparse.orig/validation/label-attr.c	2007-03-23 16:10:00.000000000 -0700
> +++ sparse/validation/label-attr.c	2007-03-23 16:10:00.000000000 -0700
> @@ -0,0 +1,6 @@
> +int foo(void)
> +{
> +       return 0;
> +rtattr_failure: __attribute__ ((unused))
> +       return -1;
> +}
> 


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
