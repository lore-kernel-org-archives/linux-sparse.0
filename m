From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] cpp: silently allow conditional directives within macro
Date: Fri, 13 Mar 2020 17:17:48 +0100
Message-ID: <20200313161748.GA22910@redhat.com>
References: <CAHk-=wiNPBt4wNkfgSd_utshPkjqQv-z7cg5iCji2jbFAUrLkg@mail.gmail.com>
 <20200312211630.53710-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgCMQRy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 13 Mar 2020 12:17:54 -0400
In-Reply-To: <20200312211630.53710-1-luc.vanoostenryck@gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 03/12, Luc Van Oostenryck wrote:
>
> @@ -2098,6 +2103,12 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
>  		if (false_nesting)
>  			goto out;
>  	}
> +
> +	if (expanding) {
> +		if (Wdirective_within_macro && !is_cond)
                    ^^^^^^^^^^^^^^^^^^^^^^^
I am not sure Wdirective_within_macro is really useful after this change,
I'd suggest to drop my patch but this is up to you.

Anyway,

> +			warning(start->pos, "directive in macro's argument list");
> +		expanding = 0;		// warn only once
> +	}

then you should probably update preprocessor22.c ? See below.

I am not sure about validation/preprocessor/expand-redef.c added by the
previous patch,

	 * check-output-start

	 1 2 1 2
	 * check-output-end

shouldn't you add check-known-to-fail into this file or change the output

	1
	2 1
	2

?

Oleg.


--- a/validation/preprocessor/preprocessor22.c
+++ b/validation/preprocessor/preprocessor22.c
@@ -19,13 +19,6 @@ define_struct(a, {
  *
  * check-command: sparse -E $file
  *
- * check-error-start
-preprocessor/preprocessor22.c:6:1: warning: directive in macro's argument list
-preprocessor/preprocessor22.c:8:1: warning: directive in macro's argument list
-preprocessor/preprocessor22.c:10:1: warning: directive in macro's argument list
-preprocessor/preprocessor22.c:12:1: warning: directive in macro's argument list
- * check-error-end
- *
  * check-output-start
 
 struct {
