From: Pavel Roskin <proski@gnu.org>
Subject: Bogus locking warnings
Date: Mon, 26 Feb 2007 20:42:32 -0500
Message-ID: <1172540552.5835.41.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:58574 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbXB0Bme (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Feb 2007 20:42:34 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HLrKs-0000i4-Pi
	for linux-sparse@vger.kernel.org; Mon, 26 Feb 2007 20:40:58 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HLrMO-0003mG-Be
	for linux-sparse@vger.kernel.org; Mon, 26 Feb 2007 20:42:32 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

The current sparse issues a warning about this file:

void my_lock(void) __attribute__ ((context(lock, 0, 1)));
void my_unlock(void) __attribute__ ((context(lock, 1, 0)));
void foo(void);
static void bar(const int locked)
{
	if (!locked)
		my_lock();
	foo();
	if (!locked)
		my_unlock();
}


$ sparse test.c 
test.c:10:3: warning: context imbalance in 'bar' - unexpected unlock

Commenting out foo() call eliminated the warning.  I understand that
sparse suspects that foo() could change "locked".

Changing "int locked" to "const int locked" makes no difference.  I
don't see what else could be done to tell sparse that "locked" won't
change throughout the function call.

Something interesting happens if I change "!locked" to "locked" in both
places:

$ sparse test.c 
test.c:9:2: warning: context imbalance in 'bar' - different lock
contexts for basic block

Although sparse doesn't know anything about the semantic of "locked", it
issues different warnings whether the variable is used "positively" or
"negatively".  No amount of paranoia about foo() can excuse this
inconsistency.

-- 
Regards,
Pavel Roskin
