From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 18:07:33 -0400
Message-ID: <4E596AA5.9080401@garzik.org>
References: <4E588EB8.80808@garzik.org> <201108271334.17659.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57227 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1H0WHi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 18:07:38 -0400
Received: by qyk15 with SMTP id 15so204882qyk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 15:07:37 -0700 (PDT)
In-Reply-To: <201108271334.17659.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>, Linus Torvalds <torvalds@linux-foundation.org>

------------------------------------------
--- a/cse.c
+++ b/cse.c
@@ -316,12 +316,14 @@ static struct instruction * try_to_cse(struct 
entrypoint *
         b1 = i1->bb;
         b2 = i2->bb;

+#if 0
         /*
          * PHI-nodes do not care where they are - the only thing that 
matters
          * are the PHI _sources_.
          */
         if (i1->opcode == OP_PHI)
                 return cse_one_instruction(i1, i2);
+#endif

--------------------------------------


That patch definitely gets much farther along in terms of handling loops.

	Jeff


