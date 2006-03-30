From: "Mitesh Shah" <mshah@teja.com>
Subject: FW: assignment expressions are not validated
Date: Wed, 29 Mar 2006 16:17:49 -0800
Message-ID: <AKEOJDDJLNPHDAKOMMBHAEIOCJAA.mshah@teja.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.teja.com ([209.10.202.133]:43963 "EHLO mail.teja.com")
	by vger.kernel.org with ESMTP id S1751287AbWC3AQj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Mar 2006 19:16:39 -0500
Received: from SURAT ([172.20.3.219])
	(authenticated user mshah@teja.com)
	by mail.teja.com (Kerio MailServer 6.0.8)
	for linux-sparse@vger.kernel.org;
	Wed, 29 Mar 2006 16:16:32 -0800
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>


Any input regarding this patch?

Thanks,

-Mitesh


> -----Original Message-----
> From: linux-sparse-owner@vger.kernel.org
> [mailto:linux-sparse-owner@vger.kernel.org]On Behalf Of Mitesh Shah
> Sent: Tuesday, March 21, 2006 12:37 PM
> To: Linux-Sparse
> Subject: assignment expressions are not validated
> 
> 
> 
> There is no error/warning for the following code:
> 
> void f(void) {
> 
>   int a;
> 
>   a = ;
> 
> }
> 
> 
> Looks like there is no check for empty expression in 
> primary_expression.
> default case simply ignores the token. Instead we can add a 
> sparse_error
> at line 360.
> 
> -Mitesh
> 
> 
> 
>  Index: expression.c
> ===================================================================
> RCS file: /home/cvs/root/sparse-bk/expression.c,v
> retrieving revision 1.10
> diff -u -r1.10 expression.c
> --- expression.c        16 Nov 2005 23:28:58 -0000      1.10
> +++ expression.c        21 Mar 2006 20:36:52 -0000
> @@ -357,7 +357,7 @@
>                 }
> 
>         default:
> -               ;
> +               sparse_error(token->pos, "Expected an expression");
>         }
>         *tree = expr;
>         return token;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

