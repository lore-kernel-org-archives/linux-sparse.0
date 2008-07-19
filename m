From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: some newbie questions about __attribute__((context,...))
Date: Sat, 19 Jul 2008 07:49:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807190737340.24056@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:49260 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbYGSLur (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 19 Jul 2008 07:50:47 -0400
Received: from cpe001d60ad7267-cm001225dbafb6.cpe.net.cable.rogers.com ([99.236.100.208] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1KKAxZ-0004B7-IR
	for linux-sparse@vger.kernel.org; Sat, 19 Jul 2008 07:50:45 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse mailing list <linux-sparse@vger.kernel.org>


  (if there's a good writeup on this, or a previous mailing post
explaining this, a pointer to that will do just fine.)

  i'm trying to understand how this context checking is actually done
by sparse.  from the sparse man page:

"Functions with the extended attribute
__attribute__((context(expression,in_context,out_context)) require the
context expression (for instance, a lock) to have the value in_context
(a constant nonnegative integer) when called, and return with the
value out_context (a constant nonnegative integer)."

  fair enough, but what are the possibilities for that "expression"
and what exactly is being compared to the values of 0 or 1?  sure, a
lock is an obvious candidate, but you can't really simply be comparing
the value of a lock to 0 or 1 -- a lock is a *structure* which doesn't
have a simple value of 0 or 1.

  so, to try to keep things simple, what is happening in the
background with code like this:

=====
static void *aarp_seq_start(struct seq_file *seq, loff_t *pos)
        __acquires(aarp_lock)
{
        struct aarp_iter_state *iter = seq->private;

        read_lock_bh(&aarp_lock);
        iter->table     = resolved;
        iter->bucket    = 0;

        return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN;
}
=====

  and how is that call to read_lock_bh() changing the "context" value
of the object aarp_lock?  thanks for any enlightenment.

rday
--


========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
