From: Jeff Layton <jlayton@redhat.com>
Subject: error: undefined identifier '__builtin_va_arg_pack'
Date: Thu, 18 Jul 2013 08:47:43 -0400
Message-ID: <20130718084743.727666bc@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47173 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab3GRMrp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jul 2013 08:47:45 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r6ICljNi002665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-sparse@vger.kernel.org>; Thu, 18 Jul 2013 08:47:45 -0400
Received: from tlielax.poochiereds.net (vpn-56-72.rdu2.redhat.com [10.10.56.72])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r6ICli9v023695
	for <linux-sparse@vger.kernel.org>; Thu, 18 Jul 2013 08:47:44 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I was running sparse on some code I maintain and saw a bunch of
warnings like this:

    /usr/include/bits/stdio2.h:98:25: error: undefined identifier '__builtin_va_arg_pack'
    /usr/include/bits/stdio2.h:98:25: error: not a function <noident>

It looks like gcc defines this in recent versions:

    http://gcc.gnu.org/onlinedocs/gcc/Constructing-Calls.html

It seems like something like this might do the trick for
__builtin_va_arg_pack_len:

-----------------[snip]------------------
diff --git a/lib.c b/lib.c
index 7e822eb..db981d8 100644
--- a/lib.c
+++ b/lib.c
@@ -779,6 +779,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
 	add_pre_buffer("extern void __sync_synchronize();\n");
 	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, ...);\n");
+	add_pre_buffer("extern size_t __builtin_va_arg_pack_len(void);\n");
 
 	/* Add Blackfin-specific stuff */
 	add_pre_buffer(
-----------------[snip]------------------

...but I'm unclear on how best to fix the errors around
__builtin_va_arg_pack since it doesn't seem to return a well-defined
type.

Thanks...
-- 
Jeff Layton <jlayton@redhat.com>
